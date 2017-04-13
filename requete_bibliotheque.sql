-- Afficher ID des livres qui n'ont jmais été rendu
SELECT id_livre FROM emprunt WHERE date_rendu IS NULL;
-- un champ NULL se test avec IS 
----------------- REQUETE IMBRIQUEES-----------------
-- Afficher le titre des livres dans la nature(date rendu NULL)
SELECT titre FROM livre WHERE id_livre IN (SELECT id_livre FROM emprunt WHERE date_rendu IS NULL);

-- Afficher la liste des abonnés n'ayant pas rendu les livres à la bibliothèque
SELECT*FROM abonne WHERE id_abonne IN (SELECT id_abonne FROM emprunt WHERE date_rendu IS NULL)
------- requête détaillé-----------------
SELECT*FROM abonne WHERE id_abonne IN(3,2)
-- afin de réaliser une requête imbriquée,il faut OBLIGATOIREMENT un champ commun entre les tables
-- Il faut toujours se poser la question : "De quelles tables je vais avoir besoin pour exécuter la requête imbriquée et quel est le champs commun entre les deux tables".--

-- Nous aimerions connaître le n° de(s) livres que Chloe a emprunté à la bibliothèque.
SELECT id_livre FROM emprunt WHERE id_abonne IN (SELECT id_abonne FROM abonne WHERE prenom='Chloe');

