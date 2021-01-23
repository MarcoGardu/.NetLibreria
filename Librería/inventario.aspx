<%@ Page Title="" Language="C#" MasterPageFile="~/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="inventario.aspx.cs" Inherits="Librería.inventario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        //Función para el uso del DataTable con JQuery
        $(document).ready(function () {
            $(".table").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();
        });
        //Función para leer las imagenes
        function leerImagen(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#imgView').attr('src', e.target.result);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
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
                                <h4 class="text text-center">Inventario</h4>
                                <hr />
                                <img class="imagenLogin" src="Imagenes/Inventario/inventario.png" id="imgView" /><br />
                            </div>
                        </div>
                        <!-- div de la imagen -->
                        <div class="row">
                            <div class="col-12">
                                <div class="form-group">
                                    <asp:FileUpload ID="FileImg" runat="server" class="form-control" OnChange="leerImagen(this);" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere insertar una imagen para nuevo registro" ControlToValidate="FileImg" CssClass="text-danger" ValidationGroup="registrar" ForeColor="Red" Display="none"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <!-- Div de las validaciones -->
                        <div class="row">
                            <div class="col-12">
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" HeaderText="<b>Errores encontrados:</b><br/>" ValidationGroup="registrar" DisplayMode="List" Font-Size="18px" CssClass="border-danger p-4 border rounded" />
                                <asp:ValidationSummary ID="ValidationSummary2" runat="server" HeaderText="<b>Errores encontrados:</b><br/>" ValidationGroup="buscar/eliminar" DisplayMode="List" Font-Size="18px" CssClass="border-danger p-4 border rounded" />
                                <asp:ValidationSummary ID="ValidationSummary3" runat="server" HeaderText="<b>Errores encontrados:</b><br/>" ValidationGroup="actualizar" DisplayMode="List" Font-Size="18px" CssClass="border-danger p-4 border rounded" />
                            </div>
                        </div>
                        <br />

                        <!-- Div nombre id y nombre -->
                        <div class="row">
                            <div class="col-md-4">
                                <label>Código de libro</label>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox class="form-control" ID="txtIdLibro" runat="server" placeholder="Código del libro:"></asp:TextBox>
                                        <asp:LinkButton class="btn btn-primary" ID="btnIr" runat="server" OnClick="Ir" ValidationGroup="buscar/eliminar"><i class="fas fa-check-circle"></i></asp:LinkButton>
                                    </div>
                                    <asp:RequiredFieldValidator ID="Validator1" runat="server" ErrorMessage="&#9940; Se requiere de un código de libro" ControlToValidate="txtIdLibro" CssClass="text-danger" ValidationGroup="buscar/eliminar" Display="none"></asp:RequiredFieldValidator><br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere de un código de libro para nuevo registro" ControlToValidate="txtIdLibro" CssClass="text-danger" ValidationGroup="registrar" Display="none"></asp:RequiredFieldValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere de un código de libro para actualizar registro" ControlToValidate="txtIdLibro" CssClass="text-danger" ValidationGroup="actualizar" Display="none"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="col-md-8">
                                <label>Nombre del libro</label>
                                <div class="form-group">
                                    <asp:TextBox class="form-control" ID="txtNombre" runat="server" placeholder="Nombre del libro:"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere de un libro para nuevo registro" ControlToValidate="txtNombre" CssClass="text-danger" ValidationGroup="registrar" Display="none"></asp:RequiredFieldValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere de un libro para actualizar registro" ControlToValidate="txtNombre" CssClass="text-danger" ValidationGroup="actualizar" Display="none"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>

                        <!-- Div idioma, autor, editorial, genero -->
                        <div class="row">
                            <div class="col-md-4">
                                <label>Idioma</label>
                                <div class="form-group">
                                    <asp:DropDownList class="form-control" ID="drpLenguaje" runat="server">
                                        <asp:ListItem Text="Español" Value="Español"></asp:ListItem>
                                        <asp:ListItem Text="Inglés" Value="Inglés"></asp:ListItem>
                                        <asp:ListItem Text="Alemán" Value="Alemán"></asp:ListItem>
                                        <asp:ListItem Text="Italiano" Value="Italiano"></asp:ListItem>
                                        <asp:ListItem Text="Francés" Value="Francés"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere un idioma para nuevo registro" ControlToValidate="drpLenguaje" CssClass="text-danger" ValidationGroup="registrar" Display="none"></asp:RequiredFieldValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere un idioma para actualizar registro" ControlToValidate="drpLenguaje" CssClass="text-danger" ValidationGroup="actualizar" Display="none"></asp:RequiredFieldValidator>
                                </div>
                                <label>Editorial</label>
                                <div class="form-group">
                                    <asp:DropDownList class="form-control" ID="drpEditorial" runat="server"></asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere una editorial para nuevo registro" ControlToValidate="drpEditorial" CssClass="text-danger" ValidationGroup="registrar" Display="none"></asp:RequiredFieldValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere una editorial para actualizar registro" ControlToValidate="drpEditorial" CssClass="text-danger" ValidationGroup="actualizar" Display="none"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label>Autor</label>
                                <div class="form-group">
                                    <asp:DropDownList class="form-control" ID="drpAutor" runat="server">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere un autor para nuevo registro" ControlToValidate="drpAutor" CssClass="text-danger" ValidationGroup="registrar" Display="none"></asp:RequiredFieldValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere un autor para actualizar registro" ControlToValidate="drpAutor" CssClass="text-danger" ValidationGroup="actualizar" Display="none"></asp:RequiredFieldValidator>
                                </div>
                                <label>Fecha de publicación</label>
                                <div class="form-group">
                                    <asp:TextBox runat="server" ID="txtFechaPublicacion" class="form-control" placeholder="dd-mm-aa" TextMode="Date"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere una fecha de publicación para nuevo registro" ControlToValidate="txtFechaPublicacion" CssClass="text-danger" ValidationGroup="registrar" Display="none"></asp:RequiredFieldValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator18" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere una fecha de publicación para actualizar registro" ControlToValidate="txtFechaPublicacion" CssClass="text-danger" ValidationGroup="actualizar" Display="none"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label>Género</label>
                                <div class="form-group">
                                    <asp:ListBox ID="lstGenero" runat="server" SelectionMode="Multiple" class="form-control" Rows="5">
                                        <asp:ListItem Text="Terror" Value="Terror"></asp:ListItem>
                                        <asp:ListItem Text="Drama" Value="Drama"></asp:ListItem>
                                        <asp:ListItem Text="Romance" Value="Romance"></asp:ListItem>
                                        <asp:ListItem Text="Comedia" Value="Comedia"></asp:ListItem>
                                        <asp:ListItem Text="Poesía" Value="Poesía"></asp:ListItem>
                                        <asp:ListItem Text="Ciencia" Value="Ciencia"></asp:ListItem>
                                        <asp:ListItem Text="Manga" Value="Manga"></asp:ListItem>
                                        <asp:ListItem Text="Novela" Value="Novela"></asp:ListItem>
                                        <asp:ListItem Text="Cuento" Value="Cuento"></asp:ListItem>
                                        <asp:ListItem Text="Fantasía" Value="Fantasía"></asp:ListItem>
                                        <asp:ListItem Text="Ficción" Value="Ficción"></asp:ListItem>
                                        <asp:ListItem Text="Paranormal" Value="Paranormal"></asp:ListItem>
                                        <asp:ListItem Text="Cultura" Value="Cultura"></asp:ListItem>
                                        <asp:ListItem Text="Teatro" Value="Teatro"></asp:ListItem>
                                        <asp:ListItem Text="Educación" Value="Educación"></asp:ListItem>
                                    </asp:ListBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requier de un nuevo género para nuevo registro" ControlToValidate="lstGenero" CssClass="text-danger" ValidationGroup="registrar" Display="None"></asp:RequiredFieldValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requier de un nuevo género para actualizar registro" ControlToValidate="lstGenero" CssClass="text-danger" ValidationGroup="actualizar" Display="None"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>

                        <!-- Div edición, costo, páginas -->
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="txtEdicion">Edición</label>
                                    <asp:TextBox class="form-control" ID="txtEdicion" runat="server" placeholder="Edición:"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere la edición del libro para nuevo registro" ControlToValidate="txtEdicion" CssClass="text-danger" ValidationGroup="registrar" Display="none"></asp:RequiredFieldValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere la edición del libro para actualizar registro" ControlToValidate="txtEdicion" CssClass="text-danger" ValidationGroup="actualizar" Display="none"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="txtCosto">Costo</label>
                                    <asp:TextBox class="form-control" ID="txtCosto" runat="server" placeholder="Costo:" TextMode="Number"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere el costo del libro para nuevo registro" ControlToValidate="txtCosto" CssClass="text-danger" ValidationGroup="registrar" Display="none"></asp:RequiredFieldValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator21" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere el costo del libro para actualizar registro" ControlToValidate="txtCosto" CssClass="text-danger" ValidationGroup="actualizar" Display="none"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="txtPaginas">Páginas</label>
                                    <asp:TextBox class="form-control" ID="txtPaginas" runat="server" placeholder="Páginas:" TextMode="Number"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere el número de páginas para nuevo registro" ControlToValidate="txtPaginas" CssClass="text-danger" ValidationGroup="registrar" Display="none"></asp:RequiredFieldValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere el número de páginas para actulizar registro" ControlToValidate="txtPaginas" CssClass="text-danger" ValidationGroup="actualizar" Display="none"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <!-- Pasillo, estante, fila -->
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="txtPasillo">Pasillo</label>
                                    <asp:TextBox class="form-control" ID="txtPasillo" runat="server" placeholder="Pasillo:"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator24" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere lel pasillo para nuevo registro" ControlToValidate="txtPasillo" CssClass="text-danger" ValidationGroup="registrar" Display="none"></asp:RequiredFieldValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator25" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere la edición del libro para actualizar registro" ControlToValidate="txtPasillo" CssClass="text-danger" ValidationGroup="actualizar" Display="none"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="txtEstante">Estante</label>
                                    <asp:TextBox class="form-control" ID="txtEstante" runat="server" placeholder="Estante:"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator26" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere el estante para nuevo registro" ControlToValidate="txtEstante" CssClass="text-danger" ValidationGroup="registrar" Display="none"></asp:RequiredFieldValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator27" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere el estante para actualizar registro" ControlToValidate="txtEstante" CssClass="text-danger" ValidationGroup="actualizar" Display="none"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="txtFila">Fila</label>
                                    <asp:TextBox class="form-control" ID="txtFila" runat="server" placeholder="Fila:"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator28" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere la fila para nuevo registro" ControlToValidate="txtFila" CssClass="text-danger" ValidationGroup="registrar" Display="none"></asp:RequiredFieldValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator29" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere la fila para actulizar registro" ControlToValidate="txtFila" CssClass="text-danger" ValidationGroup="actualizar" Display="none"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>

                        <!-- Div stock -->
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="txtStockReal">Stock real</label>
                                    <asp:TextBox class="form-control" ID="txtStockReal" runat="server" placeholder="Stock:" TextMode="Number"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage=" &nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere una cantidad de libros inicial para nuevo registro" ControlToValidate="txtStockReal" CssClass="text-danger" ValidationGroup="registrar" Display="none"></asp:RequiredFieldValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator23" runat="server" ErrorMessage=" &nbsp;&nbsp;&nbsp;&nbsp; &#9940; Se requiere una cantidad de libros inicial para actualizar registro" ControlToValidate="txtStockReal" CssClass="text-danger" ValidationGroup="actualizar" Display="none"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="txtStockActual">Stock Actual</label>
                                    <asp:TextBox class="form-control" ID="txtStockActual" runat="server" placeholder="Stock:" TextMode="Number" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="txtEnPrestamo">En prestamo</label>
                                    <asp:TextBox class="form-control" ID="txtEnPrestamo" runat="server" placeholder="Prestados:" TextMode="Number" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <!-- Div descripción -->
                        <div class="row">
                            <div class="col-12">
                                <div class="form-group">
                                    <asp:TextBox runat="server" class="form-control" ID="txtDescripcion" placeholder="Descripción:" TextMode="MultiLine"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <!-- Div botones -->
                        <div class="row">
                            <div class="col-lg-4">
                                <div class="form-group text-center">
                                    <asp:Button ID="btnAdd" Text="Añadir" class="btn btn-success btn-block" runat="server" OnClick="AddLibro" ValidationGroup="registrar"></asp:Button>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="form-group text-center">
                                    <asp:Button ID="btnActualizar" Text="Actualizar" class="btn btn-info btn-block" runat="server" OnClick="ActualizarLibro" ValidationGroup="actualizar"></asp:Button>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="form-group text-center">
                                    <asp:Button ID="btnEliminar" Text="Eliminar" class="btn btn-danger btn-block" runat="server" OnClick="EliminarLibro" ValidationGroup="buscar/eliminar"></asp:Button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <a href="default.aspx" class="text-danger">
                    <i class="far fa-arrow-alt-circle-left"></i>Regresar al inicio
                </a>
                <div class="row nuevaSeccion"></div>
            </div>

            <div class="col-lg-7 col-md-12 col-sm-12 mx-auto">
                <div class="card border-light mb-2">
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <h4 class="text text-center">Libros en inventarios</h4>
                            </div>
                        </div>
                        <!-- Linea para dar más estilo-->
                        <div class="row">
                            <div class="col">
                                <hr />
                            </div>
                        </div>

                        <div class="row">
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:libreria_BD2ConnectionString %>" SelectCommand="SELECT * FROM tbl_libros, tbl_editorial, tbl_autor WHERE editorial_id = libro_editorial AND autor_id = libro_autor"></asp:SqlDataSource>
                            <div class="col">
                                <asp:GridView ID="GrdLibros" runat="server" class="table table-striped table-bordered" AutoGenerateColumns="False" DataKeyNames="libro_id" DataSourceID="SqlDataSource1" BackColor="#FFEEFE">
                                    <Columns>
                                        <asp:BoundField DataField="libro_id" HeaderText="Código" ReadOnly="True" SortExpression="libro_id" ItemStyle-CssClass="align-middle">
                                            <ItemStyle CssClass="align-middle" Font-Bold="True"></ItemStyle>
                                        </asp:BoundField>

                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <div class="container-fluid">
                                                    <div class="row">
                                                        <div class="col-lg-10 col-md-12">
                                                            <div class="row">
                                                                <div class="col-12">
                                                                    <asp:Label runat="server" ID="lblTitulo" Text='<%# Eval("libro_nombre") %>' Font-Size="X-Large" Font-Bold="true"></asp:Label>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-5">
                                                                    <b>Autor:</b>
                                                                    <asp:Label ID="lblAutorLibro" runat="server" Text='<%# Eval("autor_nombre") %>' Font-Italic="true"></asp:Label>
                                                                </div>
                                                                <div class="col-4">
                                                                    <b>Género:</b>
                                                                    <asp:Label ID="lblGeneroLibro" runat="server" Text='<%# Eval("libro_genero") %>' Font-Italic="true"></asp:Label>
                                                                </div>
                                                                <div class="col-3">
                                                                    <b>Idioma:</b>
                                                                    <asp:Label ID="lblIdiomaLibro" runat="server" Text='<%# Eval("libro_idioma") %>' Font-Italic="true"></asp:Label>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-5">
                                                                    <b>Editorial:</b>
                                                                    <asp:Label ID="lblEditorialLibro" runat="server" Text='<%# Eval("editorial_nombre") %>' Font-Italic="true"></asp:Label>
                                                                </div>
                                                                <div class="col-4">
                                                                    <b>Fecha de publicación:</b>
                                                                    <asp:Label ID="lblFechaPub" runat="server" Text='<%# Convert.ToDateTime(Eval("libro_fecha_publicacion")).ToString("dd/MM/yyyy") %>' Font-Italic="true"></asp:Label>
                                                                </div>
                                                                <div class="col-3">
                                                                    <b>Páginas:</b>
                                                                    <asp:Label ID="lblPaginasLibro" runat="server" Text='<%# Eval("libro_paginas") %>' Font-Italic="true"></asp:Label>
                                                                </div>
                                                            </div>
                                                            <br />
                                                            <div class="row">
                                                                <div class="col-5">
                                                                    <b>Pasillo:</b>
                                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("libro_Pasillo") %>' Font-Italic="true"></asp:Label>
                                                                </div>
                                                                <div class="col-4">
                                                                    <b>Estante:</b>
                                                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("libro_Estante") %>' Font-Italic="true"></asp:Label>
                                                                </div>
                                                                <div class="col-3">
                                                                    <b>Fila:</b>
                                                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("libro_Fila") %>' Font-Italic="true"></asp:Label>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-2">
                                                                    <b>Stock:</b>
                                                                    <asp:Label ID="lblStock" runat="server" Text='<%# Eval("libro_stock_real") %>' Font-Italic="true"></asp:Label>
                                                                </div>
                                                                <div class="col-3">
                                                                    <b>Disponibles:</b>
                                                                    <asp:Label ID="lblDisponible" runat="server" Text='<%# Eval("libro_stock_actual") %>' Font-Italic="true"></asp:Label>
                                                                </div>
                                                                <div class="col-4">
                                                                    <b>Edición:</b>
                                                                    <asp:Label ID="lblEdicion" runat="server" Text='<%# Eval("libro_edicion") %>' Font-Italic="true"></asp:Label>
                                                                </div>
                                                                <div class="col-3">
                                                                    <b>Costo:</b> $<asp:Label ID="lblCostoLibro" runat="server" Text='<%# Eval("libro_costo") %>' Font-Italic="true"></asp:Label>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-12">
                                                                    <b>Descripción:</b>
                                                                    <asp:Label ID="lblDescripcionLibro" runat="server" Text='<%# Eval("libro_descripcion") %>' Font-Italic="true"></asp:Label>
                                                                </div>
                                                            </div>
                                                            <br />
                                                        </div>

                                                        <div class="col-lg-2 col-md-12">
                                                            <div style="max-width: 150px; align-items: center; text-align: center; margin: auto;">
                                                                <asp:Image ID="imagen" runat="server" ImageUrl='<%# Eval("libro_imagen") %>' class="img-fluid imagenLibros" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                    </Columns>
                                    <HeaderStyle BackColor="White" />
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
