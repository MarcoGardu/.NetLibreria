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
    public partial class gestionUsuarios : System.Web.UI.Page {
        //Llamamos la cadena de conexión desde el archivo web.config
        String CadenaCnx = ConfigurationManager.ConnectionStrings["cnx"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e) {
            //Checamos si el usuario esta logeado con los permisos necesarios
            if (Session["username"].ToString() == "" || Session["rol"].ToString() != "admin") {
                //Si no esta logeado lo redirigimos al login
                Response.Redirect("adminLogin.aspx");
            }
            //Cargamos la tabla con los datos de los usuarios en la carga de la página
            GridUsuarios.DataBind();
        }

        //Método para buscar un usuario
        protected void Buscar(Object sender, EventArgs e) {
            //Comprobamos si existe el usuario en la BD
            if (ExisteUsuario()) {
                //Llamamos al método para buscar al usuario
                Busqueda();
            } else {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaInfo('No hay usuarios coincidentes')", true);
            }
        }

        //Método Onclick para cambiar el estatus de la cuenta a activa
        protected void ActivarCuenta(Object sender, EventArgs e) {
            //Llamamos el método para cambiar el estatus a activo
            NuevoEstatus("Activo");
        }
        //Método Onclick  para cambiar el estatus de la cuenta a pendiente
        protected void SuspenderCuenta(Object sender, EventArgs e) {
            //Llamamos al método para cambiar el estaus de cuenta a pendiente
            NuevoEstatus("Pendiente");
        }
        //Método Onclick  para cambiar el estatus de la cuenta a inactiva
        protected void BajaCuenta(Object sender, EventArgs e) {
            //Llamamos el método para cambiar el estatus de cuenta a inactivo
            NuevoEstatus("Inactivo");
        }
        //Método Onclick para elimiar una cuenta
        protected void EliminarCuenta(Object sender, EventArgs e) {
            //Comprobamo si el usuario existe en la BD
            if (ExisteUsuario()) {
                //Llamamos el método para eliminar al usuario
                Eliminar();
            } else {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaInfo('No se encuentran usuarios coincidentes')", true);
            }
        }
        //Método para actualizar el estatus mediante un parámetro
        public void NuevoEstatus(String estatus) {
            //Traemos el id del usuario desde la vista
            String usuario = txtUsuario.Text.Trim();
            //Vemos si el usuario existe en la BD
            if (!ExisteUsuario()) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaInfo('No hay usuarios coincidentes')", true);
            } else {
                try {
                    SqlConnection cnx = new SqlConnection(CadenaCnx);
                    //Veemos si la conexión está cerrada
                    if (cnx.State == ConnectionState.Closed) {
                        //Abrimos la conexión
                        cnx.Open();
                    }
                    //Creamos la consulta con los campos correspondientes, y con parámetros para facilidad y seguridad
                    SqlCommand stm = new SqlCommand("UPDATE tbl_usuario SET usr_estatus_cuenta = @estatus WHERE usr_user = @usuario", cnx);
                    //Pasamos los parámetros con los datos de la vista
                    stm.Parameters.AddWithValue("@estatus", estatus.Trim());
                    stm.Parameters.AddWithValue("@usuario ", usuario.Trim());
                    //Ejecutamos la consulta
                    stm.ExecuteNonQuery();
                    //Cerramos conexión
                    cnx.Close();
                    ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaEcho('Estatus del usuario actualizado correctamente')", true);
                    limpiarCampos();
                    //Actualizamos la tablita
                    GridUsuarios.DataBind();
                } catch (Exception ex) {
                    ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
                }
            }

        }
        //Método que comprueba si existe el usuario en base al id
        public bool ExisteUsuario() {
            String usuario = txtUsuario.Text.Trim();
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                SqlCommand stm = new SqlCommand("SELECT * FROM tbl_usuario WHERE usr_user ='" + usuario + "'", cnx);        //Creamos la consulta select
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
        //Método para realizar la busqueda 
        public void Busqueda() {
            string usuario = txtUsuario.Text.Trim();
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                //Creamos la consulta con los campos correspondientes, y con parámetros para facilidad y seguridad
                SqlCommand stm = new SqlCommand("SELECT * FROM tbl_usuario WHERE usr_user='" + usuario + "'", cnx);
                SqlDataReader r = stm.ExecuteReader();
                if (r.HasRows) {                                                                            //Vemos si hay registros coincidentes
                    while (r.Read()) {                                                                      //Mientras exista información de los registros
                        txtNombre.Text = r.GetValue(0).ToString();
                        txtApellidoPaterno.Text = r.GetValue(1).ToString();
                        txtApellidoMaterno.Text = r.GetValue(2).ToString();
                        txtEstatus.Text = r.GetValue(13).ToString();
                        txtTelefono.Text = r.GetValue(4).ToString();
                        TxtCorreo.Text = r.GetValue(3).ToString();
                        txtNacimiento.Text = r.GetValue(5).ToString();
                        txtNumero.Text = r.GetValue(7).ToString();
                        txtCalle.Text = r.GetValue(6).ToString();
                        txtMunicipio.Text = r.GetValue(10).ToString();
                        txtColonia.Text = r.GetValue(8).ToString();
                        txtCodigoPostal.Text = r.GetValue(9).ToString();

                    }
                } else {
                    ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaInfo('No se encuentra el usuario deseado')", true);
                }
                //Cerramos conexión
                cnx.Close();
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
            }
        }
        //Método para eliminar al usuario
        public void Eliminar() {
            //Traemos el id desde la vista
            String usuario = txtUsuario.Text.Trim();
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                //Creamos la consulta con los campos correspondientes, y con parámetros para facilidad y seguridad
                SqlCommand stm = new SqlCommand("DELETE FROM tbl_usuario WHERE usr_user = @usuario", cnx);
                //Pasamos los parámetros con los datos de la vista
                stm.Parameters.AddWithValue("@usuario ", usuario);
                //Ejecutamos la consulta
                stm.ExecuteNonQuery();
                //Cerramos conexión
                cnx.Close();
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaEcho('Usuario eliminado correctamente')", true);
                limpiarCampos();
                //Actualizamos la tablita
                GridUsuarios.DataBind();
            } catch (SqlException ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('No puede eliminar un usuario que tiene préstamos activos')", true);
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
            }
        }
        public void limpiarCampos() {
            txtNombre.Text = "";
            txtApellidoPaterno.Text = "";
            txtApellidoMaterno.Text = "";
            txtEstatus.Text = "";
            txtTelefono.Text = "";
            TxtCorreo.Text = "";
            txtNacimiento.Text = "";
            txtNumero.Text = "";
            txtCalle.Text = "";
            txtMunicipio.Text = "";
            txtColonia.Text = "";
            txtCodigoPostal.Text = "";
        }
    }

}