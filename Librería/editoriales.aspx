<%@ Page Title="" Language="C#" MasterPageFile="~/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="editoriales.aspx.cs" Inherits="Librería.publisherManagment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        //Funci´pn para el DataTable
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
                                <h4 class="text text-center">Editorial</h4><hr/>
                                <img class="imagenLogin" src="Imagenes/editorial.png" /><br/>
                            </div>
                        </div>

                        <!-- Linea para dar más estilo-->
                        <div class="row"><div class="col"><hr/></div></div>

                        <div class="row">
                            <div class="col-md-5">
                                <div class="form-group">
                                    <label for="txtIdEditorial">Id Editorial</label>
                                    <div class="input-group">
                                        <asp:TextBox class="form-control" ID="txtIdEditorial" runat="server" placeholder="Id:"></asp:TextBox>
                                        <asp:Button id="btnIr" Text="Ir" class="btn btn-secondary" runat="server" OnClick="IrEditorial"></asp:Button>
                                    </div>
                                    <asp:RequiredFieldValidator ID="Validator1" runat="server" ErrorMessage="&#9940; Campo requerido" ControlToValidate="txtIdEditorial" CssClass="text-danger" ValidationGroup="registrar"></asp:RequiredFieldValidator><br/>
                                    <asp:RequiredFieldValidator ID="Validator2" runat="server" ErrorMessage="&#9940; Campo requerido" ControlToValidate="txtIdEditorial" CssClass="text-danger" ValidationGroup="Eliminar"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                             <div class="col-md-7">
                                 <div class="form-group">
                                     <label for="txtEditorial">Editorial</label>
                                     <asp:TextBox class="form-control" ID="txtEditorial" runat="server" placeholder="Nombre de editorial:"></asp:TextBox>
                                     <asp:RequiredFieldValidator ID="Validator3" runat="server" ErrorMessage="&#9940; Campo requerido" ControlToValidate="txtEditorial" CssClass="text-danger" ValidationGroup="registrar"></asp:RequiredFieldValidator>
                                </div>
                             </div>
                             
                        </div>

                        <div class="row">
                            <div class="col-lg-4">
                                <div class="form-group text-center">
                                     <asp:Button id="btnAdd" Text="Añadir" class="btn btn-success btn-block" runat="server" OnClick="addEditorial" ValidationGroup="registrar"></asp:Button>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="form-group text-center">
                                    <asp:Button id="btnActualizar" Text="Actualizar" class="btn btn-info btn-block" runat="server" OnClick="actualizarEditorial" ValidationGroup="registrar"></asp:Button>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="form-group text-center">
                                    <asp:Button id="btnEliminar" Text="Eliminar" class="btn btn-danger btn-block" runat="server" OnClick="eliminarEditorial" ValidationGroup="Eliminar"></asp:Button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <a href="default.aspx" class="text-danger">
                    <i class="far fa-arrow-alt-circle-left"></i> Regresar al inicio
                </a>
            </div>

            <div class="col-lg-6 col-md-12 col-sm-12 mx-auto">
                <div class="card border-light mb-2 nuevaSeccion">
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <h4 class="text text-center">Lista de Editoriales</h4>
                            </div>
                        </div>
                        <!-- Linea para dar más estilo-->
                        <div class="row"><div class="col"><hr/></div></div>

                        <div class="row">
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:libreria_BD2ConnectionString %>" SelectCommand="SELECT * FROM [tbl_editorial]"></asp:SqlDataSource>
                            <div class="col">
                                <asp:GridView ID="GrdEditorial" runat="server" class="table table-striped table-bordered" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" BackColor="#FFCCFF">
                                    <Columns>
                                        <asp:BoundField DataField="editorial_id" HeaderText="Id" SortExpression="editorial_id" />
                                        <asp:BoundField DataField="editorial_nombre" HeaderText="Nombre de la editorial" SortExpression="editorial_nombre" />
                                    </Columns>
                                    <HeaderStyle BackColor="#660033" ForeColor="White" />
                                </asp:GridView>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <div class="row subSeccion"></div>
        <div class="row subSeccion"></div>
    </div>
</asp:Content>
