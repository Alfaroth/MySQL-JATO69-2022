select avg(prezzo) "prezzo medio"
from libro;

select count(*) "quanti"	/* numero di entries */
from studente;

update studente
set citta = null
where id = 20 or id = 21;

select count(citta) "quanti"	/* non considera i valori null */
from studente;

select count(*) "quanti"	
from studente
where citta is null;

select count(*) quanti
from studente
where genere = "m";

select count(*) quanti
from studente
where genere = "f";

select max(prezzo) "il più caro", min(prezzo) "il più economico"
from libro;

select sum(prezzo) "valore catalogo"
from libro;

select prezzo, floor(prezzo) "intero basso" , ceiling(prezzo) "intero alto"	/* intero inferiore e superiore */
from libro
order by prezzo desc;

select titolo, prezzo, round(prezzo)	/* arrotondamento a intero */
from libro
order by prezzo desc;

select titolo, prezzo, round(prezzo, 1)	/* arrotondamento a prima cifra decimale */
from libro
order by prezzo desc;

select avg(prezzo) "prezzo medio", round(avg(prezzo), 2) "prezzo medio arrotondato"
from libro;

select cognome, length(cognome) "lunghezza"
from studente;

select concat(cognome, " ", nome, " ", email, " " , data_nascita)
from studente;
/* stesso risultato */
select concat_ws(" ", cognome, nome, email, data_nascita)	/* usa " " come separatore tra gli altri campi */
from studente;

select nome, substring(nome, 2, 5)	/* sottostringa dalla posizione 2 di lunghezza 5 */
from studente;

select nome, left(nome, 1), right(nome, 1) 	/* estrae un carattere da sinistra e da destra */
from studente;

select concat(left(nome,1), ".", cognome)
from studente;

/* media di caratteri di nome e cognome nella tabella */
select avg(length(nome)+length(cognome))
from studente;

insert into studente(nome,cognome,genere,email)
values("Marco","Rossi","m","marco_rossi@gmail.com");

select last_insert_id();	/* valore auto_increment di id dell'ultima fila inserita o aggiornata in una tabella */

insert into editore(nome,email)
values("Garzanti", "infogarzanti@gmail.com");

insert into libro(titolo,prezzo,pagine,editore_id)
values("La Coscienza di Zeno",20.00,300,last_insert_id());	/* utilizzabile come valore per un campo */
/* assegna a editore_id del nuovo libro l'id assegnato all'editore aggiunto nella query precedente */

update studente
set email = replace(email,".com",".it");	/* sostituisce le occorrence di ".com" nei campi email con ".it" */

update studente
set email = replace(email,".it",".com");

select now();		/* data e ora attuale */
select curdate();	/* data attuale */
select curtime();	/* ora attuale */

insert into studente(nome,cognome,email,data_nascita)
values("Pippo", "Franco", "pipfra@gmail.com", curdate());	/* utilizzabile come valore per un campo */

select cognome, data_nascita,month(data_nascita) mese	/* estrae il mese dalla data selezionata */
from studente;

select hour(curtime());			/* estrae  l'ora dall'orario attuale */
select dayofweek(curdate());	/* estrae il numero del giorno della settimana dalla data attuale (partendo dalla domenica) es. mercoledì = 4 */
select month(curdate());		/* estrae il numero del mese dalla data attuale */
select dayname(curdate());		/* estrae il nome del giorno della settimana dalla data attuale */
select monthname(curdate());	/* estrae il nome del mese dalla data attuale */

select date_format(curdate(), "%d/%m/%Y");		/* 02/11/2022 */
select date_format("2017-02-28", "%d/%m/%y");	/* 28/02/22 */
select date_format(curdate(), "%d %M %Y");		/* 02 November 2022 */

select time_format("17:50:00", "%H:%i:%s");		/* 17:50:00 */
select time_format("17:50:00", "%h:%i:%s");		/* 05:50:00 */
select time_format("17:50:00", "%h:%i %p");		/* 05:50 PM */

select cognome,data_nascita, date_format(data_nascita, "%d-%m-%Y")
from studente;

select @@lc_time_names;		/* formato orario utilizzato nel database */

set lc_time_names = "it_IT";	/* cambio formato orario */

select str_to_date(concat_ws(",","05","10","1969"),"%d,%m,%Y");	/* permette di convertire una data nel giusto formato per il database */

insert into studente(nome,cognome,email,data_nascita)
values("Oscar","Vecchione","anskat@mac.com", str_to_date(concat_ws(",","05","10","1969"),"%d,%m,%Y"));

select adddate(curdate(), 6);					/* data tra 6 giorni */
select adddate(curdate(), interval 6 month);	/* data tra 6 mesi */
select adddate(curdate(), interval 6 year);		/* data tra 6 anni */
select subdate(curdate(), interval 6 year);		/* data 6 anni fa */
/* altro modo */
select timestampadd(year,1,curdate());			/* data tra 1 anno */
select timestampadd(week,1,curdate());			/* data tra 1 settimana */

