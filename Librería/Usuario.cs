using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Librería {
    public class Usuario {
        private String nombre;
        private String apellido_paterno;
        private String apellido_materno;
        private String correo;
        private String telefono;
        private String fecha_nacimiento;
        private String calle;
        private String numero;
        private String colonia;
        String codigoPostal;
        private String municipio;
        private String user;        
        private String password;
        private String estatus;

        public Usuario() {
        }

        public Usuario(string nombre, string apellido_paterno, string apellido_materno, string correo, string telefono, String fecha_nacimiento, string calle, string numero, string colonia, string municipio, string user, string password, string estatus, String codigoPostal) {
            this.nombre = nombre;
            this.apellido_paterno = apellido_paterno;
            this.apellido_materno = apellido_materno;
            this.correo = correo;
            this.telefono = telefono;
            this.fecha_nacimiento = fecha_nacimiento;
            this.calle = calle;
            this.numero = numero;
            this.colonia = colonia;
            this.municipio = municipio;
            this.user = user;
            this.password = password;
            this.estatus = estatus;
            this.codigoPostal = codigoPostal;
    }

        public string Nombre {
            get {
                return this.nombre;
            }
            set {
                nombre = value;
            }
        }

        public string Apellido_paterno {
            get {
                return this.apellido_paterno;
            }
            set {
                apellido_paterno = value;
            }
        }

        public string Apellido_materno {
            get {
                return this.apellido_materno;
            }
            set {
                apellido_materno = value;
            }
        }

        public string Correo {
            get {
                return this.correo;
            }
            set {
                correo = value;
            }
        }

        public string Telefono {
            get {
                return this.telefono;
            }
            set {
                telefono = value;
            }
        }

        public String Fecha_nacimiento {
            get {
                return this.fecha_nacimiento;
            }
            set {
                fecha_nacimiento = value;
            }
        }

        public string Calle {
            get {
                return this.calle;
            }
            set {
                calle = value;
            }
        }

        public string Numero {
            get {
                return this.numero;
            }
            set {
                numero = value;
            }
        }

        public string Colonia {
            get {
                return this.colonia;
            }
            set {
                colonia = value;
            }
        }

        public string Municipio {
            get {
                return this.municipio;
            }
            set {
                municipio = value;
            }
        }

        public string User {
            get {
                return this.user;
            }
            set {
                user = value;
            }
        }

        public string Password {
            get {
                return this.password;
            }
            set {
                password = value;
            }
        }

        public string Estatus {
            get {
                return this.estatus;
            }
            set {
                estatus = value;
            }
        }
        public String CodigoPostal {
            get{ return this.codigoPostal; }
            set { codigoPostal = value; }
        }
    }
}