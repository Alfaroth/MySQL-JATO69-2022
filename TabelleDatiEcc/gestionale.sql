
CREATE TABLE `articolo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(255) DEFAULT NULL,
  `prezzo` decimal(6,2) DEFAULT NULL,
  `categoria` enum('hardware','software') DEFAULT NULL,
  `rimanenza` tinyint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `articolo` VALUES (1,'monitor',350.00,'hardware',87),(2,'chiavetta',38.50,'hardware',75),(3,'hard-disk',300.00,'hardware',94),(4,'smartwatch',400.00,'hardware',96),(5,'Photoshop',700.00,'software',98),(6,'Office',350.50,'software',95),(7,'Webcam',68.00,'hardware',94),(8,'Adobe CC',1200.00,'software',100),(9,'Office',120.00,'software',100);

CREATE TABLE `cliente` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cognome` varchar(50) NOT NULL,
  `nome` varchar(40) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `indirizzo` varchar(100) NOT NULL,
  `citta` varchar(50) NOT NULL,
  `provincia` char(2) NOT NULL,
  `regione` varchar(30) NOT NULL,
  `credito` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
);

INSERT INTO `cliente` VALUES (1,'rossi','paolo','0116702323','paolo25@gmail.com','Via Roma 25','torino','To','Piemonte',107),(2,'mori','marco','0116704040','marco18@gmail.com','Via Torino 18','milano','Mi','Lombardia',0),(3,'bianchi','luca','0116701010','luca2@gmail.com','Via Milano 2','bologna','Bo','Emilia-Romagna',2119),(4,'verdi','mario','0116702020','mario128@gmail.com','Corso Francia 128','torino','To','Piemonte',0),(5,'rosso','alberto','0116707070','alberto12@icloud.com','Corso Svizzera 12','milano','Mi','Lombardia',789),(6,'esposito','franco','0119978812','francoe@icloud.com','Via Roma 3','Asti','At','Piemonte',1875),(7,'bruni','carlo','0117778816','brunicarlo@icloud.com','Corso Stati Uniti 13','Torino','To','Piemonte',0);

CREATE TABLE `ufficio` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) DEFAULT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `indirizzo` varchar(50) DEFAULT NULL,
  `citta` varchar(30) DEFAULT NULL,
  `regione` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `ufficio`
VALUES (1,'IT','3332208666','via milano 31','torino','piemonte'),
(2,'Amministrazione','3332208688','via torino 25','milano','lombardia'),
(3,'Commerciale','3332207899','via milano 33','torino','piemonte'),
(4,'Logistica','3332204366','via torino 27','milano','lombardia');


CREATE TABLE `impiegato` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) DEFAULT NULL,
  `cognome` varchar(50) DEFAULT NULL,
  `ruolo` varchar(50) DEFAULT NULL,
  `rif_to` int DEFAULT NULL,
  `stipendio` decimal(6,2) DEFAULT NULL,
  `ufficio_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_impiegato_ufficio` (`ufficio_id`),
  CONSTRAINT `impiegato_ibfk_1` FOREIGN KEY (`ufficio_id`) REFERENCES `ufficio` (`id`) ON UPDATE CASCADE
);

INSERT INTO `impiegato` VALUES (1,'Mario','Rossi','tecnico',NULL,2500.00,1),(2,'Marco','Bianchi','amministrativo',7,1600.00,2),(3,'Paolo','Verdi','amministrativo',7,1600.00,2),(4,'Enrico','Marrone','venditore',8,1300.00,3),(5,'Nicola','Testa','venditore',8,1300.00,3),(6,'Franco','Barba','tecnico',1,1500.00,1),(7,'Elena','Totti','amministrativo',NULL,2600.00,2),(8,'Paola','Capra','venditore',NULL,2300.00,3),(9,'Mauro','Barba','venditore',8,1300.00,3);


CREATE TABLE `ordine` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int DEFAULT NULL,
  `impiegato_id` int DEFAULT NULL,
  `data` date DEFAULT NULL,
  `consegna` enum('consegnato','da spedire','spedito') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ordine_cliente` (`cliente_id`),
  KEY `fk_ordine_impiegato` (`impiegato_id`),
  CONSTRAINT `ordine_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `ordine_ibfk_2` FOREIGN KEY (`impiegato_id`) REFERENCES `impiegato` (`id`) ON UPDATE CASCADE
);

INSERT INTO `ordine` VALUES (1,1,4,'2017-12-01','consegnato'),(2,3,4,'2018-01-11','consegnato'),(3,5,8,'2018-01-21','da spedire'),(4,3,4,'2018-01-23','spedito'),(5,6,4,'2018-02-03','consegnato'),(7,6,8,'2018-02-13','da spedire'),(12,3,4,'2018-02-28','spedito');

CREATE TABLE `ordine_dettaglio` (
  `ordine_id` int NOT NULL,
  `articolo_id` int NOT NULL,
  `quantita` tinyint unsigned DEFAULT NULL,
  `prezzo` decimal(6,2),
  PRIMARY KEY (`ordine_id`,`articolo_id`),
  KEY `fk_od_articolo` (`articolo_id`),
  CONSTRAINT `ordine_dettaglio_ibfk_1` FOREIGN KEY (`articolo_id`) REFERENCES `articolo` (`id`) ON UPDATE CASCADE
);

INSERT INTO `ordine_dettaglio` VALUES (1,2,10,38.5),(1,7,3,68.00),(2,5,1,700.00),(2,6,5,350.50),(3,2,10,38.5),(3,4,1,400.00),(4,1,3,350.00),(4,3,2,300.00),(4,7,1,68.00),(5,3,2,300.00),(5,4,3,400.00),(5,5,1,700.00),(5,7,1,68.00),(7,2,5,38.50),(7,3,2,300.00),(7,7,1,68.00),(12,1,10,350.00);

alter table impiegato drop foreign key impiegato_ibfk_1;
alter table ordine_dettaglio drop foreign key ordine_dettaglio_ibfk_1;
alter table ordine_dettaglio drop foreign key fk_ordine_dettaglio_ordine;
alter table ordine drop foreign key ordine_ibfk_1;
alter table ordine drop foreign key ordine_ibfk_2;
alter table ordine_dettaglio drop index fk_od_articolo;

alter table impiegato
add CONSTRAINT `fk_impiegato_ufficio` FOREIGN KEY (`ufficio_id`) REFERENCES `ufficio` (`id`) ON UPDATE set null ON delete set null;
alter table ordine_dettaglio
add CONSTRAINT `fk_ordine_dettaglio_ordine` FOREIGN KEY (`ordine_id`) REFERENCES `ordine` (`id`) ON UPDATE CASCADE ON delete CASCADE;
alter table ordine_dettaglio
add CONSTRAINT `fk_ordine_dettaglio_articolo` FOREIGN KEY (`articolo_id`) REFERENCES `articolo` (`id`) ON UPDATE cascade ON delete no action;
alter table ordine
add CONSTRAINT `fk_ordine_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`) ON UPDATE CASCADE ON delete CASCADE;
alter table ordine
add CONSTRAINT `fk_ordine_impiegato` FOREIGN KEY (`impiegato_id`) REFERENCES `impiegato` (`id`) ON UPDATE set null ON delete set null;
