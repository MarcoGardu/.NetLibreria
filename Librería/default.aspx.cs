using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Librería
{
    public partial class inicio : System.Web.UI.Page{
        protected void Page_Load(object sender, EventArgs e){
            if (!IsPostBack) {
                if (Session["rol"].Equals("admin") && Session["saludar"].Equals("1")) {
                    Session["saludar"] = "2";
                    ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaSaludo('Bienvenido " + Session["nombre"] + "', 'Le deseamos un día animado y productivo')", true);
                } else if (Session["rol"].Equals("usuario") && Session["saludar"].Equals("1")) {
                    Session["saludar"] = "2";
                    ClientScript.RegisterStartupScript(this.GetType(), "Registrado", "alertaSaludo('Bienvenido " + Session["username"] + "', 'agradecemos que haga uso de nuestro servicio')", true);
                }
            }
        }
    }
}