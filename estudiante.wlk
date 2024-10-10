class Estudiante {
    const property materiasAprobadas = #{}
    const property carreras = #{}

    method agregarMateriaAprobada(materiaAprobada) {
        materiasAprobadas.add(materiaAprobada)
    }

    method validarSiEsMateriaAprobada(materia) {}

    method cantidadDeMateriasAprobadas() {
        return materiasAprobadas.size()
    }


}