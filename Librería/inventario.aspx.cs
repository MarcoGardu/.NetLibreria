using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace Librería {
    public partial class inventario : System.Web.UI.Page {
        //Llamada a la cadena de conexión
        String CadenaCnx = ConfigurationManager.ConnectionStrings["cnx"].ConnectionString;
        //Variables globales para almacenar información al obtener un registro y luego actualizarlo
        static string ruta_imagen;
        static int stock_real, stock_actual, prestados;
        protected void Page_Load(object sender, EventArgs e) {
            //Checamos si el usuario esta logeado con los permisos necesarios
            if (Session["username"].ToString() == "" || Session["rol"].ToString() != "admin") {
                //Si no esta logeado lo redirigimos al login
                Response.Redirect("adminLogin.aspx");
            }
            if (!IsPostBack) {
                //Llenamos los autores y editoriales en la carga de la página
                LlenarAutor();
                LlenarEditorial();
            }
            //Cargamos la tabla de libros en la carga de la página
            GrdLibros.DataBind();
        }

        //Método OnClick para añadir a un libro
        protected void AddLibro(object sender, EventArgs e) {
            //Revisamos si el libro ya existe, si no lo registramos
            if (ExisteLibro()) {
                //Mostramos un mensajit de alerta
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaInfo('Este libro ya existe, por favor elija otro diferente')", true);
            } else {
                //Vamos a la función para registrar el libro
                NuevoLibro();
            }
        }

        //Método OnClick para Actualizar a un Libro
        protected void ActualizarLibro(object sender, EventArgs e) {
            //Revisamos si el Libro ya existe para actualizarlo
            if (!ExisteLibro()) {
                //Mostramos el mensaje de que no existe
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaInfo('No se encuentra un libro con este id, por favor elija otro diferente')", true);
            } else {
                //LLama la función para actualizar el libro
                UpdateLibro();
            }
        }

        //Método OnClick para eliminar a un libro
        protected void EliminarLibro(object sender, EventArgs e) {
            //Revisamos si el Libro ya existe para eliminarlo
            if (!ExisteLibro()) {
                //Muestra una alerta de que el libro no se encuentra
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaInfo('No se encuentra un libro con este id, por favor elija otro diferente')", true);
            } else {
                //Llamamos la función para eliminar el libro
                DeleteLibro();
            }
        }

        //Método para añadir un Libro
        public void NuevoLibro() {
            Libro l = new Libro();
            //Traemos los datos desde la vista
            try {
                l.Id = txtIdLibro.Text.Trim();
                l.Nombre = txtNombre.Text.Trim();
                l.Idioma = drpLenguaje.SelectedItem.Value.Trim();
                l.Editorial = drpEditorial.SelectedItem.Value.Trim();
                l.Autor = drpAutor.SelectedItem.Value.Trim();

                l.FechaPublicacion = Convert.ToDateTime(txtFechaPublicacion.Text);
                l.Edicion = Convert.ToInt32(txtEdicion.Text);
                l.Costo = Convert.ToDecimal(txtCosto.Text);
                l.Paginas = Convert.ToInt32(txtPaginas.Text);
                l.StockReal = Convert.ToInt32(txtStockReal.Text);

                l.Descripcion = txtDescripcion.Text;

                l.Pasillo = txtPasillo.Text;
                l.Estante = txtEstante.Text;
                l.Fila = txtFila.Text;
                //Para los géneros al ser selección multiple los ponemos en una cadena
                l.Genero = "";
                foreach (int i in lstGenero.GetSelectedIndices()) {
                    l.Genero += lstGenero.Items[i] + ",";
                }
                //Eliminamos la coma final que no se ocupa
                l.Genero = l.Genero.Remove(l.Genero.Length - 1);


                //Ruta general donde guardar las imagenes
                l.Ruta = "~/Imagenes/Inventario/inventario.png";
                //Nombre del arhivo que subimos en el componente
                String NombreArchivo = Path.GetFileName(FileImg.PostedFile.FileName);
                //Ruta para guardar la imagen
                FileImg.SaveAs(Server.MapPath("Imagenes/Inventario/" + NombreArchivo));
                l.Ruta = "~/Imagenes/Inventario/" + NombreArchivo;

                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                //Creamos la consulta con los campos correspondientes, y con parámetros para facilidad y seguridad
                SqlCommand stm = new SqlCommand("INSERT INTO tbl_libros(libro_id, libro_nombre, libro_genero, libro_autor, libro_editorial, libro_fecha_publicacion, libro_idioma,libro_edicion, libro_costo, libro_paginas, libro_descripcion,libro_stock_actual, libro_stock_real, libro_en_prestamo, libro_imagen, libro_Pasillo, libro_Estante, libro_Fila ) VALUES(@l1, @l2, @l3, @l4, @l5, @l6, @l7, @l8, @l9, @l10, @l11, @l12, @l13, @l14, @l15, @l16, @l17, @l18  )", cnx);

                //Pasamos los parámetros con los datos de la vista
                stm.Parameters.AddWithValue("@l1", l.Id.Trim());
                stm.Parameters.AddWithValue("@l2", l.Nombre.Trim());
                stm.Parameters.AddWithValue("@l3", l.Genero.Trim());
                stm.Parameters.AddWithValue("@l4", l.Autor);
                stm.Parameters.AddWithValue("@l5", l.Editorial);
                stm.Parameters.AddWithValue("@l6", l.FechaPublicacion);
                stm.Parameters.AddWithValue("@l7", l.Idioma.Trim());
                stm.Parameters.AddWithValue("@l8", l.Edicion);
                stm.Parameters.AddWithValue("@l9", l.Costo);
                stm.Parameters.AddWithValue("@l10", l.Paginas);
                stm.Parameters.AddWithValue("@l11", l.Descripcion.Trim());
                stm.Parameters.AddWithValue("@l12", l.StockReal);
                stm.Parameters.AddWithValue("@l13", l.StockReal);
                stm.Parameters.AddWithValue("@l14", 0);
                stm.Parameters.AddWithValue("@l15", l.Ruta.Trim());
                stm.Parameters.AddWithValue("@l16", l.Pasillo.Trim());
                stm.Parameters.AddWithValue("@l17", l.Estante.Trim());
                stm.Parameters.AddWithValue("@l18", l.Fila.Trim());
                stm.ExecuteNonQuery();                                                                  //Ejecutamos la consulta
                cnx.Close();                                                                            //Cerramos conexión
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaEcho('Libro registrado correctamente')", true);
                GrdLibros.DataBind();                                                                   //Actualizamos la tablita
                LimpiarCampos();
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
            }
        }

        //Método para actualizar el Libro
        public void UpdateLibro() {
            Libro l = new Libro();
            try {
                //Traemos los datos de la vista
                l.Id = txtIdLibro.Text;
                l.Nombre = txtNombre.Text;
                l.Idioma = drpLenguaje.SelectedItem.Value;
                l.Editorial = drpEditorial.SelectedItem.Value;
                l.Autor = drpAutor.SelectedItem.Value;

                l.FechaPublicacion = Convert.ToDateTime(txtFechaPublicacion.Text);
                l.Edicion = Convert.ToInt32(txtEdicion.Text);
                l.Costo = Convert.ToDecimal(txtCosto.Text);
                l.Paginas = Convert.ToInt32(txtPaginas.Text);
                l.StockReal = Convert.ToInt32(txtStockReal.Text);
                l.StockActual = Convert.ToInt32(txtStockActual.Text);

                l.Descripcion = txtDescripcion.Text;

                l.Pasillo = txtPasillo.Text;
                l.Estante = txtEstante.Text;
                l.Fila = txtFila.Text;

                //Checamos si el stock real que traemos de la vista es el mismo que el de la BD del botón ir
                if (stock_real == l.StockReal) {
                    stock_real = l.StockReal;
                } else {
                    //Comprobamos que no se metan un stock menor a los libros que se tienen en prestamo
                    if (l.StockReal < prestados) {
                        ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('No puede tener más libros prestados que los que hay en stock')", true);
                        return;
                    } else {
                        //Calculamos el stock actual en base al real y los prestados
                        l.StockActual = l.StockReal - prestados;
                        txtStockActual.Text = "" + l.StockActual;
                    }
                }


                //Para los géneros al ser selección multiple los ponemos en una cadena
                l.Genero = "";
                foreach (int i in lstGenero.GetSelectedIndices()) {
                    l.Genero += lstGenero.Items[i] + ",";
                }
                //Eliminamos la coma final que no se ocupa
                l.Genero = l.Genero.Remove(l.Genero.Length - 1);

                //Ruta general donde guardar las imagenes
                l.Ruta = "~/Imagenes/Inventario/inventario.png";
                //Nombre del arhivo que subimos en el componente
                String NombreArchivo = Path.GetFileName(FileImg.PostedFile.FileName);
                //Si el usuario no ha ingresado una nueva imagen toma la del botón ir con la variable global
                if (NombreArchivo == "" || NombreArchivo == null) {
                    NombreArchivo = ruta_imagen;
                } else {
                    //Ruta para guardar la imagen
                    FileImg.SaveAs(Server.MapPath("Imagenes/Inventario/" + NombreArchivo));
                    l.Ruta = "~/Imagenes/Inventario/" + NombreArchivo;
                }

                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                //Creamos la consulta con los campos correspondientes, y con parámetros para facilidad y seguridad
                SqlCommand stm = new SqlCommand("UPDATE tbl_libros SET libro_nombre = @l1," +
                                                                        "libro_genero = @l2," +
                                                                        "libro_autor = @l3," +
                                                                        "libro_editorial = @l4," +
                                                                        "libro_fecha_publicacion = @l5," +
                                                                        "libro_idioma = @l6," +
                                                                        "libro_edicion = @l7," +
                                                                        "libro_costo = @l8," +
                                                                        "libro_paginas = @l9," +
                                                                        "libro_descripcion = @l10," +
                                                                        "libro_stock_actual = @l11," +
                                                                        "libro_stock_real = @l12," +

                                                                        "libro_Pasillo = @l13," +
                                                                        "libro_Estante = @l14," +
                                                                        "libro_Fila = @l15," +
                                                                        "libro_imagen = @l16  WHERE libro_id = @libro_id", cnx);
                //Pasamos los parámetros con los datos de la vista
                stm.Parameters.AddWithValue("@l1", l.Nombre.Trim());
                stm.Parameters.AddWithValue("@l2", l.Genero.Trim());
                stm.Parameters.AddWithValue("@l3", l.Autor);
                stm.Parameters.AddWithValue("@l4", l.Editorial);
                stm.Parameters.AddWithValue("@l5", l.FechaPublicacion);
                stm.Parameters.AddWithValue("@l6", l.Idioma.Trim());
                stm.Parameters.AddWithValue("@l7", l.Edicion);
                stm.Parameters.AddWithValue("@l8", l.Costo);
                stm.Parameters.AddWithValue("@l9", l.Paginas);
                stm.Parameters.AddWithValue("@l10", l.Descripcion.Trim());
                stm.Parameters.AddWithValue("@l11", l.StockActual);
                stm.Parameters.AddWithValue("@l12", l.StockReal);

                stm.Parameters.AddWithValue("@l13", l.Pasillo.Trim());
                stm.Parameters.AddWithValue("@l14", l.Estante.Trim());
                stm.Parameters.AddWithValue("@l15", l.Fila.Trim());

                stm.Parameters.AddWithValue("@l16", NombreArchivo.Trim());
                stm.Parameters.AddWithValue("@libro_id", l.Id.Trim());
                //Ejecutamos la consulta
                stm.ExecuteNonQuery();
                //Cerramos conexión
                cnx.Close();
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaEcho('Libro actualizado correctamente')", true);
                GrdLibros.DataBind();                                                                   //Actualizamos la tablita
                LimpiarCampos();
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
            }
        }

        //Método para eliminar un Libro
        public void DeleteLibro() {
            Libro l = new Libro();
            //Obtenemos el id del libro a eliminar
            l.Id = txtIdLibro.Text.Trim();
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                //Creamos la consulta con los campos correspondientes, y con parámetros para facilidad y seguridad
                SqlCommand stm = new SqlCommand("DELETE FROM tbl_libros WHERE libro_id = @libro_id", cnx);
                //Pasamos los parámetros con los datos de la vista
                stm.Parameters.AddWithValue("@libro_id", l.Id.Trim());
                //Ejecutamos la consulta
                stm.ExecuteNonQuery();
                //Cerramos conexión
                cnx.Close();
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaEcho('Libro eliminado correctamente')", true);
                LimpiarCampos();
                //Actualizamos la tablita
                GrdLibros.DataBind();
            } catch (SqlException ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('No puede eliminar un libro que esta en préstamo')", true);
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
            }
        }

        //Método para limpiar los campos
        public void LimpiarCampos() {
            //Ponemos todos los campos en blanco
            txtNombre.Text = "";
            txtIdLibro.Text = "";
            txtFechaPublicacion.Text = "";
            lstGenero.ClearSelection();
            txtEdicion.Text = "";
            txtCosto.Text = "";
            txtPaginas.Text = "";
            txtStockReal.Text = "";
            txtStockActual.Text = "";
            txtEnPrestamo.Text = "";
            txtDescripcion.Text = "";
            txtPasillo.Text = "";
            txtEstante.Text = "";
            txtFila.Text = "";
        }

        //Método para el botón de ir 
        public void Ir(object sender, EventArgs e) {
            Libro l = new Libro();
            //Traemos el id del libro a buscar
            l.Id = txtIdLibro.Text.Trim();
            //Si no existe el libro con ese id lo notificamos
            if (!ExisteLibro()) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaInfo('No se encuentra un libro con este id, por favor elija otro diferente')", true);
            }
            //Llenamos los campos con los datos de la BD coincidentes con el Id del libro
            else {
                try {
                    SqlConnection cnx = new SqlConnection(CadenaCnx);
                    //Veemos si la conexión está cerrada
                    if (cnx.State == ConnectionState.Closed) {
                        //Abrimos la conexión
                        cnx.Open();
                    }
                    SqlCommand stm = new SqlCommand("SELECT * FROM tbl_libros WHERE libro_id ='" + l.Id.Trim() + "'", cnx);          //Creamos la consulta select
                    SqlDataReader da = stm.ExecuteReader();
                    if (da.HasRows) {                                                                            //Vemos si hay registros coincidentes
                        while (da.Read()) {                                                                      //Mientras exista información de los registros
                                                                                                                 //Si se encontró el Libro, rellenamos los campos con la posición de la BD
                            txtNombre.Text = da.GetValue(1).ToString();
                            drpAutor.SelectedValue = da.GetValue(3).ToString();
                            drpEditorial.SelectedValue = da.GetValue(4).ToString();

                            txtFechaPublicacion.Text = Convert.ToDateTime(da.GetValue(5)).ToString("yyyy-MM-dd");

                            drpLenguaje.SelectedValue = da.GetValue(6).ToString();
                            txtEdicion.Text = "" + Convert.ToInt32(da.GetValue(7).ToString());

                            txtCosto.Text = "" + Convert.ToInt32(da.GetValue(8).ToString());
                            txtPaginas.Text = "" + Convert.ToInt32(da.GetValue(9).ToString());
                            txtStockReal.Text = da.GetValue(12).ToString();
                            txtStockActual.Text = da.GetValue(11).ToString();

                            txtEnPrestamo.Text = "" + (Convert.ToInt32(da.GetValue(12)) - Convert.ToInt32(da.GetValue(11)));

                            txtDescripcion.Text = da.GetValue(10).ToString();

                            txtPasillo.Text = da.GetValue(15).ToString();
                            txtEstante.Text = da.GetValue(16).ToString();
                            txtFila.Text = da.GetValue(17).ToString();

                            //Limpiamos los seleccionados de la lista de generos para llenarla con los de la BD
                            lstGenero.ClearSelection();
                            //Guardamos cada genero en un array separandolos con el split cada que encuentra ,
                            string[] genero = da.GetValue(2).ToString().Trim().Split(',');
                            for (int i = 0; i < genero.Length; i++) {
                                for (int j = 0; j < lstGenero.Items.Count; j++) {
                                    if (lstGenero.Items[j].ToString() == genero[i]) {
                                        //Selecciona el género
                                        lstGenero.Items[j].Selected = true;
                                    }
                                }
                            }
                            //Llenamos las variables globales con los valores de la BD
                            stock_real = Convert.ToInt32(da.GetValue(12).ToString());
                            stock_actual = Convert.ToInt32(da.GetValue(11).ToString());
                            prestados = stock_real - stock_actual;
                            ruta_imagen = da.GetValue(14).ToString();

                        }
                    } else {
                        ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaInfo('No se encuentra el libro deseado')", true);
                    }
                } catch (Exception ex) {
                    ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
                }
            }
        }

        //Métdo para verificar si el Libro existe
        public bool ExisteLibro() {
            Libro l = new Libro();
            //Traemos el id del libro desde el campo de la vista
            l.Id = txtIdLibro.Text.Trim();
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                SqlCommand stm = new SqlCommand("SELECT * FROM tbl_libros WHERE libro_id ='" + l.Id.Trim() + "'", cnx);          //Creamos la consulta select
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

        //Método para llenar los droplist de autores y editoriales
        public void LlenarAutor() {
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                //Creamos la consulta con los campos correspondientes, y con parámetros para facilidad y seguridad
                SqlCommand stm = new SqlCommand("SELECT autor_id, autor_nombre FROM tbl_autor", cnx);
                SqlDataAdapter adapter = new SqlDataAdapter(stm);
                DataTable table = new DataTable();
                adapter.Fill(table);
                //Llenamos el droplist con los valores de la tabla en el campo de autor
                drpAutor.DataSource = table;
                drpAutor.DataValueField = "autor_id";
                drpAutor.DataTextField = "autor_nombre";
                drpAutor.DataBind();
            } catch (Exception ex) {
                ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaFallo('" + ex.Message + "')", true);
            }
        }
        public void LlenarEditorial() {
            try {
                SqlConnection cnx = new SqlConnection(CadenaCnx);
                //Veemos si la conexión está cerrada
                if (cnx.State == ConnectionState.Closed) {
                    //Abrimos la conexión
                    cnx.Open();
                }
                //Creamos la consulta con los campos correspondientes, y con parámetros para facilidad y seguridad
                SqlCommand stm = new SqlCommand("SELECT editorial_id, editorial_nombre FROM tbl_editorial", cnx);
                SqlDataAdapter adapter = new SqlDataAdapter(stm);
                DataTable table = new DataTable();
                adapter.Fill(table);
                //Llenamos el droplist con los datos de la tabla en el campo nombre de editorial
                drpEditorial.DataSource = table;
                drpEditorial.DataValueField = "editorial_id";
                drpEditorial.DataTextField = "editorial_nombre";
                drpEditorial.DataBind();
            } catch (Exception ex) {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }
    }
}