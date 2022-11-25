/*
DATABASE jato69
seleziona il cognome, il nome, l'email e la data di nascita
dalla tabella studente
il cui cognome è uguale a 'verdi' e ordinate per nome
*/
select cognome, nome, email, data_nascita
from studente
where cognome = "verdi"
order by nome;

/*
seleziona il cognome, il nome, l'email e la data di nascita
dalla tabella studente
il cui genere è femmina e ordinate per cognome
*/
select cognome, nome, email, data_nascita
from studente
where genere = "f"
order by cognome;

/*
seleziona il cognome, il nome, l'email e la data di nascita
dalla tabella studente
il cui genere è maschio e la provincia è cuneo e ordinate per cognome
*/
select cognome, nome, email, data_nascita
from studente
where genere = "m" 
and provincia = "cn"
order by cognome;

/*
seleziona il cognome, il nome, l'email e la data di nascita
dalla tabella studente
la cui data di nascita è compresa tra il 1980 e il 1990
e il cui genere è femmina e ordinate per data di nascita dalla più recente alla più remota
*/
select cognome, nome, email, data_nascita
from studente
where data_nascita between "1980-01-01" and "1990-12-31"
and genere = "f"
order by data_nascita desc;

/*
seleziona il cognome, il nome, l'email e la data di nascita
dalla tabella studente
la cui provincia è cuneo o asti o novara e ordinate per provincia
*/
select cognome, nome, email, data_nascita
from studente
where provincia = "cn" or provincia = "at" or provincia = "no"
order by provincia;

/*
seleziona il cognome, il nome, l'email e la data di nascita
dalla tabella studente
il cui cognome inizia per 'r' e ordinate per nome
*/
select cognome, nome, email, data_nascita
from studente
where cognome like "r%"
order by nome;

/*
seleziona il cognome, il nome, l'email e la data di nascita
dalla tabella studente
il cui cognome inizia per 'v' o 'd' ed è seguito dalla lettera 'e' e ordinate per cognome
*/
select cognome, nome, email, data_nascita
from studente
where cognome regexp "^[vd]e"
order by cognome;

/*
DATABASE catalogo libro
seleziona il titolo, le pagine, il prezzo e l'editore
il cui editore è 'bompiani' e ordinate per titolo
*/
select titolo, pagine, prezzo, nome
from libro, editore
where nome = "bompiani"
and editore.id = libro.editore_id
order by titolo;

/*
seleziona il titolo, le pagine, il prezzo e l'editore
il cui prezzo è inferiore di 10 euro e ordinate per prezzo
*/
select titolo, pagine, prezzo, nome
from libro, editore
where prezzo < 10
and editore.id = libro.editore_id
order by prezzo;

/*
seleziona il titolo, le pagine, il prezzo e l'editore
il cui prezzo è inferiore di 10 euro e l'editore è 'mondadori' e ordinate per prezzo
*/
select titolo, pagine, prezzo, nome
from libro, editore
where prezzo < 10
and nome = "mondadori"
and editore.id = libro.editore_id
order by prezzo;

/*
seleziona il titolo, le pagine, il prezzo e l'editore
il cui titolo comincia per 'il' o 'la' e ordinate per prezzo
*/
select titolo, pagine, prezzo, nome
from libro, editore
where titolo regexp "^il|^la" and editore.id = libro.editore_id
order by prezzo;

/*
seleziona il titolo, le pagine, il prezzo, il nome e il cognome dell'autore
la cui nazionalità è 'en' o 'it' e ordinate per nazionalita
*/
select titolo, pagine, prezzo, autore.nome, autore.cognome
from libro, autore, autore_libro
where nazionalita in ("en","it") 
and autore_id = autore.id 
and libro_id = libro.id
order by nazionalita;

/*
seleziona il titolo, le pagine, il prezzo, il nome e il cognome dell'autore
il cui cognome comincia per 'c' e ordinate per nazionalita
*/
select titolo, pagine, prezzo, autore.nome, autore.cognome
from autore, libro, autore_libro
where libro.id = autore_libro.libro_id 
and autore.id = autore_libro.autore_id
and autore.cognome like "c%"
order by nazionalita;

/*
seleziona il titolo, le pagine, il prezzo, l'editore e il cognome dell'autore
e ordinate per titolo
*/
select titolo, pagine, prezzo, editore.nome, autore.cognome
from libro, autore, editore, autore_libro
where autore.id = autore_libro.autore_id
and libro.id = autore_libro.libro_id
and libro.editore_id = editore.id
order by titolo;

/*
seleziona il titolo, le pagine, il prezzo, l'editore e il cognome dell'autore
il cui prezzo è maggiore di 10 euro
e ordinate per prezzo dal più caro al più economico
*/
select titolo, pagine, prezzo, editore.nome, autore.cognome
from libro, autore, editore, autore_libro
where autore.id = autore_libro.autore_id
and libro.id = autore_libro.libro_id
and libro.editore_id = editore.id
and prezzo > 10
order by prezzo desc;