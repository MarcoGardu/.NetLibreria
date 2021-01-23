<%@ Page Title="" Language="C#" MasterPageFile="~/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="Registrarse.aspx.cs" Inherits="Librería.Registrarse" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-9 mx-auto">
                <div class="card border-warning mb-3 nuevaSeccion">
                    <div class="card-body">
                        <!-- Imagen con icono de usuario -->
                        <div class="row">
                            <div class="col">
                                <img class="imagenLogin" src="Imagenes/registroUsuario.png" /><br />
                                <h4 class="text text-center">Registro de usuario</h4>
                            </div>
                        </div>

                        <!-- Linea para dar más estilo-->
                        <div class="row">
                            <div class="col">
                                <hr />
                            </div>
                        </div>
                        <!-- Div de las validaciones -->
                        <div class="row">
                            <div class="col-12">
                                <asp:ValidationSummary ID="ValidationSummary2" runat="server" HeaderText="<b>Errores encontrados:</b><br/>" ValidationGroup="Registro" DisplayMode="List" Font-Size="16px" CssClass="border-danger p-4 border rounded" />
                            </div>
                        </div>
                        <br />
                        <!-- Formulario para los datos del usuario, no lleva la etiqueta form por qué esta esta desde la página maestra -->
                        <div class="row">
                            <div class="col-md-4 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="txtApellidoPaterno">Apellido Paterno</label>
                                    <asp:TextBox class="form-control" ID="txtApellidoPaterno" runat="server" placeholder="Apellido paterno:"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="Validator1" runat="server" ErrorMessage="&#9940; Se requiere su apellido paterno" ControlToValidate="txtApellidoPaterno" CssClass="text-danger" ValidationGroup="Registro" Display="None"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="txtApellidoMaterno">Apellido Materno</label>
                                    <asp:TextBox class="form-control" ID="txtApellidoMaterno" runat="server" placeholder="Apellido materno:"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="Validator2" runat="server" ErrorMessage="&#9940; Se requiere su apellido materno" ControlToValidate="txtApellidoMaterno" CssClass="text-danger" ValidationGroup="Registro" Display="None"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label for="txtNombre">Nombre(s)</label>
                                    <asp:TextBox class="form-control" ID="txtNombre" runat="server" placeholder="Ingrese su nombre:"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="Validator3" runat="server" ErrorMessage="&#9940; Se requiere su nombre" ControlToValidate="txtNombre" CssClass="text-danger" ValidationGroup="Registro" Display="None"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <!-- Div correo, teléfono y fecha -->
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="txtCorreo">Correo eléctronico</label>
                                    <asp:TextBox class="form-control" ID="txtCorreo" runat="server" placeholder="Ingrese su correo:" TextMode="Email"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="Validator4" runat="server" ErrorMessage="&#9940; Se requiere un correo eléctronico" ControlToValidate="txtCorreo" CssClass="text-danger" ValidationGroup="Registro" Display="None"></asp:RequiredFieldValidator><br />
                                    <asp:RegularExpressionValidator ID="Regex1" runat="server" ErrorMessage="&#128313; Ingrese un correo con formato válido" CssClass="text-primary" ControlToValidate="txtCorreo" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" ValidationGroup="Registro" Display="None"></asp:RegularExpressionValidator>                                    
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="txtTelefono">Teléfono</label>
                                    <asp:TextBox class="form-control" ID="txtTelefono" runat="server" placeholder="Ingrese su número:"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="Validator5" runat="server" ErrorMessage="&#9940; Se requiere un número teléfonico" ControlToValidate="txtTelefono" CssClass="text-danger" ValidationGroup="Registro" Display="None"></asp:RequiredFieldValidator><br />
                                    <asp:RegularExpressionValidator ID="Regex2" runat="server" ErrorMessage="&#128313; Ingrese un télefono válido" CssClass="text-primary" ControlToValidate="txtTelefono" ValidationExpression="^[0-9]{2}[\-]?[0-9]{4}[\-]?[0-9]{4}" ValidationGroup="Registro" Display="None"></asp:RegularExpressionValidator>                                    
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="txtNacimiento">Fecha de nacimiento</label>
                                    <asp:TextBox class="form-control" ID="txtNacimiento" runat="server" placeholder="dd-mm-aa" TextMode="Date"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="Validator6" runat="server" ErrorMessage="&#9940; Se requiere una fecha de nacimiento" ControlToValidate="txtNacimiento" CssClass="text-danger" ValidationGroup="Registro" Display="None"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <!-- Div Calle y número -->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="txtCalle">Calle</label>
                                    <asp:TextBox class="form-control" ID="txtCalle" runat="server" placeholder="Ingrese su calle:"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="Validator7" runat="server" ErrorMessage="&#9940; Se requiere el nombre de calle" ControlToValidate="txtCalle" CssClass="text-danger" ValidationGroup="Registro" Display="None"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="txtNumeroLote">Número/Lote</label>
                                    <asp:TextBox class="form-control" ID="txtNumeroLote" runat="server" placeholder="Ingrese su número:"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="Validator8" runat="server" ErrorMessage="&#9940; Se requiere de un número de casa" ControlToValidate="txtNumeroLote" CssClass="text-danger" ValidationGroup="Registro" Display="None"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <!-- Div colonia, codigo postal y municipio-->
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="lstColonia">Colonia</label>
                                    <asp:DropDownList ID="lstColonia" class="form-control" runat="server">
                                        <asp:ListItem Text="El Tejocote" Value="El Tejocote"></asp:ListItem>
                                        <asp:ListItem Text="Santiago Cuautlalpan" Value="Santiago Cuautlalpan"></asp:ListItem>
                                        <asp:ListItem Text="El arenal" Value="El arenal"></asp:ListItem>
                                        <asp:ListItem Text="Miguel Hidalgo" Value="Miguel Hidalgo"></asp:ListItem>
                                        <asp:ListItem Text="San Pedro" Value="San Pedro"></asp:ListItem>
                                        <asp:ListItem Text="Otra" Value="Otra"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="Validator9" runat="server" ErrorMessage="&#9940; Se requiere una colonia" ControlToValidate="lstColonia" CssClass="text-danger" ValidationGroup="Registro" Display="None"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="txtCP">Código Postal</label>
                                    <asp:TextBox class="form-control" ID="txtCP" runat="server" placeholder="Ingrese el código postal:" TextMode="Number"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="Validator10" runat="server" ErrorMessage="&#9940; Se requiere un código postal" ControlToValidate="txtCP" CssClass="text-danger" ValidationGroup="Registro" Display="None"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="txtMunicipio">Municipio</label>
                                    <asp:TextBox class="form-control" ID="txtMunicipio" runat="server" Text="Texcoco" ReadOnly="true"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="Validator11" runat="server" ErrorMessage="&#9940; Se requiere un municipio" ControlToValidate="txtMunicipio" CssClass="text-danger" ValidationGroup="Registro" Display="None"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <br />
                                <center><span class="badge badge-warning text-center" ">Datos de inicio de sesión</span></center>
                                <br />
                            </div>
                        </div>
                        <!-- Div usuario y contraseña -->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="txtUsuario">Usuario</label>
                                    <asp:TextBox class="form-control" ID="txtUsuario" runat="server" placeholder="Ingrese su usuario:"></asp:TextBox>                                    
                                    <asp:RequiredFieldValidator ID="Validator13" runat="server" ErrorMessage="&#9940; Se requiere un usuario" Display="None" ControlToValidate="txtUsuario" CssClass="text-danger" ValidationGroup="Registro"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="txtPassword">Contraseña</label>
                                    <asp:TextBox class="form-control" ID="txtPassword" runat="server" placeholder="Ingrese su contraseña:" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="Validator14" runat="server" Display="none" ErrorMessage="&#9940; Se requiere una contraseña" ControlToValidate="txtPassword" CssClass="text-danger" ValidationGroup="Registro"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="Regex3" runat="server" Display="None" ErrorMessage="&#128313; La contraseña debe contener almenos 1 mayúscula y 8 caracteres" ControlToValidate="txtPassword" ValidationExpression="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$" ValidationGroup="Registro" CssClass="text-primary"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div>                        
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <asp:Button ID="btnRegistrarse" Text="Registrarse" class="btn btn-success btn-block" runat="server" OnClick="RegistrarUsuario" ValidationGroup="Registro"></asp:Button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <a href="default.aspx" class="text-warning">
                    <i class="far fa-arrow-alt-circle-left"></i>Regresar al inicio
                </a>
            </div>
        </div>
        <div class="row subSeccion"></div>
    </div>
</asp:Content>
