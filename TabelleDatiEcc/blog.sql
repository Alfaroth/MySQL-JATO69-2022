create table if not exists users(
    id int auto_increment,
    username varchar(50) not null unique ,
    user_password varchar(40) not null,
    first_name varchar(30) not null,
    last_name varchar(50) not null,
    email varchar(100) not null unique,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    primary key(id) 
);

create table if not exists posts(
    id int auto_increment,
    title varchar(255) not null,
    content longtext not null,
    date_publish TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id int,
    constraint fk_posts_users
    foreign key(user_id) references users(id)
    on delete cascade on update cascade,
    primary key(id)
);

create table if not exists comments(
    id int auto_increment,
    firstname_author varchar(30),
    lastname_author varchar(50),
    email_author varchar(100) not null,
    message_txt text,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    post_id int,
    constraint fk_comments_posts
    foreign key(post_id) references posts(id)
    on delete cascade on update cascade,
    primary key(id) 
);

create table if not exists terms(
    id int auto_increment,
    label varchar(30) not null,
    taxonomy enum('category', 'tag') not null,
    primary key(id) 
);

create table if not exists posts_terms(
    id int auto_increment,
    post_id int,
    term_id int,
    constraint fk_posts_terms_posts
    foreign key(post_id) references posts(id)
    on delete cascade on update cascade,
    constraint fk_posts_terms_terms
    foreign key(term_id) references terms(id)
    on delete cascade on update cascade,
    primary key(id) 
);

INSERT INTO users
	(username,user_password,first_name,last_name,email)
VALUES
	('bigold','vecchione','oscar','vecchione','oscar.vecchione@icloud.com');

INSERT INTO posts
  (title, content, user_id)
VALUES
  ('Gestione di un form in React', 'Le applicazioni Web spesso devono inviare dati dal browser al server back-end. Certamente, il modo più utilizzato per farlo è attraverso un form HTML, utilizzando input di testo, pulsanti di opzione, caselle di controllo, selezioni e così via. Questo rimane vero in React. Stai cercando come gestire i moduli in React? Se è così, questo articolo è perfetto per te. Buona lettura.', 1),
  ('Quale framework JavaScript dovresti imparare per ottenere un lavoro nel 2019?', 'Ti stai chiedendo quale framework o libreria JavaScript dovresti usare per ottenere un lavoro nel 2019? In questo post, esaminerò un confronto tra i framework JavaScript più popolari disponibili oggi. Entro la fine di questo post, sarai pronto per scegliere il framework giusto per aiutarti a ottenere un lavoro di sviluppatore front-end nel 2019.', 1),
  ('Costruire un componente modale React accessibile', 'Modal è un overlay sulla pagina web, ma ha alcuni standard da seguire. Le pratiche di authoring WAI-ARIA sono gli standard stabiliti dal W3C. Ciò consente a bot e lettori di schermo di sapere che si tratta di un modale. Non rientra nel flusso regolare della pagina. Creeremo una fantastica modalità di reazione usando i componenti React.', 1),
  ('Redux Vs. Mobx – Cosa dovrei scegliere per la mia app Web?', 'La gestione dello stato è un problema difficile da risolvere nelle applicazioni di grandi dimensioni. Redux e Mobx sono entrambe librerie esterne comunemente utilizzate per risolvere problemi di gestione dello stato.', 1),
  ('Componenti stateful e stateless in reazione', 'Oggi esamineremo quali componenti con stato e senza stato sono in React, come puoi distinguere e il complesso processo per decidere se rendere i componenti con stato o meno.',1);