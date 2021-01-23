<%@ Page Title="" Language="C#" MasterPageFile="~/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="perfilUsuario.aspx.cs" Inherits="Librería.perfilUsuario" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $(".table").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-7 col-md-10 col-sm-10 offset-sm-2 offset-md-2 mx-auto">
                <div class="card border-light mb-2 nuevaSeccion">
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <img class="imagenLogin" src="Imagenes/logo.png" style="width:250px"/>
                                <h4 class="text text-center">Prestamos</h4>
                                <center><span class="badge badge-pill badge-info">Historial</span></center>
                            </div>
                        </div>
                        <!-- Linea para dar más estilo-->
                        <div class="row"><div class="col"><hr style="background-color:red"/></div></div>

                        <div class="row">
                            <div class="col">
                                <asp:GridView ID="GridPerfil" runat="server" class="table table-striped table-bordered" OnRowDataBound="PrestamosVencidos">

                                </asp:GridView>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            
            <div class="col-lg-5 col-md-10 col-sm-10 offset-sm-2 offset-md-2 mx-auto">
                <div class="card border-danger mb-2 nuevaSeccion">
                    <div class="card-body">   
                        <!-- Imagen con icono de usuario -->
                        <div class="row">
                            <div class="col">
                                <img class="imagenLogin" src="Imagenes/loginUsuario.png" /><br/>
                                <h4 class="text text-center">Perfil</h4>
                                <center><span>Estatus del perfil <asp:Label ID="lblEstatus" runat="server" Text="Activo" class="badge badge-pill badge-info"></asp:Label></span></center>
                            </div>
                        </div>

                        <!-- Linea para dar más estilo-->
                        <div class="row"><div class="col"><hr style="background-color:red"/></div></div>

                        <!-- Formulario para los datos del usuario, no lleva la etiqueta form por qué esta esta desde la página maestra -->
                        <div class="row">
                             <div class="col-md-4">
                                 <div class="form-group">
                                    <label for="txtApellidoPaterno">Apellido Paterno</label>
                                    <asp:TextBox class="form-control" ID="txtApellidoPaterno" runat="server" placeholder="Ingrese su apellido:"></asp:TextBox>
                                </div>
                             </div>
                            <div class="col-md-4">
                                 <div class="form-group">
                                    <label for="txtApellidoMaterno">Apellido Materno</label>
                                    <asp:TextBox class="form-control" ID="txtApellidoMaterno" runat="server" placeholder="Ingrese su apellido:"></asp:TextBox>
                                </div>
                             </div>
                             <div class="col-md-4">
                                 <div class="form-group">
                                    <label for="txtNombre">Nombre(s)</label>
                                    <asp:TextBox class="form-control" ID="txtNombre" runat="server" placeholder="Ingrese su nombre:"></asp:TextBox>
                                </div>
                             </div>
                         </div>

                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="txtCorreo">Correo eléctronico</label>
                                    <asp:TextBox class="form-control" ID="txtCorreo" runat="server" placeholder="Ingrese su correo:" TextMode="Email"></asp:TextBox>
                                </div>
                            </div>
                             <div class="col-md-4">
                                 <div class="form-group">
                                    <label for="txtTelefono">Teléfono</label>
                                    <asp:TextBox class="form-control" ID="txtTelefono" runat="server" placeholder="Ingrese su número:"></asp:TextBox>
                                </div>
                             </div>
                             <div class="col-md-4">
                                <div class="form-group">
                                    <label for="txtNacimiento">Fecha de nacimiento</label>
                                    <asp:TextBox class="form-control" ID="txtNacimiento" runat="server" placeholder="dd-mm-aa" TextMode="Date"></asp:TextBox>
                                </div>
                             </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="txtCalle">Calle</label>
                                    <asp:TextBox class="form-control" ID="txtCalle" runat="server" placeholder="Ingrese su calle:"></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="txtNumero">Número/Lote</label>
                                    <asp:TextBox class="form-control" ID="txtNumero" runat="server" placeholder="Ingrese su número:"></asp:TextBox>
                                </div>
                            </div>
                        </div>

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
                                </div>
                             </div>
                             <div class="col-md-4">
                                 <div class="form-group">
                                    <label for="txtCP">Código Postal</label>
                                    <asp:TextBox class="form-control" ID="txtCP" runat="server" placeholder="Ingrese el código postal:" TextMode="Number"></asp:TextBox>
                                </div>
                             </div>
                             <div class="col-md-4">
                                 <div class="form-group">
                                    <label for="txtMunicipio">Municipio</label>
                                    <asp:TextBox class="form-control" ID="txtMunicipio" runat="server" Text="Texcoco" ReadOnly="true"></asp:TextBox>
                                </div>
                             </div>
                         </div>

                        <div class="row">
                            <div class="col-md-12">
                                <br/><center><span class="badge badge-danger text-center" ">Datos de inicio de sesión</span></center><br/>
                            </div>
                        </div>

                        <div class="row">
                             <div class="col-md-4">
                                 <div class="form-group">
                                    <label for="txtUsuario">Usuario</label>
                                    <asp:TextBox class="form-control" ID="txtUsuario" runat="server" placeholder="Usuario actual" ReadOnly="true"></asp:TextBox>
                                </div>
                             </div>
                             <div class="col-md-4">
                                 <div class="form-group">
                                    <label for="txtPassword">Contraseña actual</label>
                                    <asp:TextBox class="form-control" ID="txtPassword" runat="server" placeholder="Contraseña actual" ReadOnly="true"></asp:TextBox>
                                </div>
                             </div>
                             <div class="col-md-4">
                                 <div class="form-group">
                                    <label for="txtNuevaContrasenia">Nueva contraseña</label>
                                    <asp:TextBox class="form-control" ID="txtNuevaContrasenia" runat="server" placeholder="Ingrese su contraseña:" TextMode="Password"></asp:TextBox>
                                </div>
                             </div>
                         </div>

                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <asp:Button id="btnActualizar" Text="Actualizar" class="btn btn-danger btn-block" runat="server" OnClick="Actualizar"></asp:Button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <a href="default.aspx" class="text-danger">
                    <i class="far fa-arrow-alt-circle-left"></i> Regresar al inicio
                </a>
            </div>
            
        </div>
        <div class="row subSeccion"><div class="col-12"></div></div>
    </div>
        </span>
</asp:Content>
