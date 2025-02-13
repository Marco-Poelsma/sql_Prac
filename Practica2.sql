SELECT *
FROM question q
WHERE q.is_solved=FALSE;
--Pregunta 1: Quants estadis hi ha? ERIK

SELECT COUNT(*) 
FROM arena AS a; 

-- 2
SELECT p.name, p.surname
FROM person p
JOIN headcoach h ON p.idcard = h.idcard;

SELECT p.surname
FROM person p
JOIN franquicia f ON p.idcard = f.idcardcoach
WHERE f.name = 'Utah Jazz';

-- 3 Troba el nom de la franquícia amb el pressupost més gran. MARCO
SELECT f.name FROM franchise f ORDER BY f.budget DESC LIMIT 1;



-- 4 Llista les arenes (noms i ciutats) de les franquícies de la conferència oest. Quin és el nom de la 5a ciutat? ERIK

SELECT a.name, a.city
FROM arena AS a 
JOIN franchise AS f ON a.name = f.ArenaName
JOIN conference AS c ON c.name = f.ConferenceName
WHERE c.name = 'Western Conference';

SELECT a.city 
FROM arena AS a 
JOIN franchise AS f ON a.name = f.ArenaName
JOIN conference AS c ON c.name = f.ConferenceName
WHERE c.name = 'Western Conference' 
ORDER BY a.city LIMIT 1 OFFSET 4; 


-- 5 Llista els noms dels jugadors que han estat seleccionats en el draft en primera, segona o tercera posició al draft del 2020.
-- Ordena pel cognom i nom del jugador (Z-A).
-- Quin és el nom del jugador mostrat en la primera fila


