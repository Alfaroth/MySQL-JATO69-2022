select nome
from catalogo_libri.editore e
where exists
	(select editore_id from catalogo_libri.libro where editore_id = e.id);
-- equivale a
select distinct nome
from catalogo_libri.editore e
join catalogo_libri.libro l
on l.editore_id = e.id;

select nome
from catalogo_libri.editore e
where not exists
	(select editore_id from catalogo_libri.libro where editore_id = e.id);
-- equivale a
select nome
from catalogo_libri.editore e
left join catalogo_libri.libro l
on l.editore_id = e.id
where l.editore_id is null;