/* 1) selezionate il valore del magazzino */

/*
+------------------+
| Valore magazzino |
+------------------+
| 340.573,50       |
+------------------+
*/

select sum(prezzo*rimanenza) `valore magazzino`
from articolo;

/* 2) selezionate il valore del magazzino diviso per categoria */

/*
+-----------+------------------+
| categoria | Valore magazzino |
+-----------+------------------+
| hardware  | 106.676,00       |
| software  | 233.897,50       |
+-----------+------------------+
*/

select categoria, sum(prezzo*rimanenza) `valore magazzino`
from articolo
group by categoria;

/* 3) selezionate la quantità articoli ordinati divisi per descrizione, ordinati per quantità discendente */

/*
+-------------+----------+
| descrizione | ordinati |
+-------------+----------+
| chiavetta   |       16 |
| monitor     |       13 |
| Webcam      |        6 |
| hard-disk   |        6 |
| Office      |        5 |
| smartwatch  |        4 |
| Photoshop   |        2 |
+-------------+----------+
*/

select descrizione, sum(quantita) ordinati
from articolo, ordine_dettaglio
where articolo.id = ordine_dettaglio.articolo_id
group by descrizione
order by ordinati desc;

/* 4) selezionate la quantità di articoli ordinati divisi per categoria */

/*
+-----------+----------+
| categoria | ordinati |
+-----------+----------+
| hardware  |       45 |
| software  |        7 |
+-----------+----------+
*/

select categoria, sum(quantita) ordinati
from articolo, ordine_dettaglio
where articolo.id = ordine_dettaglio.articolo_id
group by categoria;

/* 5) selezionate gli articoli ordinati e la quantità relativa dell’ ordine con id=7 */

/*
+-------------+----------+
| descrizione | quantita |
+-------------+----------+
| chiavetta   |        5 |
| hard-disk   |        2 |
| Webcam      |        1 |
+-------------+----------+
*/

select descrizione, sum(quantita) quantita
from articolo, ordine_dettaglio
where ordine_id = 7 and articolo.id = ordine_dettaglio.articolo_id
group by descrizione;

/* 6) selezionate il valore degli ordini: totale denaro speso dai clienti  */

/* 
+---------------+
| Valore ordini |
+---------------+
| 12.126,50     |
+---------------+
*/

select sum(prezzo*quantita) `valore ordini`
from ordine_dettaglio;

/* 7) selezionate cognome e email dei clienti che hanno effettuato ordini */

/*
+----------+----------------------+
| cognome  | email                |
+----------+----------------------+
| bianchi  | luca2@gmail.com      |
| esposito | francoe@icloud.com   |
| rossi    | paolo25@gmail.com    |
| rosso    | alberto12@icloud.com |
+----------+----------------------+
*/

select cognome, email
from cliente, ordine
where cliente.id = ordine.cliente_id
group by cognome;

/* 8) selezionate l'ordine, la data dell'ordine e il nome del cliente che ha effettuato ordine */

/*
+----------+----+------------+
| cognome  | id | data       |
+----------+----+------------+
| bianchi  |  2 | 2018-01-11 |
| bianchi  |  4 | 2018-01-23 |
| bianchi  | 12 | 2018-02-28 |
| esposito |  5 | 2018-02-03 |
| esposito |  7 | 2018-02-13 |
| rossi    |  1 | 2017-12-01 |
| rosso    |  3 | 2018-01-21 |
+----------+----+------------+
*/

select cognome, ordine.id, data 
from ordine, cliente
where cliente.id = ordine.cliente_id;

/* 9) selezionate i clienti e il denaro speso in totale da ciascuno */

/*
+----------+---------+
| cognome  | Speso   |
+----------+---------+
| rossi    |  242.50 |
| bianchi  | 7670.50 |
| rosso    |  785.00 |
| esposito | 3428.50 |
+----------+---------+
*/

select cognome, sum(quantita*prezzo) speso
from cliente, ordine_dettaglio, ordine
where cliente.id = ordine.cliente_id
and ordine.id = ordine_dettaglio.ordine_id
group by cognome;