-- Afficher les prénoms des abonnés ayant empruntés le 19/12/2014
SELECT prenom FROM abonne WHERE id_abonne IN (SELECT id_abonne FROM emprunt WHERE date_sortie ='2014-12-19');
-- Combien de livre Guillaume a emprunté à la bibliothèque
SELECT COUNT(*) FROM emprunt WHERE id_abonne IN (SELECT id_abonne FROM abonne WHERE prenom='Guillaume');
------requête détaillée---------
SELECT COUNT(*) FROM emprunt WHERE id_abonne IN (1);
--------------------------------------------------------------------------------------------
-- Afficher la liste des abonnées ayant déjà emprunté d'Alphonse Daudet
SELECT prenom FROM abonne WHERE id_abonne IN(SELECT id_abonne FROM emprunt WHERE id_livre IN (SELECT id_livre FROM livre WHERE auteur='ALPHONSE DAUDET'));
--------- requête détaillée-----------
SELECT prenom FROM abonne WHERE id_abonne IN(SELECT id_abonne FROM emprunt WHERE id_livre IN (103);
    SELECT prenom FROM abonne WHERE id_abonne IN(4),(103);
-- la liste des abonnés se trouvent dans la table abonné
-- Le n° id des livres écrits par Alphonse Daudet se trouve dans la table livre
-- la liste des emprunts ( qui a emprunté quoi?) se trouve dans la table emprunt
-- Nous ne pouvons pas relier la table abonné directement avec la table livre( car ces deux tables ne possèdent pas de champs commun)
-- Nous pouvons relier la table livre avec la table emprunt. Nous pouvons aussi relier la table abonne avec la table emprunt
-----------------------                                             --------------------------
-- Nous aimerions connaître le titre de(s) livre(s) que Chloé a emprunté à la bibliothèque
SELECT titre FROM livre WHERE id_livre IN (SELECT id_livre FROM emprunt WHERE id_abonne IN (SELECT id_abonne FROM abonne WHERE prenom ='Chloe'));
-- ET aussi nous aimerions connaître les titres de livre que Chloé n'a pas emprunté
-- Nous aimerions connaître le titre de(s) livre(s) que Chloé a emprunté à la bibliothèque
SELECT titre FROM livre WHERE id_livre NOT IN (SELECT id_livre FROM emprunt WHERE id_abonne IN (SELECT id_abonne FROM abonne WHERE prenom ='Chloe'));
----------------------------------------------------------------------------------------------------------
-- Nous aimerions maintenant connaitre le titre des livre(s) que Chloé n'a pas rendu(s) à la bibliothèque 
SELECT titre  FROM livre WHERE id_livre IN (SELECT id_livre FROM emprunt WHERE date_rendu IS NULL AND id_abonne IN ( SELECT id_abonne FROM abonne WHERE prenom ='Chloe'));
---------------------    requête détaillée         -----------------------
                                            
SELECT titre  FROM livre WHERE id_livre IN (SELECT id_livre FROM emprunt WHERE date_rendu IS NULL AND id_abonne IN ( 105) 
SELECT titre  FROM livre WHERE id_livre IN (3) ( 105) 
----------------------------------------------------------------------------------------------------------------------------
-- Qui a emprunté le plus de livre à la bibliothèque
SELECT prenom  FROM abonne WHERE id_abonne = (SELECT id_abonne FROM emprunt WHERE id_livre GROUP BY id_abonne ORDER BY COUNT(id_abonne) DESC LIMIT 0,1); 
-- = sert de comparaison et ici il y a un seul résultat
-- IN ==> PARMI
------------------------------------------------------------------------------------------------------------------------------
                                            JOINTURES
-- JOINTURE
-- Nous aimerions connaître les dates de sortie et de rendu pour l'abonné Guillaume
SELECT a.prenom,e.date_sortie,e.date_rendu FROM abonne a,emprunt e WHERE a.id_abonne = e.id_abonne AND a.prenom = "Guillaume";
-- Différence Jointure et requête imbriquée : une jointure et une requête imbriquée permettent de faire des relations entre les différentes tables afin d'avoir des colonnes associé pour former qu'un seul résultat
-- 1ére ligne : ce qu'on souhaite afficher
-- 2éme ligne : de quelle table cela provient , et qu'elle table je vais avoir besoin?
-- 3ème ligne : condition,quel est le champs en commun dans les 2 tables qui me permet d'effectuer la jointure.
                                            
-- Une jointure des possible dans tous les cas.
-- Une requête imbriquée est possible seulement dans le cas où le résultat est issue de la même table
SELECT date_sortie,date_rendu FROM emprunt WHERE id_abonne IN (SELECT id_abonne FROM abonne WHERE prenom = 'Guillaume');
------------------------------------------------------------------------------------------------------------------------------
-- Nous aimerions connaitre les mouvements des livres (date_sortie et date_rendu) écrit par Alphonse Daudet
SELECT e.date_rendu,e.date_sortie,l.auteur
FROM emprunt e , livre l
WHERE e.id_livre = l.id_livre
AND l.auteur = "ALPHONSE DAUDET";
-- On peut écrire la 1ere ligne SELECT biblio.emprunt.date_rendu, biblio.date_sortie, biblio.livre.auteur
SELECT date_rendu , date_sortie FROM emprunt WHERE id_livre IN ( SELECT id_livre FROM livre WHERE auteur ='ALPHONSE DAUDET');
------------------------------------------
-- Qui a emprunté le livre 'une vie' sur l'année 2014
SELECT a.prenom
FROM livre l , emprunt e , abonne a
WHERE e.id_abonne = a.id_abonne AND l.id_livre = e.id_livre
AND l.titre='Une vie'
AND e.date_sortie LIKE '2014%';
--- requête imbriquée----
SELECT prenom FROM abonne WHERE id_abonne IN ( SELECT id_abonne FROM emprunt WHERE date_sortie LIKE '2014%' AND id_livre IN ( SELECT id_livre FROM livre WHERE titre ='Une vie') );
-------------------------------------------------------------
-- Nous aimerions connaître le nombre de livre(s) emprunté par chaque abonné
SELECT COUNT(e.id_livre) AS 'nombre de livres empruntés',a.prenom,a.id_abonne
FROM emprunt e , abonne a 
WHERE a.id_abonne = e.id_abonne
GROUP BY a.prenom; 
-------------------------------------------------------------
-- Nous aimerions connaître le nombre de livre(s) à rendre pour chaque abonné
SELECT COUNT(e.id_livre) AS'Nombre de livre à rendre',a.prenom,a.id_abonne
FROM emprunt e,abonne a
WHERE a.id_abonne = e.id_abonne
AND e.date_rendu IS NULL
GROUP BY a.prenom;
-----------------------------------------------------------------------------
-- Qui a emprunté Quoi ? Quand ? (Titres des livres empruntés , à quelle date, et savoir par qui).
SELECT a.prenom,e.date_sortie,l.titre
FROM emprunt e, abonne a, livre l
WHERE a.id_abonne = e.id_abonne AND l.id_livre = e.id_livre;
-------------------------------------------------------------------------------
-- Afficher les prénoms des abonnés avec le n° des livres qu'ils ont empruntés.
SELECT a.prenom,e.id_livre
FROM emprunt e,abonne a
WHERE a.id_abonne = e.id_abonne;
------------------------------------------------------------------------------------
INSERT INTO  abonne (id_abonne,prenom) VALUES(5,'Omar');
----------------------------------------------------------------------------
-- Relancer la dernière jointure , vous n'apparaissez pas....
SELECT abonne.prenom,emprunt.id_livre
FROM abonne
LEFT JOIN emprunt ON abonne.id_abonne = emprunt.id_abonne;
-- La clause LEFT JOIN permet de rappatrier toutes les données dans la table considéré comme étant de gauche(donc abonné dans notre cas) sans correspondance exigée dans l'autre table (emprunt). C'est ce que l'on appelle une jointure externe.
--  permet de collecter des informations archivées
