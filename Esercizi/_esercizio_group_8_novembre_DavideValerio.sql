-- 1) Contate gli studenti divisi per genere
-- la tabelle risultante mostrerà i seguenti attributi
-- Genere, Quanti
select genere, count(*) quanti
from studente
group by genere;

-- 2) Contate gli studenti divisi per regione
-- la tabelle risultante mostrerà i seguenti attributi
-- Regione, Quanti
select regione, count(*) quanti
from studente
group by regione;

-- 3) Contate gli studenti divisi per genere solo della provincia di Bergamo
-- la tabelle risultante mostrerà i seguenti attributi
-- Genere, Quanti
select genere, count(*) quanti
from studente
where provincia = "bg"
group by genere;

-- 4) Contate gli impiegati divisi per ruolo
-- la tabelle risultante mostrerà i seguenti attributi
-- Ruolo, Quanti
select ruolo, count(*) quanti
from impiegato
group by ruolo;

-- 5) Contate gli alunni assegnati alle diverse aule
-- la tabelle risultante mostrerà i seguenti attributi
-- Nome aula, Numero studenti
select aula.nome `nome aula`, count(*) `numero studenti`
from aula, alunno
where aula.id = alunno.aula_id
group by aula.nome;

-- 6) Contate gli autori divisi per nazionalità
-- la tabelle risultante mostrerà i seguenti attributi
-- Nazionalità, Quanti
select nazionalita, count(*) quanti
from catalogo_libri.autore
group by nazionalita;

-- 7) Contate i libri per editore, e calocalate il valore dei libri contati
-- la tabelle risultante mostrerà i seguenti attributi
-- Editore, Quanti, Valore
select editore.nome editore, count(*) quanti, sum(prezzo) valore
from catalogo_libri.editore, catalogo_libri.libro
where editore.editore_id = libro.editore_id
group by editore;