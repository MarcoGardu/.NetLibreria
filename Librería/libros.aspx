<%@ Page Title="" Language="C#" MasterPageFile="~/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="libros.aspx.cs" Inherits="Librería.libros" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        //Función para el uso del DataTable con JQuery
        $(document).ready(function () {
            $(".table").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row nuevaSeccion">
            <div class="col-lg-12 col-md-12 col-sm-12 mx-auto">
                <div class="card border mb-2">
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <h4 class="text text-center">Nuestros libros</h4>
                            </div>
                        </div>
                        <!-- Linea para dar más estilo-->
                        <div class="row">
                            <div class="col">
                                <hr />
                            </div>
                        </div>

                        <div class="row">
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:libreria_BD2ConnectionString %>" SelectCommand="SELECT * FROM [tbl_libros], tbl_editorial, tbl_autor WHERE editorial_id = libro_editorial AND autor_id = libro_autor"></asp:SqlDataSource>
                            <div class="col">
                                <asp:GridView ID="GrdLibros" runat="server" class="table table-striped table-bordered" AutoGenerateColumns="False" DataKeyNames="libro_id" DataSourceID="SqlDataSource1" BackColor="#FFFFD7">
                                    <Columns>

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
                                                                    <strong>Editorial:</strong>
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
                                                            <div class="row">
                                                                <div class="col-5">
                                                                    <b>Pasillo:</b>
                                                                    <asp:Label ID="lblPasillo" runat="server" Text='<%# Eval("libro_Pasillo") %>' Font-Italic="true"></asp:Label>
                                                                </div>
                                                                <div class="col-4">
                                                                    <b>Estante:</b>
                                                                    <asp:Label ID="lblEstante" runat="server" Text='<%# Eval("libro_Estante") %>' Font-Italic="true"></asp:Label>
                                                                </div>
                                                                <div class="col-3">
                                                                    <b>Fila:</b>
                                                                    <asp:Label ID="lblFila" runat="server" Text='<%# Eval("libro_Fila") %>' Font-Italic="true"></asp:Label>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-9">
                                                                    <b>Descripción:</b>
                                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("libro_descripcion") %>' Font-Italic="true"></asp:Label>
                                                                </div>
                                                                <div class="col-3">
                                                                    <b>Edición:</b>
                                                                    <asp:Label ID="lblEdicion" runat="server" Text='<%# Eval("libro_edicion") %>' Font-Italic="true"></asp:Label>
                                                                </div>
                                                                
                                                            </div>
                                                            <br />
                                                        </div>

                                                        <div class="col-lg-2 col-md-12 mx-auto m-2">
                                                            <div style="max-width: 150px;">
                                                                <asp:Image ID="imagen" runat="server" ImageUrl='<%# Eval("libro_imagen") %>' class="img-fluid imagenLibros" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
                <a href="default.aspx" class="text">
                    <i class="far fa-arrow-alt-circle-left"></i>Regresar al inicio
                </a>
                <br /><br /><br />
            </div>
        </div>
    </div>
</asp:Content>
