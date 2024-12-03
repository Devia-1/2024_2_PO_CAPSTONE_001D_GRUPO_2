<template>
    <section style="padding-top: 3em; bottom: 0;">
        <footer class="footer fondo">
            <div class="footer-content">
                <!-- <p class="titulo content title is-3 has-text-white">
                    <strong>{{ datosLocal.nombre }}</strong>. Teléfono <strong>{{ datosLocal.telefono }}</strong>
                </p> -->
                <span class="logo-container">
                    <img src="@/assets/cafealas.png" alt="logo" class="logo">   
                </span>
            </div>
        </footer>
    </section>
</template>

<script>
import HttpService from '../Servicios/HttpService'
export default {
    name: "Pie",

    data: () => ({
        datosLocal: {}
    }),

    mounted() {
        this.obtenerDatos()
    },

    methods: {
        obtenerDatos() {
            HttpService.obtener("obtener_datos_local.php")
                .then(resultado => {
                    this.datosLocal = resultado
                })
        }
    }
}
</script>

<style scoped>
.footer {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 2em 0;
    background-color: #333; /* Color de fondo sólido */
}

.footer-content {
    display: flex;
    align-items: center; /* Alinea verticalmente los elementos */
    justify-content: space-between; /* Espacio entre texto y logo */
    width: 100%; /* Ocupa todo el ancho */
    max-width: 1200px; /* Limita el ancho máximo */
    padding: 0 20px; /* Espacio interno */
}

.logo-container {
    width: 150px; /* Tamaño del contenedor */
    height: 150px; /* Tamaño del contenedor */
    overflow: hidden;
    border-radius: 50%; /* Bordes redondeados */
    display: flex;
    justify-content: center;
    align-items: center;
    margin-left: 20px; /* Espacio a la izquierda del logo */
}

.logo {
    width: 100%;
    height: auto;
    object-fit: cover; /* Para que la imagen cubra el contenedor */
}

.titulo {
    margin: 0; /* Elimina el margen para un mejor alineamiento */
    color: #fff; /* Asegura que el texto sea blanco */
    flex-grow: 1; /* Permite que el texto ocupe el espacio disponible */
}

.has-text-white {
    color: #fff; /* Asegura que el texto dentro de este elemento sea blanco */
}
</style>