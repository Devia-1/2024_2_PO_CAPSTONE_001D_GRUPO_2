<?php
include_once "encabezado.php";
include_once "funciones.php";
$filtros = json_decode(file_get_contents("php://input"));

$insumos = obtenerinsumos($filtros);

echo json_encode($insumos);