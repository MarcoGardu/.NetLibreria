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
    public partial class publisherManagment : System.Web.UI.Page {
        //Llamamos la conexión a BD desde web.config        
        String CadenaCnx = ConfigurationManager.ConnectionStrings["cnx"].ConnectionString;
        Editorial editorial = new Editorial();
        protected void Page_Load(object sender, EventArgs e) {
            //Checamos si el usuario esta logeado con los permisos necesarios
            if (Session["username"].ToString() == "" || Session["rol"].ToString() != "admin") {
                //Si no esta logeado lo redirigimos al login
                Response.Redirect("adminLogin.aspx");
            }
            //Cargamos la tablita de datos en la carga de la página
            GrdEditorial.DataBind();
        }

        //Método OnClick para añadir a un autor
        protected void addEditorial(object sender, EventArgs e) {
            //Revisamos si la editorial ya existe, si no lo registramos
            if (existeEditorial()) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaInfo('Ya existe una editorial con el id ingresado, por favor elija una diferente')", true);
            } else {
                //Llamamos a la función para crear una nueva editorial
                NuevaEditorial();
            }
        }

        //Método OnClick para Actualizar a una editorial
        protected void actualizarEditorial(object sender, EventArgs e) {
            //Revisamos si la editorial ya existe para actualizarlo
            if (!existeEditorial()) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaInfo('No se encuentra una editorial con el id ingresado, por favor ingrese otra')", true);
            } else {
                //Llamamos la función para actualizar la editorial
                updateEditorial();
            }
        }

        //Método OnClick para eliminar a un autor
        protected void eliminarEditorial(object sender, EventArgs e) {
            //Revisamos si el autor ya existe para eliminarlo
            if (!existeEditorial()) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaInfo('No se encuentra una editorial con el id ingresado, por favor ingrese otra')", true);
            } else {
                //Llamamos la función para eliminar la editorial
                deleteEditorial();
            }
        }

        //Métdo para verificar si la editorial existe
        public bool existeEditorial() {
            //Traemos el id de la editorial desde la vista
            editorial.Id = txtIdEditorial.Text.Trim();
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                SqlCommand stm = new SqlCommand("SELECT * FROM tbl_editorial WHERE editorial_id ='" + editorial.Id + "'", cnx);          //Creamos la consulta select
                SqlDataAdapter da = new SqlDataAdapter(stm);                                                                            //Ejecutamos la consulta, con DataAdapter para ejecutar más de una
                DataTable dt = new DataTable();                                                                                         //Creamos tabla para almacenar los resultados
                da.Fill(dt);
                if (dt.Rows.Count >= 1) { return true; }                                                                                //Si el tamaño es 1 o mayor ya existe y devuelve true
                else { return false; }
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
                return false;
            }
        }

        //Método para añadir un autor
        public void NuevaEditorial() {
            //Traemos los datos de la vista
            editorial.Id = txtIdEditorial.Text.Trim();
            editorial.NombreEditorial = txtEditorial.Text.Trim();
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                //Creamos la consulta con los campos correspondientes, y con parámetros para facilidad y seguridad
                SqlCommand stm = new SqlCommand("INSERT INTO tbl_editorial(editorial_id, editorial_nombre) VALUES(@editorial_id, @editorial_nombre) ", cnx);
                //Pasamos los parámetros con los datos de la vista
                stm.Parameters.AddWithValue("@editorial_id", editorial.Id);
                stm.Parameters.AddWithValue("@editorial_nombre", editorial.NombreEditorial);
                //Ejecutamos la consulta
                stm.ExecuteNonQuery();
                //Cerramos conexión
                cnx.Close();
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaEcho('Editorial registrada correctamente')", true);
                limpiarCampos();
                //Actualizamos la tablita
                GrdEditorial.DataBind();
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
            }
        }

        //Método para actualizar el autor
        public void updateEditorial() {
            //Traeos los datos desde la vista
            editorial.Id = txtIdEditorial.Text.Trim();
            editorial.NombreEditorial = txtEditorial.Text.Trim();
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                //Creamos la consulta con los campos correspondientes, y con parámetros para facilidad y seguridad
                SqlCommand stm = new SqlCommand("UPDATE tbl_editorial SET editorial_nombre = @editorial_nombre WHERE editorial_id = @editorial_id", cnx);
                //Pasamos los parámetros con los datos de la vista
                stm.Parameters.AddWithValue("@editorial_nombre", editorial.NombreEditorial);
                stm.Parameters.AddWithValue("@editorial_id", editorial.Id);
                //Ejecutamos la consulta
                stm.ExecuteNonQuery();
                //Cerramos conexión
                cnx.Close();
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaEcho('Editorial actualizada correctamente')", true);
                limpiarCampos();
                //Actualizamos la tablita
                GrdEditorial.DataBind();
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
            }
        }

        //Método para eliminar un autor
        public void deleteEditorial() {
            //traemos el id de la editorial deseada
            editorial.Id = txtIdEditorial.Text.Trim();
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                //Creamos la consulta con los campos correspondientes, y con parámetros para facilidad y seguridad
                SqlCommand stm = new SqlCommand("DELETE FROM tbl_editorial WHERE editorial_id = @editorial_id", cnx);
                //Pasamos los parámetros con los datos de la vista
                stm.Parameters.AddWithValue("@editorial_id", editorial.Id);
                //Ejecutamos la consulta
                stm.ExecuteNonQuery();
                //Cerramos conexión
                cnx.Close();
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaEcho('Editorial eliminada correctamente')", true);
                limpiarCampos();
                //Actualizamos la tablita
                GrdEditorial.DataBind();
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
            }
        }

        //Método para limpiar los campos
        public void limpiarCampos() {
            txtEditorial.Text = "";
            txtIdEditorial.Text = "";
        }

        //Método para el botón de ir 
        public void IrEditorial(object sender, EventArgs e) {
            //obtenemos el id de la editorial desde la vista
            editorial.Id = txtIdEditorial.Text.Trim();
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                SqlCommand stm = new SqlCommand("SELECT * FROM tbl_editorial WHERE editorial_id ='" + editorial.Id + "'", cnx);          //Creamos la consulta select
                SqlDataAdapter da = new SqlDataAdapter(stm);                                                                            //Ejecutamos la consulta, con DataAdapter para ejecutar más de una
                DataTable dt = new DataTable();                                                                                         //Creamos tabla para almacenar los resultados
                da.Fill(dt);
                if (dt.Rows.Count >= 1) { txtEditorial.Text = dt.Rows[0][1].ToString().Trim(); }                                               //Si se encontró el autor, rellenamos el campo del nombre                                             //Si el tamaño es 1 o mayor ya existe y devuelve true
                else { ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaInfo('No se encuentra una editorial con el id ingresado, por favor ingrese otra')", true); }                                   //Si no se encontró mandamos una alertita
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
            }
        }
    }
}