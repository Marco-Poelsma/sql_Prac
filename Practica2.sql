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


SELECT a.city 
FROM arena AS a 
JOIN franchise AS f ON a.name = f.ArenaName
JOIN conference AS c ON c.name = f.ConferenceName
WHERE c.name = 'Western Conference' 
ORDER BY a.city LIMIT 1 OFFSET 4; 


-- 5 Llista els noms dels jugadors que han estat seleccionats en el draft en primera, segona o tercera posició al draft del 2020.
-- Ordena pel cognom i nom del jugador (Z-A).
-- Quin és el nom del jugador mostrat en la primera fila



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


-- 12 Retorna amb el país i any els equips nacionals amb el nom i cognom del seu entrenador. Fes-ho pels anys del 2010 al 2015 i pels països que comencin per A. Quants entrenadors retorna la consulta? Resultado 6 




SELECT nt.Country, nt.Year, p.Name, p.Surname
FROM nationalteam AS nt
JOIN headcoach AS h ON h.IDCard = nt.IDCardHeadCoach 
JOIN person AS p ON p.IDCard = h.IDCard 
WHERE nt.Year BETWEEN 2010 AND 2015 AND nt.country LIKE 'A%';


--13 

SELECT pf.FranchiseName, SUM(pf.Salary) AS total_salary
FROM player_franchise pf
WHERE pf.FranchiseName = 'Houston Rockets'
AND (
    pf.StartContract <= '2007-12-31' 
    AND pf.EndContract >= '2007-01-01'
)
GROUP BY pf.FranchiseName;




-- 14  Retorna cada arena amb la seva capacitat, juntament amb el nombre de seients que tenen. Quants seients té el Footprint Center?

SELECT a.Name, a.capacity, COUNT(*)
FROM arena AS a 
JOIN zone AS z ON z.ArenaName = a.Name
JOIN seat AS s ON s.ArenaName = z.ArenaName AND s.ZoneCode = z.Code
GROUP BY a.Name;

--15
SELECT p.*
FROM person AS p
JOIN player AS pl ON p.IDCard = pl.IDCard
WHERE p.nationality NOT IN ('United States', 'Spain')
ORDER BY p.nationality ASC, p.birthdate ASC
LIMIT 3 OFFSET 2;

-- 16 Mostra un informe amb el nom, cognom i data de naixement de tots els caps d'entrenadors assistents de l'especialitat de psicologia sense repetits i que tenen una data de naixement registrada. Ordena per cognom i nom. Quin és l'any de naixement del tercer resultat?


SELECT DISTINCT YEAR(p.birthdate), p.name, p.surname
FROM person p
JOIN assistantcoach a ON p.IDCard = a.IDCard
WHERE p.birthdate IS NOT NULL AND a.Especiality LIKE '%Psychologist'
GROUP BY p.name, p.surname, p.birthdate
ORDER BY p.name, p.surname
LIMIT 1 OFFSET 2;


-- 17 Volem saber quantes franquícies hi ha per a cada conferència. Mostra totes les dades relacionades amb la conferència i un nou camp amb el recompte. Quantes franquícies hi ha acada conferència?


SELECT c.Name, COUNT(f.NameFranchise) AS recuento
FROM franchise AS f
JOIN conference AS c ON f.ConferenceName = c.name
GROUP BY c.name; 


-- 18 Sabent que molts jugadors han estat seleccionats en algun moment per les seves seleccions, retorna tots els jugadors que han estat seleccionats en l'any 2010. Inclou IDCard, Nom, Cognom, Nacionalitat, Any de selecció, en aquell mateix any i el número de samarreta en la selecció. Ordena el resultat pel numero de samarreta. Quina es al nacionalitat del primer resultat que apareix?



SELECT p.IDCard, p.name, p.surname, p.Nationality, dpf.DraftYear, ntp.ShirtNumber
FROM person AS p 
JOIN player AS pl ON pl.IDCard = p.IDCard 
JOIN nationalteam_player AS ntp ON ntp.IDCard = pl.IDCard
JOIN draft_player_franchise AS dpf ON dpf.IDCardPlayer = ntp.IDCard 
WHERE ntp.Year = 2010
ORDER BY ntp.ShirtNumber ASC; 


--19


SELECT p.IDCard, p.name, p.surname, dpf.*
FROM person AS p
JOIN player AS pl ON p.IDCard = pl.IDCard
LEFT JOIN draft_player_franchise AS dpf ON dpf.IDCardPlayer = pl.IDCard
ORDER BY p.surname ASC, dpf.draftyear ASC
LIMIT 1;

