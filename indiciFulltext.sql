create fulltext index k_title_content on posts(title, content); -- dà un warning in console per la creazione di una nuova tabella usata per l'indice fulltext

select * from posts
where match(title, content) against("react redux"); -- match(colonne in cui cercare) against(stringa da cercare)
-- restituisce i record contenenti nei campi title e contenti i valori ricercati, in ordine di pertinenza

select *, match(title, content) against ("react redux") peso -- peso restituisce l'indice di pertinenza sulla ricerca effettuata
from posts;

select *, match(title, content) against ("react redux") peso
from posts
where match(title, content) against ("react redux"); -- esclude i risultati con peso 0

select *, match(title, content) against("gestione dello stato è un problema") peso
from posts
where match(title, content) against("gestione dello stato è un problema"); -- esclude i risultati con peso 0

select *, match(title, content) against('"gestione dello stato è un problema"') peso -- usando '" "' restituisce SOLO i risultati che contengono la stringa esatta
from posts
where match(title, content) against('"gestione dello stato è un problema"'); -- esclude i risultati con peso 0

select *, match(title, content) against("react -redux +stato" in boolean mode) peso -- attraverso boolean mode posso escludere (-) o includere (+) un termine
from posts
where match(title, content) against("react -redux +stato" in boolean mode) 
having peso > 0
order by peso;