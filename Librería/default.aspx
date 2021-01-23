<%@ Page Title="" Language="C#" MasterPageFile="~/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Librería.inicio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="banner">
        <img src="Imagenes/biblioteca_bg.jpg" />
        <div class="content"><br /><br />
            <h2>Bienvenido a nuestra página</h2>
            <h3>Biblioteca el tejocote</h3>
        </div>

    </section>

    <section>
        <div class="container">
            <div class="row nuevaSeccion">
                <div class="col-md-12">
                    <div class="text text-center">
                        <h2>Características</h2>
                    </div>
                </div>
            </div>
            <!-- Sección de las características -->
            <div class="row subSeccion">
                <div class="col-md-4 col-sm-12 text-center">
                    <img src="Imagenes/repositorio.jfif" width="150px" height="150px" />
                    <h4>Repositorio</h4>
                    <p>Contamos con una gran variedad de libros en nuestras instalaciones, puede revisrlos en la sección de libros de esta página</p>
                </div>
                <div class="col-md-4 col-sm-12 text-center">
                    <img src="Imagenes/caracteristica2.jpg" width="150px" height="150px" />
                    <h4>Ayuda </h4>
                    <p>En las instalaciones podrá encontrar a personas quienes le pueden orientar en cualquier duda que tenga con respecto al uso y préstamo de libros</p>
                </div>
                <div class="col-md-4 col-sm-12 text-center">
                    <img src="Imagenes/libro.png" width="150px" height="150px" />
                    <h4>Derechos de autor</h4>
                    <p>Nuestros títulos son 100% originales, por lo que podrá realizar sus trabajos sin temor a obtener información erronea</p>
                </div>
            </div>
        </div>
    </section>

    <section class="nuevaSeccion">
        <img src="Imagenes/banner.jpg" class="img-fluid" />
    </section>

    <section>
        <div class="container">
            <div class="row nuevaSeccion">
                <div class="col-md-12">
                    <div class="text text-center">
                        <h2>Servicios</h2>
                    </div>
                </div>
            </div>

            <div class="row subSeccion">
                <div class="col-md-4 col-sm-12 text-center">
                    <img src="Imagenes/caracteristica1.png" width="150px" height="150px" />
                    <h4>Préstamos</h4>
                    <p>Puede llevar los libros hasta su hogar, registrandose en la página y presentandose en la biblioteca </p>
                </div>
                <div class="col-md-4 col-sm-12 text-center">
                    <img src="Imagenes/caracteristica2.jpg" width="150px" height="150px" />
                    <h4>Bonorum </h4>
                    <p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. </p>
                </div>
                <div class="col-md-4 col-sm-12 text-center">
                    <img src="Imagenes/caracteristica3.png" width="150px" height="150px" />
                    <h4>Espacio de trabajo</h4>
                    <p>Puede usar nuestras instalaciones para consultar los materiales que necesita, sin preocupaciones y e calma</p>
                </div>
            </div>

            <div class="row subSeccion">
        </div>
    </section>
</asp:Content>
