using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Librería {
    public partial class perfilUsuario : System.Web.UI.Page {
        //Llamamos la cadena de conexión desde web.config
        String CadenaCnx = ConfigurationManager.ConnectionStrings["cnx"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e) {
            try {
                if (Session["username"].ToString() == "" || Session["username"].ToString() == null) {
                    Response.Write("<script>alert('Sesión expirada');</script>");
                    Response.Redirect("login.aspx");
                } else {
                    DatosPrestamosUsuario();
                    if (!IsPostBack) {
                        DatosUsuario();
                    }
                }
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
            }
        }

        protected void Actualizar(object sender, EventArgs e) {
            if (Session["username"].ToString() == "" || Session["username"].ToString() == null) {
                Response.Write("<script>alert('Sesión expirada');</script>");
                Response.Redirect("login.aspx");
            } else {
                ActualizarDatos();
            }
        }

        //Método para traer los datos de los prestamos del usuario
        public void DatosUsuario() {
            Usuario u = new Usuario();
            u.User = txtUsuario.Text.Trim();
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                SqlCommand stm = new SqlCommand("SELECT * FROM tbl_usuario WHERE usr_user ='" + Session["username"].ToString() + "'", cnx);        //Creamos la consulta select
                SqlDataAdapter da = new SqlDataAdapter(stm);                                                                //Ejecutamos la consulta, con DataAdapter para ejecutar más de una
                DataTable Tabla = new DataTable();                                                                             //Creamos tabla para almacenar los resultados
                da.Fill(Tabla);
                txtApellidoPaterno.Text = Tabla.Rows[0]["usr_apellido_paterno"].ToString();
                txtApellidoMaterno.Text = Tabla.Rows[0]["usr_apellido_materno"].ToString();
                txtNombre.Text = Tabla.Rows[0]["usr_nombre"].ToString();
                txtCorreo.Text = Tabla.Rows[0]["usr_correo"].ToString();
                txtTelefono.Text = Tabla.Rows[0]["usr_telefono"].ToString();
                txtNacimiento.Text = Tabla.Rows[0]["usr_fecha_nacimiento"].ToString();
                txtCalle.Text = Tabla.Rows[0]["usr_calle"].ToString();
                txtNumero.Text = Tabla.Rows[0]["usr_lote"].ToString();
                lstColonia.SelectedValue = Tabla.Rows[0]["usr_colonia"].ToString();
                txtCP.Text = Tabla.Rows[0]["usr_codigo_postal"].ToString();
                txtMunicipio.Text = Tabla.Rows[0]["usr_municipio"].ToString();
                txtUsuario.Text = Tabla.Rows[0]["usr_user"].ToString();
                txtPassword.Text = Tabla.Rows[0]["usr_password"].ToString();

                u.Estatus = Tabla.Rows[0]["usr_estatus_cuenta"].ToString();
                lblEstatus.Text = u.Estatus;

                if (u.Estatus == "Activo") {
                    lblEstatus.Attributes.Add("class", "badge badge-success text-center");
                } else if (u.Estatus == "Pendiente") {
                    lblEstatus.Attributes.Add("class", "badge badge-warning text-center");
                } else if (u.Estatus == "Inactivo") {
                    lblEstatus.Attributes.Add("class", "badge badge-danger text-center");
                } else {
                    lblEstatus.Attributes.Add("class", "badge badge-info text-center");
                }
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
            }
        }
        //Método para traer los datos de los prestamos del usuario
        public void DatosPrestamosUsuario() {
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                
                SqlCommand stm = new SqlCommand("SELECT prst_id, prst_usuario, prst_usuario_nombre, prst_libro_id, prst_libro_nombre, CONVERT(VARCHAR(10), prst_fecha_inicio,103), CONVERT(VARCHAR(10), prst_fecha_fin, 103) FROM tbl_prestamos WHERE prst_usuario ='" + Session["username"].ToString() + "'", cnx);        //Creamos la consulta select
                SqlDataAdapter da = new SqlDataAdapter(stm);                                                                                        //Ejecutamos la consulta, con DataAdapter para ejecutar más de una
                DataTable Tabla = new DataTable();                                                                             //Creamos tabla para almacenar los resultados
                da.Fill(Tabla);
                Tabla.Columns[0].ColumnName = "id";
                Tabla.Columns[1].ColumnName = "Usuario";
                Tabla.Columns[2].ColumnName = "Nombre";
                Tabla.Columns[3].ColumnName = "Código del Libro";
                Tabla.Columns[4].ColumnName = "Nombre libro";
                Tabla.Columns[5].ColumnName = "Fecha Inicio";
                Tabla.Columns[6].ColumnName = "Fecha Entrega";
                //Llenamos la tabla con la info de la BD
                GridPerfil.DataSource = Tabla;
                GridPerfil.DataBind();
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
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
                    if (hoy > FechaEntrega) {
                        //Pintamos rojo si es mayor
                        e.Row.BackColor = System.Drawing.Color.FromArgb(255, 110, 110);
                    } else if ((FechaEntrega - hoy).TotalDays == 0 || (FechaEntrega - hoy).TotalDays == 1) {
                        //Pintamos amarillo si faltan 2 días para entrega
                        e.Row.BackColor = System.Drawing.Color.FromArgb(255, 253, 126);
                    } else {
                        //Pintamos verde si esta en el plazo aun
                        e.Row.BackColor = System.Drawing.Color.FromArgb(164, 254, 100);
                    }
                }
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
            }
        }

        public void ActualizarDatos() {
            String nuevaPass = "";
            Usuario u = new Usuario();

            u.Apellido_paterno = txtApellidoPaterno.Text.Trim();
            u.Apellido_materno = txtApellidoMaterno.Text.Trim();
            u.Nombre = txtNombre.Text.Trim();
            u.Correo = txtCorreo.Text.Trim();
            u.Telefono = txtTelefono.Text.Trim();
            u.Fecha_nacimiento = txtNacimiento.Text.Trim();
            u.Calle = txtCalle.Text.Trim();
            u.Numero = txtNumero.Text.Trim();
            u.Colonia = lstColonia.SelectedItem.Value.Trim();
            u.CodigoPostal = txtCP.Text.Trim();
            u.Municipio = txtMunicipio.Text.Trim();
            u.User = txtUsuario.Text.Trim();

            if (txtNuevaContrasenia.Text.Trim() == "") {
                nuevaPass = txtPassword.Text.Trim();
            } else {
                nuevaPass = txtNuevaContrasenia.Text.Trim();
            }

            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                //Creamos la consulta con los campos correspondientes, y con parámetros para facilidad y seguridad
                SqlCommand stm = new SqlCommand("UPDATE tbl_usuario SET usr_nombre=@usr_nombre, usr_apellido_paterno = @usr_apellido_paterno, usr_apellido_materno = @usr_apellido_materno, usr_correo = @usr_correo, usr_telefono = @usr_telefono, usr_fecha_nacimiento =  @usr_fecha_nacimiento, usr_calle = @usr_calle, usr_lote = @usr_lote, usr_colonia = @usr_colonia, usr_codigo_postal = @usr_codigo_postal, usr_municipio = @usr_municipio, usr_user = @usr_user, usr_password = @usr_password WHERE usr_user = '" + Session["username"].ToString() + "'", cnx);
                //Pasamos los parámetros con los datos de la vista
                stm.Parameters.AddWithValue("@usr_nombre", u.Nombre.Trim());
                stm.Parameters.AddWithValue("@usr_apellido_paterno", u.Apellido_paterno.Trim());
                stm.Parameters.AddWithValue("@usr_apellido_materno", u.Apellido_materno.Trim());
                stm.Parameters.AddWithValue("@usr_correo", u.Correo.Trim());
                stm.Parameters.AddWithValue("@usr_telefono", u.Telefono.Trim());
                stm.Parameters.AddWithValue("@usr_fecha_nacimiento", u.Fecha_nacimiento.Trim());
                stm.Parameters.AddWithValue("@usr_calle", u.Calle.Trim());
                stm.Parameters.AddWithValue("@usr_lote", u.Numero.Trim());
                stm.Parameters.AddWithValue("@usr_colonia", u.Colonia.Trim());
                stm.Parameters.AddWithValue("@usr_codigo_postal", u.CodigoPostal.Trim());
                stm.Parameters.AddWithValue("@usr_municipio", u.Municipio.Trim());
                stm.Parameters.AddWithValue("@usr_user", u.User.Trim());
                stm.Parameters.AddWithValue("@usr_password", nuevaPass.Trim());
                //Ejecutamos la consulta
                int res = stm.ExecuteNonQuery();
                //Cerramos conexión
                cnx.Close();
                if (res > 0) {
                    ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaEcho('Datos actualizados correctamente')", true);
                    DatosUsuario(); 
                    DatosPrestamosUsuario();
                } else {
                    ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('Ha ocurrido un error')", true);
                }
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
            }
        }
    }
}