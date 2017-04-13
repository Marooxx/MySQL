----------------------------- FONCTIONS PREDEFINIES --------------------------------------
-- Fonctions prédéfinies : prévu par le langage SQL et exécuté par le développeur. Elles permettent d'effectuer un traitement spécifique
SELECT DATABASE();-- Donne le nom de la base de donnée utilisée
SELECT VERSION();-- permet de connaître la version de mySQL
INSERT INTO abonne(prenom) VALUES('test');-- Ajout d'une donnée dans la table selectionnée
SELECT LAST_INSERT_ID();-- permet d'afficher le dernier identifiant inséré
SELECT CURDATE();-- donne la date du jour au format US année-mois-jour
SELECT CURTIME();-- retourne l'heure du moment 'HH:MM:SS'
SELECT DATE_FORMAT('2012-10-03 22:23:00','%d/%m/%Y-%H:%i:%s'); -- retourne la date modifiée 
                        |                    |                                                   Argument a modifie   Cet argument modifie l argument                                              avant la virgule
-- Pour toutes les fonctions prédéfinies, il est toujours important de consulter la documentation afin de savoir quels paramètres/arguments nous devons envoyer à notre fonction et surtout de savoir ce qu'elle retourne
SELECT*,DATE_FORMAT(date_rendu,'le %d/%m/%Y') AS'Date rendu' FROM emprunt;-- permet de modifier le format de la date
-- met mes dates au format français
SELECT DAYNAME('2017-04-13');-- affiche le jour d'une date en particulier
SELECT DAYOFYEAR('2017-04-13');-- affiche le numéro du jour de l'année
INSERT INTO abonne(prenom) VALUES(PASSWORD('mypass'));-- permet de crypter le mot de passe
SELECT LENGTH('test');-- calcul la taille de la chaîne de caractère
SELECT LOCATE('j','aujourd\'hui');-- donne la position de la lettre dans le mot en paramètre
SELECT SUBSTRING('bonjour',4);-- permet de couper un mot à partir d'un parametre. Ici le mot est coupé à partir du 4eme caractère
SELECT CONCAT_WS(",","Premier nom","Deuxième nom","troisième nom");-- indique quel élément on va mettre entre une série de mot ou chaîne de caractère.
-- la fonction CONCAT_WS() signifie CONCAT With Separator,c'est à dire "concaténation(suivi de ) avec séparateur.
SELECT CONCAT_WS(" ",id_abonne,prenom) AS 'LISte' FROM abonne; -- cela permet de regrouper 2 ou plusieurs colonnes
-- Liste des abonnés avec leur numéro dans une seule colonne
SELECT REPLACE('www.cdiscount.fr','w','W');-- remplace un caractère dans une chaîne de caractère par une autre.   |                 |   | caractère qui va modifier                                    élement a changer caractère qui va modifier
----------------------------------------------------------------------------------
-- Fonctions utilisateur : prévue , inscrite et exécute par le développeur pour un traitement spécifique

DELIMITER $-- permet de signaler que la fonction commence à cet endroit et qu'il ya plusieurs ";"
CREATE FUNCTION calcul_tva(nb INT) RETURNS TEXT
COMMENT 'Fonction permettant le calcul de la TVA'
READS SQL DATA-- on spécifie que l'on va juste afficher qqch sans modifs
BEGIN
    RETURN CONCAT_WS(':','le résultat est ',(nb*12));
END
$ DELIMITER;
SELECT calcul_tva(10);

DELIMITER $ 
CREATE FUNCTION calcul_tva(nb INT) RETURNS TEXT
COMMENT 'Fonction permettant le calcul de la TVA'
READS SQL DATA
BEGIN
    RETURN CONCAT_WS(':','le résultat est ',(nb*12));
END
$ DELIMITER;

SELECT calcul_tva(10);
-- CREATE FUNCTION permet de créer la fonction
-- calcul_tva représente le nom de notre fonction
-- RETURNS TEXT permet de préciser que la fonction renverra du texte
-- (nb INT) représente un argument(paramètre) entrant de type 'integer'(nombre)
-- COMMENT 'Fonction permettant le calcul de la TVA' commentaire d'accompagnement
-- READS SQL DATA permet d'indiquer au système que notre traitement ne fera que lire ( et non pas modifier,supprimer)
-- BEGIN début de nos instructions
-- RETURN CONCAT_WS(':','Le résultat est',(nb*1.2)); nous retournons le montant calculé avec la TVA
-- END fin des instructions
-- DELIMITER $ on change le délimiteur car en inscrivant la fonction , on devra inscrire des points virgules; alors qu'il ne s'agira pas de la fin de notre fonction.