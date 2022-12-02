/* set global log_bin_trust_function_creators = 1;
da eseguire come utente root per i privilegi */

create table if not exists studente_audit like studente;
/* creo una tabella vuota studente_audit con la stessa struttura di studente */

alter table studente_audit
add action char(6) after id, 
add studente_id int after action,
add ins_record timestamp after data_nascita,
drop index email;
/* ne modifico i campi */

create trigger before_studente_update	/* nome trigger */
before update on studente				/* si attiva prima di update su studente */
for each row
insert into studente_audit				/* inserisce in studente_audit */
set action = "update",
studente_id = old.id,					/* vecchi valori prima dell'update */
nome = old.nome,
cognome = old.cognome,
genere = old.genere,
indirizzo = old.indirizzo,
citta = old.citta,
provincia = old.provincia,
regione = old.regione,
email = old.email,
data_nascita = old.data_nascita,
ins_record = old.ins;
/* per ogni record aggiornato in studente il trigger ne crea una copia in studente_audit contenente i vecchi valori */

update studente
set regione = "piemonte"
where id >= 28;

select * from jato69.studente_audit;
/* controllo che i valori siano stati inseriti nella nuova tabella */

create trigger after_studente_delete 	
after delete on studente				/* si attiva dopo cancellazioni su studente */
for each row
insert into studente_audit				
set action = "delete",
studente_id = old.id,					
nome = old.nome,
cognome = old.cognome,
genere = old.genere,
indirizzo = old.indirizzo,
citta = old.citta,
provincia = old.provincia,
regione = old.regione,
email = old.email,
data_nascita = old.data_nascita,
ins_record = old.ins;
/* per ogni record cancellato da studente il trigger ne crea una copia in studente_audit contenente i vecchi valori */

delete from studente
where id >= 33;

select * from jato69.studente_audit;
/* controllo che i valori siano stati inseriti nella nuova tabella */


delete from ordine_dettaglio;

update articolo set rimanenza = 100;
update cliente set credito = 0;

select * from articolo;
select * from cliente;

delimiter $$
create trigger after_od_insert
after insert on ordine_dettaglio
for each row
begin /* trigger complesso */
	/* aggiornao rimanenza in articolo */
	update articolo
    set rimanenza = rimanenza - new.quantita	/* rimanenza = rimanenza - la nuova quantità aggiunta negli ordini */
    where id = new.articolo_id;
    
    /* aggiorno credito in cliente */
    update cliente c
    set credito = credito + (new.quantita * new.prezzo) /* credito = credito + nuovi crediti ottenuti con l'ordine */
    where c.id = ( /* cliente_id corrispondente all'ordine */
		select o.cliente_id from ordine o 
        where new.ordine_id = o.id
	);
end$$
delimiter ;
/* dopo ogni insert in ordine_dettaglio aggiorna rimanenze e crediti */

insert into ordine_dettaglio(ordine_id, articolo_id, quantita, prezzo)
value(3,1,10,350);
/* il cliente associato all'ordine riceve i crediti */

select * from ordine_dettaglio;
select * from cliente;

delete from ordine_dettaglio
where ordine_id = 3  /* old.ordine_id */
and articolo_id = 1; /* old.articolo_id */
/* il cliente associato all'ordine perde i crediti */

DELIMITER $$
create trigger after_od_delete
after delete on ordine_dettaglio
for each row
begin
	/* aggiornao rimanenza in articolo */
    update articolo
    set rimanenza = rimanenza + old.quantita
    where id = old.articolo_id;

    /* aggiorno credito in cliente */
    update cliente c
    set credito = credito - (old.quantita * old.prezzo)
    where c.id = (
        select o.cliente_id from ordine o
        where old.ordine_id = o.id
    );
end$$
DELIMITER ;
/* dopo ogni cancellazione in ordine_dettaglio aggiorna rimanenze e crediti */

DELIMITER $$
create trigger before_od_update
before update on ordine_dettaglio
for each row
begin
	/* aggiornao rimanenza in articolo */
    update articolo
    set rimanenza = rimanenza - (new.quantita - old.quantita)
    where id = old.articolo_id;

    /* aggiorno credito in cliente */
    update cliente c
    set credito = credito + ((new.quantita - old.quantita) * new.prezzo)
    where c.id = (
        select o.cliente_id from ordine o
        where new.ordine_id = o.id
    );
end$$
DELIMITER ;
/* prima di ogni delete in ordine_dettaglio aggiorna rimanenze e crediti */

insert into ordine_dettaglio(ordine_id, articolo_id, quantita, prezzo)
value(3,1,10,350);

update ordine_dettaglio 
set quantita = 20 
where ordine_id = 3 and articolo_id = 1;
/* aumentando la quantità nell'ordine aumenta i crediti del cliente associato */

select * from ordine_dettaglio;
select * from cliente;

update ordine_dettaglio
set quantita = 5
where ordine_id = 3 and articolo_id = 1;
/* riducendo la quantità nell'ordine riduce i crediti del cliente associato */

select * from ordine_dettaglio;
select * from cliente;