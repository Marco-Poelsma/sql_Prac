-- Script 3: Updates / Deletes

-- 1. Augmentar el salari dels entrenadors principals en un +3% 
UPDATE Entrenador_Personal SET salari = salari * 1.03;

-- Augmentar el pressupost de les franquícies en un +5% 
UPDATE Franquicia SET pressupost = pressupost * 1.05;

-- 2. Actualitzar els DNIs de totes les persones que tenen 8 caràcters (manca la lletra final) 
UPDATE Persona SET dni = CONCAT(dni, '%') WHERE LENGTH(dni) = 8;

-- 3. Esborrar els jugadors que tinguin el dorsal NULL 
DELETE djf
FROM Draft_Jugador_Franquicia djf
JOIN Jugador j ON djf.jugador_codi = j.codi
WHERE j.dorsal IS NULL;

DELETE FROM Jugador
WHERE dorsal IS NULL;

-- 4. Esborrar els entrenadors principals associats a una franquícia amb pressupost inferior a 2 milions 
DELETE FROM Entrenador_Personal WHERE franquicia_codi IN ( SELECT codi FROM Franquicia WHERE pressupost < 2000000 );

-- 5. Esborrar totes les grades amb número 13 i, per propagació en cascada, també s’esborraran els seients associats 
DELETE FROM Grada WHERE numero = 13;