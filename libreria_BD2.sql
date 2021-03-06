USE [master]
GO
/****** Object:  Database [libreria_BD2]    Script Date: 23/01/2021 03:10:20 p. m. ******/
CREATE DATABASE [libreria_BD2]
GO
USE [libreria_BD2]
GO
/****** Object:  Table [dbo].[tbl_admin]    Script Date: 23/01/2021 03:10:20 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_admin](
	[adm_id] [int] IDENTITY(1,1) NOT NULL,
	[adm_apellido_paterno] [nvarchar](50) NULL,
	[adm_apellido_materno] [nvarchar](50) NULL,
	[adm_nombre] [nvarchar](50) NULL,
	[adm_user] [nvarchar](50) NOT NULL,
	[adm_password] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[adm_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_autor]    Script Date: 23/01/2021 03:10:20 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_autor](
	[autor_id] [nchar](10) NOT NULL,
	[autor_nombre] [nchar](50) NULL,
 CONSTRAINT [PK_tbl_autor] PRIMARY KEY CLUSTERED 
(
	[autor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_editorial]    Script Date: 23/01/2021 03:10:20 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_editorial](
	[editorial_id] [nchar](10) NOT NULL,
	[editorial_nombre] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[editorial_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_libros]    Script Date: 23/01/2021 03:10:20 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_libros](
	[libro_id] [nchar](10) NOT NULL,
	[libro_nombre] [nvarchar](180) NULL,
	[libro_genero] [nvarchar](100) NULL,
	[libro_autor] [nchar](10) NULL,
	[libro_editorial] [nchar](10) NULL,
	[libro_fecha_publicacion] [date] NULL,
	[libro_idioma] [nvarchar](50) NULL,
	[libro_edicion] [int] NULL,
	[libro_costo] [decimal](18, 0) NULL,
	[libro_paginas] [int] NULL,
	[libro_descripcion] [nvarchar](max) NULL,
	[libro_stock_actual] [int] NULL,
	[libro_stock_real] [int] NULL,
	[libro_en_prestamo] [int] NULL,
	[libro_imagen] [nvarchar](max) NULL,
	[libro_Pasillo] [nvarchar](20) NULL,
	[libro_Estante] [nvarchar](20) NULL,
	[libro_Fila] [nvarchar](20) NULL,
 CONSTRAINT [PK_tbl_libros] PRIMARY KEY CLUSTERED 
(
	[libro_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_prestamos]    Script Date: 23/01/2021 03:10:20 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_prestamos](
	[prst_id] [int] IDENTITY(1,1) NOT NULL,
	[prst_usuario] [nvarchar](50) NULL,
	[prst_usuario_nombre] [nvarchar](50) NULL,
	[prst_libro_id] [nchar](10) NULL,
	[prst_libro_nombre] [nvarchar](max) NULL,
	[prst_fecha_inicio] [date] NULL,
	[prst_fecha_fin] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[prst_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_usuario]    Script Date: 23/01/2021 03:10:20 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_usuario](
	[usr_nombre] [nvarchar](50) NULL,
	[usr_apellido_paterno] [nvarchar](50) NOT NULL,
	[usr_apellido_materno] [nvarchar](50) NULL,
	[usr_correo] [nvarchar](50) NULL,
	[usr_telefono] [nvarchar](50) NULL,
	[usr_fecha_nacimiento] [nvarchar](50) NOT NULL,
	[usr_calle] [nvarchar](max) NULL,
	[usr_lote] [nchar](10) NULL,
	[usr_colonia] [nvarchar](20) NULL,
	[usr_codigo_postal] [nvarchar](6) NULL,
	[usr_municipio] [nvarchar](50) NULL,
	[usr_user] [nvarchar](50) NOT NULL,
	[usr_password] [nvarchar](50) NULL,
	[usr_estatus_cuenta] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_usuario] PRIMARY KEY CLUSTERED 
(
	[usr_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tbl_admin] ON 

INSERT [dbo].[tbl_admin] ([adm_id], [adm_apellido_paterno], [adm_apellido_materno], [adm_nombre], [adm_user], [adm_password]) VALUES (1, N'Garduño', N'Correa', N'Marco Antonio', N'Marco4567', N'Marco4567')
INSERT [dbo].[tbl_admin] ([adm_id], [adm_apellido_paterno], [adm_apellido_materno], [adm_nombre], [adm_user], [adm_password]) VALUES (2, N'Guzmán', N'Salgado', N'Daniela', N'Daniela4567', N'Daniela4567')
INSERT [dbo].[tbl_admin] ([adm_id], [adm_apellido_paterno], [adm_apellido_materno], [adm_nombre], [adm_user], [adm_password]) VALUES (5, N'Torres', N'Farías', N'Alan', N'Alan4567', N'Alan4567')
INSERT [dbo].[tbl_admin] ([adm_id], [adm_apellido_paterno], [adm_apellido_materno], [adm_nombre], [adm_user], [adm_password]) VALUES (1002, N'Cabanillas', N'Ruiz', N'María Fernanda', N'Fernanda4567', N'Fernanda4567')
SET IDENTITY_INSERT [dbo].[tbl_admin] OFF
GO
INSERT [dbo].[tbl_autor] ([autor_id], [autor_nombre]) VALUES (N'A0001     ', N'Bernhard Traven Torsvan                           ')
INSERT [dbo].[tbl_autor] ([autor_id], [autor_nombre]) VALUES (N'A0002     ', N'Juan Rulfo                                        ')
INSERT [dbo].[tbl_autor] ([autor_id], [autor_nombre]) VALUES (N'A0003     ', N'Jose Emilio Pacheco                               ')
INSERT [dbo].[tbl_autor] ([autor_id], [autor_nombre]) VALUES (N'A0004     ', N'Juan Sánchez Andraka                              ')
INSERT [dbo].[tbl_autor] ([autor_id], [autor_nombre]) VALUES (N'A0005     ', N'Laura Esquivel Valdés                             ')
INSERT [dbo].[tbl_autor] ([autor_id], [autor_nombre]) VALUES (N'A0006     ', N'Pietro Arentino                                   ')
INSERT [dbo].[tbl_autor] ([autor_id], [autor_nombre]) VALUES (N'A0007     ', N'Manuel Alvar Ezquerra                             ')
INSERT [dbo].[tbl_autor] ([autor_id], [autor_nombre]) VALUES (N'A0008     ', N'William Shakespeare                               ')
INSERT [dbo].[tbl_autor] ([autor_id], [autor_nombre]) VALUES (N'A0009     ', N'Gabriel García Marquez                            ')
INSERT [dbo].[tbl_autor] ([autor_id], [autor_nombre]) VALUES (N'A0010     ', N'J. K. Rowling                                     ')
INSERT [dbo].[tbl_autor] ([autor_id], [autor_nombre]) VALUES (N'A0011     ', N'Günter Wilhelm Grass                              ')
INSERT [dbo].[tbl_autor] ([autor_id], [autor_nombre]) VALUES (N'A0012     ', N'Pablo Neruda                                      ')
GO
INSERT [dbo].[tbl_editorial] ([editorial_id], [editorial_nombre]) VALUES (N'E0001     ', N'Caligrama Editores')
INSERT [dbo].[tbl_editorial] ([editorial_id], [editorial_nombre]) VALUES (N'E0002     ', N'Editorial SELECTOR')
INSERT [dbo].[tbl_editorial] ([editorial_id], [editorial_nombre]) VALUES (N'E0003     ', N'Grupo Editorial Patria, S.A. de C.V.')
INSERT [dbo].[tbl_editorial] ([editorial_id], [editorial_nombre]) VALUES (N'E0004     ', N'Editorial Miguel Ángel Porrúa')
INSERT [dbo].[tbl_editorial] ([editorial_id], [editorial_nombre]) VALUES (N'E0005     ', N'Pearson Educación de México, S.A. de C.V.')
INSERT [dbo].[tbl_editorial] ([editorial_id], [editorial_nombre]) VALUES (N'E0006     ', N'McGraw-Hill Interamericana Editores, S.A. de C.V.')
INSERT [dbo].[tbl_editorial] ([editorial_id], [editorial_nombre]) VALUES (N'E0007     ', N'Macmillan de Mexico')
INSERT [dbo].[tbl_editorial] ([editorial_id], [editorial_nombre]) VALUES (N'E0008     ', N'Trillaz')
INSERT [dbo].[tbl_editorial] ([editorial_id], [editorial_nombre]) VALUES (N'E0009     ', N'Editores Mexicanos Unidos')
INSERT [dbo].[tbl_editorial] ([editorial_id], [editorial_nombre]) VALUES (N'E0010     ', N'Editorial Clío')
INSERT [dbo].[tbl_editorial] ([editorial_id], [editorial_nombre]) VALUES (N'E0011     ', N'Ediciones Arlequín')
INSERT [dbo].[tbl_editorial] ([editorial_id], [editorial_nombre]) VALUES (N'E0012     ', N'Editorial La Prensa')
INSERT [dbo].[tbl_editorial] ([editorial_id], [editorial_nombre]) VALUES (N'E0013     ', N'Editorial Panini')
INSERT [dbo].[tbl_editorial] ([editorial_id], [editorial_nombre]) VALUES (N'E0014     ', N'Siglo XXI Editores')
INSERT [dbo].[tbl_editorial] ([editorial_id], [editorial_nombre]) VALUES (N'E0015     ', N'Sexto Piso')
GO
INSERT [dbo].[tbl_libros] ([libro_id], [libro_nombre], [libro_genero], [libro_autor], [libro_editorial], [libro_fecha_publicacion], [libro_idioma], [libro_edicion], [libro_costo], [libro_paginas], [libro_descripcion], [libro_stock_actual], [libro_stock_real], [libro_en_prestamo], [libro_imagen], [libro_Pasillo], [libro_Estante], [libro_Fila]) VALUES (N'B0000     ', N'Biología para dummies', N'Ciencia,Educación', N'A0011     ', N'E0015     ', CAST(N'2016-08-20' AS Date), N'Español', 12, CAST(540 AS Decimal(18, 0)), 301, N'Desde las moléculas y las células hasta los animales y los ecosistemas, esta guía práctica contesta todas tus preguntas sobre el funcionamiento de los seres vivos. Escrita con un lenguaje llano y repleta de útiles ilustraciones, tablas y diagramas, va directa al grano con explicaciones sencillas de los procesos vitales comunes a todos los organismos.', 18, 20, 0, N'~/Imagenes/Inventario/Biologia.jpg', N'C2', N'C01', N'2')
INSERT [dbo].[tbl_libros] ([libro_id], [libro_nombre], [libro_genero], [libro_autor], [libro_editorial], [libro_fecha_publicacion], [libro_idioma], [libro_edicion], [libro_costo], [libro_paginas], [libro_descripcion], [libro_stock_actual], [libro_stock_real], [libro_en_prestamo], [libro_imagen], [libro_Pasillo], [libro_Estante], [libro_Fila]) VALUES (N'B0001     ', N'Enciclopedia de Anatomía Vol. 1', N'Ciencia', N'A0011     ', N'E0011     ', CAST(N'2015-12-28' AS Date), N'Español', 15, CAST(350 AS Decimal(18, 0)), 410, N'Los conocimientos anatómico aun no llegan a  la cima, pues cada día se enriquecen con nuevos hallazgos, y si es cierto  que la descripción de los órganos no varia de las descripciones clásicas, puesto que la anatomía en si no varia, en cambio la interpretación de ellas, sus aplicaciones, su función, etc.', 8, 10, 0, N'~/Imagenes/Inventario/Enciclopedia.png', N'A2', N'A01', N'2')
INSERT [dbo].[tbl_libros] ([libro_id], [libro_nombre], [libro_genero], [libro_autor], [libro_editorial], [libro_fecha_publicacion], [libro_idioma], [libro_edicion], [libro_costo], [libro_paginas], [libro_descripcion], [libro_stock_actual], [libro_stock_real], [libro_en_prestamo], [libro_imagen], [libro_Pasillo], [libro_Estante], [libro_Fila]) VALUES (N'B0002     ', N'Macario', N'Novela', N'A0001     ', N'E0001     ', CAST(N'2014-11-09' AS Date), N'Español', 10, CAST(150 AS Decimal(18, 0)), 183, N'Macario es la singular aventura o desaventura de un hombre humilde, hambriento, que al dar satisfacción al mayor deseo de su vida--comerse en soledad un pavo entero--recibe poderes sobre la vida y la muerte.', 15, 15, 0, N'~/Imagenes/Inventario/Macario.jpg', N'A2', N'A01', N'4')
INSERT [dbo].[tbl_libros] ([libro_id], [libro_nombre], [libro_genero], [libro_autor], [libro_editorial], [libro_fecha_publicacion], [libro_idioma], [libro_edicion], [libro_costo], [libro_paginas], [libro_descripcion], [libro_stock_actual], [libro_stock_real], [libro_en_prestamo], [libro_imagen], [libro_Pasillo], [libro_Estante], [libro_Fila]) VALUES (N'B0003     ', N'Como agua para chocolate', N'Drama,Romance', N'A0005     ', N'E0014     ', CAST(N'2011-12-07' AS Date), N'Español', 7, CAST(250 AS Decimal(18, 0)), 234, N'Como agua para chocolate, es una novela rosa escrita por Laura Esquivel, publicada en 1989, que trata acerca de la vida de una mujer, sus amoríos y la relación de esta con su familia, todo relacionado con la importancia de la cocina y las recetas típicas mexicanas de la época en que está ambientada su vida.', 5, 5, 0, N'~/Imagenes/Inventario/Como agua para chocolate.jpg', N'B1', N'B01', N'2')
INSERT [dbo].[tbl_libros] ([libro_id], [libro_nombre], [libro_genero], [libro_autor], [libro_editorial], [libro_fecha_publicacion], [libro_idioma], [libro_edicion], [libro_costo], [libro_paginas], [libro_descripcion], [libro_stock_actual], [libro_stock_real], [libro_en_prestamo], [libro_imagen], [libro_Pasillo], [libro_Estante], [libro_Fila]) VALUES (N'B0004     ', N'Enciclopedia de Anatomía Vol. 2', N'Ciencia', N'A0011     ', N'E0011     ', CAST(N'2015-12-28' AS Date), N'Español', 15, CAST(350 AS Decimal(18, 0)), 410, N'Los conocimientos anatómico aun no llegan a  la cima, pues cada día se enriquecen con nuevos hallazgos, y si es cierto  que la descripción de los órganos no varia de las descripciones clásicas, puesto que la anatomía en si no varia, en cambio la interpretación de ellas, sus aplicaciones, su función, etc.', 10, 10, 0, N'~/Imagenes/Inventario/Enciclopedia 2.png', N'A2', N'A01', N'2')
INSERT [dbo].[tbl_libros] ([libro_id], [libro_nombre], [libro_genero], [libro_autor], [libro_editorial], [libro_fecha_publicacion], [libro_idioma], [libro_edicion], [libro_costo], [libro_paginas], [libro_descripcion], [libro_stock_actual], [libro_stock_real], [libro_en_prestamo], [libro_imagen], [libro_Pasillo], [libro_Estante], [libro_Fila]) VALUES (N'B0005     ', N'Harry Potter y la piedra filosofal', N'Cuento,Fantasía', N'A0010     ', N'E0015     ', CAST(N'2001-11-04' AS Date), N'Español', 2, CAST(200 AS Decimal(18, 0)), 304, N'', 0, 1, 0, N'~/Imagenes/Inventario/Harry Potter.jpg', N'D2', N'E02', N'3')
INSERT [dbo].[tbl_libros] ([libro_id], [libro_nombre], [libro_genero], [libro_autor], [libro_editorial], [libro_fecha_publicacion], [libro_idioma], [libro_edicion], [libro_costo], [libro_paginas], [libro_descripcion], [libro_stock_actual], [libro_stock_real], [libro_en_prestamo], [libro_imagen], [libro_Pasillo], [libro_Estante], [libro_Fila]) VALUES (N'B0006     ', N'Enciclopedia de Anatomía Vol. 3', N'Ciencia', N'A0011     ', N'E0011     ', CAST(N'2015-12-28' AS Date), N'Español', 15, CAST(350 AS Decimal(18, 0)), 410, N'Los conocimientos anatómico aun no llegan a  la cima, pues cada día se enriquecen con nuevos hallazgos, y si es cierto  que la descripción de los órganos no varia de las descripciones clásicas, puesto que la anatomía en si no varia, en cambio la interpretación de ellas, sus aplicaciones, su función, etc.', 10, 10, 0, N'~/Imagenes/Inventario/Enciclopedia 3.png', N'A2', N'A01', N'2')
INSERT [dbo].[tbl_libros] ([libro_id], [libro_nombre], [libro_genero], [libro_autor], [libro_editorial], [libro_fecha_publicacion], [libro_idioma], [libro_edicion], [libro_costo], [libro_paginas], [libro_descripcion], [libro_stock_actual], [libro_stock_real], [libro_en_prestamo], [libro_imagen], [libro_Pasillo], [libro_Estante], [libro_Fila]) VALUES (N'B0007     ', N'Aprende francés fácil', N'Educación', N'A0007     ', N'E0015     ', CAST(N'2019-12-30' AS Date), N'Francés', 4, CAST(999 AS Decimal(18, 0)), 230, N'Libro para aprender fránces de una manera fácil y sencilla', 10, 10, 0, N'~/Imagenes/Inventario/Frances.jpg', N'B2', N'B01', N'1')
INSERT [dbo].[tbl_libros] ([libro_id], [libro_nombre], [libro_genero], [libro_autor], [libro_editorial], [libro_fecha_publicacion], [libro_idioma], [libro_edicion], [libro_costo], [libro_paginas], [libro_descripcion], [libro_stock_actual], [libro_stock_real], [libro_en_prestamo], [libro_imagen], [libro_Pasillo], [libro_Estante], [libro_Fila]) VALUES (N'B0008     ', N'Los domados', N'Novela', N'A0004     ', N'E0005     ', CAST(N'2014-01-05' AS Date), N'Francés', 12, CAST(321 AS Decimal(18, 0)), 140, N'', 13, 14, 0, N'~/Imagenes/Inventario/Los domados.jpg', N'E1', N'E01', N'2')
INSERT [dbo].[tbl_libros] ([libro_id], [libro_nombre], [libro_genero], [libro_autor], [libro_editorial], [libro_fecha_publicacion], [libro_idioma], [libro_edicion], [libro_costo], [libro_paginas], [libro_descripcion], [libro_stock_actual], [libro_stock_real], [libro_en_prestamo], [libro_imagen], [libro_Pasillo], [libro_Estante], [libro_Fila]) VALUES (N'B0009     ', N'El silencio de la luna', N'Poesía,Novela', N'A0003     ', N'E0008     ', CAST(N'2015-04-02' AS Date), N'Francés', 10, CAST(230 AS Decimal(18, 0)), 120, N'', 4, 4, 0, N'~/Imagenes/Inventario/El silencio de la luna.jpg', N'A1', N'A03', N'1')
INSERT [dbo].[tbl_libros] ([libro_id], [libro_nombre], [libro_genero], [libro_autor], [libro_editorial], [libro_fecha_publicacion], [libro_idioma], [libro_edicion], [libro_costo], [libro_paginas], [libro_descripcion], [libro_stock_actual], [libro_stock_real], [libro_en_prestamo], [libro_imagen], [libro_Pasillo], [libro_Estante], [libro_Fila]) VALUES (N'B0010     ', N'El gallo de oro', N'Comedia,Novela', N'A0002     ', N'E0011     ', CAST(N'2018-12-29' AS Date), N'Español', 13, CAST(200 AS Decimal(18, 0)), 120, N'El gallo de oro es una novela corta del escritor mexicano Juan Rulfo, escrita entre 1956 y 1958 pero publicada por primera vez en 1980.', 12, 12, 0, N'~/Imagenes/Inventario/El gallo de oro.jpg', N'D2', N'D02', N'2')
INSERT [dbo].[tbl_libros] ([libro_id], [libro_nombre], [libro_genero], [libro_autor], [libro_editorial], [libro_fecha_publicacion], [libro_idioma], [libro_edicion], [libro_costo], [libro_paginas], [libro_descripcion], [libro_stock_actual], [libro_stock_real], [libro_en_prestamo], [libro_imagen], [libro_Pasillo], [libro_Estante], [libro_Fila]) VALUES (N'B0011     ', N'Platero y yo', N'Novela', N'A0003     ', N'E0015     ', CAST(N'2009-01-22' AS Date), N'Español', 42, CAST(190 AS Decimal(18, 0)), 115, N'Platero y yo es una obra lírica escrita por Juan Ramón Jiménez, ​ que recrea poéticamente la vida del asno Platero. Es muy célebre el primer párrafo: Platero es pequeño, peludo, suave; tan blando por fuera, que se diría todo de algodón, que no lleva huesos.', 10, 10, 0, N'~/Imagenes/Inventario/Platero y yo.jpg', N'A1', N'A04', N'2')
INSERT [dbo].[tbl_libros] ([libro_id], [libro_nombre], [libro_genero], [libro_autor], [libro_editorial], [libro_fecha_publicacion], [libro_idioma], [libro_edicion], [libro_costo], [libro_paginas], [libro_descripcion], [libro_stock_actual], [libro_stock_real], [libro_en_prestamo], [libro_imagen], [libro_Pasillo], [libro_Estante], [libro_Fila]) VALUES (N'B0012     ', N'El llano en llamas', N'Novela', N'A0002     ', N'E0012     ', CAST(N'2003-02-02' AS Date), N'Español', 8, CAST(340 AS Decimal(18, 0)), 230, N'', 1, 2, 0, N'~/Imagenes/Inventario/El llano en llamas.jpg', N'C2', N'C02', N'2')
GO
SET IDENTITY_INSERT [dbo].[tbl_prestamos] ON 

INSERT [dbo].[tbl_prestamos] ([prst_id], [prst_usuario], [prst_usuario_nombre], [prst_libro_id], [prst_libro_nombre], [prst_fecha_inicio], [prst_fecha_fin]) VALUES (1015, N'Marco4567', N'Marco Antonio Garduño Correa', N'B0001     ', N'Enciclopedia de Anatomía Vol. 1', CAST(N'2021-01-22' AS Date), CAST(N'2021-01-23' AS Date))
INSERT [dbo].[tbl_prestamos] ([prst_id], [prst_usuario], [prst_usuario_nombre], [prst_libro_id], [prst_libro_nombre], [prst_fecha_inicio], [prst_fecha_fin]) VALUES (1016, N'Valentina45', N'Valentina Durán Del Castillo', N'B0001     ', N'Enciclopedia de Anatomía Vol. 1', CAST(N'2021-01-12' AS Date), CAST(N'2021-01-21' AS Date))
INSERT [dbo].[tbl_prestamos] ([prst_id], [prst_usuario], [prst_usuario_nombre], [prst_libro_id], [prst_libro_nombre], [prst_fecha_inicio], [prst_fecha_fin]) VALUES (1017, N'Victor4567', N'Victor Hugo Flores Valderrama', N'B0000     ', N'Biología para dummies', CAST(N'2021-01-24' AS Date), CAST(N'2021-02-17' AS Date))
INSERT [dbo].[tbl_prestamos] ([prst_id], [prst_usuario], [prst_usuario_nombre], [prst_libro_id], [prst_libro_nombre], [prst_fecha_inicio], [prst_fecha_fin]) VALUES (1018, N'Marco4567', N'Marco Antonio Garduño Correa', N'B0005     ', N'Harry Potter y la piedra filosofal', CAST(N'2021-01-03' AS Date), CAST(N'2021-01-18' AS Date))
INSERT [dbo].[tbl_prestamos] ([prst_id], [prst_usuario], [prst_usuario_nombre], [prst_libro_id], [prst_libro_nombre], [prst_fecha_inicio], [prst_fecha_fin]) VALUES (1020, N'Sergio', N'Sergio Solis Sánchez', N'B0008     ', N'Los domados', CAST(N'2021-01-20' AS Date), CAST(N'2021-01-24' AS Date))
INSERT [dbo].[tbl_prestamos] ([prst_id], [prst_usuario], [prst_usuario_nombre], [prst_libro_id], [prst_libro_nombre], [prst_fecha_inicio], [prst_fecha_fin]) VALUES (1021, N'Marco4567', N'Marco Antonio Garduño Correa', N'B0000     ', N'Biología para dummies', CAST(N'2021-01-26' AS Date), CAST(N'2021-02-27' AS Date))
INSERT [dbo].[tbl_prestamos] ([prst_id], [prst_usuario], [prst_usuario_nombre], [prst_libro_id], [prst_libro_nombre], [prst_fecha_inicio], [prst_fecha_fin]) VALUES (1022, N'Marco4567', N'Marco Antonio Garduño Correa', N'B0012     ', N'El llano en llamas', CAST(N'2021-01-13' AS Date), CAST(N'2021-02-06' AS Date))
SET IDENTITY_INSERT [dbo].[tbl_prestamos] OFF
GO
INSERT [dbo].[tbl_usuario] ([usr_nombre], [usr_apellido_paterno], [usr_apellido_materno], [usr_correo], [usr_telefono], [usr_fecha_nacimiento], [usr_calle], [usr_lote], [usr_colonia], [usr_codigo_postal], [usr_municipio], [usr_user], [usr_password], [usr_estatus_cuenta]) VALUES (N'Daniela', N'Guzmán', N'Salgado', N'dguzmans1400@alumno.ipn.mx', N'55-2345-8734', N'1999-03-01', N'Calle Roble', N'10        ', N'El arenal', N'56255', N'Texcoco', N'DanyGuz', N'Dani45Fs', N'Activo')
INSERT [dbo].[tbl_usuario] ([usr_nombre], [usr_apellido_paterno], [usr_apellido_materno], [usr_correo], [usr_telefono], [usr_fecha_nacimiento], [usr_calle], [usr_lote], [usr_colonia], [usr_codigo_postal], [usr_municipio], [usr_user], [usr_password], [usr_estatus_cuenta]) VALUES (N'Germán', N'Buenaventura', N'Nuñez', N'german@gmail.com', N'56-4567-8902', N'1994-08-03', N'Calle Roble', N'213       ', N'El Tejocote', N'56234', N'Texcoco', N'Germin45YT', N'Germanio34', N'Inactivo')
INSERT [dbo].[tbl_usuario] ([usr_nombre], [usr_apellido_paterno], [usr_apellido_materno], [usr_correo], [usr_telefono], [usr_fecha_nacimiento], [usr_calle], [usr_lote], [usr_colonia], [usr_codigo_postal], [usr_municipio], [usr_user], [usr_password], [usr_estatus_cuenta]) VALUES (N'Marco Antonio', N'Garduño', N'Correa', N'mgardunoc1400@gmail.com', N'55-5462-1516', N'1999-03-04', N'Calle Chabacano', N'3         ', N'Santiago Cuautlalpan', N'56255', N'Texcoco', N'Marco4567', N'Marco4567&', N'Activo')
INSERT [dbo].[tbl_usuario] ([usr_nombre], [usr_apellido_paterno], [usr_apellido_materno], [usr_correo], [usr_telefono], [usr_fecha_nacimiento], [usr_calle], [usr_lote], [usr_colonia], [usr_codigo_postal], [usr_municipio], [usr_user], [usr_password], [usr_estatus_cuenta]) VALUES (N'Sergio', N'Solis', N'Sánchez', N'sergiLoquin@hotmail.com', N'46-1234-5678', N'2000-04-23', N'Calle Manzano', N'32        ', N'El Tejocote', N'56254', N'Texcoco', N'Sergio', N'Sergi89Loq', N'Activo')
INSERT [dbo].[tbl_usuario] ([usr_nombre], [usr_apellido_paterno], [usr_apellido_materno], [usr_correo], [usr_telefono], [usr_fecha_nacimiento], [usr_calle], [usr_lote], [usr_colonia], [usr_codigo_postal], [usr_municipio], [usr_user], [usr_password], [usr_estatus_cuenta]) VALUES (N'Valentina', N'Durán', N'Del Castillo', N'valentina24@outlook.com', N'55-23456789', N'1994-12-29', N'Calle Saltillo', N'13        ', N'San Pedro', N'56255', N'Texcoco', N'Valentina45', N'Valentina1', N'Activo')
INSERT [dbo].[tbl_usuario] ([usr_nombre], [usr_apellido_paterno], [usr_apellido_materno], [usr_correo], [usr_telefono], [usr_fecha_nacimiento], [usr_calle], [usr_lote], [usr_colonia], [usr_codigo_postal], [usr_municipio], [usr_user], [usr_password], [usr_estatus_cuenta]) VALUES (N'Victor Hugo', N'Flores', N'Valderrama', N'victo.hugo@gmail.com', N'55-4323-1345', N'1967-08-05', N'Calle Mariano Ruiz', N'24        ', N'Santiago Cuautlalpan', N'56255', N'Texcoco', N'Victor4567', N'Vic12WET', N'Activo')
GO
ALTER TABLE [dbo].[tbl_libros]  WITH CHECK ADD FOREIGN KEY([libro_autor])
REFERENCES [dbo].[tbl_autor] ([autor_id])
GO
ALTER TABLE [dbo].[tbl_libros]  WITH CHECK ADD FOREIGN KEY([libro_editorial])
REFERENCES [dbo].[tbl_editorial] ([editorial_id])
GO
ALTER TABLE [dbo].[tbl_prestamos]  WITH CHECK ADD FOREIGN KEY([prst_libro_id])
REFERENCES [dbo].[tbl_libros] ([libro_id])
GO
ALTER TABLE [dbo].[tbl_prestamos]  WITH CHECK ADD FOREIGN KEY([prst_usuario])
REFERENCES [dbo].[tbl_usuario] ([usr_user])
GO
USE [master]
GO
ALTER DATABASE [libreria_BD2] SET  READ_WRITE 
GO
