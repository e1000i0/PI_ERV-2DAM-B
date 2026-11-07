CREATE DATABASE IF NOT EXISTS hanger_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE hanger_db;

CREATE TABLE usuarios (
    id_usuario BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(120) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categorias (
    id_categoria BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE prendas (
    id_prenda BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    descripcion TEXT,
    color VARCHAR(50),
    talla VARCHAR(30),
    marca VARCHAR(80),
    temporada ENUM('primavera', 'verano', 'otono', 'invierno', 'todo_el_ano') DEFAULT 'todo_el_ano',
    estado ENUM('en_uso', 'poco_usada', 'para_vender', 'vendida', 'para_donar', 'donada') DEFAULT 'en_uso',
    imagen_url VARCHAR(255),
    precio_compra DECIMAL(10, 2),
    fecha_alta DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_usuario BIGINT NOT NULL,
    id_categoria BIGINT NOT NULL,
    CONSTRAINT fk_prendas_usuarios
        FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_prendas_categorias
        FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE etiquetas (
    id_etiqueta BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE prenda_etiqueta (
    id_prenda BIGINT NOT NULL,
    id_etiqueta BIGINT NOT NULL,
    PRIMARY KEY (id_prenda, id_etiqueta),
    CONSTRAINT fk_prenda_etiqueta_prendas
        FOREIGN KEY (id_prenda) REFERENCES prendas(id_prenda)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_prenda_etiqueta_etiquetas
        FOREIGN KEY (id_etiqueta) REFERENCES etiquetas(id_etiqueta)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE outfits (
    id_outfit BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    descripcion TEXT,
    ocasion VARCHAR(80),
    temporada ENUM('primavera', 'verano', 'otono', 'invierno', 'todo_el_ano') DEFAULT 'todo_el_ano',
    favorito BOOLEAN NOT NULL DEFAULT FALSE,
    fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_usuario BIGINT NOT NULL,
    CONSTRAINT fk_outfits_usuarios
        FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE outfit_prenda (
    id_outfit BIGINT NOT NULL,
    id_prenda BIGINT NOT NULL,
    PRIMARY KEY (id_outfit, id_prenda),
    CONSTRAINT fk_outfit_prenda_outfits
        FOREIGN KEY (id_outfit) REFERENCES outfits(id_outfit)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_outfit_prenda_prendas
        FOREIGN KEY (id_prenda) REFERENCES prendas(id_prenda)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE uso_prenda (
    id_uso BIGINT AUTO_INCREMENT PRIMARY KEY,
    fecha_uso DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_prenda BIGINT NOT NULL,
    id_outfit BIGINT,
    CONSTRAINT fk_uso_prenda_prendas
        FOREIGN KEY (id_prenda) REFERENCES prendas(id_prenda)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_uso_prenda_outfits
        FOREIGN KEY (id_outfit) REFERENCES outfits(id_outfit)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE INDEX idx_prendas_usuario ON prendas(id_usuario);
CREATE INDEX idx_prendas_categoria ON prendas(id_categoria);
CREATE INDEX idx_outfits_usuario ON outfits(id_usuario);
CREATE INDEX idx_uso_prenda_prenda ON uso_prenda(id_prenda);
CREATE INDEX idx_uso_prenda_outfit ON uso_prenda(id_outfit);
