<%@ Page Title="" Language="C#" MasterPageFile="~/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="adminLogin.aspx.cs" Inherits="Librería.adminLogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-6 mx-auto">
                <div class="card border-success mb-3 nuevaSeccion">
                    <div class="card-body">
                        <!-- Imagen con icono de usuario -->
                        <div class="row">
                            <div class="col">
                                <img class="imagenLogin" src="Imagenes/loginAdmin.png" /><br />
                                <h4 class="text text-center">Administrador</h4>
                            </div>
                        </div>

                        <!-- Linea para dar más estilo-->
                        <div class="row"><div class="col"><hr/></div></div>

                        <!-- Formulario para los datos del usuario, no lleva la etiqueta form por qué esta esta desde la página maestra -->
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="txtUsuario">Usuario</label>
                                    <asp:TextBox class="form-control" ID="txtUsuario" runat="server" placeholder="Ingrese su usuario:"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="Validator1" runat="server" ErrorMessage="&#9940; Campo requerido" ControlToValidate="txtUsuario" CssClass="text-danger" ValidationGroup="logeo"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group">
                                    <label for="txtPassword">Contraseña</label>
                                    <asp:TextBox class="form-control" ID="txtPassword" runat="server" placeholder="Ingrese su contraseña:" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="Validator2" runat="server" ErrorMessage="&#9940; Campo requerido" ControlToValidate="txtPassword" CssClass="text-danger" ValidationGroup="logeo"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group">
                                    <asp:Button id="btnLogin" Text="Ingresar" class="btn btn-success btn-block" runat="server" OnClick="logeo" ValidationGroup="logeo"></asp:Button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <a href="default.aspx" class="text-success">
                    <i class="far fa-arrow-alt-circle-left"></i> Regresar al inicio
                </a>     
            </div>
        </div>

        <div class="row subSeccion"></div>
    </div>
</asp:Content>
