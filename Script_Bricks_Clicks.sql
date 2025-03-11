-- Ariadne Selena Romero Rivero #1957540 
CREATE DATABASE IF NOT EXISTS Empresa_BrickClicks_Ariadne; 
USE Empresa_BrickClicks_Ariadne; 

-- TABLAS
CREATE TABLE Clientes (
   id_cliente INT AUTO_INCREMENT PRIMARY KEY,  
   nombre VARCHAR(50) NOT NULL,
   apellido VARCHAR(50) NOT NULL,
   email VARCHAR(100),
   telefono VARCHAR(15),
   direccion VARCHAR(225),
   ciudad varchar(225)
);

CREATE TABLE Productos (
	id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    categoria VARCHAR(225),
    marca VARCHAR(50),
    precio DECIMAL(10,2) NOT NULL
);

CREATE TABLE Sucursales (
    id_sucursal INT AUTO_INCREMENT PRIMARY KEY,
    nombre_sucursal VARCHAR(100) NOT NULL,
    direccion VARCHAR(225) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    ciudad VARCHAR(100)
);

CREATE TABLE Metodos_Pagos (
	id_metodo INT AUTO_INCREMENT PRIMARY KEY,
    nombre_met VARCHAR(50) NOT NULL,
    descripcion VARCHAR(225)
);

CREATE TABLE Inventario (
    id_producto INT NOT NULL,
    id_sucursal INT NOT NULL,
    cantidad_disponible INT NOT NULL,
    cantidad_reservada INT NOT NULL,
    PRIMARY KEY (id_producto, id_sucursal),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto),
    FOREIGN KEY (id_sucursal) REFERENCES Sucursales(id_sucursal)
);

CREATE TABLE Ordenes (
	id_orden INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_sucursal INT NOT NULL,
    fecha_orden DATE,
    tipo_orden ENUM('Comprada en sucursal', 'Recogida en sucursal', 'Envío a casa', 'En línea') NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_sucursal) REFERENCES Sucursales(id_sucursal)
);

CREATE TABLE Detalles_Ordenes (
	id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_orden INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2),
    monto DECIMAL(10,2),
	FOREIGN KEY (id_orden) REFERENCES Ordenes(id_orden),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

CREATE TABLE Facturacion (
	id_factura INT AUTO_INCREMENT PRIMARY KEY,
	id_orden INT NOT NULL,
    id_metodo INT NOT NULL,
    fecha_emision DATE,
	estatus_facturacion ENUM('Emitido', 'Pagado', 'Cancelado') NOT NULL,
    monto decimal(10,2),
	FOREIGN KEY (id_orden) REFERENCES Ordenes(id_orden),
	FOREIGN KEY (id_metodo) REFERENCES Metodos_Pagos(id_metodo)
);

-- Envío a casa, En línea, recogida en sucursal
CREATE TABLE Envios(
	id_envio INT AUTO_INCREMENT PRIMARY KEY,
    id_orden INT NOT NULL,
    fecha_envio DATE,
    ciudad VARCHAR(225),
    direccion VARCHAR(225),
    estatus_envio ENUM('Pendiente', 'En transito', 'Entregado', 'Cancelado', 'Listo para recoger') NOT NULL,
    costo_envio DECIMAL(10,2),
	FOREIGN KEY (id_orden) REFERENCES Ordenes(id_orden)
);


-- INSERTS
INSERT INTO Clientes (id_cliente, nombre, apellido, email, telefono, direccion, ciudad) values (1, 'Ariadne', 'Romero', 'ariadne@gmail.com', '7548558322', '9 Norway Maple Center', 'Escobedo');
INSERT INTO Clientes (id_cliente, nombre, apellido, email, telefono, direccion, ciudad) values (2, 'Erick', 'Flores', 'erick@hotmail.com', '3556167246', '21658 Cambridge Way', 'Monterrey');
INSERT INTO Clientes (id_cliente, nombre, apellido, email, telefono, direccion, ciudad) values (3, 'Ximena', 'Gomez', 'ximena@yahoo.com', '3701582103', '3 Jackson Hill', 'Guadalupe');
INSERT INTO Clientes (id_cliente, nombre, apellido, email, telefono, direccion, ciudad) values (4, 'Jonathan', 'Lucio', 'jonalucio@gmail.com', '5157176958', '268 Lindbergh Street', 'Escobedo');
INSERT INTO Clientes (id_cliente, nombre, apellido, email, telefono, direccion, ciudad) values (5, 'Stefany', 'Rivero', 'fefirivero@yahoo.com', '4191624730', '066 Memorial Road', 'San Nicolás de los Garza');

