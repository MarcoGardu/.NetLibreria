<%@ Page Title="" Language="C#" MasterPageFile="~/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="gestionUsuarios.aspx.cs" Inherits="Librería.gestionUsuarios" %>
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
            <div class="col-lg-5 col-md-10 col-sm-10 mx-auto">
                <div class="card border-light mb-2 nuevaSeccion">
                    <div class="card-body">
                        <!-- Imagen con icono de usuario -->
                        <div class="row">
                            <div class="col">
                                <h4 class="text text-center">Detalles de usuario</h4><hr />
                                <img class="imagenLogin" src="Imagenes/loginUsuario.png" /><br/>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4">
                                <label>Usuario</label>
                                <div class="form-group">
                                    <div class="input-group">
                                      <asp:TextBox class="form-control" ID="txtUsuario" runat="server" placeholder="Usuario"></asp:TextBox>
                                      <asp:LinkButton class="btn btn-primary" ID="LinkButton4" runat="server" OnClick="Buscar" ValidationGroup="buscar"><i class="fas fa-check-circle"></i></asp:LinkButton>
                                    </div>
                                    <asp:RequiredFieldValidator ID="Validator3" runat="server" ErrorMessage="&#9940; Campo requerido" ControlToValidate="txtUsuario" CssClass="text-danger" ValidationGroup="buscar"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <label>Apellido Paterno</label>
                                <div class="form-group">
                                    <asp:TextBox class="form-control" ID="txtApellidoPaterno" runat="server" placeholder="Apellido paterno" ReadOnly="True"></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <label>Apellido Materno</label>
                                <div class="form-group">
                                    <asp:TextBox class="form-control" ID="txtApellidoMaterno" runat="server" placeholder="Apellido materno" ReadOnly="True"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="row">

                            <div class="col-md-6">
                                <label>Nombre</label>
                                <div class="form-group">
                                    <asp:TextBox class="form-control" ID="txtNombre" runat="server" placeholder="Nombre" ReadOnly="True"></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label>Estatus</label>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox CssClass="form-control mr-1" ID="txtEstatus" runat="server" placeholder="Estatus:" ReadOnly="True"></asp:TextBox>
                                        <asp:LinkButton class="btn btn-success mr-1" ID="btnActivo" runat="server" OnClick="ActivarCuenta" ValidationGroup="buscar"><i class="fas fa-check-circle"></i></asp:LinkButton>
                                        <asp:LinkButton class="btn btn-warning mr-1" ID="btPediente" runat="server" OnClick="SuspenderCuenta" ValidationGroup="buscar"><i class="far fa-pause-circle"></i></asp:LinkButton>
                                        <asp:LinkButton class="btn btn-danger mr-1" ID="btnInactivo" runat="server" OnClick="BajaCuenta" ValidationGroup="buscar"><i class="fas fa-times-circle"></i></asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4">
                                <label>Teléfono</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="txtTelefono" runat="server" placeholder="Teléfono" ReadOnly="True"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label>Correo</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="TxtCorreo" runat="server" placeholder="Correo" ReadOnly="True"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label>Fecha de nacimiento</label>
                                <div class="form-group">
                                    <asp:TextBox class="form-control" ID="txtNacimiento" runat="server" placeholder="Fecha de nacimiento" ReadOnly="True"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="txtCalle">Calle</label>
                                    <asp:TextBox class="form-control" ID="txtCalle" runat="server" placeholder="Ingrese su calle:" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="txtNumero">Número/Lote</label>
                                    <asp:TextBox class="form-control" ID="txtNumero" runat="server" placeholder="Ingrese su número:" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-4">
                                <label>Municipio</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="txtMunicipio" runat="server" placeholder="Municipio" ReadOnly="True"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <label>Colonia</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="txtColonia" runat="server" placeholder="Colonia" ReadOnly="True"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <label>Código Postal</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="txtCodigoPostal" runat="server" placeholder="C.P" ReadOnly="True"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-12 mx-auto">
                                <asp:Button ID="btnEliminar" class="btn btn-lg btn-block btn-danger btn-sm" runat="server" Text="Eliminar usuario" Onclick="EliminarCuenta" ValidationGroup="buscar"/>
                            </div>
                        </div>
                    </div>
                </div>
                <a href="default.aspx" class="text-danger">
                    <i class="far fa-arrow-alt-circle-left"></i> Regresar al inicio
                </a> <br/><br/>
            </div>

            <div class="col-lg-7 col-md-12 col-sm-12 mx-auto">
                <div class="card border-light mb-2 nuevaSeccion">
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <h4 class="text text-center">Lista de usuarios</h4>
                            </div>
                        </div>
                        <!-- Linea para dar más estilo-->
                        <div class="row"><div class="col"><hr/></div></div>

                        <div class="row">
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:libreria_BD2ConnectionString %>" SelectCommand="SELECT * FROM [tbl_usuario]"></asp:SqlDataSource>
                            <div class="col">
                                <asp:GridView ID="GridUsuarios" runat="server" class="table table-striped table-bordered" AutoGenerateColumns="False" DataKeyNames="usr_user" DataSourceID="SqlDataSource1" BackColor="#DBFFFF">
                                    <Columns>
                                        <asp:BoundField DataField="usr_user" HeaderText="Usuario" ReadOnly="True" SortExpression="usr_user" />
                                        <asp:BoundField DataField="usr_apellido_paterno" HeaderText="Apellido paterno" SortExpression="usr_apellido_paterno" />
                                        <asp:BoundField DataField="usr_nombre" HeaderText="Nombre" SortExpression="usr_nombre" />
                                        <asp:BoundField DataField="usr_correo" HeaderText="Correo" SortExpression="usr_correo" />
                                        <asp:BoundField DataField="usr_telefono" HeaderText="Teléfono" SortExpression="usr_telefono" />
                                        <asp:BoundField DataField="usr_estatus_cuenta" HeaderText="Estatus" SortExpression="usr_estatus_cuenta" />
                                    </Columns>
                                    <HeaderStyle BackColor="#0066FF" ForeColor="White" />
                                </asp:GridView>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
