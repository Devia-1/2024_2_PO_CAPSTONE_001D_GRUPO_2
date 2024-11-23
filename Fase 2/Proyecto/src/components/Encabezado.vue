<template>
    <b-navbar class="navbar-custom" type="dark" fixed>
      <template #brand>
        <b-navbar-item>
          <img src="@/assets/cafealas.png" alt="logo" width="60" height="60">
          <span class="has-text-weight-bold ml-2">{{ datosLocal.nombre }}</span>
        </b-navbar-item>
      </template>
  
      <template #start>
        <b-navbar-item tag="router-link" :to="{ path: '/' }" exact>
          <b-icon icon="home" size="is-large"></b-icon>
          <span class="ml-2">Inicio</span>
        </b-navbar-item>
  
        <b-navbar-item tag="router-link" :to="{ path: '/insumos' }">
          <b-icon icon="food-fork-drink" size="is-large"></b-icon>
          <span class="ml-2">Consumisbles</span>
        </b-navbar-item>
  
        <!-- <b-navbar-item tag="router-link" :to="{ path: '/realizar-orden' }">
          <b-icon icon="order-bool-ascending-variant" size="is-large"></b-icon>
          <span class="ml-2">Ordenar</span>
        </b-navbar-item> -->
  
        <b-navbar-item tag="router-link" :to="{ path: '/categorias' }">
          <b-icon icon="archive-outline" size="is-large"></b-icon>
          <span class="ml-2">Categorías</span>
        </b-navbar-item>
  
        <b-navbar-item tag="router-link" :to="{ path: '/usuarios' }">
          <b-icon icon="account-group" size="is-large"></b-icon>
          <span class="ml-2">Usuarios</span>
        </b-navbar-item>
  
        <b-navbar-item tag="router-link" :to="{ path: '/reporte-ventas' }">
          <b-icon icon="cash-register" size="is-large"></b-icon>
          <span class="ml-2">Ventas</span>
        </b-navbar-item>
  
        <b-navbar-item tag="router-link" :to="{ path: '/configurar' }">
          <b-icon icon="application-cog-outline" size="is-large"></b-icon>
          <span class="ml-2">Configurar</span>
        </b-navbar-item>
      </template>
  
      <template #end>
        <b-navbar-item>
          <div class="buttons">
            <a class="button is-warning" @click="irAPerfil">
              <strong>{{ "Perfil" }}</strong>
            </a>
            <a class="button is-light" @click="salir">
              Cerrar sesión
            </a>
          </div>
        </b-navbar-item>
      </template>
    </b-navbar>
  </template>
  
  <script>
  import HttpService from '../Servicios/HttpService'
  import Utiles from '../Servicios/Utiles'
  
  export default {
    name: 'Encabezado',
    data() {
      return {
        expandOnHover: false,
        expandWithDelay: false,
        mobile: "reduce",
        reduce: false,
        datosLocal: {},
        nombreUsuario: "",
        logo: null
      };
    },
  
    mounted() {
      this.obtenerDatos()
      this.nombreUsuario = localStorage.getItem('nombreUsuario')
      this.logo = Utiles.generarUrlImagen(this.datosLocal.logo)
    },
  
    methods: {
      irAPerfil() {
        this.$router.push({
          name: "Perfil",
        })
      },
  
      obtenerDatos() {
        HttpService.obtener("obtener_datos_local.php")
          .then(resultado => {
            this.datosLocal = resultado
            this.logo = Utiles.generarUrlImagen(this.datosLocal.logo)
          })
      },
  
      salir() {
        this.$buefy.dialog.confirm({
          title: 'Cerrar Sesión?',
          message: 'Deseas Cerrar Sesión?',
          confirmText: 'Sí, Cerrar',
          cancelText: 'No',
          type: 'is-danger',
          hasIcon: true,
          onConfirm: () => {
            this.$emit("cerrar", false)
            localStorage.removeItem('logeado')
            this.$buefy.toast.open('Hasta pronto')
          }
        })
      }
    }
  }
  </script>
  
  <style scoped>
  .navbar-custom {
    background-color: #2C3E50; /* Color oscuro para el navbar */
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1); /* Sombra sutil */
  }
  
  .navbar-custom .navbar-item {
    color: #ecf0f1; /* Color claro para los items */
  }
  
  .navbar-custom .navbar-item:hover {
    background-color: #34495e; /* Cambio de color al pasar el mouse */
  }
  
  .navbar-custom .navbar-item.is-active {
    color: #f39c12; /* Color para el item activo */
    background-color: #34495e; /* Fondo para item activo */
  }
  
  .navbar-custom .navbar-item.router-link-exact-active {
    color: #f39c12; /* Asegura que el item activo tenga el mismo color */
    background-color: #34495e; /* Fondo para item activo */
  }
  
  .button {
    transition: all 0.3s ease; /* Transiciones suaves */
  }
  
  .button:hover {
    transform: scale(1.05); /* Efecto de agrandar el botón */
  }
  
  .button.is-warning:hover {
    background-color: #f39c12; /* Color para botones de advertencia al pasar el mouse */
  }
  
  .button.is-light:hover {
    background-color: #ecf0f1; /* Color para botones claros al pasar el mouse */
    color: #2c3e50; /* Color de texto para los botones claros */
  }
  
  .has-text-weight-bold {
    font-weight: 700; /* Fuente en negrita */
  }
  
  .ml-2 {
    margin-left: 8px; /* Espacio entre icono y texto */
  }
  </style>
  