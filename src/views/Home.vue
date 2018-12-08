<template>
  <div class="home">
    <div>
      Name: {{name}}
    </div>
    <div>
      Account: {{coinbase}}
    </div>
    <div>
      Is Owner?: {{isOwner ? 'Yes' : 'No'}}
    </div>

    <div v-if="isOwner">
      Name: <input type="text" name="name" v-model="newName">
      <button type="button" @click="save">Guardar</button>

      <div>
        <div>Adicionar Curso</div>
        <div>Código: <input type="number" name="codigo_curso" v-model="form.newCourseCode"></div>
        <div>Nombre Curso: <input type="text" name="nombre_curso" v-model="form.newCourseName"></div>
        <div>Costo: <input type="number" name="costo_curso" v-model="form.newCourseCost"></div>
        <div>Duración: <input type="number" name="duracion_curso" v-model="form.newCourseDuration"></div>
        <div>Umbral para pasar el curso: <input type="number" name="umbral_curso" v-model="form.newCourseThreshold"></div>
        <div>Códigos asistencia:</div>
        <div><input type="number" name="codigos_curso" v-model="form.newCourseCodes"></div>

        <button type="button" @click="saveCourse">Crear Curso</button>
      </div>
    </div>
    <div v-else>
    no tiene permisos
    </div>

    <div>
      <div>Inscribirse a Curso</div>
      <div>Código: <input type="number" name="codigo_curso" v-model="formInscripcion.courseCode"></div>
      <div>Primer nombre: <input type="text" name="nombre_estudiante" v-model="formInscripcion.firstName"></div>
      <div>Apellido: <input type="text" name="apellido_estudiante" v-model="formInscripcion.lastName"></div>
      <div>Edad: <input type="number" name="edad" v-model="formInscripcion.age"></div>
      <div>Email: <input type="text" name="email" v-model="formInscripcion.email"></div>

      <button type="button" @click="saveStudent">Inscribirse</button>
    </div>

    <div>
      <div>Listado de cursos</div>
      <table>
        <tr>
          <td>Código</td>
          <td>Nombre</td>
          <td>Costo</td>
          <td>Duración</td>
          <td>Umbral</td>
          <td>Inscribirse</td>
        </tr>
        <tr v-for="curso in cursos">
          <td>{{curso}}</td>
          <td>curso.name</td>
          <td>{{curso.cost}}</td>
          <td>{{curso.duration}}</td>
          <td>{{curso.threshold}}</td>
          <td><button type="button">Inscribirse</button></td>
        </tr>
      </table>
    </div>

  </div>
</template>

<script>
  import {mapActions, mapState} from 'vuex'
  import * as constants from '@/store/constants'

  export default {
    name: 'home',
    data() {
      return {
        newName: null,
        form: {
          newCourseCode: null,
          newCourseName: null,
          newCourseCost: null,
          newCourseDuration: null,
          newCourseThreshold: null,
          newCourseCodes: null,
        },
        formInscripcion: {
          courseCode: null,
          firstName: null,
          lastName: null,
          age: null,
          email: null,
        }
      }
    },
    computed: {
      ...mapState({
        name: state => state.Certifier.name,
        coinbase: state => state.Certifier.coinbase,
        isOwner: state => state.Certifier.isOwner,
        cursos: state => state.Certifier.cursos,
      })
    },
    methods: {
      ...mapActions({
        init: constants.CERTIFIER_INIT,
        saveName: constants.CERTIFIER_SET_NAME_BY_OWNER,
        saveNewCourse: constants.CERTIFIER_SET_NEW_COURSE_BY_OWNER,
        inscribirStudent: constants.CERTIFIER_SET_NEW_STUDENT_COURSE,
      }),
      save() {
        this.saveName(this.newName);
      },
      saveCourse() {
        this.saveNewCourse(this.form);
      },
      saveStudent() {
        this.inscribirStudent(this.formInscripcion);
      }
    },
    created() {
      this.init()
    }
  }
</script>
