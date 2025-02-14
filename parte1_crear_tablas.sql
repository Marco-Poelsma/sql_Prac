-- Script 1: Creació de Taules
-- Comentari inicial amb els noms dels integrants
-- Integrants: Xavi Farrús, Erik Muñoz, Marco Poelsmaa

-- 1. Crear la base de dades LSG_NBA amb charset utf8mb4 i collation utf8mb4_unicode_ci
DROP DATABASE IF EXISTS LSG_NBA;
CREATE DATABASE IF NOT EXISTS LSG_NBA CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; USE LSG_NBA;

-- 2. Taula Persona
CREATE TABLE Persona ( codi INT UNSIGNED AUTO_INCREMENT, nom VARCHAR(30) NOT NULL, cognom VARCHAR(30) NOT NULL, dni CHAR(9) NOT NULL, any_naixement INT NOT NULL, sexe CHAR NOT NULL, PRIMARY KEY (codi) );

-- 3. Taula Franquicia
CREATE TABLE Franquicia ( codi INT UNSIGNED AUTO_INCREMENT, nom VARCHAR(30) NOT NULL, pressupost DECIMAL(12,2), ZonaGeografica VARCHAR(30) UNIQUE, PRIMARY KEY (codi) );

-- 4. Taula Equip_Nacional
CREATE TABLE Equip_Nacional ( codi INT UNSIGNED AUTO_INCREMENT, nom VARCHAR(30) NOT NULL, PRIMARY KEY (codi) );

-- 5. Taula Jugador
CREATE TABLE Jugador ( codi INT UNSIGNED AUTO_INCREMENT, persona_codi INT UNSIGNED NOT NULL, dorsal INT, posicio VARCHAR(30), PRIMARY KEY (codi), FOREIGN KEY (persona_codi) REFERENCES Persona(codi) ON DELETE CASCADE ON UPDATE CASCADE );

-- 6. Taula Preparador_Fisic
CREATE TABLE Preparador_Fisic ( codi INT UNSIGNED AUTO_INCREMENT, persona_codi INT UNSIGNED NOT NULL, especialitat VARCHAR(30), PRIMARY KEY (codi), FOREIGN KEY (persona_codi) REFERENCES Persona(codi) ON DELETE CASCADE ON UPDATE CASCADE );

-- 7. Taula Entrenador_Personal
CREATE TABLE Entrenador_Personal ( codi INT UNSIGNED AUTO_INCREMENT, persona_codi INT UNSIGNED NOT NULL, salari DECIMAL(10,2), franquicia_codi INT UNSIGNED, PRIMARY KEY (codi), FOREIGN KEY (persona_codi) REFERENCES Persona(codi) ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY (franquicia_codi) REFERENCES Franquicia(codi) ON DELETE RESTRICT ON UPDATE RESTRICT );

-- 8. Taula Equip_Nacional_Jugador
CREATE TABLE Equip_Nacional_Jugador ( codi INT UNSIGNED AUTO_INCREMENT, equip_nacional_codi INT UNSIGNED NOT NULL, jugador_codi INT UNSIGNED NOT NULL, PRIMARY KEY (codi), FOREIGN KEY (equip_nacional_codi) REFERENCES Equip_Nacional(codi) ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY (jugador_codi) REFERENCES Jugador(codi) ON DELETE CASCADE ON UPDATE CASCADE );

-- 9. Taula Draft
CREATE TABLE Draft ( codi INT UNSIGNED AUTO_INCREMENT, any INT, PRIMARY KEY (codi) );

-- 10. Taula Draft_Jugador_Franquicia
CREATE TABLE Draft_Jugador_Franquicia ( codi INT UNSIGNED AUTO_INCREMENT, draft_codi INT UNSIGNED NOT NULL, jugador_codi INT UNSIGNED NOT NULL, franquicia_codi INT UNSIGNED NOT NULL, Es_guanyador BOOLEAN DEFAULT FALSE, PRIMARY KEY (codi), FOREIGN KEY (draft_codi) REFERENCES Draft(codi) ON DELETE RESTRICT ON UPDATE RESTRICT, FOREIGN KEY (jugador_codi) REFERENCES Jugador(codi) ON DELETE RESTRICT ON UPDATE RESTRICT, FOREIGN KEY (franquicia_codi) REFERENCES Franquicia(codi) ON DELETE RESTRICT ON UPDATE RESTRICT );

-- 11. Taula Pavello
CREATE TABLE Pavello ( codi INT UNSIGNED AUTO_INCREMENT, nom VARCHAR(30) NOT NULL, PRIMARY KEY (codi) );

-- 12. Taula Grada
CREATE TABLE Grada ( codi INT UNSIGNED AUTO_INCREMENT, pavello_codi INT UNSIGNED NOT NULL, numero INT NOT NULL, PRIMARY KEY (codi), FOREIGN KEY (pavello_codi) REFERENCES Pavello(codi) ON DELETE CASCADE ON UPDATE CASCADE );

-- 13. Taula Seient
CREATE TABLE Seient ( codi INT UNSIGNED AUTO_INCREMENT, grada_codi INT UNSIGNED NOT NULL, fila VARCHAR(30), numero INT, PRIMARY KEY (codi), FOREIGN KEY (grada_codi) REFERENCES Grada(codi) ON DELETE CASCADE ON UPDATE CASCADE );

-- 14. Taula Conferencia
CREATE TABLE Conferencia ( codi INT UNSIGNED AUTO_INCREMENT, nom VARCHAR(30) NOT NULL, PRIMARY KEY (codi) );

-- 15. Taula Franquicia_Temporada
CREATE TABLE Franquicia_Temporada ( codi INT UNSIGNED AUTO_INCREMENT, franquicia_codi INT UNSIGNED NOT NULL, temporada VARCHAR(30), PRIMARY KEY (codi), FOREIGN KEY (franquicia_codi) REFERENCES Franquicia(codi) ON DELETE CASCADE ON UPDATE CASCADE );

-- 16. Taula Temporada_Regular
CREATE TABLE Temporada_Regular ( codi INT UNSIGNED AUTO_INCREMENT, temporada VARCHAR(30), Inici DATE, Fi DATE, PRIMARY KEY (codi) );