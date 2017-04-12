CREATE DATABASE nom_de_la_base;-- création d'une base de données
SHOW DATABASES;-- permet de voir toutes les bases de données
USE nom_de_la_base;-- permet de sélectionner et utiliser la base de donnée
DROP nom_de_la_base;-- supprimer une base de données
DROP table nom_de_la_base_donnée;-- supprime une table
TRUNCATE nom_de_la_base;-- permet de vider la table

----------REQUETE DE SELECTION----------------------------------


-- AFFICHAGE COMPLET
SELECT id_employes,prenom,nom,sexe,service,date_embauche,salaire
FROM employes;-- va me chercher les données DE la table employés
SELECT * FROM employes;-- affichage de la table employes avec le raccourci de l'étoile'*' pour dire 'ALL'
-- traduction = affiche moi [*toutes les colonnes] de la [table employes]
-----------------------------------------------------------------------------
-- quels sont les noms et prénoms des employés travaillant dans l'entreprise?
SELECT nom,prenom FROM employes;
-----------------------------------------------------------------------------
-- quels sont les différents services occupés par les employés travaillant en entreprise ?
SELECT service FROM employes;
-- lorsque l'on met une virgule, cela siginifie que l'on selectionne un autre champs du tableau : exp SELECT nom','prenom FROM employes
------------------------------------------------------
-- DISTINCT permet de ne pas  voir et d'éviter  de chercher les doublons
SELECT DISTINCT service FROM employes;
--------------------------------------------------------
-- condition WHERE ( à condition que ='')
-- affichage des employes du service informatique
SELECT nom, prenom, service FROM employes WHERE service ='informatique';
-- affiche moi le nom et prénom des employés au service informatique

-------------------------------------------------------------
-- BETWEEN
-- AFFICHAGE des employes ayant été recrutés entre 2010 et aujourd'hui
SELECT nom,prenom,date_embauche FROM employes WHERE date_embauche BETWEEN '2010-01-01' AND '2017-04-11';
SELECT CURDATE();-- renvoie la date du jour
SELECT NOW();-- affiche la date et l'heure
-- pas de différence entre les quotes simples' 'et les guillemets"". Quand il y'a une valeur , il faut mettre des guillemets " " ou des quotes ' '.En revanche quand il s'agit d'un chiffre , on ne doit les mettre.
--------------------------------------------------------------
-- LIKE : valeur approchante
-- Affichage des employés ayant un prénom commençant par la lettre 's'
SELECT prenom FROM employes WHERE prenom LIKE 's%'; -- je souhaite connaitre le prénom des personnes commençant par la lettre 's'
SELECT prenom FROM employes WHERE prenom LIKE '%s';-- je souhaite connaître le prenom des personnes terminant par la lettre 's'
SELECT prenom FROM employes WHERE prenom LIKE '%-%';-- je souhaite connaître le prenom des personnes ayant un nom composé
-- % : peu importe la suite
-- ID ----- nom--------code postal
-- 1 ------ Appart1---- 75015
-- 2 ------ Appart2---- 75011
-- 3 ------ Appart3---- 75016
-- 4 ------ Appart4---- 95000
-- SELECT * FROM appartement WHERE code_postal = 75; mauvaise requête
-- SELECT * FROM appartement WHERE code_postal LIKE '75%'; je selectionne tous les appartements avec un code postal commençant par 75
------------------------------------------------------------------
-- Affichage de tous les employés sauf les informaticiens


SELECT * FROM employes WHERE NOT service='informatique';-- je souhaite connaitre le nom et prenom de tous les employés de l'entreprise NE travaillant PAS dans le service informatique
SELECT * FROM employes WHERE service !='informatique';-- je souhaite connaitre le nom et prenom de tous les employés de l'entreprise NE travaillant PAS dans le service informatique
-- != différent de...

-- OPERATEURS DE COMPARAISON
-- = "est égal"
-- > "strictement supérieur"
-- < "strictement inférieur"
-- >= "inférieur ou égal"
-- <= "supérieur ou égal"
-- <> ou != "différent de" 

--------------------------------------------------------------------
-- Afficher le nom ,prénom ,service et salaire des employés de l'entreprise ayant un salaire supérieur à 3000€

SELECT nom,prenom,service,salaire FROM employes WHERE salaire > 3000;

