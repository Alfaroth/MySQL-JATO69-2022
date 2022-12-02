select * from gestionale.ordine;

insert into gestionale.ordine_dettaglio
value(12,1,10,350.00);
insert into gestionale.ordine_dettaglio
value(5,2,20,38.5);

select * from gestionale.cliente;

drop trigger after_od_insert;
drop trigger before_od_delete;
drop trigger after_od_delete;

/* set global log_bin_trust_function_creators = 1;
da eseguire come utente root per i privilegi */

/* Trigger per insert ordine_dettaglio ------------------------------------------------------------------------------------------------------ */
delimiter $$
create trigger before_od_insert
before insert on ordine_dettaglio
for each row
begin
	declare spedizione enum("consegnato", "da spedire", "spedito");
    declare rimanenza_d tinyint;
    declare msg varchar(255);
    set spedizione = (select consegna from ordine where id = new.ordine_id);
    set rimanenza_d = (select rimanenza from articolo where id = new.articolo_id);
    
    if spedizione = "da spedire" /* condizione 1: se l'ordine è ancora da spedire */
	then
		if new.quantita <= rimanenza_d /* condizione 2: se ci sono abbastanza articoli rimasti */
		then
			update articolo
			set rimanenza = rimanenza_d - new.quantita /* aggiorna la rimanenza degli articoli ordinati */
			where id = new.articolo_id;
            
			update cliente c
			set credito = credito + (new.quantita * new.prezzo) /* aggiorna i crediti dell'utente relativo all'ordine */
			where c.id = (
				select o.cliente_id from ordine o
				where new.ordine_id = o.id
			);
                
		else /* se non ci sono abbastanza articoli rimasti */
            set msg = concat("Non ci sono abbastanza articoli in magazzino. Articoli in giacenza: ", rimanenza_d);
            signal sqlstate value "45000" /* messaggio di errore generico */
            set message_text = msg;
			
            end if; /* fine condizione 2 */
            
	else /* se l'ordine è già stato spedito o consegnato */
		signal sqlstate value "45000"
        set message_text = "Non puoi aggiornare l'ordine. Gli articoli sono già stati spediti.";
        
	end if; /* fine condizione 1 */

end$$
delimiter ;

select * from ordine_dettaglio;

insert into ordine_dettaglio 
value(12,9,1,120.00); /* cerchiamo di inserire articoli in un ordine già spedito */
/* errore: "Non puoi aggiornare l'ordine. Gli articoli sono già stati spediti." */

insert into ordine_dettaglio
value(3,9,120,120.00); /* cerchiamo di ordinare più articoli di quanti ne restano in magazzino */
/* errore: "Non ci sono abbastanza articoli in magazzino. Articoli in giacenza: 100" */

insert into ordine_dettaglio
value(3,9,10,120.00); /* cerchiamo di inserire articoli disponibili in un ordine ancora da spedire */
/* funziona - scala la quantità disponibile in magazzino e aggiorna i crediti del cliente relativo all'ordine */

select * from cliente;

/* Trigger per update ordine_dettaglio ------------------------------------------------------------------------------------------------------ */
delimiter $$
create trigger before_od_update
before update on ordine_dettaglio
for each row
begin
	declare spedizione enum("consegnato", "da spedire", "spedito");
    declare rimanenza_d tinyint;
    declare msg varchar(255);
    set spedizione = (select consegna from ordine where id = new.ordine_id);
    set rimanenza_d = (select rimanenza from articolo where id = new.articolo_id);
    
    if spedizione = "da spedire" /* condizione 1: se l'ordine è ancora da spedire */
	then
		if (new.quantita - old.quantita) <= rimanenza_d /* condizione 2: se ci sono abbastanza articoli rimasti */
		then
			update articolo
			set rimanenza = rimanenza_d - (new.quantita - old.quantita) /* aggiorna la rimanenza degli articoli ordinati */
			where id = old.articolo_id;
            
			update cliente c
			set credito = credito + ((new.quantita - old.quantita) * new.prezzo) /* aggiorna i crediti dell'utente relativo all'ordine */
			where c.id = (
				select o.cliente_id from ordine o
				where new.ordine_id = o.id
			);
                
		else /* se non ci sono abbastanza articoli rimasti */
            set msg = concat("Non ci sono abbastanza articoli in magazzino. Articoli in giacenza: ", rimanenza_d);
            signal sqlstate value "45000" /* messaggio di errore generico */
            set message_text = msg;
			
		end if; /* fine condizione 2 */
            
	else /* se l'ordine è già stato spedito o consegnato */
		signal sqlstate value "45000"
        set message_text = "Non puoi aggiornare l'ordine. Gli articoli sono già stati spediti.";
        
	end if; /* fine condizione 1 */

