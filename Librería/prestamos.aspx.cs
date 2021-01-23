using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Librería {
    public partial class prestamos : System.Web.UI.Page {
        //Llamamos la cadena de conexión desde web.config
        String CadenaCnx = ConfigurationManager.ConnectionStrings["cnx"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e) {
            //Checamos si el usuario esta logeado con los permisos necesarios
            if (Session["username"].ToString() == "" || Session["rol"].ToString() != "admin") {
                //Si no esta logeado lo redirigimos al login
                Response.Redirect("adminLogin.aspx");
            }
            //Cargamos los datos en la carga de la página 
            GridPrestamos.DataBind();
        }

        //Método OnClick para realizar el préstamo del libro
        protected void Prestamo(Object sender, EventArgs e) {
            if (ExistePrestamo()) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaInfo('Este usuario ya tiene un préstamo con este libro')", true);
                //Limpiamos para obligar buscar otro libro
                txtIdLibro.Text = "";
                txtLibro.Text = "";
                return;
            } else {
                if (CuentaActiva()) {
                    ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('La cuenta del usuario no esta activa')", true);
                    return;
                }
                String correo;
                String idUsuario = txtUsuario.Text.Trim();
                String idLibro = txtIdLibro.Text.Trim();
                String NombreUsuario = txtNombre.Text.Trim();
                String Libro = txtLibro.Text.Trim();
                DateTime FechaInicio = Convert.ToDateTime(txtPrestamo.Text);
                DateTime FechaEntrega = Convert.ToDateTime(txtEntrega.Text);
                                
                //Vemos si la fecha de inicio es mayor a la del prestamos
                if (FechaEntrega <= FechaInicio) {
                    ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('La fecha de entrega no puede ser menor a la de inicio')", true);
                    return;
                }

                try {
                    SqlConnection cnx = new SqlConnection(CadenaCnx);
                    //Veemos si la conexión está cerrada
                    if (cnx.State == ConnectionState.Closed) {
                        //Abrimos la conexión
                        cnx.Open();
                    }

                    //Creamos la consulta con los campos correspondientes, y con parámetros para facilidad y seguridad
                    SqlCommand stm = new SqlCommand("INSERT INTO tbl_prestamos(prst_usuario, prst_usuario_nombre, prst_libro_id, prst_libro_nombre, prst_fecha_inicio, prst_fecha_fin) " +
                                                                       "VALUES(@prst_usuario, @prst_usuario_nombre, @prst_libro_id, @prst_libro_nombre, @prst_fecha_inicio, @prst_fecha_fin) ", cnx);
                    //Pasamos los parámetros con los datos de la vista
                    stm.Parameters.AddWithValue("@prst_usuario", idUsuario.Trim());
                    stm.Parameters.AddWithValue("@prst_usuario_nombre", NombreUsuario.Trim());
                    stm.Parameters.AddWithValue("@prst_libro_id", idLibro.Trim());
                    stm.Parameters.AddWithValue("@prst_libro_nombre", Libro.Trim());
                    stm.Parameters.AddWithValue("@prst_fecha_inicio", FechaInicio);
                    stm.Parameters.AddWithValue("@prst_fecha_fin", FechaEntrega);
                    //Ejecutamos la consulta
                    stm.ExecuteNonQuery();

                    //Reducimos el stock disponible en 1
                    stm = new SqlCommand("UPDATE tbl_libros SET libro_stock_actual = libro_stock_actual-1 WHERE libro_id = @libro_id", cnx);
                    stm.Parameters.AddWithValue("@libro_id", idLibro.Trim());
                    //Ejecutamos la consulta
                    stm.ExecuteNonQuery();
                    //Cerramos conexión

                    stm = new SqlCommand("SELECT usr_correo FROM tbl_usuario WHERE usr_user = @usr_user", cnx);
                    stm.Parameters.AddWithValue("@usr_user", idUsuario.Trim());
                    SqlDataAdapter da = new SqlDataAdapter(stm);                                                                    //Ejecutamos la consulta, con DataAdapter para ejecutar más de una
                    DataTable Tabla = new DataTable();                                                                             //Creamos tabla para almacenar los resultados
                    da.Fill(Tabla);
                    correo = Tabla.Rows[0]["usr_correo"].ToString();

                    cnx.Close();
                    ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaEcho('Préstamo registrado')", true);
                    System.Diagnostics.Debug.WriteLine(correo);
                    string body = this.EnviarEmail(NombreUsuario, Libro, FechaInicio, FechaEntrega);
                    System.Diagnostics.Debug.WriteLine(body);
                    this.SendHtmlFormattedEmail(correo.Trim(), "Nuevo préstamo!", body);

                    limpiarCampos();
                    //Actualizamos la tablita
                    GridPrestamos.DataBind();
                } catch (SqlException ex) {
                    ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
                } catch (SmtpException Ex) {
                    Response.Write("<script>alert('" + Ex.Message + "');</script>");
                }
            }
        }

        //Método OnClick para realizar el regreso del libro
        protected void Regreso(Object sender, EventArgs e) {
            Prestamo P = new Prestamo();
            if (DisponibilidadLibro() && ExisteUsuario()) {
                if (ExistePrestamo()) {
                    P.Usuario = txtUsuario.Text.Trim();
                    P.Id_libro = txtIdLibro.Text.Trim();
                    try {
                        SqlConnection cnx = new SqlConnection(CadenaCnx);
                        //Veemos si la conexión está cerrada
                        if (cnx.State == ConnectionState.Closed) {
                            //Abrimos la conexión
                            cnx.Open();
                        }
                        //Creamos la consulta con los campos correspondientes, y con parámetros para facilidad y seguridad
                        SqlCommand stm = new SqlCommand("DELETE FROM tbl_prestamos WHERE prst_usuario = @prst_usuario AND prst_libro_id=@prst_libro_id ", cnx);
                        //Pasamos los parámetros con los datos de la vista
                        stm.Parameters.AddWithValue("@prst_usuario", P.Usuario.Trim());
                        stm.Parameters.AddWithValue("@prst_libro_id", P.Id_libro.Trim());
                        //Ejecutamos la consulta
                        int RES = stm.ExecuteNonQuery();

                        if (RES > 0) {
                            //Reducimos el stock disponible en 1
                            stm = new SqlCommand("UPDATE tbl_libros SET libro_stock_actual = libro_stock_actual+1 WHERE libro_id = @libro_id", cnx);
                            stm.Parameters.AddWithValue("@libro_id", P.Id_libro.Trim());
                            //Ejecutamos la consulta
                            stm.ExecuteNonQuery();
                        }
                        //Cerramos conexión
                        cnx.Close();
                        ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaEcho('Libro regresado, préstamo completado')", true);
                        limpiarCampos();
                        //Actualizamos la tablita
                        GridPrestamos.DataBind();
                    } catch (Exception ex) {
                        ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
                    }
                } else {
                    ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaInfo('No hay un préstamo para este usuario de este libro')", true);
                    return;
                }
            } else {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('No se encuentra ningún registro coincidente')", true);
            }
        }

        //Método OnClick para buscar un registro
        protected void Ir(Object sender, EventArgs e) {
            //Checa que este disponible tanto el libro como el usuario
            if (DisponibilidadLibro() && ExisteUsuario()) {
                Datos();
            }
            //Si no esta disponible el libro pero si existe usuario
            else if (!DisponibilidadLibro() && ExisteUsuario()) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('No se encuentra ningún libro con este id')", true);
            }
            //Esta disponible el libro pero no el usuario
            else if (DisponibilidadLibro() && !ExisteUsuario()) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('No se encuentra ningún usuario con esos datos')", true);
            }
            //No existe ninguno de los 2
            else {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('No se encuentra ningún registro con esos datos')", true);
            }
        }

        //Métdo para verificar si el Libro tiene unidades disponibles
        public bool DisponibilidadLibro() {
            Prestamo P = new Prestamo();
            //Traemos el id del libro desde el campo de la vista
            P.Id_libro = txtIdLibro.Text.Trim();
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                SqlCommand stm = new SqlCommand("SELECT * FROM tbl_libros WHERE libro_id ='" + P.Id_libro.Trim() + "' AND libro_stock_actual >0", cnx);          //Creamos la consulta select
                SqlDataAdapter da = new SqlDataAdapter(stm);                                                                //Ejecutamos la consulta, con DataAdapter para ejecutar más de una
                DataTable dt = new DataTable();                                                                             //Creamos tabla para almacenar los resultados
                da.Fill(dt);
                if (dt.Rows.Count >= 1) { return true; }                                                                    //Si el tamaño es 1 o mayor ya existe y devuelve true
                else { return false; }
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
                return false;
            }
        }
        //Método que comprueba si existe el usuario en base al id
        public bool ExisteUsuario() {
            Prestamo P = new Prestamo();
            P.Usuario = txtUsuario.Text.Trim();
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                SqlCommand stm = new SqlCommand("SELECT * FROM tbl_usuario WHERE usr_user ='" + P.Usuario.Trim() + "'", cnx);        //Creamos la consulta select
                SqlDataAdapter da = new SqlDataAdapter(stm);                                                                //Ejecutamos la consulta, con DataAdapter para ejecutar más de una
                DataTable dt = new DataTable();                                                                             //Creamos tabla para almacenar los resultados
                da.Fill(dt);
                if (dt.Rows.Count >= 1) { return true; }                                                                    //Si el tamaño es 1 o mayor ya existe y devuelve true
                else { return false; }
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
                return false;
            }
        }
        //Método para traer los datos requeridos
        public void Datos() {
            Prestamo P = new Prestamo();
            //Traemos los datos de la vista
            P.Usuario = txtUsuario.Text.Trim();
            P.Id_libro = txtIdLibro.Text.Trim();

            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                //Creamos la consulta con los campos correspondientes, y con parámetros para facilidad y seguridad
                SqlCommand stm = new SqlCommand("SELECT libro_nombre FROM tbl_libros WHERE libro_id ='" + P.Id_libro.Trim() + "'", cnx);
                SqlDataAdapter adaptador = new SqlDataAdapter(stm);
                DataTable table = new DataTable();
                adaptador.Fill(table);

                if (table.Rows.Count >= 1) {
                    txtLibro.Text = table.Rows[0]["libro_nombre"].ToString();
                }

                //Creamos la consulta con los campos correspondientes, y con parámetros para facilidad y seguridad
                stm = new SqlCommand("SELECT * FROM tbl_usuario WHERE usr_user ='" + P.Usuario.Trim() + "'", cnx);
                adaptador = new SqlDataAdapter(stm);
                table = new DataTable();
                adaptador.Fill(table);

                if (table.Rows.Count >= 1) {
                    txtNombre.Text = table.Rows[0]["usr_nombre"].ToString() + " " + table.Rows[0]["usr_apellido_paterno"].ToString() + " " + table.Rows[0]["usr_apellido_materno"].ToString();
                }
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
            }
        }

        //Método para verificar si hay un préstamo de libro a usuario
        public bool ExistePrestamo() {
            Prestamo P = new Prestamo();
            P.Usuario = txtUsuario.Text.Trim();
            P.Id_libro = txtIdLibro.Text.Trim();
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                SqlCommand stm = new SqlCommand("SELECT * FROM tbl_prestamos WHERE prst_usuario = @prst_usuario AND prst_libro_id = @prst_libro_id", cnx);        //Creamos la consulta select
                stm.Parameters.AddWithValue("@prst_usuario", P.Usuario.Trim());
                stm.Parameters.AddWithValue("@prst_libro_id", P.Id_libro.Trim());
                SqlDataAdapter da = new SqlDataAdapter(stm);                                                                //Ejecutamos la consulta, con DataAdapter para ejecutar más de una
                DataTable dt = new DataTable();                                                                             //Creamos tabla para almacenar los resultados
                da.Fill(dt);
                if (dt.Rows.Count >= 1) { return true; }                                                                    //Si el tamaño es 1 o mayor ya existe y devuelve true
                else { return false; }
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
                return false;
            }
        }

        public void limpiarCampos() {
            txtUsuario.Text = "";
            txtIdLibro.Text = "";
            txtNombre.Text = "";
            txtLibro.Text = "";
            txtPrestamo.Text = "";
            txtEntrega.Text = "";
        }

        public bool CuentaActiva() {
            Prestamo P = new Prestamo();
            P.Usuario = txtUsuario.Text.Trim();
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                
                SqlCommand stm = new SqlCommand("SELECT usr_estatus_cuenta FROM tbl_usuario WHERE usr_user ='" + P.Usuario.Trim() + "'", cnx);        //Creamos la consulta select
                SqlDataAdapter da = new SqlDataAdapter(stm);                                                                //Ejecutamos la consulta, con DataAdapter para ejecutar más de una
                DataTable dt = new DataTable();                                                                             //Creamos tabla para almacenar los resultados
                da.Fill(dt);
                if (dt.Rows[0]["usr_estatus_cuenta"].ToString() != "Activo") { return true; }                                                                    //Si el tamaño es 1 o mayor ya existe y devuelve true
                else { return false; }
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
                return false;
            }
        }

        protected void PrestamosVencidos(Object sender, GridViewRowEventArgs e) {
            try {
                if (e.Row.RowType == DataControlRowType.DataRow) {
                    //Traemos el valor de la fecha de entrega desde la columna 6 de la tabla
                    DateTime FechaEntrega = Convert.ToDateTime(e.Row.Cells[6].Text);
                    //Obtenemos la fecha del día de hoy
                    DateTime hoy = DateTime.Today;

                    //Vemos si la fecha de hoy es mayor a la del prestamos
                    if(hoy > FechaEntrega) {
                        //Pintamos rojo si es mayor
                        e.Row.BackColor = System.Drawing.Color.FromArgb(255, 110, 110);
                    }else if((FechaEntrega - hoy).TotalDays == 0 || (FechaEntrega - hoy).TotalDays == 1) {
                        //Pintamos amarillo si faltan 2 días para entrega
                        e.Row.BackColor = System.Drawing.Color.FromArgb(255, 253, 126);
                    } else {
                        //Pintamos verde si esta en el plazo aun
                        e.Row.BackColor = System.Drawing.Color.FromArgb(164, 254,100);
                    }
                }
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
            }
        }



        public string EnviarEmail(string userName, String libro, DateTime Inicio, DateTime Fin) {
            string body = string.Empty;
            using (StreamReader reader = new StreamReader(Server.MapPath("PlantillasHTML/NuevoPrestamo.html"))) {
                body = reader.ReadToEnd();
            }
            body = body.Replace("{UserName}", userName);
            body = body.Replace("{Libro}", libro);
            body = body.Replace("{Inicio}", Inicio.ToString("dd/MM/yyyy"));
            body = body.Replace("{Entrega}", Fin.ToString("dd/MM/yyyy"));
            return body;
        }
        private void SendHtmlFormattedEmail(string recepientEmail, string subject, string body) {
            using (MailMessage mailMessage = new MailMessage()) {
                mailMessage.From = new MailAddress(ConfigurationManager.AppSettings["UserName"]);
                mailMessage.Subject = subject;
                mailMessage.Body = body;
                mailMessage.IsBodyHtml = true;
                mailMessage.To.Add(new MailAddress(recepientEmail));
                SmtpClient smtp = new SmtpClient();
                smtp.Host = ConfigurationManager.AppSettings["Host"];
                smtp.EnableSsl = Convert.ToBoolean(ConfigurationManager.AppSettings["EnableSsl"]);
                System.Net.NetworkCredential NetworkCred = new System.Net.NetworkCredential();
                NetworkCred.UserName = ConfigurationManager.AppSettings["UserName"];
                NetworkCred.Password = ConfigurationManager.AppSettings["Password"];
                smtp.UseDefaultCredentials = true;
                smtp.Credentials = NetworkCred;
                smtp.Port = int.Parse(ConfigurationManager.AppSettings["Port"]);
                smtp.Send(mailMessage);
            }
        }
    }
}