----------------------------------------------------------------------
-- ORDER BY
-- Affichage des employés dans l'ordre alphabétique
SELECT prenom FROM employes ORDER BY prenom ASC,-- ASC = ascendant ou croissant
SELECT prenom FROM employes ORDER BY prenom DESC,-- DESC = descendant ou décroissant
SELECT prenom,salaire,  FROM employes ORDER BY salaire DESC, prenom ASC;-- DESC = descendant ou décroissant
-- ORDER BY permet d'effectuer un classement 
-- ASC: ascendant ,croissant
-- DESC: descendant,décroissant
-------------------------------------------------------------------------
-- LIMIT
-- Affiche des employés 3 par 3
SELECT prenom FROM employes ORDER BY prenom LIMIT 0,3;-- "0" est le début du tableau et "3" est le nombre d'employé à afficher
-- LIMIT 0,3 : 0 est la position de départ de mon tableau et 3 est le nombre d'employés que je souhaite afficher
--------------------------------------------------------------------------
-- Affichage des employés avec un salaire annuel
SELECT prenom,salaire*12 FROM employes;
SELECT prenom,salaire*12 AS 'Salaire annuel' FROM employes;-- AS = Alias qui permetd de donner un nom à notre table quis'écri AS ''
---------------------SUM (la somme)------------------------------
-- SUM() (somme)
-- Affichage de la "masse salariale" sur le 12 mois
SELECT SUM(salaire*12) AS 'masse salariale' FROM employes;
-----------------CALCULER UNE MOYENNE---------------------------------------
-- AVG() permet de calculer une moyenne
-- Affichage du salaire moyen
SELECT ROUND(AVG(salaire),2) AS 'Salaire moyen' FROM employes;-- ROUND()permet d'arrondir un nombre,une somme et ',x' permet de définir à combien de chiffre après la virgule.
-- AVG() : moyenne
-- ROUND() : permet d'arrondir un chiffre
-- ROUND() permet d'arrondir,ROUND(...,2),le 2 permet d'afficher un chiffre arrondi à 2 chiffres apres la virgule 
-----------------------------------------------------------------------------
-- COUNT() 
-- Affichage du nombre de femmes travaillant dans l'entreprise
SELECT COUNT(*) AS 'Nombre de femmes dans l\'entreprise' FROM employes WHERE sexe = 'f';
-- COUNT permet de compter
--------------------------------------------------------------------------------------
-- MIN()/MAX()
-- Affichage des salaires minimum/maximun
SELECT MIN(salaire) AS 'Salaire minimum' FROM employes;
SELECT MAX(salaire) AS 'Salaire maximum' FROM employes;
--------------------- EXERCICE-----------------------------------------------------------------
-- Afficher le prenom et  le salaire de l' employé ayant le salaire le plus petit
SELECT prenom,salaire FROM employes WHERE salaire = (SELECT MIN(salaire) FROM employes);-- ou
SELECT prenom , salaire FROM employes ORDER BY salaire LIMIT 0,1;-- AFFICHER le prenom et le salaire DEPUIS la base des employés PAR ORDRE DE salaire EN PRENANT en partant de la case 0 et de la premiere ligne  
---------- requête détaillée------------------
SELECT prenom , salaire FROM employes WHERE salaire = 1390;

