<template>
  <section class="hero is-fullheight fondo">
    <div class="hero-body">
      <div class="container">
        <p class="title is-1 has-text-weight-bold has-text-white has-text-centered titulo">
          Bienvenido a Cafetería AlasCofe <br />
          <b-icon icon="account" size="is-large"></b-icon>
          Inicio de sesión
        </p>
        <div class="columns is-centered">
          <div class="column is-5-tablet is-6-desktop is-6-widescreen">
            <form class="box login-box" @keydown.enter.prevent="ingresar">
              <img src="@/assets/cafealas.png" alt="Logo" class="logo" />
              <b-field>
                <b-input
                  placeholder="Correo electrónico"
                  type="email"
                  icon="email"
                  v-model="correo"
                ></b-input>
              </b-field>
              <b-field>
                <b-input
                  type="password"
                  placeholder="Contraseña"
                  v-model="password"
                  password-reveal
                ></b-input>
              </b-field>
              <div class="field has-text-centered">
                <b-button
                  icon-left="login"
                  type="is-primary"
                  size="is-large"
                  @click="ingresar"
                >
                  Ingresar
                </b-button>
              </div>
            </form>
          </div>
        </div>
        <b-loading
          :is-full-page="true"
          v-model="cargando"
          :can-cancel="false"
        ></b-loading>
      </div>
    </div>
  </section>
</template>

<script>
import HttpService from "../../Servicios/HttpService";

export default {
  name: "Login",

  data: () => ({
    correo: "",
    password: "",
    cargando: false,
  }),

  methods: {
    ingresar() {
      if (!this.correo) {
        this.$buefy.toast.open({
          message: "Debes colocar el correo",
          type: "is-warning",
        });
        return;
      }
      if (!this.password) {
        this.$buefy.toast.open({
          message: "Debes colocar la contraseña",
          type: "is-warning",
        });
        return;
      }

      this.cargando = true;

      const payload = {
        correo: this.correo,
        password: this.password,
      };

      HttpService.obtenerConDatos(payload, "iniciar_sesion.php")
        .then((log) => {
          this.cargando = false;

          if (!log) {
            throw new Error("Respuesta del servidor vacía.");
          }

          if (log.resultado === "cambia") {
            this.$buefy.toast.open({
              message: "Datos correctos. Debes cambiar tu contraseña",
              type: "is-info",
            });
            this.$emit("logeado", log);
            return;
          }

          if (log.resultado) {
            this.$buefy.toast.open({
              message: "Datos correctos. Bienvenido",
              type: "is-success",
            });

            // Almacenar solo id_cargos
            const usuario = log.datos;
            const id_cargos = usuario.id_cargos; // Aquí obtenemos solo el id_cargos

            // Guardamos el id_cargos en el localStorage
            localStorage.setItem("id_cargos", id_cargos);

            // Redirigir a la ruta correspondiente dependiendo del rol.
            if (log.redirect) {
              this.$router.push({ path: `${log.redirect}` });
            } else {
              this.$buefy.toast.open({
                message: "Logeado Correctamente.",
                type: "is-green",
              });
            }

            this.$emit("logeado", log);
          } else {
            this.$buefy.toast.open({
              message: "Datos incorrectos. Verifica tu información",
              type: "is-danger",
            });
          }
        })
        .catch((error) => {
          console.error("Error al hacer login:", error);
          this.cargando = false;
          this.$buefy.toast.open({
            message: "Error en la conexión con el servidor",
            type: "is-danger",
          });
        });
    },
  },
};
</script>

</script>

  <style scoped>
  .fondo {
      background-image: url('~@/assets/Fondo_Cafeteria.png');
      background-attachment: fixed;
      background-size: cover;
      background-repeat: no-repeat;
      background-position: center;
  }
  
  .logo {
      width: 150px; 
      height: 150px; 
      border-radius: 50%;
      display: block;
      margin: 0 auto; 
      object-fit: cover;
  }
  
  .login-box {
      background-color: rgba(255, 255, 255, 0.8); /* Fondo blanco semi-transparente */
      border-radius: 10px; /* Bordes redondeados */
      padding: 20px; /* Espaciado interno */
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* Sombra para darle profundidad */
  }
  </style>
  
  
  
  