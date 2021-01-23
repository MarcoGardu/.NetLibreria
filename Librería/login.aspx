<%@ Page Title="" Language="C#" MasterPageFile="~/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Librería.login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-6 mx-auto">
                <div class="card border-info mb-3 nuevaSeccion">
                    <div class="card-body">
                        <!-- Imagen con icono de usuario -->
                        <div class="row">
                            <div class="col">
                                <img class="imagenLogin" src="Imagenes/loginUsuario.png" /><br />
                                <h4 class="text text-center">Login de usuario</h4>
                            </div>
                        </div>

                        <!-- Linea para dar más estilo-->
                        <div class="row">
                            <div class="col">
                                <hr />
                            </div>
                        </div>

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
                                    <asp:Button ID="btnLogin" Text="Ingresar" class="btn btn-success btn-block" runat="server" OnClick="logeo" ValidationGroup="logeo"></asp:Button>
                                </div>
                                <div class="form-group">
                                    <a href="Registrarse.aspx">
                                        <asp:Button runat="server" ID="btnRegistrarse" Text="Registrarse" OnClick="irRegistro" class="btn btn-info btn-block"></asp:Button>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <a href="default.aspx">
                    <i class="far fa-arrow-alt-circle-left"></i>Regresar al inicio
                </a>
            </div>
        </div>

        <div class="row subSeccion"></div>
    </div>
</asp:Content>
