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
    public partial class Autor : System.Web.UI.Page {
        //Llamamos a la cadena de conexión desde el archivo web.config
        String CadenaCnx = ConfigurationManager.ConnectionStrings["cnx"].ConnectionString;
        Autores autor = new Autores();
        protected void Page_Load(object sender, EventArgs e) {
            //Checamos si el usuario esta logeado con los permisos necesarios
            if (Session["username"].ToString() == "" || Session["rol"].ToString() != "admin") {
                //Si no esta logeado lo redirigimos al login
                Response.Redirect("adminLogin.aspx");
            }
            //Cargamos los datos de la tabla de autor en la carga de la página
            GrdAutor.DataBind();
        }

        //Método OnClick para añadir a un autor
        protected void addAutor(object sender, EventArgs e) {
            //Revisamos si el autor ya existe, si no lo registramos
            if (existeAutor()) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaInfo('Un autor con este id ya existem elija otro id')", true);                
            } else {
                //Llamamos a la función para registrar un autor
                NuevoAutor();
            }
        }

        //Método OnClick para Actualizar a un autor
        protected void actualizarAutor(object sender, EventArgs e) {
            //Revisamos si el autor ya existe para actualizarlo
            if (!existeAutor()) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaInfo('No se encuentra un autor con el id ingresado')", true);                
            } else {
                //Llamamos la función para actualizar un autor
                updateAutor();
            }
        }

        //Método OnClick para eliminar a un autor
        protected void eliminarAutor(object sender, EventArgs e) {
            //Revisamos si el autor ya existe para eliminarlo
            if (!existeAutor()) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaInfo('No se encuentra un autor con el id ingresado')", true);                
            } else {
                //Llamamos la función para eliminar el autor
                deleteAutor();
            }
        }

        //Métdo para verificar si el autor existe
        public bool existeAutor() {
            //Obtenemos el id para el autor desde la vista
            autor.Id = txtIdAutor.Text.Trim();
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                SqlCommand stm = new SqlCommand("SELECT * FROM tbl_autor WHERE autor_id ='" + autor.Id + "'", cnx);        //Creamos la consulta select
                SqlDataAdapter da = new SqlDataAdapter(stm);                                                            //Ejecutamos la consulta, con DataAdapter para ejecutar más de una
                DataTable dt = new DataTable();                                                                         //Creamos tabla para almacenar los resultados
                da.Fill(dt);
                if (dt.Rows.Count >= 1) { return true; }                                                                //Si el tamaño es 1 o mayor ya existe y devuelve true
                else { return false; }
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('"+ex.Message+"')", true);                
                return false;
            }
        }

        //Método para añadir un autor
        public void NuevoAutor() {
            //Traemos los datos de la vista
            autor.Id = txtIdAutor.Text.Trim();
            autor.Nombre = txtNombreAutor.Text.Trim();
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                //Creamos la consulta con los campos correspondientes, y con parámetros para facilidad y seguridad
                SqlCommand stm = new SqlCommand("INSERT INTO tbl_autor(autor_id, autor_nombre) VALUES(@autor_id, @autor_nombre) ", cnx);
                //Pasamos los parámetros con los datos de la vista
                stm.Parameters.AddWithValue("@autor_id", autor.Id);
                stm.Parameters.AddWithValue("@autor_nombre", autor.Nombre);
                //Ejecutamos la consulta
                stm.ExecuteNonQuery();
                //Cerramos conexión
                cnx.Close();
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaEcho('Autor registrado correctamente')", true);                
                limpiarCampos();
                //Actualizamos la tablita
                GrdAutor.DataBind();
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('"+ex.Message+"')", true);                
            }
        }

        //Método para actualizar el autor
        public void updateAutor() {
            //Traemos los datos de la vista
            autor.Id = txtIdAutor.Text.Trim();
            autor.Nombre = txtNombreAutor.Text.Trim();
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                //Creamos la consulta con los campos correspondientes, y con parámetros para facilidad y seguridad
                SqlCommand stm = new SqlCommand("UPDATE tbl_autor SET autor_nombre = @autor_nombre WHERE autor_id = @autor_id", cnx);
                //Pasamos los parámetros con los datos de la vista
                stm.Parameters.AddWithValue("@autor_nombre", autor.Nombre);
                stm.Parameters.AddWithValue("@autor_id", autor.Id);
                //Ejecutamos la consulta
                stm.ExecuteNonQuery();
                //Cerramos conexión
                cnx.Close();
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaEcho('Autor actualizado correctamente')", true);                
                limpiarCampos();
                //Actualizamos la tablita
                GrdAutor.DataBind();
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('"+ex.Message+"')", true);                
            }
        }

        //Método para eliminar un autor
        public void deleteAutor() {
            autor.Id = txtIdAutor.Text.Trim();
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                //Creamos la consulta con los campos correspondientes, y con parámetros para facilidad y seguridad
                SqlCommand stm = new SqlCommand("DELETE FROM tbl_autor WHERE autor_id = @autor_id", cnx);
                //Pasamos los parámetros con los datos de la vista
                stm.Parameters.AddWithValue("@autor_id", autor.Id);
                //Ejecutamos la consulta
                stm.ExecuteNonQuery();
                //Cerramos conexión
                cnx.Close();
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaEcho('Autor eliminado correctamente')", true);                
                limpiarCampos();
                //Actualizamos la tablita
                GrdAutor.DataBind();
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('"+ex.Message+"')", true);                
            }
        }

        //Método para limpiar los campos
        public void limpiarCampos() {
            txtNombreAutor.Text = "";
            txtIdAutor.Text = "";
        }

        //Método para el botón de ir 
        public void Ir(object sender, EventArgs e) {
            autor.Id = txtIdAutor.Text.Trim();
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                SqlCommand stm = new SqlCommand("SELECT * FROM tbl_autor WHERE autor_id ='" + autor.Id + "'", cnx);          //Creamos la consulta select
                SqlDataAdapter da = new SqlDataAdapter(stm);                                                                //Ejecutamos la consulta, con DataAdapter para ejecutar más de una
                DataTable dt = new DataTable();                                                                             //Creamos tabla para almacenar los resultados
                da.Fill(dt);
                if (dt.Rows.Count >= 1) { txtNombreAutor.Text = dt.Rows[0][1].ToString().Trim(); }                                 //Si se encontró el autor, rellenamos el campo del nombre                                             //Si el tamaño es 1 o mayor ya existe y devuelve true
                else { ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaInfo('No se encuentra un autor con el id ingresado')", true); }                           //Si no se encontró mandamos una alertita
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaInfo('"+ex.Message+"')", true);
            }
        }
    }
}