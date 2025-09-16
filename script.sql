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
