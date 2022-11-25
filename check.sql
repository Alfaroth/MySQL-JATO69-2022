create table if not exists libro2 (
	id int auto_increment,
	titolo varchar(255),
    prezzo decimal(6,2),
    pagine smallint check (pagine > 0),
    editore_id int,
    primary key(id),
	constraint chk_prezzo check (prezzo > 0)
);

show create table libro2;

insert into libro2(titolo, prezzo, pagine, editore_id)
values ("Titolo test", 0, 0, 1); -- errore perché prezzo è 0

insert into libro2(titolo, pagine, prezzo, editore_id)
values ("Titolo test", 0, 0, 1); -- errore perché prezzo è 0

insert into libro2(titolo, pagine, prezzo, editore_id)
values ("Titolo test", 0, 10, 1); -- errore perché pagine è 0

insert into libro2(titolo, pagine, prezzo, editore_id)
values ("Titolo test", 100, 10, 1); -- errore perché il prezzo è 0 