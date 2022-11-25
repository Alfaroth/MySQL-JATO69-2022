select cognome, email, data_nascita
from studente
order by cognome desc
limit 0,10;		# visualizza 10 risultati dall'inizio

select cognome, email, data_nascita
from studente
order by cognome desc
limit 10,10;	# visualizza 10 risultati dalla decima posizione

select nome,cognome,genere,email,data_nascita
from studente
where genere = 'f'
order by cognome;

select nome,cognome,genere,email,data_nascita
from studente
where data_nascita < '1980-01-01'
order by data_nascita;

select nome,cognome,genere,provincia,email,data_nascita
from studente
where genere = 'm'
and provincia = 'cn'
order by data_nascita;

select nome,cognome,genere,provincia,email,data_nascita
from studente
where data_nascita between '1985-01-01' and '1994-12-31'	# include i valori inseriti
order by data_nascita;

select nome,cognome,genere,provincia,email,data_nascita
from studente
where data_nascita not between '1985-01-01' and '1994-12-31'	# esclude i valori inseriti
order by data_nascita;

update studente set data_nascita = null where id = 5;	# cancella data_nascita dello studente con id = 5
select nome,cognome,email,data_nascita
from studente
where data_nascita is null;
update studente set data_nascita = '1987-10-01' where id = 5;	# aggiorno data_nascita dello studente con id = 5

select nome, cognome, email
from studente 
where nome like 'm%'  # nomi che iniziano con 'm'
order by nome;

select nome, cognome, email
from studente 
where email like '%gmail.com'  # email che finiscono con 'gmail.com'
order by nome;

select nome, cognome, email
from studente 
where nome like 'mari_'  # '_' indica un singolo carattere
order by nome;

select nome, cognome, email
from studente 
where nome regexp 'ao'  # nomi che contengono 'ao' in qualsiasi posizione
order by nome;

select cognome, nome, email
from studente 
where nome regexp '^mar'  # nomi che iniziano con 'mar'
order by nome;

select nome, cognome, email
from studente 
where nome regexp 'co$'  # nomi che finiscono con 'co'
order by nome;

select nome, cognome, email
from studente 
where nome regexp 'mar|ara|gio'	# nomi che contengono 'mar' o 'ara' o 'ria' in qualsiasi posizione
order by nome;

select nome, cognome, email
from studente 
where nome regexp '^mar|ara|co$'	# nomi che contengono 'mar' all'inizio o 'co' alla fine o 'ara' in qualsiasi posizione
order by nome;

select nome, cognome, email
from studente 
where nome regexp 'a[ero]'	# nomi che contengono 'ae', 'ar' o 'ao' in qualsiasi posizione
order by nome;

select nome, cognome, email
from studente 
where nome regexp 'l[ao]$'	# nomi che contengono 'la' o 'lo' alla fine
order by nome;

select nome, cognome, email
from studente 
where nome regexp '[f-m]e'	# nomi che contengono 'fe', 'ge', 'he', 'ie', 'je', 'ke', 'le', 'me' in qualsiasi posizione
order by nome;