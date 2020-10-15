--Question 2.2
INSERT INTO AUTEUR(IDAUTEUR, NOMAUTEUR, PRENOM, EMAIL, SITEWEB)
VALUES (17, 'Lourhmati', 'Oussama', 'lourhmati@gmail.com','https://www.w3schools.com');

--Question 2.3
INSERT INTO AUTEUR(IDAUTEUR, NOMAUTEUR, PRENOM)
VALUES (18, 'Trump', 'Donald');

--Question 2.4
DELETE FROM AUTEUR 
WHERE idauteur in (17,18);

--Question 2.5 
UPDATE EDITION
SET EDITION.nom = INITCAP (EDITION.nom);

--Question 3.1
SELECT nom nom_editeur
FROM EDITION;

--Question 3.2
SELECT DISTINCT pays pays_edition
FROM EDITION;

--Question 3.3
SELECT titre titre_article
FROM ARTICLE
ORDER BY titre;

--Question 3.4
SELECT *
FROM livre
WHERE annee > 1990;

--Question 3.5
SELECT *
FROM journal
WHERE UPPER(nomjournal) like UPPER('%pattern%');

--Question 3.6
SELECT nomauteur, siteweb
FROM AUTEUR
WHERE siteweb IS NOT NULL;

--Question 3.7
SELECT COUNT(idjournal) nombre_journaux
FROM JOURNAL;

--Question 3.8
SELECT titre titre_article, (pagefin - pagedebut) nombre_pages
FROM ARTICLE;

--Question 3.9
SELECT ARTICLE.idarticle, ARTICLE.idjournal, article_auteur.idauteur
FROM ARTICLE
JOIN ARTICLE_AUTEUR ON ARTICLE.idarticle = ARTICLE_AUTEUR.idarticle
JOIN AUTEUR ON article_auteur.idauteur = auteur.idauteur
WHERE auteur.nomauteur = 'Adams';

--Question 3.10
SELECT ARTICLE.titre, journal.nomjournal
FROM ARTICLE
JOIN JOURNAL ON article.idjournal = journal.idjournal;

--Question 3.11
SELECT *
FROM AUTEUR
LEFT JOIN LIVRE_AUTEUR ON LIVRE_AUTEUR.IDAUTEUR = AUTEUR.IDAUTEUR
WHERE AUTEUR.IDAUTEUR NOT IN (SELECT IDAUTEUR FROM LIVRE_AUTEUR);

--Question 3.12
SELECT *
FROM ARTICLE
JOIN article_motcles ON article.idarticle = article_motcles.idarticle
JOIN motcles ON article_motcles.idmot = motcles.IDMOT
WHERE MOTCLES.MOT LIKE '%segmentation%';

--Question 3.13
SELECT *
FROM AUTEUR
JOIN ARTICLE_AUTEUR ON auteur.idauteur = article_auteur.idauteur
JOIN ARTICLE ON article_auteur.idarticle = article.idarticle
JOIN JOURNAL ON article.idjournal = journal.idjournal
WHERE journal.nomjournal LIKE 'Information Processing Letters';

--Question 3.14
SELECT edition.nom, livre.annee
FROM EDITION
JOIN LIVRE ON edition.idedition = livre.idedition
WHERE LIVRE.ANNEE > (SELECT EXTRACT(YEAR FROM SYSDATE) - 33
FROM DUAL);

--Question 3.15
SELECT *
FROM EDITION
JOIN JOURNAL ON edition.idedition = journal.idedition
JOIN LIVRE ON edition.idedition = livre.idedition
WHERE edition.idedition IN (SELECT IDEDITION FROM JOURNAL)
AND edition.idedition IN (SELECT IDEDITION FROM LIVRE);

--Question 3.16
SELECT ARTICLE.TITRE, JOURNAL.NOMJOURNAL
FROM ARTICLE
JOIN JOURNAL ON ARTICLE.IDJOURNAL = journal.idjournal
ORDER BY journal.annee
FETCH FIRST ROW ONLY;

--Question 3.17
SELECT auteur.nomauteur, article.titre
FROM AUTEUR
JOIN ARTICLE_AUTEUR ON article_auteur.idauteur = auteur.idauteur
JOIN ARTICLE ON ARTICLE_AUTEUR.IDARTICLE = article.idarticle
WHERE article.titre IN (
SELECT ARTICLE.TITRE
FROM ARTICLE
JOIN ARTICLE_AUTEUR ON article.idarticle = ARTICLE_AUTEUR.IDARTICLE
GROUP BY ARTICLE.TITRE
HAVING COUNT(ARTICLE_AUTEUR.IDAUTEUR) = 2)
GROUP BY AUTEUR.NOMAUTEUR, ARTICLE.TITRE
ORDER BY ARTICLE.TITRE;

--Question 3.18 
SELECT COUNT(LIVRE.IDLIVRE) NOMBRE_LIVRE, auteur.nomauteur
FROM AUTEUR
JOIN LIVRE_AUTEUR ON livre_auteur.idauteur = auteur.idauteur
JOIN LIVRE ON livre.idlivre = livre_auteur.idlivre
GROUP BY auteur.nomauteur;

--Question 3.19
SELECT AUTEUR.IDAUTEUR, AUTEUR.NOMAUTEUR, COUNT(organisme.idorganisme) NOMBRE_ORGANISMES
FROM AUTEUR
JOIN AUTEUR_ORGANISME ON AUTEUR.IDAUTEUR = AUTEUR_ORGANISME.IDAUTEUR
JOIN ORGANISME ON auteur_organisme.idorganisme = organisme.idorganisme
GROUP BY auteur.nomauteur, AUTEUR.IDAUTEUR;

--Question 3.20 
SELECT DISTINCT AUTEUR.NOMAUTEUR, COUNT(ARTICLE_AUTEUR.IDARTICLE) NOMBRE_ARTICLES
FROM AUTEUR
JOIN auteur_organisme ON auteur.idauteur = auteur_organisme.idauteur
JOIN ORGANISME ON AUTEUR_ORGANISME.idorganisme = organisme.idorganisme
JOIN ARTICLE_AUTEUR ON auteur.idauteur = article_auteur.idauteur
WHERE organisme.pays LIKE 'Canada'
GROUP BY auteur.nomauteur, organisme.nom;  

--Question 3.21
SELECT article.titre
FROM ARTICLE
JOIN ARTICLE_MOTCLES ON article.idarticle = article_motcles.idarticle
JOIN motcles ON article_motcles.idmot = motcles.idmot
GROUP BY article.titre
HAVING COUNT(motcles.mot)=2;

--Question 3.22
SELECT livre.titre
FROM livre
JOIN LIVRE_AUTEUR ON livre.idlivre = livre_auteur.idlivre
JOIN AUTEUR ON livre_auteur.idauteur = auteur.idauteur
GROUP BY LIVRE.TITRE
HAVING COUNT(AUTEUR.NOMAUTEUR) > 2;