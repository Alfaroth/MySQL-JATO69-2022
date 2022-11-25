select stipendio from impiegato where id = 6;
-- restituisce 1500.00 e lo uso per la seconda query
select nome, cognome, stipendio
from impiegato
where stipendio > 1500.00
order by cognome;
-- in una sola query utilizzando subquery
select nome, cognome, stipendio
from impiegato
where stipendio > ( 
	select stipendio from impiegato where id = 6 -- stipendi dell'impiegato con id = 6
)
order by cognome;
-- impiegati con stipendio più alto dell'impiegato con id = 6

select nome, cognome, stipendio
from impiegato
where stipendio > ALL ( -- maggiore di tutti i valori restituiti dalla subquery
	select stipendio from impiegato where cognome = "Barba" -- stipendi degli impiegati con cognome "Barba"
) -- ALL serve perché la subquery restituisce più di un risultato
order by cognome;
-- impiegati con stipendio più alto di ogni impiegato con cognome "Barba"

select e.nome, l.titolo
from libro l
join editore e
on l.editore_id = e.id
where l.editore_id = (
	select max(editore_id) from libro -- id più alto (ultimo inserito)
);
-- libri relativi all'ultimo editore inserito nel db

select titolo, prezzo
from libro
where prezzo > 10.00
order by prezzo;
-- con subquery
select titolo, prezzo
from libro
where prezzo > (
	select avg(prezzo) from libro -- prezzo medio
)
order by prezzo;
-- libri con  prezzo sopra la media

select cognome, nome, stipendio
from impiegato 
where stipendio < (
	select avg(stipendio) from impiegato -- stipendio medio
)
order by stipendio;
-- impiegati con stipendio sotto la media

select u.nome, avg(stipendio) `stipendio medio`
from impiegato i
join ufficio u
on i.ufficio_id = u.id
group by i.ufficio_id
having `stipendio medio` >= ALL ( -- maggiore di tutti i valori restituiti dalla subquery
	select avg(stipendio) from impiegato group by ufficio_id -- stipendio medio per ogni tipo di ufficio
); 
-- ufficio con stipendio medio più alto

select cognome, impiegato.nome, ufficio.nome
from impiegato, ufficio
where ufficio.id = impiegato.ufficio_id 
and ufficio_id = ANY ( -- un qualsiasi id restituito dalla subquery
	select id from ufficio where regione = "Piemonte" -- uffici in Piemonte
);
-- impiegati che lavorano in Piemonte
	
select count(*)
from impiegato
where ufficio_id = ANY (
	select id from ufficio where regione = "Piemonte" -- uffici in Piemonte
);
-- quanti impiegati lavorano in Piemonte

select "Lombardia", count(*)
from impiegato 
where ufficio_id IN ( -- equivale a = ANY
	select id from ufficio where regione = "Lombardia" -- uffici in Lombardia
);
-- quanti impiegati lavorano in Lombardia

select cognome, nome, telefono
from cliente
where id IN (
	select cliente_id from ordine -- clienti che hanno effettuato ordini
);
-- equivale a
select distinct cognome, nome, telefono
from cliente c 
join ordine o 
on c.id = o.cliente_id;
-- dati dei clienti che hanno effettuato ordini

select cognome, nome, telefono
from cliente
where id not in (
	select cliente_id from ordine -- clienti che hanno effettuato ordini
);
-- equivale a
select cognome, nome, telefono
from cliente c 
left join ordine o 
on c.id = o.cliente_id
where o.cliente_id is null;
-- dati dei clienti che non hanno effettuato ordini

select nome, cognome
from amico
where row(nome, cognome) = (
	select nome, cognome from parente where id = 4
);

update articolo
set rimanenza = 100;
-- resetto la rimanenza di ogni articolo a 100
select sum(quantita)
from ordine_dettaglio
group by articolo_id;
-- quantità ordinata di ogni articolo
-- con subquery
update articolo a
set rimanenza = rimanenza - (
	select sum(quantita) 
    from ordine_dettaglio od
    where a.id = od.articolo_id 
    group by a.id 
);
-- setto la rimanenza di ogni articolo all'attuale rimanenza (100) - la somma delle loro quantità ordinate
-- il problema è che se la rimanenza è 100 viene settata a null perché 100-null viene considerata null, quindi risolvo con questo update:
update articolo set rimanenza = 100 where rimanenza = null;
-- per risolvere usando if in una singola query:
update articolo a
set rimanenza = if (
	-- condizione (se la quantità ordinata è > 0)
	(select sum(quantita)				
    from ordine_dettaglio od
    where a.id = od.articolo_id
    group by a.id) > 0,
    -- se true setto la rimanenza a 100 - quantità ordinata
    100 - (select sum(quantita)			
    from ordine_dettaglio od
    where a.id = od.articolo_id
    group by a.id),
    -- se false (l'articolo non è stato ordinato) setto la rimanenza a 100
    100									
);

select c.cognome, sum(od.prezzo*od.quantita) `spesa totale`
from ordine_dettaglio od
join ordine o on o.id = od.ordine_id
join cliente c on c.id = o.cliente_id
group by c.id
order by c.cognome;
-- spesa totale di ogni cliente
update cliente set credito = 0;
-- resetto a 0 il credito di tutti i clienti

update cliente c 
set credito = if (
	-- condizione (se la spesa totale è > 0)
	(select sum(prezzo*quantita) prezzo
	from ordine_dettaglio od
	join ordine o
	on o.id = od.ordine_id where c.id = o.cliente_id
	order by c.cognome) > 0,
	-- se true setto i crediti a al valore della spesa totale
	(select sum(prezzo*quantita) prezzo
	from ordine_dettaglio od
	join ordine o
	on o.id = od.ordine_id where c.id = o.cliente_id
	order by c.cognome),
	-- se false (nessun ordine) setto i crediti a 0
	0
);