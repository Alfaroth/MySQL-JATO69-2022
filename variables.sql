show variables;

select @@lc_time_names;
select @@foreign_key_checks;
select @@log_bin_trust_function_creators;

set lc_time_names = "it_IT";

select @@lc_time_names;

set @mediaPrezzo = (select avg(prezzo) from catalogo_libri.libro);
/* memorizzo la media dei prezzi del catalogo_libri nella variabile @mediaPrezzo */

select @mediaPrezzo;

select * from catalogo_libri.libro
where prezzo > @mediaPrezzo;
/* equivale a */
select * from catalogo_libri.libro
where prezzo > (select avg(prezzo) from catalogo_libri.libro);

set @testNome = "Dave";
select @testNome;

select * from performance_schema.user_variables_by_thread;
/* elenco variabili dichiarate - necessita privilegi */

