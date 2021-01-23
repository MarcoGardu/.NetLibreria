using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Librería{
    public partial class login : System.Web.UI.Page{
        //Llamamos la cadena de conexión desde web.config
        String CadenaCnx = ConfigurationManager.ConnectionStrings["cnx"].ConnectionString;
        Usuario u = new Usuario();
        protected void Page_Load(object sender, EventArgs e){

        }
        //Método para reedirigir a la página de registro
        protected void irRegistro(object sender, EventArgs e) {
            Response.Redirect("Registrarse.aspx");
        }

        protected void logeo(object sender, EventArgs e) {
            //Traemos los datos desde la vista
            u.User = txtUsuario.Text.Trim();
            u.Password = txtPassword.Text.Trim();
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                //Creamos la consulta con los campos correspondientes, y con parámetros para facilidad y seguridad
                SqlCommand stm = new SqlCommand("SELECT * FROM tbl_usuario WHERE usr_user='"+u.User.Trim() + "' AND usr_password='"+u.Password.Trim() + "'", cnx);
                SqlDataReader r = stm.ExecuteReader();
                if (r.HasRows) {                                                                        //Vemos si hay registros coincidentes
                    while (r.Read()) {                                                                  //Mientras exista información de los registros
                        Response.Write("<script>alert('Login realizado satisfactoriamente')</script>");
                        //Creamos las variables de sesión para los datos traídos de la BD y perfil de usuarios
                        Session["username"] = r.GetValue(11).ToString();
                        Session["nombre"] = r.GetValue(0).ToString();
                        Session["rol"] = "usuario";
                        Session["status"] = r.GetValue(13).ToString();
                        Session["saludar"] = "1";
                    }
                    Response.Redirect("Default.aspx");
                } else {
                    ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('Credenciales erroneas, intente una vez más')", true);                    
                }
                //Cerramos conexión
                cnx.Close();
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);                
            }
        }
    }
}