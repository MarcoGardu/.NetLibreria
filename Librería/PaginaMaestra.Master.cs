using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Librería {
    public partial class _default : System.Web.UI.MasterPage {
        protected void Page_Init(object sender, EventArgs e) {
           
        }
        protected void Page_Load(object sender, EventArgs e) {
            try {
                //Checamos si la persona logeada tiene el rol para permisos
                if (Session["rol"].Equals("")) {                        //Si no tiene rol habilitamos los botones basicos
                    btnVerLibros.Visible = true;                        //Botón para ver los libros
                    btnLogin.Visible = true;                            //Botón para hacer login
                    btnRegistrarse.Visible = true;                      //Botón para registraarse

                    btnPerfil.Visible = false;                          //Botón para ver el perfil
                    btnSalir.Visible = false;                           //Botón para salir del login

                    btnloginAdmin.Visible = true;                       //Botón para login como admin
                    btnInventario.Visible = false;                      //Botón para ver el inventario como admin
                    btnPrestamos.Visible = false;                       //Botón para gestionar los prestamos como admin
                    btnUsuarios.Visible = false;                        //Botón para gestionar usuarios como admin
                    btnAutores.Visible = false;                         //Botón para gestionar autores como admin
                    btnEditoriales.Visible = false;                     //Botón para gestionar editoriales
                } else if (Session["rol"].Equals("usuario")) {          //Si el rol es usuario
                    btnVerLibros.Visible = true;                        //Botón para ver los libros
                    btnLogin.Visible = false;                           //Botón para hacer login
                    btnRegistrarse.Visible = false;                     //Botón para registraarse

                    btnPerfil.Visible = true;                           //Botón para ver el perfil
                    btnPerfil.Text = "Hola " + Session["username"].ToString();
                    btnSalir.Visible = true;                            //Botón para salir del login

                    btnloginAdmin.Visible = false;                      //Botón para login como admin
                    btnInventario.Visible = false;                      //Botón para ver el inventario como admin
                    btnPrestamos.Visible = false;                       //Botón para gestionar los prestamos como admin
                    btnUsuarios.Visible = false;                        //Botón para gestionar usuarios como admin
                    btnAutores.Visible = false;                         //Botón para gestionar autores como admin
                    btnEditoriales.Visible = false;                     //Botón para gestionar editoriales
                } else if (Session["rol"].Equals("admin")) {            //Si el rol es administrador
                    btnVerLibros.Visible = false;                       //Botón para ver los libros
                    btnLogin.Visible = false;                           //Botón para hacer login
                    btnRegistrarse.Visible = false;                     //Botón para registraarse

                    btnPerfil.Visible = false;                           //Botón para ver el perfil
                    btnSalir.Visible = true;                            //Botón para salir del login

                    btnloginAdmin.Visible = false;                      //Botón para login como admin
                    btnInventario.Visible = true;                       //Botón para ver el inventario como admin
                    btnPrestamos.Visible = true;                        //Botón para gestionar los prestamos como admin
                    btnUsuarios.Visible = true;                         //Botón para gestionar usuarios como admin
                    btnAutores.Visible = true;                          //Botón para gestionar autores como admin
                    btnEditoriales.Visible = true;                      //Botón para gestionar editoriales
                }
            } catch (Exception ex) {
                Session["rol"] = "";
            }
        }
        //Reedirecciones para el usuario
        protected void verLibros(object sender, EventArgs e) { Response.Redirect("libros.aspx"); }
        protected void registrarse(object sender, EventArgs e) { Response.Redirect("Registrarse.aspx"); }
        protected void loginUser(object sender, EventArgs e) { Response.Redirect("login.aspx"); }
        protected void verPerfil(object sender, EventArgs e) { Response.Redirect("perfilUsuario.aspx"); }
        protected void salir(object sender, EventArgs e) { Response.Redirect("default.aspx"); }
        //Reedirecciones para el administrador
        protected void loginAdmin(object sender, EventArgs e) { Response.Redirect("adminLogin.aspx"); }
        protected void verInventario(object sender, EventArgs e) { Response.Redirect("inventario.aspx"); }
        protected void verPrestamos(object sender, EventArgs e) { Response.Redirect("prestamos.aspx"); }
        protected void verUsuarios(object sender, EventArgs e) { Response.Redirect("gestionUsuarios.aspx"); }
        protected void verAutores(object sender, EventArgs e) { Response.Redirect("Autor.aspx"); }
        protected void verEditoriales(object sender, EventArgs e) { Response.Redirect("editoriales.aspx"); }

        //Método para cerrar la sesión
        public void logout(object sender, EventArgs e) {
            Session["username"] = "";
            Session["nombre"] = "";
            Session["rol"] = "";

            btnVerLibros.Visible = true;        //Botón para ver los libros
            btnLogin.Visible = true;            //Botón para hacer login
            btnRegistrarse.Visible = true;      //Botón para registraarse

            btnPerfil.Visible = false;          //Botón para ver el perfil
            btnSalir.Visible = false;           //Botón para salir del login

            btnloginAdmin.Visible = true;       //Botón para login como admin
            btnInventario.Visible = false;      //Botón para ver el inventario como admin
            btnPrestamos.Visible = false;       //Botón para gestionar los prestamos como admin
            btnUsuarios.Visible = false;        //Botón para gestionar usuarios como admin
            btnAutores.Visible = false;         //Botón para gestionar autores como admin
            btnEditoriales.Visible = false;     //Botón para gestionar editoriales

            Response.Redirect("Default.aspx");
        }
    }
}