<?php

$usuario = json_decode(file_get_contents("php://input"));
if(!$usuario) exit("No se encontraron datos");

include_once "encabezado.php";
include_once "funciones.php";

$respuesta = iniciarSesion($usuario->correo, $usuario->password);

if($respuesta){
    // Agrega id_cargos al arreglo de respuesta
    $usuario = [
        "nombreUsuario" => $respuesta->nombre,
        "idUsuario" => $respuesta->id,
        "id_cargos" => $respuesta->id_cargos // Aquí agregas el id_cargos
    ];

    $verificaPass = verificarPassword("Contraseña123", $respuesta->id);
    if($verificaPass) {
        echo json_encode(["resultado" => "cambia", "datos" => $usuario]);
        return;
    }

    echo json_encode(["resultado" => true, "datos" => $usuario]);
} else {
    echo json_encode(["resultado" => false]);
}
