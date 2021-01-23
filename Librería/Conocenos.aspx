<%@ Page Title="" Language="C#" MasterPageFile="~/PaginaMaestra.Master" AutoEventWireup="true" CodeBehind="Conocenos.aspx.cs" Inherits="Librería.Conocenos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/conocenos.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="main">

        <section class="fotos" id="conocenos">
                <div class="container">
                    <div class="row nuevaSeccion">
                        <div class="col-md-12">
                            <h3 class="titulo1">Conocenos<hr></h3>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="row foto">
                                <div class="col-sm-8 col-md-8 derecha">
                                    <h2 class="titulo text-warning">No te preocupes por nada...</h2>
                                    <p class="parrafo ">No te preocupes si no tienes el equipo necesario, nosotros te lo proporcionamos para que disfrutes.
                                        Además sientete seguro dentro y alrededor de las instalaciones, nadie podrá molestarte. 
                                    </p>
                                </div>
                                <div class="col-sm-4 col-md-4 thumb">
                                    <img src="Imagenes/conocenos1.jpg" alt="" class="img-thumbnail img-fluid">
                                </div>
                            </div>
                            <div class="row foto">
                                <div class="col-sm-4 col-md-4 thumb">
                                    <img src="Imagenes/conocenos2.jpg" alt="" class="img-thumbnail img-fluid">
                                </div>
                                <div class="col-sm-8 col-md-8">
                                    <h2 class="titulo text-primary">Diversión a tu alcance</h2>
                                    <p class="parrafo">Podrás disfrutar de nuestras instalaciones y usarlas cuando quieras, contamos con diversidad de titulos, desde temas para
                                        los más pequeños, hasta algunas tesis de universitarios.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

        <section class="ubicacion">
            <div class="contenedor">
                <h3 class="titulo" id="ubicacion">Ubicación</h3>
                <div class="direccion">
                    <h4>Dirección</h4>
                    <p class="calle">Calle Olmillos, El Tejocote, 56265 Texcoco, Méx. En el parque el Tejocote</p>
                    <p class="contacto">
                        Teléfono: (678) 234-2347
                    <br />
                        Email: correo[@]gmail.com
                    </p>
                </div>
                <div class="horario">
                    <h4>Horarios</h4>
                    <p class="entre-semana">
                        Lunes a Viernes<br />
                        8:00 a.m - 7:00 p.m
                    </p>
                    <p class="fin-semana">
                        Sabado y Domingo<br />
                        10:00 a.m - 4:00 p.m
                    </p>
                </div>
            </div>
        </section>

        <section class="mapa">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d996.511375676433!2d-98.90499153288239!3d19.44149931929134!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x85d1e14a55edfba9%3A0xa5e0efdab876fb5c!2sParque%20el%20Tejocote!5e0!3m2!1ses-419!2smx!4v1609814748309!5m2!1ses-419!2smx"
                width="1500" height="550" frameborder="0" style="border: 0;" aria-hidden="false" tabindex="0"></iframe>
        </section>
    </section>

</asp:Content>