-------------------------------------------------------------------------------------------------
-- IN
-- Je souhaite connaître le prénom des employés travaillant dans le service comptabilité et le service informatique.
SELECT prenom , service FROM employes WHERE service IN('informatique','comptabilite'); 
-- IN permet de sélectionner plusieurs valeurs
-- = permet de selectionner une seule valeur
-- je souhaite connaitre le prénom des employés ne travaillant pas dans les services informatique et comptabilité
SELECT prenom,service FROM employes WHERE service NOT IN('informatique','comptabilite');
-- A l'inverse , pour connaitre le prenom des employés ne faisant pas partie des services comptabilité et informatique,classé par service.
SELECT prenom,service FROM employes WHERE service NOT IN('informatique','comptabilité') ORDER BY service;
-- Je souhaite connaître le prénom et le nom des employes du service commercial avec un salaire inférieur ou égal à 2000€.
SELECT prenom,nom FROM employes WHERE service ='commercial' AND salaire<=2000;
-- AND :et... (condition supplémentaire)
----------------------------------------------------------------------------------------------------------------------
-- OR
-- Exercice : je souhaite connaitre le prénom et noms des employés du service commercial pour un salaire de 1900 ou 2300
SELECT prenom,nom,salaire FROM employes WHERE service='commercial' AND (salaire=1900 OR salaire=2300);
------------------------------------------------------------------------------------------------------------------------
-- GROUP BY
-- Affichage du nombre d'employes par service
SELECT service,COUNT(*) AS 'Nombre' FROM employes GROUP BY service;
-- GROUP BY permet d'effectuer des regroupements
----------------------------- REQUETE D INSERTION-------------------------------
INSERT INTO employes(prenom,nom,sexe,service,date_embauche,salaire) VALUES('Omar','HAMZI','m','informatique','2017-01-19','25000');
INSERT INTO employes(id_employes,prenom,nom,sexe,service,date_embauche,salaire) VALUES('1980','Omar','HAMZI','m','informatique','2017-01-19','25000');
------------------------------ REQUETE DE MODIFICATION----------------------------
UPDATE employes SET salaire= 1100,service='nettoyage' WHERE id_employes = 350;
REPLACE INTO employes(id_employes,prenom,nom,sexe,service,date_embauche,salaire)VALUES(592,'Laura','Blanchet','m','cuisine','2017-01-01','1100');
-- Si ID n'est pas trouvé ,REPLACE se comporte comme un INSERT sinon il se comporte comme un UPDATE
SELECT *FROM employes -- on observe le contenu de la table après les modifications

---------------------------------- REQUETE DE SUPPRESSION--------------------------------
DELETE FROM employes WHERE prenom ='jean-pierre';-- suppression de l'employé ayant le prénom jean-pierre
DELETE FROM employes WHERE id_employes ='350';-- suppression de l'employé ayant l'ID 350
-- Supprimer tout les informaticiens sauf id_employes 701
DELETE FROM employes WHERE service ='informatique'  AND NOT id_employes= '701';
-- ou 
DELETE FROM employes WHERE service ='informatique' AND id_employes !='701';

------------------ TP------------------------------
-- 1 Afficher la profession de l'employé 547
SELECT service  FROM employes WHERE id_employes='547';-- commercial

-- 2 Afficher la date d'embauche d'Amandine
SELECT date_embauche FROM employes WHERE prenom='Amandine'; -- 2010-01-23

-- 3 Afficher le nom de famille de Guillaume--
SELECT nom FROM employes WHERE prenom = 'Guillaume';-- Miller

-- 4 Afficher le nombre d'employés ayant un n° Id employes commençant par le chiffre 5
SELECT*FROM employes WHERE id_employes LIKE '5%';-- 3 
SELECT COUNT AS 'Nombre de commerciaux' FROM employes WHERE id_employes LIKE '5%';-- correction

-- 5 Afficher le nombre de commerciaux
SELECT*FROM employes WHERE service ='commercial';-- 6
SELECT COUNT AS'Nombre de commerciaux' FROM employes WHERE service='commercial';-- correction

-- 6 Afficher le salaire moyen des informaticiens(+arrondi)
SELECT ROUND(AVG(salaire)) AS 'Salaire moyen informaticien'FROM employes WHERE service = 'informatique';-- 1983 €

-- 7 Afficher les 5 premiers employes apres avoir classe leurs noms de famille par ordre alphabétique
SELECT nom,prenom FROM employes ORDER BY nom LIMIT 0,5;-- BLANCHET/CHEVEL/COLLIER/COTTET/DESPREZ

-- 8 Afficher le coût des commerciaux sur une année
SELECT SUM(salaire*12) FROM employes WHERE service='commercial';-- 184 200 €

-- 9 Afficher le salaire moyen par service ( salaire + salaire moyen)
SELECT AVG(salaire) FROM employes GROUP BY service;
SELECT service, AVG(salaire) AS 'salaire moyen par service'FROM employes GROUP BY service;-- correction

-- 10 Afficher le nombre de recrutemement sur l'année 2010 (+ alias)

