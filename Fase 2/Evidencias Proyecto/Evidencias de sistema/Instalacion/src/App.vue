<template>
  <div id="app" class="background-image">
    <configuracion-inicial v-if="configurar"/>
    <login @logeado="onLog" v-if="!logeado && !configurar"></login>
    <cambiar-password v-if="cambiarPassword"></cambiar-password>
    <div v-if="logeado && !cambiarPassword">
      <encabezado @cerrar="onClose"/> 
      <div class="container">
        <router-view/>
      </div> 
      <pie /> 
    </div>
  </div>
</template>

<script>
import Login from './components/Usuarios/Login.vue'
import CambiarPassword from './components/Usuarios/CambiarPassword.vue'
import ConfiguracionInicial from './components/Configuracion/ConfiguracionInicial.vue'
import Encabezado from './components/Encabezado.vue'
import Pie from './components/Pie.vue'
import HttpService from './Servicios/HttpService'

export default {
  components: { Encabezado, Pie, Login, CambiarPassword, ConfiguracionInicial },
  name: 'App',

  data: ()=> ({
    logeado: false,
    datos: "",
    cambiarPassword: false,
    configurar: false
  }),

  mounted(){
    this.verificarInformacion()
    let logeado = this.verificarSesion()
    if(logeado) {
      this.logeado = true
    }
  },

  methods: {
    verificarInformacion(){
      HttpService.obtener("verificar_tablas.php")
      .then(resultado => {
        if(resultado.resultado > 0){
          this.configurar = false
          return
        }

        this.configurar = true
        return
      })
    },

    verificarSesion(){
      let logeado = localStorage.getItem('logeado')
      if(logeado) {
        return logeado
      }
      return false
    },

    onLog(logeado){
      if(logeado.resultado === "cambia"){
        this.cambiarPassword = true
        this.logeado = true
        localStorage.setItem('nombreUsuario', logeado.datos.nombreUsuario)
        localStorage.setItem('idUsuario', logeado.datos.idUsuario)
        return
      }

      if(logeado.resultado){
        this.logeado = true
        localStorage.setItem('logeado', true)
        localStorage.setItem('nombreUsuario', logeado.datos.nombreUsuario)
        localStorage.setItem('idUsuario', logeado.datos.idUsuario)

        // Obtener el id_cargos desde el localStorage
        const id_cargos = localStorage.getItem('id_cargos');
        console.log(`ID Cargo: ${id_cargos}`); // Aquí puedes usar el id_cargos según el rol
      }
    },

    onClose(logeado){
      this.logeado = logeado
    }
  }
}
</script>

<style scoped>
.background-image {
  background-image: url('~@/assets/fondocolorcrema.png');
  background-size: cover;
  background-position: center;
  height: 100vh;
  width: 100%;
}
</style>
