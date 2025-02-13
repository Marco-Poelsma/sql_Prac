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
    SELECT 1 FROM franquicia f
    WHERE f.DNIEntrenadorPrincipal = ep.DNI
    AND f.Pressupost < 2000000
);

-- 5. Eliminar las gradas número 13 y sus asientos asociados
DELETE FROM seient
WHERE Codi IN (
    SELECT Codi FROM grada
    WHERE EsCoberta = 13
);

DELETE FROM grada
WHERE EsCoberta = 13;




































