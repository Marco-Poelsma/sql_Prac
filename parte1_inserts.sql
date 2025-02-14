-- Script 2: Inserts

-- Nota: Es fan inserts amb dades fictícies per tenir realisme.

-- Persona (30 registres) 
INSERT INTO Persona (nom, cognom, dni, any_naixement, sexe) VALUES ('Anna','Garcia','12345678A',1985,'D'), ('Joan','Martinez','23456789B',1990,'H'), ('Maria','Lopez','34567890C',1982,'D'), ('Pere','Sanchez','45678901D',1995,'H'), ('Laura','Diaz','56789012E',1988,'D'), ('Marc','Vidal','67890123F',1992,'H'), ('Sofia','Ramirez','78901234G',1980,'D'), ('Alex','Fernandez','89012345H',1991,'NB'), ('Iria','Marti','90123456I',1987,'D'), ('Leo','Cortes','01234567J',1993,'H'), ('Clara','Ramos','11234567K',1984,'D'), ('David','Pujol','12234567L',1989,'H'), ('Marta','Costa','13234567M',1986,'D'), ('Pol','Ribas','14234567N',1994,'H'), ('Nuria','Gomez','15234567O',1983,'D'), ('Oscar','Llorens','16234567P',1990,'H'), ('Elena','Blanco','17234567Q',1982,'D'), ('Ramon','Herrera','18234567R',1991,'H'), ('Carmen','Molina','19234567S',1987,'D'), ('Jordi','Marin','20234567T',1992,'H'), ('Laia','Ferrer','21234567U',1984,'D'), ('Ivan','Suarez','22234567V',1993,'H'), ('Nadia','Ribas','23234567W',1985,'D'), ('Roger','Bazan','24234567X',1990,'H'), ('Eva','Camps','25234567Y',1988,'D'), ('Arnau','Soler','26234567Z',1991,'H'), ('Gemma','Pons','27234567A',1983,'D'), ('Alexandre','Fabra','28234567B',1992,'H'), ('Vera','Torres','29234567C',1987,'D'), ('Nil','Mas','30234567D',1994,'H');

-- Jugador (16 registres, associats als 16 primers persones) 
INSERT INTO Jugador (persona_codi, dorsal, posicio) VALUES (1, 10, 'Base'), (2, 7, 'Escolta'), (3, 23, 'Alero'), (4, 11, 'AlaPivot'), (5, 8, 'Pivot'), (6, 15, 'Escolta'), (7, 20, 'Base'), (8, NULL, 'Escolta'), (9, 3, 'Alero'), (10, 22, 'AlaPivot'), (11, 5, 'Pivot'), (12, 12, 'Base'), (13, 14, 'Escolta'), (14, 6, 'Alero'), (15, 9, 'AlaPivot'), (16, 13, 'Pivot');

-- Preparador_Fisic (5 registres; s’utilitzen persones 17 a 21, amb una reutilització per arribar a 5) 
INSERT INTO Preparador_Fisic (persona_codi, especialitat) VALUES (17, 'Entrenament'), (18, 'Nutricio'), (19, 'Recuperacio'), (20, 'Fisioterapia'), (1, 'Psicologia'); -- reutilització per aconseguir 5 registres

-- Franquicia (4 registres) 
INSERT INTO Franquicia (nom, pressupost, ZonaGeografica) VALUES ('Franquicia_A', 2500000.00, 'Zona1'), ('Franquicia_B', 3000000.00, 'Zona2'), ('Franquicia_C', 1800000.00, 'Zona3'), ('Franquicia_D', 2200000.00, 'Zona4');

-- Entrenador_Personal (8 registres, associats a persones 22 a 29) 
INSERT INTO Entrenador_Personal (persona_codi, salari, franquicia_codi) VALUES (22, 50000.00, 1), (23, 52000.00, 2), (24, 48000.00, 3), (25, 51000.00, 4), (26, 53000.00, 1), (27, 55000.00, 2), (28, 49000.00, 3), (29, 56000.00, 4);

