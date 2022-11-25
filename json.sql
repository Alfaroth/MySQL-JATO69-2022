create table if not exists articolo (
	id int auto_increment primary key,
	descrizione varchar(100),
	specifiche json
);

insert into articolo(descrizione,specifiche)
values(
	'TV Samsung 32" Smart TV',
	'{
		"marca": "Samsung",
        "pesoKg": 5.12,
        "schermo": "LCD",
        "pollici": 32,
        "uscite": ["HDMI", "USB"]
	}'
);

insert into articolo(descrizione,specifiche)
values(
	'TV Sony 32" Smart TV',
    json_object(
		"marca", "Sony",
        "pesoKg", 6.5,
        "schermo", "LED",
        "pollici", 32,
        "uscite", "HDMI"
	)
);

insert into articolo(descrizione,specifiche)
values(
	'TV Philips 55" Smart TV',
    json_object(
		"marca", "Philips",
		"pesoKg", 9.5,
		"schermo", "LED",
		"pollici", 55,
		"uscite", json_array("HDMI", "RCA", "USB", "Coaxial", "SCART")
	)
);

select json_extract(specifiche, '$.uscite') from articolo;
select specifiche -> '$.uscite' from articolo;	/* scorciatoia */

select json_extract(specifiche, '$.uscite[2') from articolo;	/* posizione con indice 2 dell'array */
select specifiche -> '$.uscite[2]' from articolo;	/* scorciatoia */

update articolo
set specifiche =
json_set(
	specifiche,
    '$.marca', 'LG',
    '$.uscite', json_array(
					"HDMI", "S/PDIF", "SCART"
				),
	'$.ingressi', json_array(
					   "Ethernet", "USB"
				  )
)
where id = 1;

update articolo
set specifiche = 
json_insert(
	specifiche,
	"$.uscite[3]", "RGB"
)
where id = 1;

update articolo
set specifiche = 
json_replace(
	specifiche,
	"$.marca", "Sony"
)
where id = 1;

update articolo
set specifiche = 
json_remove(
	specifiche,
	"$.uscite[0]"
)
where id = 1;
