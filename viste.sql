-- la vista non è una tabella ma una query memorizzata 
create or replace view studente_v as 
select nome, cognome, genere, indirizzo, citta, provincia, regione, email, data_nascita, eta
from studente;

select cognome, genere from studente_v;

show create view studente_v; -- mostra la query utilizzata per creare la vista

insert into studente_v(nome, cognome, genere, email, data_nascita) -- viene inserito nella tabella studente
values("Giuseppina", "Verdi", "f", "giuse_green@gmail.com", "1990-02-05");

select * from studente_v;
-- equivale a
select * 
from (select nome, cognome, genere, indirizzo, citta, provincia, regione, email, data_nascita, eta 
	  from studente) as tbl;

select * from studente; -- controllo che il nuovo studente sia stato inserito nella tabella

-- vista complessa: non posso fare operazioni di data manipulation language
create or replace view libro_tot as
select 
	l.titolo Titolo, 
    round(l.prezzo * 1.22, 2) Prezzo /* calcolo il prezzo con IVA */, 
    concat (a.nome, " ", a.cognome) Autore,
    a.nazionalita `Nazionalità`,
    e.nome Editore
from libro l
join editore e on l.editore_id = e.editore_id
join autore_libro al on al.libro_id = l.id
join autore a on a.id = al.autore_id
order by Titolo;

select * from libro_tot where `Nazionalità` = "it"; -- posso quindi fare select sulla vista senza dover eseguire join tra più tabelle ogni volta

select * from autore;
update autore set cognome = "Futteri" where id = 18; -- modifico il cognome dell'autore con id=18 in "Futteri"
select * from libro_tot; -- anche nella vista libro_tot appare la modifica effettuata in autore

alter table studente drop eta; -- cancello la colonna eta in studente
select * from studente_v; -- dà errore perché ho modificato una colonna utilizzata nella query della vista

create or replace view studente_v as -- sostituisco la vista con una nuova query che non include eta
select nome, cognome, genere, indirizzo, citta, provincia, regione, email, data_nascita
from studente;

select * from studente_v; -- ora funziona

/* DA ESEGUIRE EFFETTUANDO L'ACCESSO COME UTENTE ROOT -------------------------------------------------------------*/
create user "ospite"@"localhost" identified by "ospite";
grant select on jato69.studente_v to "ospite"@"localhost"; -- l'utente ospite può leggere solo la vista studente_v
/*-----------------------------------------------------------------------------------------------------------------*/


/* DA ESEGUIRE EFFETTUANDOO L'ACCESSO SUL NUOVO UTENTE OSPITE -----------------------------------------------------*/
select * from studente_v; -- posso eseguirla perché ospite ha i permessi di lettura
insert into studente_v(cognome, email) -- non posso eseguirla perché ospite non ha permessi di scrittura 
values("vecchio", "vecchius@gmail.com");
/*-----------------------------------------------------------------------------------------------------------------*/

create or replace view studente_v as 
select nome, cognome, genere, indirizzo, citta, provincia, regione, email, data_nascita
from studente
where provincia = "bg" -- aggiungo un filtro alla vista
with check option;

insert into studente_v(nome, cognome, genere, email, data_nascita, provincia) -- fallisce a causa del vincolo
values("Andrea", "Rossi", "m", "ar@gmail.com", "1990-02-05", "to");

create or replace view studente_v as -- rimuovo il filtro
select nome, cognome, genere, indirizzo, citta, provincia, regione, email, data_nascita
from studente
with check option;

insert into studente_v(nome, cognome, genere, email, data_nascita, provincia) -- ora funziona
values("Andrea", "Rossi", "m", "ar@gmail.com", "1990-02-05", "to");

drop view studente_v; -- elimino la vista studente_v

rename table libro_tot to catalogo_completo; -- rinomino la vista libro_tot