SELECT COUNT(*) AS'Nombre de recrutement' FROM employes GROUP BY date_embauche = '2010';-- 20
SELECT COUNT(date_embauche) AS 'recrutement année 2010' FROM employes WHERE date_embauche BETWEEN '2010-01-01' AND '2010-12-31';
SELECT COUNT(date_embauche) AS 'recrutement année 2010' FROM employes WHERE date_embauche LIKE'2010%';

-- 11 Afficher le salaire moyen appliqué lors des recrutements sur la période de 2005 à 2007
SELECT AVG(salaire) FROM employes WHERE date_embauche BETWEEN '2005-01-01' AND '2007-01-01';3033,3333
SELECT ROUND (AVG(salaire))AS'salaire moyen' FROM employes WHERE date_embauche BETWEEN '2005-01-01' AND '2007-01-01';3033,3333-- correction

-- 12 Afficher le nombre de service différent
SELECT COUNT(DISTINCT service) FROM employes;-- 9

-- 13. Afficher tous les employes (sauf ceux du service production et secrétariat)
SELECT*FROM employes WHERE service NOT IN('production','secretariat');
SELECT prenom,nom,service FROM employes WHERE service NOT IN('production','secretariat');-- correction


-- 14. Afficher conjoitement le nombre d'homme et de femme dans l'entreprise
SELECT sexe FROM employes WHERE sexe;
SELECT sexe, COUNT(*) FROM employes GROUP BY sexe;-- correction

-- 15. Afficher les commerciaux ayant été recruté avant 2005 de sexe masculin et gagnant un salaire supérieur à 2500€
SELECT prenom,nom,service FROM employes WHERE sexe ='m' AND salaire>2500 AND date_embauche<'2005-01-01' AND service='commercial';-- THOMAS MILLER
SELECT prenom,nom,service FROM employes WHERE date_embauche<'2005-01-01' AND salaire>2500 AND sexe='m' AND service='commercial';-- correction

-- 16. Qui a été embauché en dernier? 
SELECT * FROM employes WHERE date_embauche ORDER BY date_embauche;
SELECT prenom,nom FROM employes WHERE date_embauche=(SELECT MAX(date_embauche) FROM employes);-- correction
SELECT prenom,nom FROM employes ORDER BY date_embauche DESC LIMIT 0,1;-- correction

-- 17. Afficher les informations sur l'employé du service commercial gagnant le salaire le plus élevé
SELECT prenom,nom,date_embauche,salaire FROM employes WHERE service = 'commercial' AND SELECT MAX (salaire >5000);
SELECT prenom,nom,date_embauche,salaire FROM employes WHERE service ='commercial' AND salaire =(SELECT MAX(salaire) FROM employes WHERE service='commercial');-- correction

 -- 18. Afficher le prénom de l informaticien gagnant le meilleur salaire
SELECT prenom,salaire FROM employes WHERE service='informatique' AND salaire =(SELECT MAX(salaire) FROM employes WHERE service='informatique');
SELECT prenom,salaire FROM employes WHERE service='informatique' ORDER BY salaire DESC LIMIT 0,1;-- correction

-- 19. Afficher le prenom de l'informaticien ayant été recruté en premier.
SELECT prenom FROM employes WHERE service='informatique' ORDER BY date_embauche DESC LIMIT 0,1;
SELECT prenom FROM employes WHERE service='informatique' AND date_embauche =(SELECT MIN(date_embauche) FROM employes WHERE service='informatique');-- correction

-- 20. Augmenter chaque employé de 100€
UPDATE employes SET salaire= salaire+100;-- correction// pas utile de mettre les parenthèses car 1 seule opération

-- 21. Supprimer les employés du service commercial   
DELETE FROM employes WHERE service='commercial';

-- 22. Donner le nom de l'employé ayant gagné le plus dans tous les commerciaux
SELECT prenom,nom,salaire FROM employes WHERE salaire>(SELECT MAX(salaire) FROM employes WHERE service='commercial');
SELECT prenom,nom,salaire FROM employes WHERE salaire ORDER BY;

-- 23.Combien y'a t'il de commerciaux gagnant un salaire inférieur ou égal avoisinant les 1500€ ? 
SELECT COUNT(*) FROM employes WHERE service='commercial' AND salaire LIKE 1500;
SELECT COUNT(*) FROM employes WHERE service='commercial' AND salaire <=1500;