end$$
delimiter ;

/* Trigger per delete ordine_dettaglio ------------------------------------------------------------------------------------------------------ */
delimiter $$
create trigger before_od_delete
before delete on ordine_dettaglio
for each row
begin
	declare spedizione enum("consegnato", "da spedire", "spedito");
    declare rimanenza_d tinyint;
    declare msg varchar(255);
    set spedizione = (select consegna from ordine where id = old.ordine_id);
	set rimanenza_d = (select rimanenza from articolo where id = old.articolo_id);

    if spedizione = "da spedire" /* condizione: se l'ordine è ancora da spedire */
	then
		update articolo
		set rimanenza = rimanenza_d + old.quantita /* aggiorna la rimanenza degli articoli ordinati */
		where id = old.articolo_id;
        
		update cliente c
		set credito = credito - (old.quantita * old.prezzo) /* aggiorna i crediti dell'utente relativo all'ordine */
		where c.id = (
			select o.cliente_id from ordine o
			where old.ordine_id = o.id
		);
                
	else /* se l'ordine è già stato spedito o consegnato */
		signal sqlstate value "45000"
        set message_text = "Non puoi rimuovere gli articoli. Gli articoli sono già stati spediti.";
        
	end if; /* fine condizione 1 */

end$$
delimiter ;

update ordine_dettaglio 
set quantita = 20
where ordine_id = 12 and articolo_id = 1; /* cerchiamo di aggiornare gli articoli in un ordine già spedito */
/* errore: "Non puoi aggiornare l'ordine. Gli articoli sono già stati spediti." */

delete from ordine_dettaglio 
where ordine_id = 12 and articolo_id = 1; /* cerchiamo di rimuovere articoli da un ordine già spedito */
/* errore: "Non puoi rimuovere gli articoli. Gli articoli sono già stati spediti." */

update ordine_dettaglio
set quantita = 20
where ordine_id = 3 and articolo_id = 1; /* cerchiamo di aggiornare la quantità di articoli disponibili in un ordine non spedito */
/* funziona - scala la quantità disponibile in magazzino e aggiorna i crediti del cliente relativo all'ordine */

select * from cliente;

delete from ordine_dettaglio
where ordine_id = 3 and articolo_id = 1; /* cerchiamo di eliminare articoli da un ordine non spedito */
/* funziona - ripristina la quantità disponibile in magazzino e riduce i crediti del cliente relativo all'ordine */

select * from cliente;

/* Trigger per delete ordine ---------------------------------------------------------------------------------------------------------------- */
delimiter $$
create trigger before_ordine_delete
before delete on ordine
for each row
begin
	declare spedizione enum("consegnato", "da spedire", "spedito");
    set spedizione = (select consegna from ordine where id = old.id);
	
    if spedizione = "da spedire" /* condizione: se l'ordine è ancora da spedire */
    then
		delete from ordine_dettaglio /* cancello l'ordine */
        where ordine_id = old.id;
        
	else
		signal sqlstate value "45000"
        set message_text = "Non puoi eliminare l'ordine. Gli articoli sono già stati spediti.";
        
	end if;

end$$
delimiter ;
