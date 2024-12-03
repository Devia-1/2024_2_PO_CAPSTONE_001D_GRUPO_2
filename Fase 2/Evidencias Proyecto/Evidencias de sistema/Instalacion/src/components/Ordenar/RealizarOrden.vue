<template>
    <section>
        <p class="title is-1 has-text-weight-bold">
            <b-icon
                icon="hamburger-check"
                size="is-large"
                type="is-primary">
            </b-icon>
            Pedidos 
        </p>

        <div class="columns is-multiline">
            <div class="column" 
            v-for="mesa in mesas" 
            :key="mesa.mesa.idMesa">
                
                <div class="box">
                    <p class="title is-2 has-text-grey">Mesa #{{ mesa.mesa.idMesa }}
                        <span class="title is-1 has-text-weight-bold is-pulled-right" v-if="mesa.mesa.total">
                            ${{ mesa.mesa.total }}
                        </span>
                    </p>
                    <p v-if="mesa.mesa.atiende">
                        <strong>Atiende</strong>: {{ mesa.mesa.atiende }}
                    </p>
                    <p v-if="mesa.mesa.cliente">
                        <strong>Cliente</strong>: {{ mesa.mesa.cliente }}
                    </p>
                    <p v-if="mesa.mesa.estado === 'ocupada'">
                        <strong>Tiempo de espera:</strong> {{ formatTime(mesa.timer) }} 
                    </p>
                    <b-collapse 
                        class="card" 
                        animation="slide" 
                        aria-id="contentIdForA11y3"
                        v-if="mesa.mesa.estado === 'ocupada'">
                        <template #trigger="props">
                            <div
                                class="card-header"
                                role="button"
                                aria-controls="contentIdForA11y3"
                                :aria-expanded="props.open">
                                <p class="card-header-title">
                                    insumos en la orden
                                </p>
                                <a class="card-header-icon">
                                    <b-icon
                                        :icon="props.open ? 'menu-down' : 'menu-up'">
                                    </b-icon>
                                </a>
                            </div>
                        </template>

                        <div class="card-content">
                            <div class="content">
                                <b-table
                                :data="mesa.insumos"
                                :checked-rows.sync="checkedRows"
                                :is-row-checkable="(row) => row.estado !== 'entregado'"
                                checkable
                                :checkbox-position="checkboxPosition"
                                :checkbox-type="checkboxType">

                                    <b-table-column field="codigo" label="Código" v-slot="props">
                                        {{ props.row.codigo }}
                                    </b-table-column>                                    
                                    
                                    <b-table-column field="nombre" label="Nombre" v-slot="props">
                                        {{ props.row.nombre }}
                                    </b-table-column>                                    
                                    
                                    <b-table-column field="caracteristicas" label="Características" v-slot="props">
                                        {{ props.row.caracteristicas }}
                                    </b-table-column>  

                                    <b-table-column field="cantidad" label="Cantidad" v-slot="props">
                                        {{ props.row.cantidad }} X ${{  props.row.precio }}
                                    </b-table-column>                                        
                                    
                                    <b-table-column field="subtotal" label="Subtotal" v-slot="props">
                                        ${{ props.row.cantidad * props.row.precio }}
                                    </b-table-column>                                                                
                                    <b-table-column field="estado" label="" v-slot="props">
                                        <b-icon icon="alert" type="is-danger" v-if="props.row.estado ==='pendiente'"></b-icon>
                                        <b-icon icon="check" type="is-success" v-if="props.row.estado ==='entregado'"></b-icon>
                                    </b-table-column>                                                                
                                </b-table>
                            </div>
                        </div>
                    </b-collapse>
                    <br>
                    <div class="has-text-centered">
                        <b-button type="is-primary" icon-left="check" @click="ocuparMesa(mesa)" v-if="mesa.mesa.estado === 'libre'">Ocupar</b-button>  
                        <div class="field is-grouped is-centered" v-if="mesa.mesa.estado === 'ocupada'">
                            <p class="control">
                                <b-button type="is-success" icon-left="cash" @click="cobrar(mesa)">Cobrar</b-button>
                            </p>
                            <p class="control">
                                <b-button type="is-info" icon-left="plus" @click="ocuparMesa(mesa)">Agregar  insumos</b-button>
                            </p>
                            <p class="control">
                                <b-button type="is-warning" icon-left="check" v-if="checkedRows.length > 0" @click="marcarinsumosEntregados(mesa)">Marcar entrega</b-button>
                            </p>
                            <p class="control">
                                <b-button type="is-danger" icon-left="close"  @click="cancelarOrden(mesa.mesa.idMesa)">Cancelar</b-button>
                            </p>
                        </div>
                    </div>            
                </div>
            </div>
        </div>
        <b-loading :is-full-page="true" v-model="cargando" :can-cancel="false"></b-loading>
        <ticket @impreso="onImpreso" :venta="this.ventaSeleccionada" :insumos="insumosSeleccionados" :datosLocal="datos" :logo="logo" v-if="mostrarTicket"></ticket>
    </section>
