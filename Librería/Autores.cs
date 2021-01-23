using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Librería {
    public class Autores {
        private String id;
        private String nombre;

        public Autores(){}

        public Autores(string id, string nombre) {
            this.id = id;
            this.nombre = nombre;
        }
        public string Id { get => id; set => id = value; }
        public string Nombre { get => nombre; set => nombre = value; }
        
    }
}