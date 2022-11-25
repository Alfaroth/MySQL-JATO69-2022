-- aggiornare tabella alunno modificando il valore di aula_id in null
-- per gli alunni con id = 5, 10, 15 (unica query)
update alunno
set aula_id = null
where id = 5 or id = 10 or id = 15;

-- aggiungere nella tabella aule
-- l'aula 1b, capienza 10 piano 1*
-- l'aula 2b, capienza 10 piano 2*
-- l'aula 3b, capienza 10 piano 3*
insert into aula (nome, capienza, piano)
values ("1B", 10, "1° piano"), ("2B", 10, "2° piano"), ("3B", 10, "3° piano");

-- create 3 tabelle: americhe, asia, europa
-- xogni tabella inserite gli attributi: stato e capitale
-- xogni tabella inserite almeno 3 record
create table if not exists americhe (
	id int auto_increment,
	stato varchar(40),
    capitale varchar(40),
    primary key (id)
);

create table if not exists asia 
like americhe;

create table if not exists europa 
like americhe;

insert into americhe (stato, capitale) 
values ("Utah", "Salt Lake City"), ("Alabama", "Montgomery"), ("Peru", "Lima");

insert into asia (stato, capitale) 
values ("Giappone", "Tokyo"), ("India", "Nuova Delhi"), ("Taiwan", "Taipei");

insert into europa (stato, capitale) 
values ("Italia", "Roma"), ("Germania", "Berlino"), ("Svezia", "Stoccolma");