INSERT INTO Productos (id_producto, nombre_producto, categoria, marca, precio) VALUES (1, 'Smartphone Galaxy S21', 'Electrónica', 'Samsung', 2699.99);
INSERT INTO Productos (id_producto, nombre_producto, categoria, marca, precio) VALUES (2, 'Laptop MacBook Air', 'Electrónica', 'Apple', 1845.99);
INSERT INTO Productos (id_producto, nombre_producto, categoria, marca, precio) VALUES (3, 'Detergente Líquido 5L', 'Limpieza', 'Ariel', 60);
INSERT INTO Productos (id_producto, nombre_producto, categoria, marca, precio) VALUES (4, 'Escoba Multiusos', 'Limpieza', 'Scotch-Brite', 100);
INSERT INTO Productos (id_producto, nombre_producto, categoria, marca, precio) VALUES (5, 'Arroz Integral 1kg', 'Comida', 'Great Value', 40);
INSERT INTO Productos (id_producto, nombre_producto, categoria, marca, precio) VALUES (6, 'Cámara Réflex EOS 250D', 'Fotografía', 'Canon', 999.99);

INSERT INTO Sucursales (id_sucursal, nombre_sucursal, direccion, telefono, ciudad) VALUES (1, 'Sucursal Centro', 'Av. Central 123', '555-1234', 'Escobedo');
INSERT INTO Sucursales (id_sucursal, nombre_sucursal, direccion, telefono, ciudad) VALUES (2, 'Sucursal Norte', 'Calle Hidalgo 456', '555-5678', 'San Nicolás de los Garza');
INSERT INTO Sucursales (id_sucursal, nombre_sucursal, direccion, telefono, ciudad) VALUES (3, 'Sucursal Sur', 'Blvd. del Sur 789', '555-9012', 'Monterrey');
INSERT INTO Sucursales (id_sucursal, nombre_sucursal, direccion, telefono, ciudad) VALUES (4, 'Sucursal Este', 'Av. de las Flores 101', '555-3456', 'Guadalupe');
INSERT INTO Sucursales (id_sucursal, nombre_sucursal, direccion, telefono, ciudad) VALUES (5, 'Sucursal Oeste', 'Calle Luna 202', '555-7890', 'San Pedro Garza García');

