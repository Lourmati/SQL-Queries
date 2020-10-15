
--Creation des tables

CREATE TABLE EDITION (
idEdition number(6) PRIMARY KEY,
nom varchar2(40) NOT NULL,
telephone varchar2(20),
fax varchar2(20),
pays varchar2(20));

CREATE TABLE JOURNAL (
idJournal number(8) PRIMARY KEY,
nomJournal varchar2(100) NOT NULL,
idEdition number(6),
annee number(4),
proprietaire varchar2(100),
CONSTRAINT fk_journal_idEdition FOREIGN KEY (idEdition)
REFERENCES EDITION (idEdition));

CREATE TABLE ARTICLE (
idArticle number(8) PRIMARY KEY,
idJournal number(8) NOT NULL,
titre varchar2(200) NOT NULL,
pageDebut number(4),
pageFin number(4),
volume number(4),
serie number(3),
CONSTRAINT fk_article_idJournal FOREIGN KEY (idJournal)
REFERENCES JOURNAL (idJournal));

CREATE TABLE AUTEUR(
idAuteur number(8) PRIMARY KEY,
nomAuteur varchar2(60) NOT NULL,
prenom varchar2(60) NOT NULL,
email varchar2(80),
siteWeb varchar2(150));

CREATE TABLE ORGANISME(
idOrganisme number(6) PRIMARY KEY,
nom varchar2(512) NOT NULL,
telephone varchar2(20),
pays varchar2(20));

CREATE TABLE LIVRE(
idLivre number(8) PRIMARY KEY,
titre varchar2(80) NOT NULL,
idEdition number(6),
annee number(4),
nbrePage number(4),
CONSTRAINT fk_livre_idEdition FOREIGN KEY (idEdition)
REFERENCES EDITION (idEdition));

CREATE TABLE MOTCLES(
idMot number(6) PRIMARY KEY,
mot varchar2(40) NOT NULL,
descriptif varchar2(80));

CREATE TABLE ARTICLE_AUTEUR(
idArticle number(8) NOT NULL,
idAuteur number(8) NOT NULL,
CONSTRAINT pk_article_auteur PRIMARY KEY (idArticle, idAuteur),
CONSTRAINT fk_article_auteur_idArticle FOREIGN KEY (idArticle) REFERENCES ARTICLE (idArticle),
CONSTRAINT fk_article_auteur_idAuteur FOREIGN KEY (idAuteur) REFERENCES AUTEUR (idAuteur));

CREATE TABLE AUTEUR_ORGANISME(
idAuteur number(8) NOT NULL,
idOrganisme number(6) NOT NULL,
CONSTRAINT pk_auteur_organisme PRIMARY KEY (idAuteur, idOrganisme),
CONSTRAINT fk_auteurorganisme_idAuteur2 FOREIGN KEY (idAuteur)
REFERENCES AUTEUR (idAuteur),
CONSTRAINT fk_auteurorganisme_idOrganisme FOREIGN KEY (idOrganisme)
REFERENCES ORGANISME (idOrganisme));

CREATE TABLE LIVRE_AUTEUR(
idLivre number(8) NOT NULL,
idAuteur number(8) NOT NULL,
CONSTRAINT pk_livre_auteur PRIMARY KEY (idLivre, idAuteur),
CONSTRAINT fk_livreauteur_idLivre FOREIGN KEY (idLivre)
REFERENCES LIVRE (idLivre),
CONSTRAINT fk_livreauteur_idAuteur FOREIGN KEY (idAuteur)
REFERENCES AUTEUR (idAuteur));

CREATE TABLE ARTICLE_MOTCLES(
idArticle number(8) NOT NULL,
idMot number(6) NOT NULL,
CONSTRAINT pk_article_motcles PRIMARY KEY (idArticle, idMot),
CONSTRAINT fk_articlemotcles_idArticle FOREIGN KEY (idArticle)
REFERENCES ARTICLE (idArticle),
CONSTRAINT fk_articlemotcles_idMot FOREIGN KEY (idMot)
REFERENCES MOTCLES (idMot));

--Suppression des tables
--DROP TABLE ARTICLE_MOTCLES;
--DROP TABLE LIVRE_AUTEUR;
--DROP TABLE AUTEUR_ORGANISME;
--DROP TABLE ARTICLE_AUTEUR;
--DROP TABLE MOTCLES;
--DROP TABLE LIVRE;
--DROP TABLE ORGANISME;
--DROP TABLE AUTEUR;
--DROP TABLE ARTICLE;
--DROP TABLE JOURNAL;
--DROP TABLE EDITION;
