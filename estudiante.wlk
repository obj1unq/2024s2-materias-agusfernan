import materiaAprobada.*
import materia.*
import carrera.*


class Estudiante {
    const property nombre
    const property materiasAprobadas = #{}
    const property carreras 

    method agregarMateriaAprobada(materiaAprobada, notaAprobada) {
        self.validarSiEsMateriaAprobada(self.unaMateriaAprobada(materiaAprobada, notaAprobada))
        materiasAprobadas.add(self.unaMateriaAprobada(materiaAprobada, notaAprobada))
    }

    method unaMateriaAprobada(materiaAprobada, notaAprobada) {
        return new Aprobada(materia = materiaAprobada, nota = notaAprobada)
    }

    method validarSiEsMateriaAprobada(materia) {
        return if (self.esMateriaAprobada(materia)) {
            self.error("Ya aprobó esta materia el estudiante!")
        } else if (materia.nota() < 4) {
            self.error("La materia no esta aprobada!")
        }
    }

    method esMateriaAprobada(materia) {
        return materiasAprobadas.contains(materia) 
    }

    method cantidadDeMateriasAprobadas() {
        return materiasAprobadas.size()
    }

    method promedioDeAprobadas() {
        return self.sumaDeNotasDeMateriasAprobadas() / self.cantidadDeMateriasAprobadas()
    }

    method sumaDeNotasDeMateriasAprobadas() {
        return materiasAprobadas.sum({materia => materia.nota()})
    }

    method todasLasMaterias() { //4
        return carreras.map({carrera => carrera.materias()}).flatten()
    }

    method validarSiPuedeInscribirse(materia) {
        return if (not self.esMateriaDeAlgunaCarrera(materia)) {
            self.error("La materia no pertenece a una carrera del estudiante!")
        } else if (self.esMateriaAprobada(materia)) {
            self.error("No puede volver a inscribirse a esta materia, ya la aprobo!")
        } else if (materia.estaInscripto(self)) {
            self.error("Ya esta inscripto en esta materia!")
        } else if (not self.puedeAnotarseEn(materia)) {
            self.error("No cumple con los requisitos de la materia para inscribirse!")
        }
    }

    method puedeAnotarseEn(materia) {
        return materia.correlativas().All({correlativa => self.esMateriaAprobada(correlativa)}) // Ver si esta bien
    }

    method esMateriaDeAlgunaCarrera(materia) {
        return self.todasLasMaterias().contains(materia)
    }


    method materiasInscripto() {
        return self.todasLasMaterias().filter({materia => materia.estaInscripto(self)})
    }

    method materiasEnEsperaDeInscripcion() {
        return self.todasLasMaterias().filter({materia => materia.estaEnListaDeEspera(self)})
    }

    method informacionMaterias() {
        return "Las materias a las que esta inscripto son:" + self.materiasInscripto().join(", ") + ". Mientras que esta en lista de espera de las siguientes materias: " + self.materiasEnEsperaDeInscripcion().join(", ") + "."
    }

    method materiasALasQueSePuedeInscribir(carrera) {
        if (self.estaCursandoLaCarrera(carrera)) {
                carrera.materias().filter({materia => self.validarSiPuedeInscribirse(materia)})
        }
    }

    method estaCursandoLaCarrera(carrera) {
        return carreras.contains(carrera)
    }

}


