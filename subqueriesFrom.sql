create or replace view libro_v as
select titolo Titolo, prezzo Prezzo, pagine Pagine
from libro
order by Titolo;

select * from libro_v;
-- equivale a
select * from (
	select titolo Titolo, prezzo Prezzo, pagine Pagine
	from libro
	order by Titolo
) pippo; -- alias che dobbiamo dare ad ogni tabella derivata

select od.ordine_id, sum(quantita) q_articoli
from ordine_dettaglio od
group by od.ordine_id
order by q_articoli desc;
-- quantità di articoli in ogni ordine

select min(q_articoli), avg(q_articoli), max(q_articoli)
from (
	select sum(quantita) q_articoli
	from ordine_dettaglio od
	group by od.ordine_id
	order by q_articoli desc
) pippo;
-- quantità minima, media e massima di articoli tra tutti gli ordini