create database db_alquiler;

--Tabla de clientes
CREATE TABLE `db_alquiler`.`clientes` (
    `id_cliente` INT AUTO_INCREMENT NOT NULL,
    `nombre` VARCHAR(100) NOT NULL,
    `telefono` VARCHAR(20),
    `correo` VARCHAR(100),
    `direccion` VARCHAR(150),
    PRIMARY KEY (`id_cliente`)
);

--tabla de propiedades

CREATE TABLE `db_alquiler`.`propiedades` (
    `id_propiedad` INT AUTO_INCREMENT NOT NULL,
    `direccion` VARCHAR(150) NOT NULL,
    `tipo` VARCHAR(50),
    `precio_mensual` DECIMAL(10,2),
    `disponible` BIT DEFAULT 1,
    PRIMARY KEY (`id_propiedad`)
);

--Tabla de alquilers

CREATE TABLE `db_alquiler`.`alquileres` (
    `id_alquiler` INT AUTO_INCREMENT NOT NULL,
    `id_cliente` INT NOT NULL,
    `id_propiedad` INT NOT NULL,
    `fecha_inicio` DATE NOT NULL,
    `fecha_fin` DATE,
    PRIMARY KEY (`id_alquiler`),
    CONSTRAINT `fk_alquileres__clientes`
        FOREIGN KEY (`id_cliente`) REFERENCES `clientes`(`id_cliente`),
    CONSTRAINT `fk_alquileres__propiedades`
        FOREIGN KEY (`id_propiedad`) REFERENCES `propiedades`(`id_propiedad`)
);

-- Consultas: 

-- INSERT
insert into  clientes (nombre, correo, telefono)
values 
('Mariana López', 'mariana.lopez@gmail.com', '3004567891'),
('Julián Torres', 'julian.torres@yahoo.com', '3012233445'),
('Sofía Herrera', 'sofia.herrera@hotmail.com', '3027788990');

select * from clientes;
-- UPDATE
update clientes
set nombre = 'Julián Torres Gómez',
    correo = 'julian.gomez@example.com',
    telefono = '3111112222'
WHERE id_cliente = 5;

-- DELETE
delete from clientes
where id_cliente = 6;

-- CONSULTA
SELECT * FROM clientes;

-- INSERT DE TABLA PROPIEDADES
INSERT INTO propiedades (direccion, tipo, precio_mensual, disponible)
VALUES 
('Calle 80 #45-22', 'Apartamento', 1500000.00, 1),
('Carrera 12 #34-56', 'Casa', 2800000.00, 1),
('Avenida 7 #89-10', 'Local', 2000000.00, 0);

