/* aggiungo chiave esterna che blocca l'eliminazione */
alter table libro
add constraint fk_libro_editore
foreign key(editore_id) references editore(id);

/* test 01 - blocca l'eliminazione */
delete from editore where id = 1;

/* mostro la foreign key */
show create table libro;

/* elimino la fk per ricrearla con altra regola */
alter table libro drop foreign key fk_libro_editore;

alter table libro
add constraint fk_libro_editore
foreign key(editore_id) references editore(id)
on delete cascade on update cascade;

/* test 02 - anche nella tabella libro vengono cancellati gli autori con id = 1 */
delete from editore where id = 1;

/* aggiungo le fk su autore_libro */
alter table autore_libro
add constraint fk_al_libro
foreign key (libro_id) references libro(id),
add constraint fk_al_autore
foreign key (autore_id) references autore(id);
/* blocca l'eliminazione di libri e autori se vi sono riferimenti in autore_libro */

/*
set foreign_key_checks = 0;

truncate autore; 
truncate autore_libro; 
truncate editore; 
truncate libro;

set foreign_key_checks = 1;
*/

select table_name, column_name, constraint_name, referenced_table_name, referenced_column_name
from informationn_schema.key_column_usage
where table_schema = "catalogo_libro"
and referenced_column_name is null;

insert into libro(titolo, prezzo, pagine, editore_id)
values("A volte basta un gatto", 17.00, 334, 1);

insert into editore(nome, email)
values("Feltrinelli", "feltrinelli@gmail.com");

insert into libro(titolo, prezzo, pagine, editore_id)
values("L'interpretazione dei sogni", 35.00, 600, 20);