-- 20 Retorna les franquícies que han jugat a totes les temporades regulars registrades. Ordena alfabèticament de la Z a la A. I tornaúnicament el 3 resultat.Quin és el nom del equip?
SELECT f.Name
FROM franchise f
JOIN franchise_season fs ON f.Name = fs.FranchiseName
GROUP BY f.Name
HAVING COUNT(DISTINCT fs.RegularSeasonYear) = (SELECT COUNT(DISTINCT RegularSeasonYear) FROM franchise_season)
ORDER BY f.Name DESC
LIMIT 1 OFFSET 2;
INSERT INTO answer (IDquestion, answer_value, sql_query_used)
VALUES (20, "Toronto Raptors", "SELECT f.Name
FROM franchise f
JOIN franchise_season fs ON f.Name = fs.FranchiseName
GROUP BY f.Name
HAVING COUNT(DISTINCT fs.RegularSeasonYear) = (SELECT COUNT(DISTINCT RegularSeasonYear) FROM franchise_season)
ORDER BY f.Name DESC
LIMIT 1 OFFSET 2;")

-- 21 Per cada especialitat d'entrenadors assistents, retorna quants n'ha tingut cada franquícia. Qunatsmetges tenen els Brooklin Nets?
SELECT ac.Especiality, COUNT(*) AS TotalEntrenadors
FROM assistantcoach ac
JOIN franchise f ON ac.FranchiseName = f.Name
WHERE f.Name = 'Brooklyn Nets' AND ac.Especiality LIKE '%Doctor%'
GROUP BY ac.Especiality;

INSERT INTO answer (IDquestion, answer_value, sql_query_used)
VALUES (21, '5', 'SELECT ac.Especiality, COUNT(*) AS TotalEntrenadors
FROM assistantcoach ac
JOIN franchise f ON ac.FranchiseName = f.Name
WHERE f.Name = 'Brooklyn Nets' AND ac.Especiality LIKE '%Doctor%'
GROUP BY ac.Especiality;');
--22
SELECT COUNT(*) 
FROM person AS p
JOIN player AS pl ON p.IDCard = pl.IDCard
JOIN draft_player_franchise AS dpf ON dpf.IDCardPlayer = pl.IDCard 
WHERE YEAR(p.birthdate) NOT IN (SELECT DraftYear FROM draft_player_franchise WHERE DraftYear IS NOT NULL);

-- 23 Quants entrenadors cobren més que qualsevol jugador?
SELECT COUNT(*)
FROM headcoach AS h
JOIN person AS p ON h.IDCard = p.IDCard
WHERE h.Salary > (SELECT MAX(pf.Salary) FROM player_franchise AS pf);

-- 24 Omple la columna NBARings de la taula de Franquícies. Aquest camp es pot calcular mitjançant la taula Franchise_Season contant quantes vegades han guanyat. Utilitza una declaració UPDATE. Un cop ho tingueu, trobeu quantes franquícies tenen 4 o més anells.
UPDATE franchise AS f
SET NBARings = (
    SELECT COUNT(*)
    FROM franchise_season AS fs
    WHERE fs.FranchiseName = f.Name AND fs.IsWinner = 1
);
SELECT COUNT(*)
FROM franchise f
WHERE f.NBARings >= 4;

-- 25 Troba el nom de la franquícia amb el valor de budget més petit.
SELECT f.Name
FROM franchise f
ORDER BY f.Budget
LIMIT 1;


--26
SELECT a.City, COUNT(*) AS TotalSeats
FROM seat AS s
JOIN zone AS z ON s.ArenaName = z.ArenaName AND s.ZoneCode = z.Code
JOIN arena AS a ON z.ArenaName = a.Name
GROUP BY a.City
HAVING TotalSeats > 18000
ORDER BY TotalSeats DESC
LIMIT 1;

-- 27 Retorna la ID del jugador i el nom de la seva franquicia que han quedat primers al draft i al mateix any d'aquest han gunayat la temporada regular. Retorna la ID de l'únic que te Universitat d'origen.
SELECT dpf.IDCardPlayer, f.Name
FROM draft_player_franchise dpf
JOIN franchise_season fs ON dpf.DraftYear = fs.RegularSeasonYear AND dpf.FranchiseName = fs.FranchiseName
JOIN player pl ON dpf.IDCardPlayer = pl.IDCard
JOIN player_franchise pf ON pl.IDCard = pf.IDCardPlayer
JOIN franchise f ON pf.FranchiseName = f.Name
WHERE dpf.position = 1 AND fs.IsWinner = 1 AND pl.UniversityOfOrigin IS NOT NULL;

-- 28 Retorna els paisos amb més de 50 jugadors, 3 entrenadors i 10 assistents de paisos que tinguin selecció. Quin país apareix als resultats?
SELECT p.nationality
FROM person AS p
JOIN player AS pl ON p.IDCard = pl.IDCard
JOIN headcoach AS h ON p.IDCard = h.IDCard
JOIN assistantcoach AS ac ON p.IDCard = ac.IDCard
JOIN nationalteam AS nt ON p.nationality = nt.country
GROUP BY p.nationality
HAVING COUNT(pl.IDCard) > 50
AND COUNT(h.IDCard) > 3
AND COUNT(ac.IDCard) > 10;





-- 29 Retorna els headcoach que entrenin equips nacionals amb el salari més gran o el percentantge de victòria més petit, d'entre els que entrenen equips nacionals. Quan sumen els salaris dels entrenadors resultants?
SELECT SUM(h.Salary)
FROM headcoach h
JOIN nationalteam nt ON h.IDCard = nt.IDCardHeadCoach
WHERE h.Salary = (SELECT MAX(Salary) FROM headcoach WHERE IDCard IN (SELECT IDCardHeadCoach FROM nationalteam))
OR h.VictoryPercentage = (SELECT MIN(VictoryPercentage) FROM headcoach WHERE IDCard IN (SELECT IDCardHeadCoach FROM nationalteam));


-- 30 Retorna els jugadors que han jugat en 2 equips o més i han estat convocats també a la selecció més d'un cop. Quants jugadors hi ha en aquesta situació?
SELECT COUNT(DISTINCT pl.IDCard)
FROM player AS pl
JOIN player_franchise AS pf ON pl.IDCard = pf.IDCardPlayer
JOIN nationalteam_player AS ntp ON pl.IDCard = ntp.IDCard
GROUP BY pl.IDCard
HAVING COUNT(DISTINCT pf.FranchiseName) >= 2 AND COUNT(ntp.IDCard) > 1;

-- 1401 En quin estadi la capacitat excedeit en mes de 50 el nombre de seients?
SELECT a.Name
FROM arena AS a
JOIN seat AS s ON a.Name = s.ArenaName
GROUP BY a.Name, a.capacity
HAVING a.capacity > COUNT(*) + 50;
