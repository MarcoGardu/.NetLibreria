using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Librería {
    public partial class Registrarse : System.Web.UI.Page {
        //Obtenemos la conexión desde el web.config
        String CadenaCnx = ConfigurationManager.ConnectionStrings["cnx"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e) {

        }
        //Evento del botón de registro
        protected void RegistrarUsuario(object sender, EventArgs e) {
            //Revisamos si el usuario ya existe, si no lo registramos
            if (UsuarioExistente()) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaInfo('El usuario que ha elejido no se encuentra disponible, elija otro por favor')", true);
            } else {
                //Llamamos al método para registrar al usuario
                NuevoUsuario();
            }
        }

        //Método para checar si el usuario ya existe en la Base de datos
        public bool UsuarioExistente() {
            Usuario u = new Usuario();
            //Traemos el usuario de la vista
            u.User = txtUsuario.Text.Trim();
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                SqlCommand stm = new SqlCommand("SELECT * FROM tbl_usuario WHERE usr_user='" + u.User + "'", cnx);     //Creamos la consulta select
                SqlDataAdapter da = new SqlDataAdapter(stm);                                                            //Ejecutamos la consulta, con DataAdapter para ejecutar más de una
                DataTable dt = new DataTable();                                                                         //Creamos tabla para almacenar los resultados
                da.Fill(dt);
                if (dt.Rows.Count >= 1) { return true; }                                                                //Si el tamaño es 1 o mayor ya existe y devuelve true
                else { return false; }
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
                return false;
            }
        }
        //Método para registrar el usuario
        public void NuevoUsuario() {
            Usuario u = new Usuario();
            //Traemos los datos de la vista
            u.Apellido_paterno = txtApellidoPaterno.Text.Trim();
            u.Apellido_materno = txtApellidoMaterno.Text.Trim();
            u.Nombre = txtNombre.Text.Trim();
            u.Correo = txtCorreo.Text.Trim();
            u.Telefono = txtTelefono.Text.Trim();
            u.Fecha_nacimiento = txtNacimiento.Text.Trim();
            u.Calle = txtCalle.Text.Trim();
            u.Numero = txtNumeroLote.Text.Trim();
            u.Colonia = lstColonia.SelectedItem.Value.Trim();
            u.CodigoPostal = txtCP.Text.Trim();
            u.Municipio = txtMunicipio.Text.Trim();
            u.User = txtUsuario.Text.Trim();
            u.Password = txtPassword.Text.Trim();
            u.Estatus = "Pendiente";
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                //Creamos la consulta con los campos correspondientes, y con parámetros para facilidad y seguridad
                SqlCommand stm = new SqlCommand("INSERT INTO tbl_usuario(usr_nombre, usr_apellido_paterno, usr_apellido_materno, usr_correo, usr_telefono, usr_fecha_nacimiento, " +
                                                                            "usr_calle, usr_lote, usr_colonia, usr_codigo_postal, usr_municipio, " +
                                                                            "usr_user, usr_password, usr_estatus_cuenta) VALUES(" +
                                                                            "@usr_nombre, @usr_apellido_paterno, @usr_apellido_materno, @usr_correo, @usr_telefono, @usr_fecha_nacimiento, " +
                                                                            "@usr_calle, @usr_lote, @usr_colonia, @usr_codigo_postal, @usr_municipio, " +
                                                                            "@usr_user, @usr_password, @usr_estatus_cuenta) ", cnx);
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
                stm.Parameters.AddWithValue("@usr_password", u.Password.Trim());
                stm.Parameters.AddWithValue("@usr_estatus_cuenta", u.Estatus.Trim());
                //Ejecutamos la consulta
                stm.ExecuteNonQuery();
                //Cerramos conexión
                cnx.Close();
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaEcho('Usuario registrado, dirigase a la sección de login para ingresar')", true);
                string body = this.EnviarEmail(u.Nombre + " " + u.Apellido_paterno + " " + u.Apellido_materno, "Puede iniciar sesión desde aquí", "Puede pedir nuestros libros para llevarlos a su casa");
                this.SendHtmlFormattedEmail(u.Correo, "Registro satisfactorio!", body);                
                limpiarCampos();
            } catch (SqlException ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
            } catch(SmtpException Ex) {
                Response.Write("<script>alert('"+Ex.Message+ "');</script>");
            }
        }
        //Método para poner vacíos los campos del formulario
        public void limpiarCampos() {
            txtApellidoPaterno.Text = "";
            txtApellidoMaterno.Text = "";
            txtNombre.Text = "";
            txtCorreo.Text = "";
            txtTelefono.Text = "";
            txtNacimiento.Text = "";
            txtCalle.Text = "";
            txtNumeroLote.Text = "";
            txtCP.Text = "";
            txtUsuario.Text = "";
            txtPassword.Text = "";
        }

        public string EnviarEmail(string userName, string title, string description) {
            string body = string.Empty;
            using (StreamReader reader = new StreamReader(Server.MapPath("PlantillasHTML/NuevoUsuario.html"))) {
                body = reader.ReadToEnd();
            }
            body = body.Replace("{UserName}", userName);
            body = body.Replace("{Title}", title);            
            body = body.Replace("{Description}", description);
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