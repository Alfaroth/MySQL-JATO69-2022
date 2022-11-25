/*NUOVE TABELLE
Nel database jato69 create 2 tabelle: aula e alunno:

La tabella aula ha i seguenti attributi:
nome, capienza, piano
i campi devono essere tutti obbligatori */
create table if not exists aula(
	id int auto_increment,
    nome varchar(2) not null unique,
    capienza tinyint not null,
    piano varchar(20) not null,
    primary key(id)
);

/* i nomi delle aule sono: 1a, 2a, 3a;
la capienza per ciascuna aula è di 10 alunni;
i piani sono rispettivamente: 1° piano, 2°piano , seminterrato;

inserite i record relativi alle aule:
1A, 10, 1° piano;
2A, 10, 2°piano;
3A, 10, seminterrato; */
insert into aula values 
(1, '1A', 10, '1° piano'),
(2, '2A', 10, '2° piano'),
(3, '3A', 10, 'seminterrato');

/*La tabella alunno ha i seguenti attributi:
cognome, nome, genere, eta, aula_id
i campi cognome, nome, eta devono essere obbligatori; */
create table if not exists alunno(
	id int auto_increment,
	cognome varchar(30) not null,
    nome varchar(20) not null,
    genere enum('m','f'),
    eta tinyint not null,
    aula_id int,
    primary key(id),
    foreign key(aula_id) references aula(id)
);

/* inserite 15 alunni, 5 per ogni aula
gli alunni della prima hanno 11 anni,
quelli della seconda 12 e quelli della terza 13
(5 alunni per la classe 1a, 5 alunni per la classe 2a e 5 alunni per la classe 3a) 

l'aula_id riporta l'id dell'aula a cui sono stati assegnati gli alunni
per esempio i record degli alunni di 11 anni saranno assegnati alla 1a;*/
insert into alunno values
(1, 'Dalla', 'Mirko', 'm', 11, 1),
(2, 'Canali', 'Ninetta', 'f', 11, 1),
(3, 'Bertoni', 'Gilberto', 'm', 11, 1),
(4, 'Sagnelli', 'Costanzo', 'm', 11, 1),
(5, 'Paolini', 'Mattia', 'm', 11, 1),
(6, 'Trotta', 'Daniele', 'm', 12, 2),
(7, 'Bartoli', 'Sonia', 'f', 12, 2),
(8, 'Borsellino', 'Amalia', 'f', 12, 2),
(9, 'Condoleo', 'Umberto', 'm', 12, 2),
(10, 'Bertoni', 'Ornella', 'f', 12, 2),
(11, 'Longhena', 'Gianpaolo', 'm', 13, 3),
(12, 'Mercati', 'Natalia', 'f', 13, 3),
(13, 'Totino', 'Totino', 'm', 13, 3),
(14, 'Romano', 'Angelo', 'm', 13, 3),
(15, 'Traversa', 'Fortunata', 'f', 13, 3);

/* dopo aver creato le tabelle e inserito i record scrivete le 3 query seguenti:

seleziona il cognome, il nome, il genere, piano aula di tutti gli studenti */
select cognome, alunno.nome, genere, piano
from alunno, aula
where alunno.aula_id = aula.id;

/* seleziona il cognome, il nome, il genere, piano aula degli studenti assegnati alla 1A */
select cognome, alunno.nome, genere, piano
from alunno, aula
where alunno.aula_id = 1
and alunno.aula_id = aula.id;

/* seleziona il cognome, il nome, il genere, piano aula degli studenti assegnati alla 2A */
select cognome, alunno.nome, genere, piano
from alunno, aula
where alunno.aula_id = 2
and alunno.aula_id = aula.id;

/* seleziona il cognome, il nome, il genere, piano aula degli studenti assegnati alla 3A */
select cognome, alunno.nome, genere, piano
from alunno, aula
where alunno.aula_id = 3
and alunno.aula_id = aula.id;

/* MODIFICHE ALLA TABELLA STUDENTE 

rendete gli attributi 'nome', 'cognome' e 'genere' obbligatori; */
alter table studente
modify column nome varchar(20) not null,
modify column cognome varchar(30) not null,
modify column genere enum('m', 'f') not null,
/* modificate l'attributo regione in modo che possa ospitare al massimo 25 caratteri; */
modify column regione varchar(25);

/* AGGIORNAMENTI NELLA TABELLA STUDENTE 

aggiornate l'indirizzo, la citta, la provincia e la regione dello studente 'mauro bruni' con i valori seguenti:
indirizzo: viale Torino 18
citta: milano
provincia: mi
regione: lombardia */
update studente set indirizzo = 'viale Torino 18', citta = 'milano', provincia = 'mi', regione = 'lombardia'
where nome = 'mauro' and cognome = 'bruni';

/* aggiornate per tutti i record con citta = 'torino' la citta, la provincia e la regione con i valori seguenti: bergamo, bg e lombardia*/
update studente set citta = 'bergamo', provincia = 'bg', regione = 'lombardia'
where citta = 'torino';









