<%@ Page Title="" Language="C#" MasterPageFile="~/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="prestamos.aspx.cs" Inherits="Librería.prestamos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        //Función para el uso del DataTable con JQuery
        $(document).ready(function () {
            $(".table").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-7 col-md-10 col-sm-10 mx-auto">
                <div class="card border-light mb-2 nuevaSeccion">
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <h4 class="text text-center">Listado de prestamos</h4>
                            </div>
                        </div>
                        <!-- Linea para dar más estilo-->
                        <div class="row">
                            <div class="col">
                                <hr />
                            </div>
                        </div>

                        <div class="row">
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:libreria_BD2ConnectionString %>" SelectCommand="SELECT L.libro_nombre, P.prst_id, P.prst_usuario, P.prst_fecha_inicio, P.prst_fecha_fin, P.prst_libro_id, U.usr_nombre, U.usr_apellido_paterno FROM tbl_prestamos AS P CROSS JOIN tbl_libros AS L CROSS JOIN tbl_usuario AS U WHERE U.usr_user = P.prst_usuario AND P.prst_libro_id = L.libro_id"></asp:SqlDataSource>
                            <div class="col">
                                <asp:GridView ID="GridPrestamos" runat="server" class="table table-striped table-bordered" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" OnRowDataBound="PrestamosVencidos" DataKeyNames="prst_id">
                                    <Columns>
                                        <asp:BoundField DataField="prst_usuario" HeaderText="Usuario" SortExpression="prst_usuario" />
                                        <asp:BoundField DataField="usr_nombre" HeaderText="Nombre" SortExpression="usr_nombre" />
                                        <asp:BoundField DataField="usr_apellido_paterno" HeaderText="Apellido" SortExpression="usr_apellido_paterno" />
                                        <asp:BoundField DataField="prst_libro_id" HeaderText="Código del libro" SortExpression="prst_libro_id" />
                                        <asp:BoundField DataField="libro_nombre" HeaderText="Libro" SortExpression="libro_nombre" />
                                        <asp:BoundField DataField="prst_fecha_inicio" DataFormatString="{0: dd-MM-yyyy}" HeaderText="Fecha de inicio" SortExpression="prst_fecha_inicio" />
                                        <asp:BoundField DataField="prst_fecha_fin" DataFormatString="{0: dd-MM-yyyy}" HeaderText="Fecha de entrega" SortExpression="prst_fecha_fin" />
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

            <div class="col-lg-5 col-md-10 col-sm-10 mx-auto">
                <div class="card border-light mb-2 nuevaSeccion">
                    <div class="card-body">
                        <!-- Imagen con icono de usuario -->
                        <div class="row">
                            <div class="col">
                                <h4 class="text text-center">Prestamos de libros</h4>
                                <hr />
                                <img class="imagenLogin" src="Imagenes/logo.png" /><br />
                            </div>
                        </div>

                        <!-- Linea para dar más estilo-->
                        <div class="row">
                            <div class="col">
                                <hr />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="txtUsuario">Usuario</label>
                                    <asp:TextBox class="form-control" ID="txtUsuario" runat="server" placeholder="Usuario"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="Validator1" runat="server" ErrorMessage="&#9940; Campo Requerido" ControlToValidate="txtUsuario" CssClass="text-danger" ValidationGroup="buscar"></asp:RequiredFieldValidator>
                                    <asp:RequiredFieldValidator ID="Validator2" runat="server" ErrorMessage="&#9940; Requerido" ControlToValidate="txtUsuario" CssClass="text-danger" ValidationGroup="Prestar"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="txtIdLibro">Id del libro</label>
                                    <div class="input-group">
                                        <asp:TextBox class="form-control" ID="txtIdLibro" runat="server" placeholder="Id libro:"></asp:TextBox>
                                        <asp:Button ID="btnIr" Text="Ir" class="btn btn-secondary" runat="server" OnClick="Ir" ValidationGroup="buscar"></asp:Button>
                                    </div>
                                    <asp:RequiredFieldValidator ID="Validator3" runat="server" ErrorMessage="&#9940; Campo Requerido" ControlToValidate="txtIdLibro" CssClass="text-danger" ValidationGroup="buscar"></asp:RequiredFieldValidator>
                                    <asp:RequiredFieldValidator ID="Validator4" runat="server" ErrorMessage="&#9940; Requerido" ControlToValidate="txtIdLibro" CssClass="text-danger" ValidationGroup="Prestar"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="txtNombre">Nombre del usuario</label>
                                    <asp:TextBox class="form-control" ID="txtNombre" runat="server" placeholder="Nombre" ReadOnly="true"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="&#9940; Campo Requerido" ControlToValidate="txtNombre" CssClass="text-danger" ValidationGroup="Prestar"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="txtLibro">Nombre del libro</label>
                                    <asp:TextBox class="form-control" ID="txtLibro" runat="server" placeholder="Libro" ReadOnly="true"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="&#9940; Campo Requerido" ControlToValidate="txtLibro" CssClass="text-danger" ValidationGroup="Prestar"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="txtPrestamo">Fecha de prestamo</label>
                                    <asp:TextBox class="form-control" ID="txtPrestamo" runat="server" placeholder="dd-mm-aa" TextMode="Date"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="Validator5" runat="server" ErrorMessage="&#9940; Campo requerido" ControlToValidate="txtPrestamo" CssClass="text-danger" ValidationGroup="Prestar"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="txtEntrega">Fecha de entrega</label>
                                    <asp:TextBox class="form-control" ID="txtEntrega" runat="server" placeholder="dd-mm-aa" TextMode="Date"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="Validator6" runat="server" ErrorMessage="&#9940; Campo requerido" ControlToValidate="txtEntrega" CssClass="text-danger" ValidationGroup="Prestar"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-6">
                                <div class="form-group text-center">
                                    <asp:Button ID="btnPrestar" Text="Prestar" class="btn btn-success btn-block" runat="server" OnClick="Prestamo" ValidationGroup="Prestar"></asp:Button>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="form-group text-center">
                                    <asp:Button ID="btnRegresado" Text="Regresado" class="btn btn-danger btn-block" runat="server" OnClick="Regreso" ValidationGroup="buscar"></asp:Button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <a href="default.aspx" class="text-danger">
                    <i class="far fa-arrow-alt-circle-left"></i>Regresar al inicio
                </a>
            </div>
        </div>
        <div class="row subSeccion"></div>
    </div>
</asp:Content>