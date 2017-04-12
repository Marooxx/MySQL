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
                                        