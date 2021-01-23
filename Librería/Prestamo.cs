using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Librería {
    public class Prestamo {
        private int id;
        private String usuario;
        private String nombre_usuario;
        private String id_libro;
        private String nombre_libro;
        private DateTime fecha_inicio;
        private DateTime fecha_fin;

        public Prestamo() {
        }

        public Prestamo(int id, string usuario, string nombre_usuario, string id_libro, string nombre_libro, DateTime fecha_inicio, DateTime fecha_fin) {
            this.id = id;
            this.usuario = usuario;
            this.nombre_usuario = nombre_usuario;
            this.id_libro = id_libro;
            this.nombre_libro = nombre_libro;
            this.fecha_inicio = fecha_inicio;
            this.fecha_fin = fecha_fin;
        }

        public int Id {
            get {
                return this.id;
            }
            set {
                id = value;
            }
        }

        public string Usuario {
            get {
                return this.usuario;
            }
            set {
                usuario = value;
            }
        }

        public string Nombre_usuario {
            get {
                return this.nombre_usuario;
            }
            set {
                nombre_usuario = value;
            }
        }

        public string Id_libro {
            get {
                return this.id_libro;
            }
            set {
                id_libro = value;
            }
        }

        public string Nombre_libro {
            get {
                return this.nombre_libro;
            }
            set {
                nombre_libro = value;
            }
        }

        public DateTime Fecha_inicio {
            get {
                return this.fecha_inicio;
            }
            set {
                fecha_inicio = value;
            }
        }

        public DateTime Fecha_fin {
            get {
                return this.fecha_fin;
            }
            set {
                fecha_fin = value;
            }
        }

    }
}