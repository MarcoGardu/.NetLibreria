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
    public partial class adminLogin : System.Web.UI.Page{
        String CadenaCnx = ConfigurationManager.ConnectionStrings["cnx"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e){

        }
        protected void logeo(object sender, EventArgs e) {
            String user = txtUsuario.Text.Trim();
            String password = txtPassword.Text.Trim();
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                //Creamos la consulta con los campos correspondientes, y con parámetros para facilidad y seguridad
                SqlCommand stm = new SqlCommand("SELECT * FROM tbl_admin WHERE adm_user='" + user + "' AND adm_password='" + password + "'", cnx);
                SqlDataReader r = stm.ExecuteReader();
                if (r.HasRows) {                    //Vemos si hay registros coincidentes
                    while (r.Read()) {              //Mientras exista información de los registros
                        ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaEcho('Login realizado satisfactoriamente')", true);                        
                        //Creamos las variables de sesión para los datos traídos de la BD y perfil de usuarios
                        Session["username"] = r.GetValue(4).ToString();
                        Session["nombre"] = r.GetValue(3).ToString() + " " + r.GetValue(1).ToString(); ;
                        Session["rol"] = "admin";
                        Session["saludar"] = "1";
                    }
                    Response.Redirect("Default.aspx");
                } else {
                    ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('Credenciales erroneas, intente una vez más')", true);
                }
                //Cerramos conexión
                cnx.Close();
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('"+ex.Message+"')", true);
                
            }
        }
    }
}