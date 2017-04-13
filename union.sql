SELECT auteur AS 'Liste personne physique' FROM livre UNION SELECT prenom FROM abonne;
-- permet d'afficher les prénoms des abonnés dans la même liste que les noms des auteurs

-- permet de fusionner 2 colonnes entre elles
-- Union permet de fusionner 2 résultats dans une même liste de résultats