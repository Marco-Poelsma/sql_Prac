---------------------------------------------------
                    PARTE 1
---------------------------------------------------

DROP DATABASE IF EXISTS LSG_NBA;
CREATE DATABASE LSG_NBA
    CHARACTER SET 'utf8mb4'
    COLLATE 'utf8mb4_spanish_ci';


USE DATABASE LSG_NBA; 

DROP TABLE IF EXISTS persona;
CREATE TABLE persona (
    DNI VARCHAR(9),
    Nom VARCHAR(30) NOT NULL,
    Cognom1 VARCHAR(30) NOT NULL,
    Cognom2 VARCHAR(30) NOT NULL,
    Nacionalitat VARCHAR(30) NOT NULL,
    Sexe ENUM('H','D','NB','ND') NOT NULL,
    DataNaixement DATE NOT NULL,
    PRIMARY KEY (DNI)
);

DROP TABLE IF EXISTS pavello;
CREATE TABLE pavello(
    Nom VARCHAR(30),
    Ciutat VARCHAR(30),
    Capacitat VARCHAR(30),
    PRIMARY KEY (Nom)
);

DROP TABLE IF EXISTS conferencia;
CREATE TABLE conferencia(
    Nom VARCHAR(30),
    ZonaGeografica VARCHAR(30) UNIQUE,
    PRIMARY KEY(Nom)
);

DROP TABLE IF EXISTS equip_nacional;
CREATE TABLE equip_nacional(
    Any INT(4) UNSIGNED,
    Pais VARCHAR(30),
    PRIMARY KEY(Any, Pais)
);

DROP TABLE IF EXISTS draft;
CREATE TABLE draft(
    Any INT(4) UNSIGNED,
    PRIMARY KEY (Any)
);

DROP TABLE IF EXISTS temporada_regular;
CREATE TABLE temporada_regular(
    Any INT(4) UNSIGNED,
    Inici DATE,
    Fi DATE,
    PRIMARY KEY(Any)
);

DROP TABLE IF EXISTS entrenador_principal;
CREATE TABLE entrenador_principal(
    DNI VARCHAR(9),
    PercentatgeVictories DECIMAL(5,2) UNSIGNED,
    Salari DECIMAL(10,2) UNSIGNED,
    AnyEquipNacional INT(4) UNSIGNED,
    PaisEquipNacional VARCHAR(30),
    PRIMARY KEY (DNI),
    FOREIGN KEY (DNI) REFERENCES persona(DNI) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (AnyEquipNacional, PaisEquipNacional) REFERENCES equip_nacional(Any, Pais) ON UPDATE CASCADE ON DELETE CASCADE
);


DROP TABLE IF EXISTS franquicia;
CREATE TABLE franquicia (
    Nom VARCHAR(30),
    Ciutat VARCHAR(30),
    Pressupost DECIMAL(10,2) UNSIGNED,
    AnellsNBA INT UNSIGNED,
    DNIEntrenadorPrincipal VARCHAR(9),
    NomPavello VARCHAR(30),
    DNIPropietari VARCHAR(9),
    NomConferencia VARCHAR(30),
    PRIMARY KEY (Nom),
    FOREIGN KEY(DNIEntrenadorPrincipal) REFERENCES entrenador_principal(DNI) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY(NomPavello) REFERENCES pavello(Nom) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY(DNIPropietari) REFERENCES persona(DNI) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY(NomConferencia) REFERENCES conferencia(Nom) ON UPDATE RESTRICT ON DELETE RESTRICT
);

