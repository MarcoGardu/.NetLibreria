using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Librería {
    public class Editorial {
        private String id;
        private String nombreEditorial;

        public Editorial() {
        }

        public Editorial(string id, string nombreEditorial) {
            this.id = id;
            this.nombreEditorial = nombreEditorial;
        }

        public string Id { get => id; set => id = value; }
        public string NombreEditorial { get => nombreEditorial; set => nombreEditorial = value; }
        
    }
}