/*
USARE LA SINTASSI JOIN
seleziona il titolo, le pagine, il prezzo e l'editore
il cui editore è 'bompiani' e ordinate per titolo
*/
select titolo, pagine, prezzo, nome
from libro
inner join editore
on editore_id = editore.id
where nome = "Bompiani"
order by titolo;

/*
seleziona il titolo, le pagine, il prezzo e l'editore
il cui prezzo è inferiore di 10 euro e ordinate per prezzo
*/
select titolo, pagine, prezzo, nome
from libro
inner join editore
on editore_id = editore.id
where prezzo < 10
order by prezzo;

/*
seleziona il titolo, le pagine, il prezzo, il nome e il cognome dell'autore
la cui nazionalità è 'en' o 'it' e ordinate per nazionalita
*/
select titolo, pagine, prezzo, nome, cognome
from libro
inner join autore_libro
on  libro.id = autore_libro.libro_id
inner join autore
on autore_libro.autore_id = autore.id
where nazionalita in ("en", "it")
order by nazionalita;

/*
seleziona il titolo e il nome dell'editore
mostrando anche gli editori per i quali non esistono libri a catalogo
*/
select titolo, nome
from libro
right join editore
on editore_id = editore.id;

/*
seleziona gli editori
per i quali non esistono libri a catalogo
*/
select nome
from editore
left join libro
on editore.id = editore_id
where editore_id is null;

/*
seleziona nome, cognome degli alunni e il nome dell'aula assegnata
ordina per aula
*/
select alunno.nome, cognome, aula.nome
from alunno
inner join aula
on aula_id = aula.id
order by aula.nome;

/*
seleziona nome dell'aule per le quali non sono stati assegnati gli alunni
ordina per aula
*/
select aula.nome
from aula
left join alunno
on aula.id = aula_id
where aula_id is null
order by aula.nome;