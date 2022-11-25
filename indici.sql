-- aggiunta indice durante creazione tabella
create table test(
	id int auto_increment,
    nome varchar(30),
    cognome varchar(50),
    index k_cogn(cognome),
    primary key(id)
);

-- aggiunta indice su tabella già esistente
alter table cliente add index k_prov(provincia);
-- oppure
create index k_prov on cliente(provincia);

-- filtered = efficacia filtraggio, rows = righe che ha dovuto leggere per filtrare il risultato finale
explain select * from cliente where provincia = "to";		-- con indice 100.00 filtered, 3 rows, filtra usando indice
/* drop index k_prov on cliente;
explain select * from cliente where provincia = "to"; */	-- senza indice 14.29 filtered, 7 rows, filtra usando where

-- filtered = efficacia filtraggio (max 100), rows = righe che ha dovuto leggere per filtrare il risultato finale

select * from cliente where provincia = "to" and credito > 100;
explain select * from cliente where provincia = "to" and credito > 100;		-- 33.33 filtered, 3 rows, filtra usando sia indice k_prov che where
-- filtered non è 100% perché dopo aver filtrato con l'indice ha dovuto leggere tutti i record estratti per controllare la condizione del where
create index k_prov_credito on cliente(provincia, credito); -- creo un nuovo indice composto da due campi
explain select * from cliente where provincia = "to" and credito > 100;		-- 100.00 filtered, 1 row, filtra usando indice

------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from anagrafica where sezioni_2011 = 89;

explain select * from anagrafica where sezioni_2011 = 89;

alter table anagrafica add index k_sezioni(sezioni_2011);
alter table anagrafica add index k_sezioni_area(sezioni_2011, area_statistica);

select * from anagrafica
where sezioni_2011 = 42
and area_statistica = "aeroporto";

drop index k_sezioni on anagrafica;

explain select * from anagrafica where sezioni_2011 = 42 and area_statistica = "aeroporto";