INSERT INTO answer (IDquestion, answer_value, sql_query_used) VALUES ('5', 'Evan', 'SELECT p.name, p. surname
FROM person AS p 
JOIN player AS pl ON p.IDCard = pl.IDCard 
JOIN draft_player_franchise AS dpf ON dpf.IDCardPlayer = pl.IDCard
WHERE dpf.position IN (1,2,3) AND DraftYear = 2020
ORDER BY p.surname DESC LIMIT 1;');

SELECT p.name, p. surname
FROM person AS p 
JOIN player AS pl ON p.IDCard = pl.IDCard 
JOIN draft_player_franchise AS dpf ON dpf.IDCardPlayer = pl.IDCard
WHERE dpf.position IN (1,2,3) AND DraftYear = 2020
ORDER BY p.surname DESC LIMIT 1;


-- 6
SELECT p.Name
FROM person p
JOIN player pl ON p.IDCard  = pl.IDCard 
WHERE p.BirthDate <= '1980-03-01' AND p.Surname = 'Lue'
ORDER BY p.BirthDate DESC
LIMIT 1;


-- 8 Tenim guardat els colors dels seients de tots els estadis. Retorna quants seients blaus hi ha en total.

INSERT INTO answer (IDquestion, answer_value, sql_query_used) VALUES ('8', '36402', 'SELECT COUNT(*) 
FROM seat AS s 
WHERE Color = 'blue'');

SELECT COUNT(*) 
FROM seat AS s 
WHERE Color = 'blue';


-- 9 Retorna la mitjana de seients (arrodonint sense decimals) per color d’entre tots els estadis. Quina es la mitjana dels platejats? 

SELECT s.Color, ROUND(COUNT(*) / COUNT(DISTINCT s.ArenaName)) AS average_seats
FROM seat AS s
GROUP BY s.Color;

-- 10 Retorna els entrenadors principals amb el seu rendiment segons el salari (rendiment = (VictoryPercentage / 100) * (Salary / 1000)), tallant els decimals que resultin. Quin és el rendiment de l'entrenador 100000004?


SELECT p.Name, ROUND((VictoryPercentage / 100) * (Salary / 1000)) AS Rendimiento 
FROM person AS p 
JOIN headcoach AS h ON p.IDCard = h.IDCard 
WHERE h.IDCard = 100000004;

-- 11 Per cada equip retorna quantes vegades ha guanyat. Sempre que siguin 3 vegades o més. Quantes files retorna el select?

SELECT f.Name, COUNT(*)
FROM franchise AS f 
JOIN franchise_season AS fs ON fs.FranchiseName = f.Name 
WHERE fs.IsWinner = 1
GROUP BY f.Name
HAVING COUNT(*) >= 3; 


--13 
SELECT pf.FranchiseName, SUM(pf.Salary) AS total_salary
FROM player_franchise pf
WHERE pf.FranchiseName = 'Houston Rockets'
AND (
    pf.StartContract <= '2007-12-31' 
    AND pf.EndContract >= '2007-01-01'
)
GROUP BY pf.FranchiseName;


-- 12 Retorna amb el país i any els equips nacionals amb el nom i cognom del seu entrenador. Fes-ho pels anys del 2010 al 2015 i pels països que comencin per A. Quants entrenadors retorna la consulta? Resultado 6 


SELECT COUNT(*)
FROM nationalteam AS nt
JOIN headcoach AS h ON h.IDCard = nt.IDCardHeadCoach 
JOIN person AS p ON p.IDCard = h.IDCard 
WHERE nt.Year BETWEEN 2010 AND 2015 AND nt.country LIKE 'A%';


-- 14  Retorna cada arena amb la seva capacitat, juntament amb el nombre de seients que tenen. Quants seients té el Footprint Center?

SELECT a.Name, a.capacity, COUNT(*)
FROM arena AS a 
JOIN zone AS z ON z.ArenaName = a.Name
JOIN seat AS s ON s.ArenaName = z.ArenaName AND s.ZoneCode = z.Code
WHERE a.Name = "Footprint Center"
GROUP BY a.Name;



-- 17 Volem saber quantes franquícies hi ha per a cada conferència. Mostra totes les dades relacionades amb la conferència i un nou camp amb el recompte. Quantes franquícies hi ha acada conferència?


SELECT c.*, COUNT(*) AS recuento
FROM franchise AS f
JOIN conference AS c ON f.ConferenceName = c.name
GROUP BY c.name; 





-- 18 Sabent que molts jugadors han estat seleccionats en algun moment per les seves seleccions, retorna tots els jugadors que han estat seleccionats en l'any 2010. Inclou IDCard, Nom, Cognom, Nacionalitat, Any de selecció, en aquell mateix any i el número de samarreta en la selecció. Ordena el resultat pel numero de samarreta. Quina es al nacionalitat del primer resultat que apareix?



SELECT p.IDCard, p.name, p.surname, p.Nationality, dpf.DraftYear, ntp.ShirtNumber
FROM person AS p 
JOIN player AS pl ON pl.IDCard = p.IDCard 
JOIN nationalteam_player AS ntp ON ntp.IDCard = pl.IDCard
WHERE ntp.Year = 2010
ORDER BY ntp.ShirtNumber ASC; 

--19
SELECT p.IDCard, p.name, p.surname, dpf.*
FROM person AS p
JOIN player AS pl ON p.IDCard = pl.IDCard
LEFT JOIN draft_player_franchise AS dpf ON dpf.IDCardPlayer = pl.IDCard
ORDER BY p.surname ASC, dpf.draftyear ASC
LIMIT 1;

--22
SELECT COUNT(*) 
FROM person AS p
JOIN player AS pl ON p.IDCard = pl.IDCard
JOIN draft_player_franchise AS dpf ON dpf.IDCardPlayer = pl.IDCard 
WHERE YEAR(p.birthdate) NOT IN (SELECT DraftYear FROM draft_player_franchise WHERE DraftYear IS NOT NULL);


--26
SELECT a.City, COUNT(*) AS TotalSeats
FROM seat AS s
JOIN zone AS z ON s.ArenaName = z.ArenaName AND s.ZoneCode = z.Code
JOIN arena AS a ON z.ArenaName = a.Name
GROUP BY a.City
HAVING TotalSeats > 18000
ORDER BY TotalSeats DESC
LIMIT 1;