-- Equip_Nacional (8 registres) 
INSERT INTO Equip_Nacional (nom) VALUES ('Equip_Nacional_1'), ('Equip_Nacional_2'), ('Equip_Nacional_3'), ('Equip_Nacional_4'), ('Equip_Nacional_5'), ('Equip_Nacional_6'), ('Equip_Nacional_7'), ('Equip_Nacional_8');

-- Equip_Nacional_Jugador (18 registres) 
INSERT INTO Equip_Nacional_Jugador (equip_nacional_codi, jugador_codi) VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8), (1, 9), (2, 10), (3, 11), (4, 12), (5, 13), (6, 14), (7, 15), (8, 16), (1, 2), (2, 3);

-- Draft (4 registres) 
INSERT INTO Draft (any) VALUES (2020), (2021), (2022), (2023);

-- Draft_Jugador_Franquicia (13 registres) 
INSERT INTO Draft_Jugador_Franquicia (draft_codi, jugador_codi, franquicia_codi, Es_guanyador) VALUES (1, 1, 1, FALSE), (1, 2, 1, FALSE), (2, 3, 2, FALSE), (2, 4, 2, FALSE), (3, 5, 3, FALSE), (3, 6, 3, FALSE), (4, 7, 4, FALSE), (4, 8, 4, FALSE), (1, 9, 1, TRUE), (2, 10, 2, FALSE), (3, 11, 3, FALSE), (4, 12, 4, FALSE), (1, 13, 1, FALSE);

-- Pavello (4 registres) 
INSERT INTO Pavello (nom) VALUES ('Pavello_A'), ('Pavello_B'), ('Pavello_C'), ('Pavello_D');

-- Grada (14 registres) 
INSERT INTO Grada (pavello_codi, numero) VALUES (1, 10), (1, 11), (2, 12), (2, 13), (3, 14), (3, 15), (4, 16), (4, 13), (1, 17), (2, 18), (3, 19), (4, 20), (1, 21), (2, 22);

-- Seient (30 registres; assignats a diverses grades) 
INSERT INTO Seient (grada_codi, fila, numero) VALUES (1, 'A', 1), (1, 'A', 2), (2, 'B', 1), (2, 'B', 2), (3, 'C', 1), (3, 'C', 2), (4, 'D', 1), (4, 'D', 2), (5, 'E', 1), (5, 'E', 2), (6, 'F', 1), (6, 'F', 2), (7, 'G', 1), (7, 'G', 2), (8, 'H', 1), (8, 'H', 2), (9, 'I', 1), (9, 'I', 2), (10, 'J', 1), (10, 'J', 2), (11, 'K', 1), (11, 'K', 2), (12, 'L', 1), (12, 'L', 2), (13, 'M', 1), (13, 'M', 2), (14, 'N', 1), (14, 'N', 2), (1, 'O', 3), (2, 'P', 3);

-- Conferencia (2 registres) 
INSERT INTO Conferencia (nom) VALUES ('Conferencia_Este'), ('Conferencia_Oest');

-- Franquicia_Temporada (12 registres) 
INSERT INTO Franquicia_Temporada (franquicia_codi, temporada) VALUES (1, '2020-2021'), (2, '2020-2021'), (3, '2020-2021'), (4, '2020-2021'), (1, '2021-2022'), (2, '2021-2022'), (3, '2021-2022'), (4, '2021-2022'), (1, '2022-2023'), (2, '2022-2023'), (3, '2022-2023'), (4, '2022-2023');

-- Temporada_Regular (3 registres) 
INSERT INTO Temporada_Regular (temporada, Inici, Fi) VALUES ('2020-2021', '2020-10-01', '2021-06-30'), ('2021-2022', '2021-10-01', '2022-06-30'), ('2022-2023', '2022-10-01', '2023-06-30');