DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorias` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tipo` enum('PLATILLO','BEBIDA') NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;



LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'PLATILLO','Tacos','Tacos de carne asada con salsa verde'),(2,'PLATILLO','Burguer','Hamburguesa con queso cheddar'),(3,'BEBIDA','Cerveza','Cerveza artesanal local'),(4,'BEBIDA','Refresco','Refresco de cola'),(5,'PLATILLO','Quesadillas','Quesadillas de queso con salsa roja'),(6,'PLATILLO','Nachos','Nachos con queso y jalapeños'),(7,'BEBIDA','Tequila','Tequila 100% agave'),(8,'BEBIDA','Agua Mineral','Agua mineral con gas'),(9,'PLATILLO','Sopes','Sopes de frijol con crema y salsa'),(10,'PLATILLO','Enchiladas','Enchiladas rojas con pollo'),(11,'BEBIDA','Margarita','Margarita clásica con sal'),(12,'BEBIDA','Limonada','Limonada fresca y natural');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `informacion_negocio`
--

DROP TABLE IF EXISTS `informacion_negocio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `informacion_negocio` (
  `nombre` varchar(100) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `numeroMesas` tinyint(4) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `informacion_negocio`
--

LOCK TABLES `informacion_negocio` WRITE;
/*!40000 ALTER TABLE `informacion_negocio` DISABLE KEYS */;
INSERT INTO `informacion_negocio` VALUES ('CafeAlas','+56972669452',4,'./fotos/673c4bd963472.png'),('CafeAlas','+56972669452',4,'./fotos/673c4bd963472.png'),('CafeAlas','+56972669452',4,'./fotos/673c4bd963472.png'),('CafeAlas','+56972669452',4,'./fotos/673c4bd963472.png');
/*!40000 ALTER TABLE `informacion_negocio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insumos`
--

DROP TABLE IF EXISTS `insumos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insumos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `codigo` varchar(100) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `precio` decimal(6,2) NOT NULL,
  `tipo` enum('PLATILLO','BEBIDA') NOT NULL,
  `categoria` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insumos`
--

LOCK TABLES `insumos` WRITE;
/*!40000 ALTER TABLE `insumos` DISABLE KEYS */;
INSERT INTO `insumos` VALUES (1,'INS001','Tortillas','Tortillas de maíz',15.00,'PLATILLO',1),(2,'INS002','Carne Asada','Carne asada para tacos',120.00,'PLATILLO',1),(3,'INS003','Pan de Hamburguesa','Pan suave para hamburguesas',10.00,'PLATILLO',2),(4,'INS004','Queso Cheddar','Queso para hamburguesas',30.00,'PLATILLO',2),(5,'INS005','Cerveza Artesanal','Cerveza de producción local',50.00,'BEBIDA',3),(6,'INS006','Refresco de Cola','Refresco clásico',25.00,'BEBIDA',4),(7,'INS007','Queso Oaxaca','Queso derretido para quesadillas',35.00,'PLATILLO',1),(8,'INS008','Jalapeños','Jalapeños en rodajas',20.00,'PLATILLO',2),(9,'INS009','Guacamole','Guacamole fresco',40.00,'PLATILLO',2),(10,'INS010','Tequila Plata','Tequila suave',150.00,'BEBIDA',3),(11,'INS011','Agua Mineral','Botella de agua mineral',15.00,'BEBIDA',4),(12,'INS012','Frijoles','Frijoles negros cocidos',25.00,'PLATILLO',1),(13,'INS013','Crema','Crema agria',15.00,'PLATILLO',1),(14,'INS014','Pollo Deshebrado','Pollo cocido y desmenuzado',100.00,'PLATILLO',2),(15,'INS015','Margarita Mix','Mezcla para margaritas',60.00,'BEBIDA',3),(16,'INS016','Limones','Limones frescos',10.00,'BEBIDA',4);
/*!40000 ALTER TABLE `insumos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insumos_venta`
--

DROP TABLE IF EXISTS `insumos_venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insumos_venta` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idInsumo` bigint(20) unsigned NOT NULL,
  `precio` decimal(6,2) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `idVenta` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insumos_venta`
--

LOCK TABLES `insumos_venta` WRITE;
/*!40000 ALTER TABLE `insumos_venta` DISABLE KEYS */;
INSERT INTO `insumos_venta` VALUES (1,1,15.00,10,1),(2,2,120.00,1,1),(3,5,50.00,2,1),(4,3,10.00,1,2),(5,4,30.00,1,2),(6,7,35.00,5,3),(7,8,20.00,3,3),(8,9,40.00,2,3),(9,10,150.00,1,4),(10,11,15.00,2,4),(11,12,25.00,4,5),(12,13,15.00,2,5),(13,14,100.00,1,5),(14,15,60.00,3,6),(15,16,10.00,5,6),(16,2,120.00,1,7),(17,6,25.00,1,7),(18,2,120.00,1,18),(19,2,120.00,2,19),(20,1,15.00,1,19),(21,2,120.00,1,20),(22,4,30.00,1,20),(23,4,30.00,1,21),(24,10,150.00,1,21),(25,2,120.00,1,23),(26,3,10.00,1,23),(27,2,120.00,1,24),(28,6,25.00,1,24),(29,3,10.00,1,25),(30,14,100.00,1,25),(31,2,120.00,1,26),(32,10,150.00,1,26),(33,6,25.00,1,26);
/*!40000 ALTER TABLE `insumos_venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `correo` varchar(100) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(50) NOT NULL DEFAULT 'user',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'cafeteria@gmail.com','cafeteria','12345678','$2y$10$GGqTlKif8pIkRk1P7/cMYO7o7htYXrw6Z5IpD1ry0i1GDE7DSmP6S','admin'),(2,'admin@botanero.com','Admin','5559876543','password123','user');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ventas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idMesa` tinyint(4) NOT NULL,
  `cliente` varchar(100) DEFAULT NULL,
  `fecha` datetime NOT NULL,
  `total` decimal(6,2) NOT NULL,
  `pagado` decimal(6,2) NOT NULL,
  `idUsuario` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` VALUES (1,1,'Carlos Ruiz','2024-11-16 12:30:00',250.00,250.00,1),(2,2,'Laura Gómez','2024-11-16 13:15:00',150.00,150.00,2),(3,3,'María Fernández','2024-11-16 14:00:00',300.00,300.00,1),(4,4,'Luis Martínez','2024-11-16 15:30:00',200.00,200.00,2),(5,5,'Elena Ruiz','2024-11-16 16:00:00',350.00,350.00,1),(6,6,'Diego Ríos','2024-11-16 17:15:00',275.00,275.00,2),(7,1,'MOSTRADOR','2024-11-17 18:13:36',145.00,200.00,1),(8,1,'Fernanda Castro','2024-11-17 11:00:00',180.00,180.00,1),(9,2,'Ricardo Pérez','2024-11-17 11:30:00',220.00,220.00,2),(10,3,'Sofía Martínez','2024-11-17 12:00:00',300.00,300.00,1),(11,4,'Alberto Torres','2024-11-17 12:30:00',150.00,150.00,2),(12,5,'Valeria López','2024-11-17 13:00:00',400.00,400.00,1),(13,6,'Javier Ramírez','2024-11-17 13:30:00',275.00,275.00,2),(14,7,'Cristina Medina','2024-11-17 14:00:00',130.00,130.00,1),(15,8,'Diego Torres','2024-11-17 14:30:00',90.00,90.00,2),(16,9,'Marta Sánchez','2024-11-17 15:00:00',350.00,350.00,1),(17,10,'Luis Hernández','2024-11-17 15:30:00',210.00,210.00,2),(18,1,'MOSTRADOR','2024-11-17 23:49:57',120.00,9999.99,1),(19,1,'MOSTRADOR','2024-11-18 01:11:05',255.00,300.00,1),(20,1,'MOSTRADOR','2024-11-19 09:38:07',150.00,160.00,1),(21,1,'MOSTRADOR','2024-11-19 10:56:07',180.00,1111.00,1),(22,1,'MOSTRADOR','2024-11-19 12:27:41',0.00,1.00,1),(23,2,'MOSTRADOR','2024-11-19 12:27:54',130.00,1111.00,1),(24,1,'MOSTRADOR','2024-11-19 13:08:37',145.00,2000.00,1),(25,1,'MOSTRADOR','2024-11-19 13:37:13',110.00,200.00,1),(26,1,'MOSTRADOR','2024-11-19 15:32:17',295.00,399.00,1);
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;


ALTER TABLE `insumos`
ADD CONSTRAINT `fk_categoria_insumo`
FOREIGN KEY (`categoria`) REFERENCES `categorias` (`id`)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE `insumos_venta`
ADD CONSTRAINT `fk_insumo_insumos_venta`
FOREIGN KEY (`idInsumo`) REFERENCES `insumos` (`id`)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE `insumos_venta`
ADD CONSTRAINT `fk_venta_insumos_venta`
FOREIGN KEY (`idVenta`) REFERENCES `ventas` (`id`)
ON DELETE CASCADE
ON UPDATE CASCADE;


ALTER TABLE `ventas`
ADD CONSTRAINT `fk_usuario_venta`
FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`id`)
ON DELETE CASCADE
ON UPDATE CASCADE;


ALTER TABLE `ventas`
ADD CONSTRAINT `fk_cliente_venta`
FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`id`)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE `empleados`
ADD CONSTRAINT `fk_usuario_empleado`
FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`id`)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE `empleados`
ADD CONSTRAINT `fk_puesto_empleado`
FOREIGN KEY (`idPuesto`) REFERENCES `puestos` (`id`)
ON DELETE CASCADE
ON UPDATE CASCADE;
