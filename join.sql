alter table alunno
add constraint fk_alunno_aula
foreign key(aula_id) references aula(id)
on delete set null
on update cascade;

/*
alter table alunno
drop foreign key fk_alunno_aula;
*/

delete from aula
where id = 1;
/* i campi aula_id degli studenti con campo aula_id = 1 diventano null */

select stato, capitale from americhe
union
select stato, capitale from asia
union
select stato, capitale from europa
order by stato;
/* stampa tutte e 3 le tabelle */

select cognome, nome, data_nascita, "Generation X" generazione
from studente where data_nascita < "1981-01-01"
union
select cognome, nome, data_nascita, "Millennials" generazione
from studente where data_nascita between "1981-01-01" and "1996-12-31"
union
select cognome, nome, data_nascita, "Generation Z" generazione
from studente where data_nascita > "1996-12-31"
order by data_nascita;

select titolo, nome
from libro l, editore e
where e.id = l.editore_id;
/* stesso risultato con join */
select titolo, nome
from libro l
inner join editore e 	/* valori in comune */
on e.id = l.editore_id;

select al.nome, cognome, au.nome
from alunno al, aula au
where al.aula_id = au.id;
/* stesso risultato con join */
select al.nome, cognome, au.nome
from alunno al
inner join aula au
on al.aula_id = au.id;

/*
left join  = valori della tabella a sinistra con oppure senza corrispondenze in quella a destra
inner join = valori in comune su tutte le tabelle
right join = valori della tabella a destra con oppure senza corrispondenza in quella a sinistra
full outer join = estrae tutti i valori oppure quelli che non hanno corrispondenze su tutte le tabelle
*/

/* solo i libri con editore assegnato */
select titolo, nome
from libro l
left join editore e
on editore_id = e.id;

/* tutti gli editori anche senza libri assegnati */
select titolo, nome
from libro l
right join editore e
on editore_id = e.id;

/* tutte le aule anche senza studenti assegnati */
select al.nome, cognome, au.nome
from aula au
left join alunno al
on au.id = al.aula_id;

/* tutti gli alunni anche senza aula assegnata */
select al.nome, cognome, au.nome
from aula au
right join alunno al
on au.id = al.aula_id;

/* solo le aule senza studenti assegnati */
select alunno.nome, cognome, aula.nome
from aula
left join alunno
on aula.id = aula_id
where aula_id is null;

/* solo gli alunni senza aule assegnate */
select alunno.nome, cognome, aula.nome
from aula
right join alunno
on aula.id = aula_id
where aula_id is null;

/* --------------- FULL OUTER JOIN --------------- */
/* tutte le aule e tutti gli alunni */

/* tutte le aule anche senza studenti assegnati */
select al.nome, cognome, au.nome
from aula au
left join alunno al
on au.id = al.aula_id

union

/* tutti gli alunni anche senza aula assegnata */
select al.nome, cognome, au.nome
from aula au
right join alunno al
on au.id = al.aula_id;

/* --------------- FULL OUTER JOIN --------------- */
/* aule senza studenti e studenti senza aule */

/* solo le aule senza studenti assegnati */
select alunno.nome, cognome, aula.nome
from aula
left join alunno
on aula.id = aula_id
where aula_id is null

union

/* solo gli alunni senza aule assegnate */
select alunno.nome, cognome, aula.nome
from aula
right join alunno
on aula.id = aula_id
where aula_id is null;

create table if not exists impiegato (
	id int auto_increment,
    nome varchar(20),
    cognome varchar(30),
    ruolo varchar(50),
    id_resp int,
    stipendio decimal(6,2),
    ufficio_id int,
	primary key (id)
);

INSERT INTO impiegato (id, nome, cognome, ruolo, id_resp, stipendio, ufficio_id) VALUES
(1, 'Mario', 'Rossi', 'tecnico', NULL, '2500.00', 1),
(2, 'Marco', 'Bianchi', 'amministrativo', 7, '1600.00', 2),
(3, 'Paolo', 'Verdi', 'amministrativo', 7, '1600.00', 2),
(4, 'Enrico', 'Marrone', 'venditore', 8, '1300.00', 3),
(5, 'Nicola', 'Testa', 'venditore', 8, '1300.00', 3),
(6, 'Franco', 'Barba', 'tecnico', 1, '1500.00', 1),
(7, 'Elena', 'Totti', 'amministrativo', NULL, '2600.00', 2),
(8, 'Paola', 'Capra', 'venditore', NULL, '2300.00', 3),
(9, 'Mauro', 'Barba', 'venditore', 8, '1300.00', 3);

/* uso la stessa tabella come se fossero due tabelle diverse per rappresentare i rapporti impiegato-responsabile */
select i.cognome, i.nome, i.ruolo, r.cognome	/* r.cognome = cognome del responsabile */
from impiegato i		/* impiegato */
join impiegato r	/* responsabile */
on r.id = i.id_resp		/* id_resp sono gli id degli impiegati assegnati come responsabili ad altri impiegati */
order by i.ruolo;

/* stessa query con left join: elenco anche i responsabili, ovvero gli impiegati senza responsabili assegnati */
select i.cognome, i.nome, i.ruolo, r.cognome	
from impiegato i		
left join impiegato r	
on r.id = i.id_resp		
order by i.ruolo;

/* rinomino la colonna id di editore in editore_id */
alter table editore
rename column id to editore_id;

/* rinomino la colonna id di libro in libro_id */
alter table libro 
rename column id to libro_id;

select titolo, nome
from libro
join editore
using(editore_id);	/* uso il campo in comune editore_id in comune tra le due tabelle */