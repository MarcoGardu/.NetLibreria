<%@ Page Title="" Language="C#" MasterPageFile="~/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="Autor.aspx.cs" Inherits="Librería.Autor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        //Función para el uso del DataTable con JQuery
        $(document).ready(function () {
            $(".table").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();
        });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-md-12 col-sm-12 mx-auto">
                <div class="card border-light mb-2 nuevaSeccion">
                    <div class="card-body">
                        <!-- Imagen con icono de usuario -->
                        <div class="row">
                            <div class="col">
                                <h4 class="text text-center">Autor</h4>
                                <hr />
                                <img class="imagenLogin" src="Imagenes/autor.png" /><br />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-5">
                                <div class="form-group">
                                    <label for="txtIdAutor">Id Autor</label>
                                    <div class="input-group">
                                        <asp:TextBox class="form-control" ID="txtIdAutor" runat="server" placeholder="Id:"></asp:TextBox>
                                        <asp:Button ID="btnIr" Text="Ir" class="btn btn-secondary" runat="server" OnClick="Ir"></asp:Button>
                                    </div>
                                    <asp:RequiredFieldValidator ID="Validator1" runat="server" ErrorMessage="&#9940; Campo requerido" ControlToValidate="txtIdAutor" CssClass="text-danger" ValidationGroup="registrar"></asp:RequiredFieldValidator><br />
                                    <asp:RequiredFieldValidator ID="Validator2" runat="server" ErrorMessage="&#9940; Campo requerido" ControlToValidate="txtIdAutor" CssClass="text-danger" ValidationGroup="Eliminar"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-7">
                                <div class="form-group">
                                    <label for="txtNombreAutor">Autor</label>
                                    <asp:TextBox class="form-control" ID="txtNombreAutor" runat="server" placeholder="Nombre del autor:"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="Validator3" runat="server" ErrorMessage="&#9940; Campo requerido" ControlToValidate="txtNombreAutor" CssClass="text-danger" ValidationGroup="registrar"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                        </div>

                        <div class="row">
                            <div class="col-lg-4">
                                <div class="form-group text-center">
                                    <asp:Button ID="btnAdd" Text="Añadir" class="btn btn-success " runat="server" OnClick="addAutor" ValidationGroup="registrar"></asp:Button>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="form-group text-center">
                                    <asp:Button ID="btnActualizar" Text="Actualizar" class="btn btn-info " runat="server" OnClick="actualizarAutor" ValidationGroup="registrar"></asp:Button>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="form-group text-center">
                                    <asp:Button ID="btnEliminar" Text="Eliminar" class="btn btn-danger" runat="server" OnClick="eliminarAutor" ValidationGroup="Eliminar"></asp:Button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <a href="default.aspx" class="text-danger">
                    <i class="far fa-arrow-alt-circle-left"></i>Regresar al inicio
                </a>
            </div>

            <div class="col-lg-6 col-md-12 col-sm-12 mx-auto">
                <div class="card border-light mb-2 nuevaSeccion">
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <h4 class="text text-center">Lista de autores</h4>
                            </div>
                        </div>
                        <!-- Linea para dar más estilo-->
                        <div class="row">
                            <div class="col">
                                <hr />
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:libreria_BD2ConnectionString %>" SelectCommand="SELECT * FROM [tbl_autor]"></asp:SqlDataSource>
                        <div class="col">
                            <asp:GridView ID="GrdAutor" runat="server" class="table table-striped table-bordered" AutoGenerateColumns="False" DataKeyNames="autor_id" DataSourceID="SqlDataSource1" BackColor="#FFEFD0">
                                <Columns>
                                    <asp:BoundField DataField="autor_id" HeaderText="Id" ReadOnly="True" SortExpression="autor_id" />
                                    <asp:BoundField DataField="autor_nombre" HeaderText="Nombre del autor" SortExpression="autor_nombre" />
                                </Columns>
                                <HeaderStyle BackColor="#663300" ForeColor="White" />
                            </asp:GridView>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <div class="row subSeccion"></div>
    <div class="row subSeccion"></div>
</asp:Content>
