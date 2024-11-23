<?php
// Incluir la conexión a la base de datos
include 'conexion.php'; // Asegúrate de que este archivo contiene la conexión correcta

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $correo = $_POST['correo'];
    $password = $_POST['password'];

    // Consulta para obtener el usuario y su rol
    $query = $pdo->prepare("SELECT id, nombre, password, role FROM usuarios WHERE correo = :correo");
    $query->bindParam(':correo', $correo);
    $query->execute();
    $user = $query->fetch(PDO::FETCH_ASSOC);

    if ($user && password_verify($password, $user['password'])) {
        // Iniciar sesión o generar token
        session_start();
        $_SESSION['id'] = $user['id'];
        $_SESSION['nombre'] = $user['nombre'];
        $_SESSION['role'] = $user['role'];

        // Enviar respuesta con el rol
        echo json_encode([
            'resultado' => true,
            'role' => $user['role'],  // Incluimos el rol
            'nombre' => $user['nombre'] // Incluimos el nombre si es necesario
        ]);
    } else {
        echo json_encode([
            'resultado' => false,
            'message' => 'Credenciales incorrectas'
        ]);
    }
}
?>