DROP TABLE IF EXISTS jugador;
CREATE TABLE jugador (
    DNI VARCHAR(9),
    AnysPRO INT(4) UNSIGNED,
    UniversitatOrigen VARCHAR(30),
    NombreAnellsNBA INT UNSIGNED,
    Dorsal INT UNSIGNED,
    NomFranquicia VARCHAR(30),
    PRIMARY KEY (DNI),
    FOREIGN KEY (DNI) REFERENCES persona(DNI) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (NomFranquicia) REFERENCES franquicia(Nom) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS preparador_fisic;
CREATE TABLE preparador_fisic(
    DNI VARCHAR(9),
    Especialitat VARCHAR(30),
    Cap VARCHAR(9),
    NomFranquicia VARCHAR(30),
    PRIMARY KEY (DNI),
    FOREIGN KEY (DNI) REFERENCES persona(DNI) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Cap) REFERENCES preparador_fisic(DNI) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (NomFranquicia) REFERENCES franquicia(Nom) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS franquicia_temporada;
CREATE TABLE franquicia_temporada(
    NomFranquicia VARCHAR(30),
    AnyTemporada INT(4) UNSIGNED,
    EsGuanyador TINYINT(1) NOT NULL DEFAULT '0',
    PRIMARY KEY(NomFranquicia, AnyTemporada),
    FOREIGN KEY(NomFranquicia) REFERENCES franquicia(Nom) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(AnyTemporada) REFERENCES temporada_regular(Any) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS equip_nacional_jugador;
CREATE TABLE equip_nacional_jugador(
    Any INT(4) UNSIGNED,
    Pais VARCHAR(30),
    DNI VARCHAR(9),
    PRIMARY KEY (Any,Pais,DNI),
    FOREIGN KEY (Any,Pais) REFERENCES equip_nacional(Any,Pais) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (DNI) REFERENCES jugador(DNI) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS grada;
CREATE TABLE grada(
    Codi INT UNSIGNED AUTO_INCREMENT,
    NomPavello VARCHAR(30),
    EsCoberta TINYINT(1),
    PRIMARY KEY (Codi, NomPavello),
    FOREIGN KEY (NomPavello) REFERENCES pavello(Nom) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS seient;
CREATE TABLE seient(
    Codi INT UNSIGNED,
    NomPavello VARCHAR(30),
    Numero INT UNSIGNED,
    Color VARCHAR(30),
    PRIMARY KEY (NomPavello,Codi,Numero),
    FOREIGN KEY (NomPavello, Codi) REFERENCES grada(NomPavello, Codi) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS draft_jugador_franquicia;
CREATE TABLE draft_jugador_franquicia(
    AnyDRAFT INT(4) UNSIGNED,
    DNIJugador VARCHAR(9),
    NomFranquicia VARCHAR(30),
    Posicio TINYINT UNSIGNED,
    PRIMARY KEY (AnyDRAFT,DNIJugador,NomFranquicia),
    FOREIGN KEY (AnyDRAFT) REFERENCES draft(Any) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (DNIJugador) REFERENCES jugador(DNI) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (NomFranquicia) REFERENCES franquicia(Nom) ON UPDATE RESTRICT ON DELETE RESTRICT
);

---------------------------------------------------
                    PARTE 2
---------------------------------------------------

-- Inserciones en la tabla persona (20 registros)
INSERT INTO persona (DNI, Nom, Cognom1, Cognom2, Nacionalitat, Sexe, DataNaixement) VALUES
('12345678A', 'Pau', 'Gasol', 'Sáez', 'Española', 'H', '1980-07-06'),
('87654321B', 'Kobe', 'Bryant', NULL, 'Estadounidense', 'H', '1978-08-23'),
('11223344C', 'LeBron', 'James', NULL, 'Estadounidense', 'H', '1984-12-30'),
('22334455D', 'Stephen', 'Curry', NULL, 'Estadounidense', 'H', '1988-03-14'),
('33445566E', 'Kevin', 'Durant', NULL, 'Estadounidense', 'H', '1988-09-29'),
('44556677F', 'Giannis', 'Antetokounmpo', NULL, 'Griega', 'H', '1994-12-06'),
('55667788G', 'James', 'Harden', NULL, 'Estadounidense', 'H', '1989-08-26'),
('66778899H', 'Chris', 'Paul', NULL, 'Estadounidense', 'H', '1985-05-06'),
('77889900I', 'Carmelo', 'Anthony', NULL, 'Estadounidense', 'H', '1984-05-29'),
('88990011J', 'Anthony', 'Davis', NULL, 'Estadounidense', 'H', '1993-03-11'),
('99001122K', 'Russell', 'Westbrook', NULL, 'Estadounidense', 'H', '1988-11-12'),
('10111223L', 'Paul', 'George', NULL, 'Estadounidense', 'H', '1990-05-02'),
('11121324M', 'Damian', 'Lillard', NULL, 'Estadounidense', 'H', '1990-07-15'),
('12131425N', 'Kawhi', 'Leonard', NULL, 'Estadounidense', 'H', '1991-06-29'),
('13141526O', 'Joel', 'Embiid', NULL, 'Camerunense', 'H', '1994-03-16'),
('14151627P', 'Luka', 'Dončić', NULL, 'Esloveno', 'H', '1999-02-28'),
('15161728Q', 'Zion', 'Williamson', NULL, 'Estadounidense', 'H', '2000-07-06'),
('16171829R', 'Jayson', 'Tatum', NULL, 'Estadounidense', 'H', '1998-03-03'),
('17181930S', 'Trae', 'Young', NULL, 'Estadounidense', 'H', '1998-09-19');

-- Inserciones en la tabla jugador (16 registros)
INSERT INTO jugador (DNI, AnysPRO, UniversitatOrigen, NombreAnellsNBA, Dorsal, NomFranquicia) VALUES
('12345678A', 19, 'FC Barcelona', 2, 16, 'Lakers'),
('87654321B', 15, 'University of Lower Merion', 5, 24, 'Lakers'),
('11223344C', 18, 'St. Vincent-St. Mary High School', 4, 23, 'Lakers'),
('22334455D', 13, 'Davidson College', 3, 30, 'Warriors'),
('33445566E', 12, 'University of Texas', 2, 7, 'Nets'),
('44556677F', 8, 'University of Athens', 1, 34, 'Bucks'),
('55667788G', 14, 'Arizona State University', 1, 13, 'Rockets'),
('66778899H', 17, 'Wake Forest University', 0, 3, 'Suns'),
('77889900I', 10, 'Syracuse University', 1, 7, 'Knicks'),
('88990011J', 9, 'University of Kentucky', 1, 3, 'Pelicans'),
('99001122K', 12, 'UCLA', 0, 0, 'Wizards'),
('10111223L', 11, 'Fresno State University', 0, 13, 'Pacers'),
('11121324M', 8, 'Weber State University', 0, 0, 'Trail Blazers'),
('12131425N', 7, 'San Diego State University', 0, 7, 'Spurs'),
('13141526O', 5, 'University of Kansas', 0, 21, 'Mavericks'),
('14151627P', 4, 'Duke University', 0, 12, 'Pelicans');

-- Inserciones en la tabla preparador_fisic (5 registros)
INSERT INTO preparador_fisic (DNI, Especialitat, Cap, NomFranquicia) VALUES
('99999999X', 'Rehabilitación', NULL, 'Lakers'),
('88888888Y', 'Fisioterapia', NULL, 'Warriors'),
('77777777Z', 'Prevención de Lesiones', NULL, 'Bucks'),
('66666666A', 'Entrenamiento Físico', NULL, 'Nets'),
('55555555B', 'Recuperación Deportiva', NULL, 'Rockets');

-- Inserciones en la tabla entrenador_principal (8 registros)
INSERT INTO entrenador_principal (DNI, PercentatgeVictories, Salari, AnyEquipNacional, PaisEquipNacional) VALUES
('88888888Y', 75.50, 3500000, 2023, 'USA'),
('77777777Z', 60.30, 2800000, 2023, 'España'),
('66666666A', 68.80, 2500000, 2023, 'Francia'),
('55555555B', 65.90, 2200000, 2023, 'Argentina'),
('44444444C', 72.10, 3000000, 2023, 'Brasil'),
('33333333D', 64.50, 2000000, 2023, 'Australia'),
('22222222E', 78.20, 4000000, 2023, 'Grecia'),
('11111111F', 70.00, 3200000, 2023, 'Serbia');

-- Inserciones en la tabla equip_nacional (8 registros)
INSERT INTO equip_nacional (Any, Pais) VALUES
(2023, 'USA'),
(2023, 'España'),
(2023, 'Francia'),
(2023, 'Argentina'),
(2023, 'Brasil'),
(2023, 'Australia'),
(2023, 'Grecia'),
(2023, 'Serbia');

-- Inserciones en la tabla equip_nacional_jugador (18 registros)
INSERT INTO equip_nacional_jugador (Any, Pais, DNI) VALUES
(2023, 'USA', '12345678A'),
(2023, 'USA', '87654321B'),
(2023, 'USA', '11223344C'),
(2023, 'USA', '22334455D'),
(2023, 'USA', '33445566E'),
(2023, 'USA', '44556677F'),
(2023, 'USA', '55667788G'),
(2023, 'USA', '66778899H'),
(2023, 'España', '77889900I'),
(2023, 'España', '88990011J'),
(2023, 'España', '99001122K'),
(2023, 'Francia', '10111223L'),
(2023, 'Francia', '11121324M'),
(2023, 'Argentina', '12131425N'),
(2023, 'Argentina', '13141526O'),
(2023, 'Brasil', '14151627P'),
(2023, 'Australia', '15161728Q'),
(2023, 'Grecia', '16171829R');

-- Inserciones en la tabla draft (4 registros)
INSERT INTO draft (Any) VALUES
(2020), (2021), (2022), (2023);

-- Inserciones en la tabla draft_jugador_franquicia (13 registros)
INSERT INTO draft_jugador_franquicia (AnyDRAFT, DNIJugador, NomFranquicia, Posicio) VALUES
(2020, '12345678A', 'Lakers', 1),
(2021, '87654321B', 'Lakers', 2),
(2022, '11223344C', 'Warriors', 3),
(2023, '22334455D', 'Nets', 4),
(2020, '33445566E', 'Bucks', 5),
(2021, '44556677F', 'Rockets', 6),
(2022, '55667788G', 'Knicks', 7),
(2023, '66778899H', 'Pelicans', 8),
(2020, '77889900I', 'Pacers', 9),
(2021, '88990011J', 'Trail Blazers', 10),
(2022, '99001122K', 'Spurs', 11),
(2023, '10111223L', 'Mavericks', 12),
(2020, '11121324M', 'Pelicans', 13);

-- Inserciones en la tabla franquicia (4 registros)
INSERT INTO franquicia (Nom, Ciutat, Pressupost, AnellsNBA, DNIEntrenadorPrincipal, NomPavello, DNIPropietari, NomConferencia) VALUES
('Lakers', 'Los Angeles', 500000000, 17, '88888888Y', 'Staples Center', '77777777Z', 'Oeste'),
('Warriors', 'San Francisco', 400000000, 6, '77777777Z', 'Chase Center', '66666666A', 'Oeste'),
('Nets', 'Brooklyn', 300000000, 2, '66666666A', 'Barclays Center', '55555555B', 'Este'),
('Bucks', 'Milwaukee', 250000000, 1, '55555555B', 'Fiserv Forum', '44444444C', 'Este');

-- Inserciones en la tabla pavello (4 registros)
INSERT INTO pavello (Nom, Ciutat, Capacitat) VALUES
('Staples Center', 'Los Angeles', '20000'),
('Chase Center', 'San Francisco', '18000'),
('Fiserv Forum', 'Milwaukee', '17000'),
('Barclays Center', 'Brooklyn', '19000');

-- Inserciones en la tabla grada (14 registros)
INSERT INTO grada (NomPavello, EsCoberta) VALUES
('Staples Center', 1),
('Chase Center', 1),
('Fiserv Forum', 1),
('Barclays Center', 1),
('Staples Center', 1),
('Chase Center', 1),
('Fiserv Forum', 1),
('Barclays Center', 1),
('Staples Center', 0),
('Chase Center', 0),
('Fiserv Forum', 0),
('Barclays Center', 0),
('Staples Center', 1),
('Chase Center', 1);

-- Inserciones en la tabla seient (30 registros)
INSERT INTO seient (NomPavello, Codi, Numero, Color) VALUES
('Staples Center', 1, 1, 'Rojo'),
('Chase Center', 1, 1, 'Azul'),
('Fiserv Forum', 1, 1, 'Verde'),
('Barclays Center', 1, 1, 'Naranja'),
('Staples Center', 2, 2, 'Rojo'),
('Chase Center', 2, 2, 'Azul'),
('Fiserv Forum', 2, 2, 'Verde'),
('Barclays Center', 2, 2, 'Naranja'),
('Staples Center', 3, 3, 'Rojo'),
('Chase Center', 3, 3, 'Azul'),
('Fiserv Forum', 3, 3, 'Verde'),
('Barclays Center', 3, 3, 'Naranja'),
('Staples Center', 4, 4, 'Rojo'),
('Chase Center', 4, 4, 'Azul'),
('Fiserv Forum', 4, 4, 'Verde'),
('Barclays Center', 4, 4, 'Naranja'),
('Staples Center', 5, 5, 'Rojo'),
('Chase Center', 5, 5, 'Azul'),
('Fiserv Forum', 5, 5, 'Verde'),
('Barclays Center', 5, 5, 'Naranja'),
('Staples Center', 6, 6, 'Rojo'),
('Chase Center', 6, 6, 'Azul'),
('Fiserv Forum', 6, 6, 'Verde'),
('Barclays Center', 6, 6, 'Naranja'),
('Staples Center', 7, 7, 'Rojo'),
('Chase Center', 7, 7, 'Azul'),
('Fiserv Forum', 7, 7, 'Verde'),
('Barclays Center', 7, 7, 'Naranja'),
('Staples Center', 8, 8, 'Rojo');

-- Inserciones en la tabla conferencia (2 registros)
INSERT INTO conferencia (Nom, ZonaGeografica) VALUES
('Este', 'Este USA'), 
('Oeste', 'Oeste USA');

-- Inserciones en la tabla franquicia_temporada (12 registros)
INSERT INTO franquicia_temporada (NomFranquicia, AnyTemporada, EsGuanyador) VALUES
('Lakers', 2023, 1),
('Warriors', 2023, 0),
('Bucks', 2023, 0),
('Nets', 2023, 0),
('Lakers', 2022, 1),
('Warriors', 2022, 0),
('Bucks', 2022, 0),
('Nets', 2022, 0),
('Lakers', 2021, 0),
('Warriors', 2021, 1),
('Bucks', 2021, 0),
('Nets', 2021, 0);

-- Inserciones en la tabla temporada_regular (3 registros)
INSERT INTO temporada_regular (Any, Inici, Fi) VALUES
(2021, '2021-10-01', '2022-04-30'),
(2022, '2022-10-01', '2023-04-30'),
(2023, '2023-10-01', '2024-04-30');

---------------------------------------------------
                    PARTE 3
---------------------------------------------------

-- 1. Incrementar el salario de los entrenadores principales en un 3%
UPDATE entrenador_principal
SET Salari = Salari * 1.03;

-- Incrementar el presupuesto de la franquicia en un 5%
UPDATE franquicia
SET Pressupost = Pressupost * 1.05;

-- 2. Añadir '%' al final del DNI de las personas a las que les falta la letra final (DNI con longitud 8)
UPDATE persona
SET DNI = CONCAT(DNI, '%')
WHERE CHAR_LENGTH(DNI) = 8;

-- 3. Eliminar jugadores cuyo dorsal sea NULL
DELETE FROM jugador
WHERE Dorsal IS NULL;

-- 4. Eliminar entrenadores principales asociados a franquicias con presupuesto menor a 2 millones
DELETE ep
FROM entrenador_principal ep
WHERE EXISTS (
    SELECT * FROM franquicia f
    WHERE f.DNIEntrenadorPrincipal = ep.DNI
    AND f.Pressupost < 2000000
);

-- 5. Eliminar las gradas número 13 y sus asientos asociados
DELETE FROM seient
WHERE Codi IN (
    SELECT Codi FROM grada
    WHERE Codi = 13
);

DELETE FROM grada
WHERE Codi = 13;




