select addtime(curtime(), "00:10:00");			/* ora tra 10 minuti */
select subtime(curtime(), "00:10:00");			/* ora 10 minuti fa */

select datediff("2022-11-02","2022-10-02");			/* giorni tra le due date */
select timestampdiff(year,"1969-10-05",curdate());	/* anni tra le due date */
select timestampdiff(month,"1969-10-05",curdate());	/* mesi tra le due date */

update studente
set eta = timestampdiff(year, data_nascita, curdate());		/* calcolo l'età con la differenza in anni tra la data di nascita e la data attuale */

insert into studente(nome, cognome, genere, email, data_nascita, eta)
values("Peppe", "Giostra","m","peppegiostra@gmail.com","1992-05-05",timestampdiff(year,data_nascita,curdate()));	

select 
	cognome,
    data_nascita,
    timestampdiff(year,data_nascita,curdate()) eta
from studente
order by eta desc;

select 
	cognome, 
	data_nascita, 
    dayofyear(data_nascita)-dayofyear(curdate()) giorni	/* giorni mancanti (o trascprso, in negativo) alla data di nascita */
from studente
where dayofyear(data_nascita)-dayofyear(curdate()) between 0 and 31					/* selezioni solo gli studenti che compieranno gli anni entro 31 giorni */
/* having giorni between 0 and 31 */					   /* "having" invece di "where" permette di utilizzare l'alias definito nel select come condizione */
order by giorni desc;

select if(1<2,"vero","falso"); 	/* if(condizione, istruzione se true, istruzione se false) */

select cognome, if(provincia="to", "sede", "fuori sede") Sede
from studente;

select provincia,
case provincia
when "to" then "Torino"
when "at" then "Asti"
when "al" then "Alessandria"
when "cn" then "Cuneo"
when "no" then "Novara"
when "mi" then "Milano"
/* restituisce null per Bergamo bg siccome non è coperto da una condizione */
end `Provincia completa`	/* alt+96 `` per definire alias */
from studente;

select provincia,
case provincia
when "to" then "Torino"
when "at" then "Asti"
when "al" then "Alessandria"
when "cn" then "Cuneo"
when "no" then "Novara"
when "mi" then "Milano"
when "bg" then "Bergamo"
end `Provincia completa`
from studente
order by `Provincia completa`;

select titolo, prezzo,
case
	when prezzo < 5 then "Economico"
	when prezzo >= 5 and prezzo < 10 then "Prezzo medio"
	when prezzo >= 10 then "Caro"
    end Valore
from libro
order by prezzo;

select cognome, nome, data_nascita `Data di nascita`,
case 
	when year(data_nascita) < "1980" then "Gen X"
    when year(data_nascita) >= "1980" and year(data_nascita) < "1995" then "Millennial"
    when year(data_nascita) >= "1995" then "Gen Z"
	when year(data_nascita) is null then "Manca la data"
    end Generazione
from jato69.studente	/* avendo i privilegi su entrambi i db non ho bisogno di selezionare manualmente il database prima di eseguire la query */
order by `Data di nascita`;

select distinct cognome		/* restituisce tutti i cognomi senza ripetizioni */
from jato69.studente;
/* altro modo */
select cognome
from jato69.studente
group by cognome;

select count(genere)
from jato69.studente
where genere = "f";

select count(genere) 
from jato69.studente
where genere = "m";

/* in una singola query */
select genere, count(genere) Quanti
from jato69.studente
group by genere
order by Quanti;

/*con ulteriori filtri */
select genere, eta, count(genere) Quanti
from jato69.studente
where provincia = "bg"
group by genere
having eta > 30
order by Quanti;

select e.nome Editore, count(*) Quanti
from libro l
join editore e
on e.editore_id = l.editore_id
group by Editore
having Quanti > 1
order by Quanti desc;

select genere, round(avg(eta))
from studente 
group by genere;

select nome, sum(prezzo)  tot
from libro
join editore 
on editore.editore_id = libro.editore_id
group by nome
order by tot;

select aula.nome, count(*) Quanti
from aula join alunno
on alunno.aula_id = aula.id
group by aula.nome;

select e.nome Editore,
	count(*) Quanti,
    sum(prezzo) Valore,
    round(avg(prezzo),2) `Prezzo medio`,
    max(prezzo) `Più caro`,
    min(prezzo) `Più economico`
from libro l
join editore e
on e.editore_id = l.editore_id
group by Editore
order by Quanti desc;

select provincia, genere, count(genere) numero
from jato69.studente
group by provincia, genere
having numero > 1
order by provincia, genere;

select provincia, genere, count(*) quanti
from jato69.studente
group by provincia, genere;
/* con istruzione with rollup */
select provincia, genere, count(*) quanti
from jato69.studente
group by provincia, genere
with rollup; /* produce ulteriori righe con subtotali o totali a seconda dei raggruppamenti costruiti */
/* in questo caso la riga ulteriore segna il totale m + f per ogni provincia */