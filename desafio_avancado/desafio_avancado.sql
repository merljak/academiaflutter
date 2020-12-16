CREATE DATABASE IF NOT EXISTS ibge CHARACTER SET utf8 COLLATE 
utf8_general_ci;

CREATE TABLE IF NOT EXISTS estados (
id int primary key not null, 
estado varchar(100) not null, 
sigla varchar(2) not null
);

CREATE TABLE IF NOT EXISTS cidades (
id int primary key not null,
cidade varchar(100) not null,
estado_id int not null,
foreign key (estado_id) references estados(id)
)AUTO_INCREMENT = 1;

select * from ibge.estados;
select * from ibge.cidades;

-- SET FOREIGN_KEY_CHECKS = 0;
-- TRUNCATE TABLE cidades;
-- SET FOREIGN_KEY_CHECKS = 1;

-- SET FOREIGN_KEY_CHECKS = 0;
-- TRUNCATE TABLE estados;
-- SET FOREIGN_KEY_CHECKS = 1;

-- SET FOREIGN_KEY_CHECKS = 0;
-- DROP TABLE estados;
-- SET FOREIGN_KEY_CHECKS = 1;

-- SET FOREIGN_KEY_CHECKS = 0;
-- DROP TABLE cidades;
-- SET FOREIGN_KEY_CHECKS = 1;

DROP DATABASE `ibge`;
