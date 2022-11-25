-- calcolate il numero di libri editi da mondadori
select count(*) `Libri Mondadori`
from libro, editore
where libro.editore_id = editore.editore_id
and editore.nome = "Mondadori";

-- calcolate il valore del catalogo libri
select sum(prezzo) `Valore catalogo libri`
from libro;

-- calcolate età media degli studenti, restituendo un valore intero
select round(avg(eta)) `Età media`
from studente;

-- seleziona gli studenti e l'email creando un attributo in cui rappresentate il nome completo
-- es 'Marco Rossi' | 'marco_rossi@gmail.com'
select concat("'", nome, " ", cognome, "'", " | ", "'", email, "'")
from studente;

-- sostituite nella tabella studenti gli indirizzi contenenti 'Corso '  con 'Viale '
update studente
set indirizzo = replace(indirizzo,"Corso ","Viale ");

-- selezionare nome,cognome,email, data_nascita degli studenti mostrando della data di nascita solo l'anno
select nome, cognome, email, year(data_nascita) `anno di nascita`
from studente;

-- selezionare nome,cognome,email, data_nascita degli studenti mostrando la data di nascita nel formato italiano
select nome, cognome, email, date_format(data_nascita, "%d-%m-%Y") `data di nascita`
from studente;

/*
inserite nella tabella articolo, l'articolo seguente:
descrizione: Canon 7d
specifiche: marca: canon, modello: 7d, schermo: lcd, peso: 1.5 kg, sensore: CMOS, rapporto: 3:2, fullframe: no, uscite: hdmi mmini, mini jack stero
*/
insert into articolo(descrizione,specifiche)
values(
	'Canon 7D',
	'{
		"marca": "Canon",
        "modello": "7D",
        "pesoKg": 1.5,
        "schermo": "LCD",
        "sensore": "CMOS",
        "rapporto": "3:2",
        "fullframe": "no",
        "uscite": ["Mini HDMI", "Mini Jack Stereo"]
	}'
);

-- selezionate la marca dalla tabella articolo, estraendola dalla colonna json
select json_extract(specifiche, '$.marca') `Marca`
from articolo;

-- selezionate cognome, nome  degli autori e indicate se l'autore è 'Italiano' o 'Straniero'. Usare funzione if 
select cognome, nome,
if (nazionalita = "it", "Italiano", "Straniero") `Nazionalità`
from autore
order by `Nazionalità`;