INSERT INTO Metodos_Pagos (id_metodo, nombre_met, descripcion) values (1, 'PayPal', 'In hac habitasse platea dictumst. Morbi vestibulum');
INSERT INTO Metodos_Pagos (id_metodo, nombre_met, descripcion) values (2, 'americanexpress', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.');
INSERT INTO Metodos_Pagos (id_metodo, nombre_met, descripcion) values (3, 'Visa', 'Duis consequat dui nec nisi volutpat ');
INSERT INTO Metodos_Pagos (id_metodo, nombre_met, descripcion) values (4, 'Efectivo', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.');
INSERT INTO Metodos_Pagos (id_metodo, nombre_met, descripcion) values (5, 'Mastercard', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.');

INSERT INTO Inventario (id_producto, id_sucursal, cantidad_disponible, cantidad_reservada) values (1, 1, 7, 2);
INSERT INTO Inventario (id_producto, id_sucursal, cantidad_disponible, cantidad_reservada) values (2, 1, 8, 2);

INSERT INTO Inventario (id_producto, id_sucursal, cantidad_disponible, cantidad_reservada) values (3, 2, 26, 0);
INSERT INTO Inventario (id_producto, id_sucursal, cantidad_disponible, cantidad_reservada) values (4, 2, 20, 2);

INSERT INTO Inventario (id_producto, id_sucursal, cantidad_disponible, cantidad_reservada) values (5, 3, 30, 14);
INSERT INTO Inventario (id_producto, id_sucursal, cantidad_disponible, cantidad_reservada) values (6, 3, 9, 1);

INSERT INTO Inventario (id_producto, id_sucursal, cantidad_disponible, cantidad_reservada) values (1, 4, 9, 0);
INSERT INTO Inventario (id_producto, id_sucursal, cantidad_disponible, cantidad_reservada) values (2, 4, 10, 5);

INSERT INTO Inventario (id_producto, id_sucursal, cantidad_disponible, cantidad_reservada) values (3, 5, 36, 1);
INSERT INTO Inventario (id_producto, id_sucursal, cantidad_disponible, cantidad_reservada) values (6, 5, 30, 0);


-- Orden 1---------------------------------------------------
insert into Ordenes (id_orden, id_cliente, id_sucursal, fecha_orden, tipo_orden, subtotal, total) values (1, 5, 2, '2023-10-10', 'Envío a casa', 220, 266.38);
insert into Detalles_Ordenes (id_detalle, id_orden, id_producto, cantidad, precio_unitario, monto) values (1, 1, 3, 2, 60, 120);
insert into Detalles_Ordenes (id_detalle, id_orden, id_producto, cantidad, precio_unitario, monto) values (2, 1, 4, 1, 100, 100);
insert into Envios (id_envio, id_orden, fecha_envio, ciudad, direccion, estatus_envio, costo_envio) values (1, 1, '2023-10-13', 'San Nicolás de los Garza', '066 Memorial Road', 'Entregado', 9.64);
insert into Facturacion (id_factura, id_orden, id_metodo, fecha_emision, estatus_facturacion, monto) VALUES (1, 1, 3, '2023-10-10', 'Pagado', 266.38);


-- Orden 2------------------------------------------------
insert into Ordenes (id_orden, id_cliente, id_sucursal, fecha_orden, tipo_orden, subtotal, total) values (2, 4, 1, '2024-10-17', 'En línea', 2699.99, 3131.98);
insert into Detalles_Ordenes (id_detalle, id_orden, id_producto, cantidad, precio_unitario, monto) values (3, 2, 1, 1, 2699.99, 2699.99);
insert into Envios (id_envio, id_orden, fecha_envio, ciudad, direccion, estatus_envio, costo_envio) values (2, 2, '2023-10-14', 'Escobedo', '268 Lindbergh Street', 'Entregado', 0);
insert into Facturacion (id_factura, id_orden, id_metodo, fecha_emision, estatus_facturacion, monto) VALUES (2, 2, 2, '2024-10-17', 'Pagado', 3131.98);

-- Orden 3-----------------------------------------------
insert into Ordenes (id_orden, id_cliente, id_sucursal, fecha_orden, tipo_orden, subtotal, total) values (3, 2, 3, '2024-10-05', 'Comprada en sucursal', 160, 185.6);
insert into Detalles_Ordenes (id_detalle, id_orden, id_producto, cantidad, precio_unitario, monto) values (4, 3, 5, 4, 40, 160);
insert into Facturacion (id_factura, id_orden, id_metodo, fecha_emision, estatus_facturacion, monto) VALUES (3, 3, 4, '2024-10-05', 'Pagado', 185.6);

-- Orden 4-----------------------------------------------------
insert into Ordenes (id_orden, id_cliente, id_sucursal, fecha_orden, tipo_orden, subtotal, total) values (4, 1, 5, '2024-10-01', 'En línea', 999.99, 1195.36);
insert into Detalles_Ordenes (id_detalle, id_orden, id_producto, cantidad, precio_unitario, monto) values (5, 4, 6, 1, 999.99, 999.99);
insert into Envios (id_envio, id_orden, fecha_envio, ciudad, direccion, estatus_envio, costo_envio) values (3, 4, '2024-02-07', 'Escobedo', '9 Norway Maple Center', 'Pendiente', 30.50);
insert into Facturacion (id_factura, id_orden, id_metodo, fecha_emision, estatus_facturacion, monto) VALUES (4, 4, 5, '2024-10-01', 'Emitido', 1195.36);

-- Orden 5 -------------------------------------------------------------------------
insert into Ordenes (id_orden, id_cliente, id_sucursal, fecha_orden, tipo_orden, subtotal, total) values (5, 3, 4, '2024-10-06', 'Envío a casa', 2699.99, 3138.42);
insert into Detalles_Ordenes (id_detalle, id_orden, id_producto, cantidad, precio_unitario, monto) values (6, 5, 1, 1, 2699.99, 2699.99);
insert into Envios (id_envio, id_orden, fecha_envio, ciudad, direccion, estatus_envio, costo_envio) values (4, 5, '2024-10-01', 'Guadalupe', '3 Jackson Hill', 'Cancelado', 5.55);
insert into Facturacion (id_factura, id_orden, id_metodo, fecha_emision, estatus_facturacion, monto) VALUES (5, 5, 1, '2024-10-06', 'Cancelado', 3138.42);

-- Orden 6--------------------------------------------------
insert into Ordenes (id_orden, id_cliente, id_sucursal, fecha_orden, tipo_orden, subtotal, total) values (6, 3, 4, '2024-10-07', 'Envío a casa', 1845.99, 2147.78);
insert into Detalles_Ordenes (id_detalle, id_orden, id_producto, cantidad, precio_unitario, monto) values (7, 6, 2, 1, 1845.99, 1845.99);
insert into Envios (id_envio, id_orden, fecha_envio, ciudad, direccion, estatus_envio, costo_envio) values (5, 6, '2024-10-13', 'Guadalupe', '3 Jackson Hill', 'Pendiente', 5.55);
insert into Facturacion (id_factura, id_orden, id_metodo, fecha_emision, estatus_facturacion, monto) VALUES (6, 6, 1, '2024-10-06', 'Emitido', 2147.78);

-- Vistas 
-- Ver todos los datos respecto a una orden
DROP VIEW if exists vordenes_Completas;
CREATE VIEW vordenes_Completas AS
SELECT 
    o.id_orden,
    c.nombre AS cliente_nombre,
    c.apellido AS cliente_apellido,
    s.nombre_sucursal AS sucursal,
    o.fecha_orden,
    o.tipo_orden,
    o.subtotal,
    o.total,
	f.fecha_emision,
    f.estatus_facturacion AS estatus_factura,
    e.estatus_envio,
    e.ciudad AS envio_ciudad,
    e.direccion AS envio_direccion,
    e.costo_envio,
    e.fecha_envio
FROM Ordenes o
JOIN Clientes c ON c.id_cliente = o.id_cliente
JOIN Sucursales s ON s.id_sucursal = o.id_sucursal
JOIN Facturacion f ON f.id_orden = o.id_orden
LEFT JOIN Envios e ON e.id_orden = o.id_orden
ORDER BY id_orden ASC;
-- ----------------------------------------------------------------------------

-- Ver todos los detalles de las ordenes
DROP VIEW if exists vdesglose_Detalles;
CREATE VIEW vdesglose_Detalles AS
SELECT 
    o.id_orden,
    c.nombre AS cliente_nombre,
    c.apellido AS cliente_apellido,
    s.nombre_sucursal AS sucursal,
    o.fecha_orden,
    o.tipo_orden,
    p.nombre_producto,
    d.cantidad,
    d.precio_unitario,
    d.monto,
    f.estatus_facturacion,
    f.fecha_emision AS fecha_factura,
    e.estatus_envio,
    e.ciudad AS envio_ciudad,
    e.direccion AS envio_direccion,
    e.fecha_envio
FROM Ordenes o
JOIN Clientes c ON c.id_cliente = o.id_cliente
JOIN Sucursales s ON s.id_sucursal = o.id_sucursal
JOIN Detalles_Ordenes d ON d.id_orden = o.id_orden
JOIN Productos p ON p.id_producto = d.id_producto
LEFT JOIN Facturacion f ON f.id_orden = o.id_orden
LEFT JOIN Envios e ON e.id_orden = o.id_orden
ORDER BY o.id_orden ASC;
-- ----------------------------------------------------------------------------

-- Vista para ver el inventario
DROP VIEW if exists Vinventario_Sucursales;
CREATE VIEW Vinventario_Sucursales AS
SELECT 
	s.id_sucursal,
    s.nombre_sucursal,
    p.id_producto,
    p.nombre_producto,
    p.categoria,
    p.marca,
    i.cantidad_disponible,
    i.cantidad_reservada
FROM Inventario i
JOIN Productos p ON i.id_producto = p.id_producto
JOIN Sucursales s ON i.id_sucursal = s.id_sucursal
ORDER BY id_sucursal;
-- ----------------------------------------------------------------------------

-- FUNCIONES UTILIZADAS EN LOS SP-----------------------------------------------------------------------

-- 1. EXISTENCIA DE PRODUCTO EN SUCURSAL----------------------------
USE `Empresa_BrickClicks_Ariadne`;
DROP function IF EXISTS `ExistenciaProductoSucursal`;
DELIMITER $$
USE `Empresa_BrickClicks_Ariadne`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ExistenciaProductoSucursal`(product INT, sucursal INT) RETURNS int
    READS SQL DATA
BEGIN
	DECLARE stock INT;
    
    SET stock = (SELECT cantidad_disponible FROM inventario
    WHERE id_producto = product AND id_sucursal = sucursal);
    
    IF stock IS NULL THEN
        SET stock = 0; -- Asignar 0 si es NULL
    END IF;
    
    RETURN stock;
END$$

DELIMITER ;
;

-- 2. OBTENER EL PRECIO UNITARIO DE UN PRODUCTO----------------------------
USE `Empresa_BrickClicks_Ariadne`;
DROP function IF EXISTS `ObtenerPrecio_Unitario`;


DELIMITER $$
USE `Empresa_BrickClicks_Ariadne`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ObtenerPrecio_Unitario`(idP int) RETURNS decimal(10,2)
    READS SQL DATA
BEGIN
	DECLARE price DECIMAL(10,2);
	SET price = (SELECT precio FROM productos WHERE id_producto = idP);

	RETURN price;
END$$

DELIMITER ;
;
-- 3. OBTENER LA CANTIDAD RESERVADA DE UN PRODUCTO ----------------------------
USE `Empresa_BrickClicks_Ariadne`;
DROP function IF EXISTS `StockReservado`;

DELIMITER $$
USE `Empresa_BrickClicks_Ariadne`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `StockReservado`(product INT, sucursal INT) RETURNS int
    READS SQL DATA
BEGIN
	DECLARE stock INT;
    
    SET stock = (SELECT cantidad_reservada FROM inventario
    WHERE id_producto = product AND id_sucursal = sucursal);
    
    RETURN stock;

END$$

DELIMITER ;


-- 4. CALCULAR EL COSTO TOTAL DE ENVIO ----------------------------
USE `Empresa_BrickClicks_Ariadne`;
DROP function IF EXISTS `CostoTotalEnvio`;

DELIMITER $$
USE `Empresa_BrickClicks_Ariadne`$$
CREATE FUNCTION `CostoTotalEnvio`(id INT)
RETURNS decimal(10,2)
READS SQL DATA
BEGIN
	DECLARE costo DECIMAL(10,2);
    SET costo = (SELECT SUM(costo_envio) FROM envios WHERE id_orden= id);

RETURN costo;
END$$

DELIMITER ;

-- 5. CALCULAR EL SUBTOTAL ----------------------------
USE `Empresa_BrickClicks_Ariadne`;
DROP function IF EXISTS `CalcularSubtotal`;

DELIMITER $$
USE `Empresa_BrickClicks_Ariadne`$$
CREATE FUNCTION `CalcularSubtotal` (id INT)
RETURNS decimal(10,2)
READS SQL DATA
BEGIN
	DECLARE subtotal DECIMAL(10,2);
    SET subtotal = (SELECT SUM(monto) FROM detalles_ordenes WHERE id_orden=id);
    
	RETURN subtotal;
END$$

DELIMITER ;

-- 6. CALCULAR EL TOTAL ----------------------------
USE `Empresa_BrickClicks_Ariadne`;
DROP function IF EXISTS `CalcularTotal`;

DELIMITER $$
USE `Empresa_BrickClicks_Ariadne`$$
CREATE FUNCTION `CalcularTotal`(id_o INT)
RETURNS decimal(10,2)
READS SQL DATA
BEGIN
	DECLARE total DECIMAL(10,2);
    DECLARE envio DECIMAL(10,2);
    DECLARE subtotal DECIMAL(10,2);
    
    SET envio = CostoTotalEnvio(id_o);
    
    IF envio IS NULL THEN
        SET envio = 0; -- Asignar 0 si es NULL
    END IF;
    
    SET subtotal = CalcularSubtotal(id_o);
    SET total = (envio + subtotal)*1.16;
    
RETURN total;
END$$

DELIMITER ;

-- 7. OBTENER EL NOMBRE DE CLIENTE ----------------------------
USE `Empresa_BrickClicks_Ariadne`;
DROP function IF EXISTS `Obtener_NombreCliente`;

DELIMITER $$
USE `Empresa_BrickClicks_Ariadne`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `Obtener_NombreCliente`(id_c INT) RETURNS varchar(50) CHARSET utf8mb4
    READS SQL DATA
BEGIN
	DECLARE nom varchar(50);
    
    SET nom = (SELECT CONCAT(nombre,' ', apellido) FROM clientes
    WHERE id_cliente=id_c);

RETURN nom;
END$$

DELIMITER ;

-- Procedimientos Almacenados-----------------------------------------------

-- Insertar una nueva orden
USE `Empresa_BrickClicks_Ariadne`;
DROP procedure IF EXISTS `sp_Insertar_Orden_Detalle`;

USE `Empresa_BrickClicks_Ariadne`;
DROP procedure IF EXISTS `empresabc`.`sp_Insertar_Orden_Detalle`;
;

DELIMITER $$
USE `Empresa_BrickClicks_Ariadne`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Insertar_Orden_Detalle`(
    IN Idcliente INT, 
    IN Idproducto INT, 
    IN IdSucursal INT, 
    IN p_tipo_orden ENUM('Comprada en sucursal', 'Recogida en sucursal', 'Envío a casa', 'En línea'),
    IN canti INT, 
    IN met INT
)
BEGIN
    DECLARE ExistenciaProducto INT;
    DECLARE NumOrden INT;
    DECLARE precio_producto DECIMAL(10,2);
    DECLARE monto DECIMAL(10,2);
    DECLARE subtotal DECIMAL(10,2);
    DECLARE total DECIMAL(10,2);
    DECLARE costoEnvio DECIMAL(10,2);
    DECLARE dir VARCHAR(255);
    DECLARE city VARCHAR(100);
    DECLARE nom_s VARCHAR(225);

    -- 1. Comprobar existencia del producto en la sucursal deseada
    SET ExistenciaProducto = ExistenciaProductoSucursal(Idproducto, IdSucursal);

    -- 2. Verificar si hay suficiente inventario disponible
    IF (ExistenciaProducto - canti) >= 0 THEN
        -- 3. Insertar nueva orden
        INSERT INTO ordenes (id_cliente, id_sucursal, fecha_orden, tipo_orden, subtotal, total)
        VALUES (Idcliente, IdSucursal, CURDATE(), p_tipo_orden, -1, -1);

        -- Obtener el ID de la orden recién insertada
        SET NumOrden = LAST_INSERT_ID();

        -- 4. Obtener precio unitario y calcular monto para el detalle de la orden
        SET precio_producto = ObtenerPrecio_Unitario(Idproducto);
        SET monto = precio_producto * canti;

        -- 5. Insertar el detalle de la orden
        INSERT INTO detalles_ordenes (id_orden, id_producto, cantidad, precio_unitario, monto)
        VALUES (NumOrden, Idproducto, canti, precio_producto, monto);

        -- 6. Registrar envío si el tipo de orden lo requiere
        IF p_tipo_orden IN ('En línea', 'Envío a casa') THEN
            SET dir = (SELECT direccion FROM clientes WHERE id_cliente = Idcliente);
            SET city = (SELECT ciudad FROM clientes WHERE id_cliente = Idcliente);
            
            SET costoEnvio = monto * 0.02; -- Calcular costo de envío como el 2% del monto del producto

            INSERT INTO envios (id_orden, fecha_envio, ciudad, direccion, estatus_envio, costo_envio)
            VALUES (NumOrden, DATE_ADD(CURDATE(), INTERVAL 1 WEEK), city, dir, 'Pendiente', costoEnvio);
        END IF;
        
        IF p_tipo_orden IN ('Recogida en sucursal') THEN
            SET nom_s = (SELECT nombre_sucursal FROM sucursales WHERE id_sucursal = IdSucursal);
            SET city = (SELECT ciudad FROM sucursales WHERE id_sucursal= IdSucursal);

            INSERT INTO envios (id_orden, fecha_envio, ciudad, direccion, estatus_envio, costo_envio)
            VALUES (NumOrden, DATE_ADD(CURDATE(), INTERVAL 1 WEEK), city, nom_s , 'Pendiente', 0);
        END IF;
        
        -- 7. Calcular el subtotal y total de la orden
        SET subtotal = CalcularSubtotal(NumOrden);
        SET total = CalcularTotal(NumOrden);
    
        -- Actualizar la orden con los valores de subtotal y total calculados
        UPDATE ordenes 
        SET subtotal = subtotal, total = total 
        WHERE id_orden = NumOrden;

		-- 8. Agregar la facturacion
		IF p_tipo_orden IN ('En línea', 'Recogida en sucursal') THEN -- Pedido desde la pagina
			INSERT INTO Facturacion (id_orden, id_metodo, fecha_emision, estatus_facturacion, monto) 
			VALUES (NumOrden, met, CURDATE(), 'Emitido', total);
		ELSE 
			-- El pago se realiza dentro de una surcursal  Comprada en sucursal y Envio a casa
			INSERT INTO Facturacion (id_orden, id_metodo, fecha_emision, estatus_facturacion, monto) 
			VALUES (NumOrden, met, CURDATE(), 'Pagado', total);
		END IF;
        
    ELSE 
        -- Error si no hay suficiente inventario
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El producto no se encuentra disponible en esa sucursal';
    END IF;
    
END$$
DELIMITER ;
-- -------------------------------------------------------------------------------

-- Agregar productos a la orden
USE `Empresa_BrickClicks_Ariadne`;
DROP procedure IF EXISTS `sp_AgregarDetalles`;

-- FALTA MODIFICAR
DELIMITER $$
USE `Empresa_BrickClicks_Ariadne`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_AgregarDetalles`(IN IdOrden int, IN idProducto int, IN canti int)
BEGIN
	DECLARE ExistenciaProducto INT;
    DECLARE precio_producto DECIMAL(10,2);
    DECLARE monto DECIMAL(10,2);
    DECLARE subtotal DECIMAL(10,2);
    DECLARE total DECIMAL(10,2);
    DECLARE costoEnvio DECIMAL(10,2);
    DECLARE IdSucursal INT;
	DECLARE p_tipo_orden ENUM('Comprada en sucursal', 'Recogida en sucursal', 'Envío a casa', 'En línea');

    -- 1. Verificar si la orden existe y obtener el id_sucursal de la orden
    SET IdSucursal = (SELECT id_sucursal FROM ordenes WHERE id_orden = IdOrden);

    IF IdSucursal IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La orden no fue encontrada';
    ELSE
        -- 2. Comprobar existencia del producto en la sucursal de la orden
        SET ExistenciaProducto = ExistenciaProductoSucursal(IdProducto, IdSucursal);

        -- 3. Verificar si hay suficiente inventario disponible
        IF (ExistenciaProducto - canti) < 0 THEN
            -- Error si no hay suficiente inventario
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: El producto no se encuentra disponible en esa sucursal';
        ELSE
            -- 4. Obtener precio unitario y calcular monto del nuevo detalle de orden
            SET precio_producto = ObtenerPrecio_Unitario(IdProducto);
            SET monto = precio_producto * canti;

            -- 5. Insertar el nuevo detalle de orden
            INSERT INTO detalles_ordenes (id_orden, id_producto, cantidad, precio_unitario, monto)
            VALUES (IdOrden, IdProducto, canti, precio_producto, monto);

            -- 6. Actualizar envío si el tipo de orden requiere envío
            SET p_tipo_orden = (SELECT tipo_orden FROM ORDENES WHERE id_orden = IdOrden);
            IF p_tipo_orden IN ('En línea', 'Envío a casa') THEN
                SET costoEnvio = CalcularSubtotal(IdOrden) * 0.02; -- Calcular costo de envío como el 2% del subtotal

                -- Verificar si ya existe un envío para esta orden
                IF NOT EXISTS (SELECT 1 FROM envios WHERE id_orden = IdOrden) THEN
                    SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Error: La orden no tiene registro en la tabla envios';
                ELSE
                    -- Si ya existe un envío, actualizar el costo de envío
                    UPDATE envios
                    SET costo_envio = costoEnvio
                    WHERE id_orden = IdOrden;
                END IF;
            END IF;
			
            -- 7. Recalcular el subtotal y total de la orden después de agregar el nuevo producto
            SET subtotal = CalcularSubtotal(IdOrden);
            SET total = CalcularTotal(IdOrden);
            
            -- 8. Actualizar la orden con los nuevos valores de subtotal y total
            UPDATE ordenes 
            SET subtotal = subtotal, total = total 
            WHERE id_orden = IdOrden;
            
            -- 9. Actualizar facturacion
            UPDATE FACTURACION
            SET monto = total
			WHERE id_orden = IdOrden;
            
        END IF;
    END IF;
END$$
DELIMITER ;
-- -------------------------------------------------------------------

-- Ver los productos en una sola orden
USE `empresa_brickclicks_ariadne`;
DROP procedure IF EXISTS `sp_DesgloseCompra`;

USE `empresa_brickclicks_ariadne`;
DROP procedure IF EXISTS `empresa_brickclicks_ariadne`.`sp_DesgloseCompra`;
;

DELIMITER $$
USE `empresa_brickclicks_ariadne`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_DesgloseCompra`(IN p_id_orden INT)
BEGIN
	SELECT 
        o.id_orden,
        c.nombre AS cliente_nombre,
        c.apellido AS cliente_apellido,
        p.nombre_producto,
        d.cantidad,
        d.precio_unitario,
        d.monto,
        f.fecha_emision AS fecha_factura
    FROM Ordenes o
    JOIN Clientes c ON o.id_cliente = c.id_cliente
    JOIN Detalles_Ordenes d ON o.id_orden = d.id_orden
    JOIN Productos p ON d.id_producto = p.id_producto
    LEFT JOIN Facturacion f ON o.id_orden = f.id_orden
    WHERE o.id_orden = p_id_orden;

END$$
DELIMITER ;
-- -------------------------------------------------------------------

-- TRIGGERS ---------------------------------------------------------
-- Trigger para actualizar el inventario
DELIMITER $$
CREATE trigger tr_actualizar_inventario_after_insert
AFTER INSERT ON detalles_ordenes
FOR each row
BEGIN
	DECLARE t_orden VARCHAR(50);
    SET t_orden = (SELECT tipo_orden FROM Ordenes WHERE id_orden = NEW.id_orden);
	
    -- Actualizar inventario disponible
	UPDATE Inventario
    SET cantidad_disponible = cantidad_disponible - NEW.cantidad
    WHERE id_producto = NEW.id_producto
	AND id_sucursal = (SELECT id_sucursal FROM Ordenes WHERE id_orden = NEW.id_orden);
    
    -- Actualizar cantidad reservada en el inventario si la orden no es de compra directa en sucursal
    IF t_orden IN ('En línea', 'Recogida en sucursal') THEN
        UPDATE Inventario
        SET cantidad_reservada = cantidad_reservada + NEW.cantidad
        WHERE id_producto = NEW.id_producto
		AND id_sucursal = (SELECT id_sucursal FROM Ordenes WHERE id_orden = NEW.id_orden);
    END IF;
    
END$$
DELIMITER ;
-- ------------------------------------------------------------------------------

-- Cambiar estatus de la orden en factura y envio
DELIMITER $$
CREATE TRIGGER tr_cambiar_estatus_orden_after_update
AFTER UPDATE ON Facturacion
FOR EACH ROW
BEGIN
	DECLARE t_orden VARCHAR(50);
    -- Verificar si el estatus de facturación ha cambiado a 'Pagado'
    IF NEW.estatus_facturacion = 'Pagado' THEN
        -- Verificar el tipo de orden para actualizar el estatus de la orden
        -- Obtener el tipo de envío de la tabla Ordenes
        SET t_orden = (SELECT tipo_orden FROM Ordenes WHERE id_orden = NEW.id_orden);
        
        -- Actualizar el estatus de la orden dependiendo del tipo de envío
        IF t_orden = 'En línea' THEN
            -- Si es un envío a casa, actualizar el estatus a 'En tránsito'
            UPDATE ENVIOS
            SET estatus_envio = 'En tránsito'
            WHERE id_orden = NEW.id_orden;
        END IF;
        
        IF t_orden = 'Recogida en sucursal' THEN
            -- Si es una recogida en sucursal, actualizar el estatus a 'Listo para entregar'
            UPDATE ENVIOS
            SET estatus_envio = 'Listo para recoger'
            WHERE id_orden = NEW.id_orden;
		END IF;
                
    END IF;
END$$
DELIMITER ;
-- ------------------------------------------------------------------------------

-- Precios no negativos en la tabla producto
DELIMITER $$
CREATE TRIGGER tr_no_negativos_before_insert 
BEFORE INSERT ON Productos
FOR EACH ROW
BEGIN
    IF NEW.precio < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Trigger: El precio del producto no puede ser negativo.';
    END IF;
END$$;
DELIMITER ;