</template>

<script>
import HttpService from '../../Servicios/HttpService'
import Ticket from '../Ventas/Ticket.vue'
import Utiles from '../../Servicios/Utiles'

export default ({
    name: "RealizarOrden",
    components: { Ticket },

    data: () => ({
        datos: {},
        logo: null,
        checkboxPosition: 'left',
        checkboxType: 'is-primary',
        checkedRows: [],
        mesas: [],
        timers: {}, 
        cargando: false,
        mostrarTicket: false,
        ventaSeleccionada: {},
        insumosSeleccionados: []
    }),

    mounted(){
        this.crearMesas()
        this.obtenerDatos()
        
        // Iniciar el temporizador para cada mesa ocupada
        this.startTimers();
    },

    methods:{
        startTimers() {
            Object.values(this.timers).forEach(timer => clearInterval(timer));
            this.mesas.forEach(mesa => {
                if (mesa.mesa.estado === 'ocupada') {
                    mesa.timer = 0;
                    this.timers[mesa.mesa.idMesa] = setInterval(() => {
                        mesa.timer++;
                    }, 1000);
                }
            });
        },

        formatTime(seconds) {
            const minutes = Math.floor(seconds / 60);
            const secs = seconds % 60;
            return `${minutes}:${secs < 10 ? '0' : ''}${secs}`;
        },

        watch: {
            mesas: {
                handler() {
                    this.startTimers(); 
            },
            deep: true  // Esto garantiza que los cambios en el objeto 'mesas' sean observados, incluso si cambian dentro

           }
        }, 

        cancelarOrden(id){
            this.$buefy.dialog.confirm({
                title: 'Cancelar mesa ' + id,
                message: '¿Seguro deseas  cancelar la órden?',
                confirmText: 'Sí, cancelar',
                cancelText: 'No',
                type: 'is-danger',
                hasIcon: true,
                onConfirm: () => {
                    this.cargando = true
                    HttpService.eliminar("cancelar_mesa.php", id)
                    .then(resultado => {
                        if(resultado){
                            this.$buefy.toast.open({
                                message: "Orden de la mesa " + id + " cancelada",
                                type: "is-success"
                            })
                            this.crearMesas()
                            this.cargando = false
                        }
                    })
                }
            })
        },

        obtenerDatos() {
            HttpService.obtener("obtener_datos_local.php").then((resultado) => {
                this.datos = resultado;
                this.logo = Utiles.generarUrlImagen(this.datos.logo)
            });
        },

        onImpreso(resultado){
            this.mostrarTicket = resultado
        },

        imprimirComprobante(venta){
            let hoy = new Date();
            let fecha = hoy.getFullYear()+'-'+(hoy.getMonth()+1)+'-'+hoy.getDate();
            let hora = hoy.getHours() + ":" + hoy.getMinutes() + ":" + hoy.getSeconds();
            let fechaVenta = fecha+' '+hora
            this.ventaSeleccionada = {
                atendio: venta.atiende,
                cliente: venta.cliente,
                fecha: fechaVenta,
                pagado: venta.pagado,
                total: venta.total
            }
            this.insumosSeleccionados = venta.insumos
            this.mostrarTicket = true
        },

        marcarinsumosEntregados(mesa){
            this.cargando = true
            let insumos = mesa.insumos
            let marcados = this.checkedRows

            insumos.forEach(insumo => {
                marcados.forEach(marca => {
                    if(insumo.id === marca.id)
                        insumo.estado = "entregado"
                })
            })

            let payload = {
                id: mesa.mesa.idMesa,
                insumos: insumos,
                total: mesa.mesa.total,
                atiende: mesa.mesa.atiende,
                idUsuario: mesa.mesa.idUsuario,
                cliente: mesa.mesa.cliente
            }

            HttpService.registrar(payload, "editar_mesa.php")
            .then(resultado => {
                if(resultado){
                    this.$buefy.toast.open({
                        message: 'insumos marcados como entregados',
                        type: 'is-success'
                    })
                    this.crearMesas()
                    this.cargando = false
                }
                this.checkedRows = []
            })
        },

        cobrar(mesa){
            this.$buefy.dialog.prompt({
                title: `Cobrar a la mesa #` + mesa.mesa.idMesa,
                message: `El cliente debe pagar $` + mesa.mesa.total,
                inputAttrs: {
                    type: 'number',
                    value:"",
                    placeholder: 'Escribe la cantidad con la que paga',
                    min: 1
                },
                trapFocus: true,
                onConfirm: (value) => {
                    if(parseFloat(value) < parseFloat(mesa.mesa.total)){
                        this.$buefy.toast.open({
                            message: 'Escribe una cantidad correcta',
                            type: 'is-warning'
                        })
                        return
                    }

                    this.cargando = true
                    let cambio = parseFloat(value - mesa.mesa.total)

                    let payload = {
                        idMesa: mesa.mesa.idMesa,
                        cliente: mesa.mesa.cliente,
                        total: mesa.mesa.total,
                        pagado: value, 
                        idUsario: mesa.mesa.idUsuario,
                        insumos: mesa.insumos,
                        atiende: mesa.mesa.atiende
                    }
                    
                    HttpService.registrar(payload, "registrar_venta.php")
                    .then(registrado => {
                        if(registrado){
                            this.$buefy.dialog.alert({
                                title: 'Venta registrada',
                                message: 'Gracias por su compra, su cambio <b>$' + cambio + '</b>',
                                confirmText: 'OK'
                            })
                            this.imprimirComprobante(payload)
                            this.crearMesas()
                            this.cargando = false
                        }
                    })
                }
            })
        },

        crearMesas(){
            this.cargando = true;
            HttpService.obtener("obtener_mesas.php")
            .then(resultado => {
                this.mesas = resultado;
                this.startTimers(); // Reiniciar temporizadores al cargar mesas
                this.cargando = false
            })
        },

        ocuparMesa(mesa){
            this.$router.push({
                name: "Ordenar",
                params: { id: mesa.mesa.idMesa, insumosEnLista: mesa.insumos, cliente: mesa.mesa.cliente },
            });
            mesa.timer = 0; // Reiniciar el temporizador al ocupar mesa
            this.cargando = false;
        }
    }
})
</script>
<!-- <style scoped>
    .box {
        background-color: #f7f7f7; /* Color de fondo más suave */
        border: 2px solid #dcdcdc; /* Borde suave */
        border-radius: 8px; /* Bordes redondeados */
        transition: all 0.3s ease; /* Efecto de transición para interactividad */
    }

    .box:hover {
        background-color: #e0e0e0; /* Cambio de fondo al pasar el mouse */
        border-color: #aaa; /* Borde más oscuro al pasar el mouse */
    }

    .title.is-2 {
        color: #333333; /* Color de texto más oscuro para mejor contraste */
    }

    .card-header {
        background-color: #4CAF50; /* Verde para el header */
        color: white; /* Texto blanco en el header */
        padding: 1rem;
    }

    .card-header:hover {
        background-color: #45a049; /* Verde más oscuro cuando pasa el mouse */
    }

    .card-content {
        background-color: #ffffff; /* Fondo blanco para el contenido */
    }

    .has-text-grey {
        color: #666666; /* Gris suave para los textos secundarios */
    }

    .card {
        border: 2px solid #ccc; /* Borde gris claro para las tarjetas */
        margin-top: 1rem; /* Separación superior */
        border-radius: 8px; /* Bordes redondeados */
    }

    .field.is-grouped.is-centered p.control b-button {
        margin: 0 5px;
    }

    /* Estilos para los botones para mejorar la visibilidad */
    .is-primary {
        background-color: #3498db; /* Azul para el botón primario */
        border-color: #2980b9;
    }

    .is-success {
        background-color: #2ecc71; /* Verde para el botón de éxito */
        border-color: #27ae60;
    }

    .is-warning {
        background-color: #f39c12; /* Amarillo para el botón de advertencia */
        border-color: #e67e22;
    }

    .is-danger {
        background-color: #e74c3c; /* Rojo para el botón de peligro */
        border-color: #c0392b;
    }
</style> -->
