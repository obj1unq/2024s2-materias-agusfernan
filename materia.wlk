import estudiante.*
import carrera.*
import materiaAprobada.*


class Materia {
    const property correlativas 
    var property cursantes = #{}
    var property cupos
    var property listaEspera = []

    method estaInscripto(estudiante) {
        return cursantes.contains(estudiante)
    }

    method estaEnListaDeEspera(estudiante) {
        return listaEspera.contains(estudiante)
    }

    method inscribirEstudiante(estudiante) {
        estudiante.validarSiPuedeInscribirse(self)
        if (cupos > 0) {
            cupos -= 1
            cursantes.add(estudiante)
        } else {
            listaEspera.add(estudiante)
        }   
    }

    method darDeBaja(estudiante) {
        cursantes.remove(estudiante)
        cursantes.add(self.primeroDeListaDeEspera())
        listaEspera.remove(self.primeroDeListaDeEspera())
    }

    method primeroDeListaDeEspera() {
        return listaEspera.head()
    }

    method nombreEstudiantes(estudiantes) {
        return estudiantes.map({estudiante => estudiante.nombre()}).join(", ") // El join convierte en strings la coleccion y los separa, en este caso con comas
    }

    method resultadosInscripcion() {
        return "Los estudiantes inscriptos a la materia son: " + self.nombreEstudiantes(cursantes) + ". Mientras que los estudiantes en lista de espera son: " + self.nombreEstudiantes(listaEspera) + "."
    }

    
}