using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Librería {
    public class Libro {
        private String id;
        private String nombre;
        private String idioma;
        private String autor;
        private String editorial;
        private String genero;
        private String ruta;
        private DateTime fechaPublicacion;
        private int edicion;
        private decimal costo;
        private int paginas;
        private int stockReal;
        private int stockActual;
        private int prestados;
        private String descripcion;
        private String pasillo;
        private String estante;
        private String fila;


        public Libro() {
        }

        public Libro(string id, string nombre, string idioma, string autor, string editorial, string genero, string ruta, DateTime fechaPublicacion, int edicion, decimal costo, int paginas, int stockReal, int stockActual, int prestados, string descripcion, string pasillo, string estante, string fila) {
            this.id = id;
            this.nombre = nombre;
            this.idioma = idioma;
            this.autor = autor;
            this.editorial = editorial;
            this.genero = genero;
            this.ruta = ruta;
            this.fechaPublicacion = fechaPublicacion;
            this.edicion = edicion;
            this.costo = costo;
            this.paginas = paginas;
            this.stockReal = stockReal;
            this.stockActual = stockActual;
            this.prestados = prestados;
            this.descripcion = descripcion;
            this.pasillo = pasillo;
            this.estante = estante;
            this.fila = fila;
        }

        public string Id {
            get {
                return this.id;
            }
            set {
                id = value;
            }
        }

        public string Nombre {
            get {
                return this.nombre;
            }
            set {
                nombre = value;
            }
        }

        public string Idioma {
            get {
                return this.idioma;
            }
            set {
                idioma = value;
            }
        }

        public string Autor {
            get {
                return this.autor;
            }
            set {
                autor = value;
            }
        }

        public string Editorial {
            get {
                return this.editorial;
            }
            set {
                editorial = value;
            }
        }

        public string Genero {
            get {
                return this.genero;
            }
            set {
                genero = value;
            }
        }

        public string Ruta {
            get {
                return this.ruta;
            }
            set {
                ruta = value;
            }
        }

        public DateTime FechaPublicacion {
            get {
                return this.fechaPublicacion;
            }
            set {
                fechaPublicacion = value;
            }
        }

        public int Edicion {
            get {
                return this.edicion;
            }
            set {
                edicion = value;
            }
        }

        public decimal Costo {
            get {
                return this.costo;
            }
            set {
                costo = value;
            }
        }

        public int Paginas {
            get {
                return this.paginas;
            }
            set {
                paginas = value;
            }
        }

        public int StockReal {
            get {
                return this.stockReal;
            }
            set {
                stockReal = value;
            }
        }

        public int StockActual {
            get {
                return this.stockActual;
            }
            set {
                stockActual = value;
            }
        }

        public int Prestados {
            get {
                return this.prestados;
            }
            set {
                prestados = value;
            }
        }

        public string Descripcion {
            get {
                return this.descripcion;
            }
            set {
                descripcion = value;
            }
        }

        public string Pasillo {
            get {
                return this.pasillo;
            }
            set {
                pasillo = value;
            }
        }

        public string Estante {
            get {
                return this.estante;
            }
            set {
                estante = value;
            }
        }

        public string Fila {
            get {
                return this.fila;
            }
            set {
                fila = value;
            }
        }

    }
}