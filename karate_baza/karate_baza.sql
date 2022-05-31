----------------------------------------------------------
---------------------BRISANJE TABLICA---------------------


DROP TABLE op;
DROP TABLE osoba;
DROP TABLE prijava;
DROP TABLE kolo;
DROP TABLE kumite;
DROP TABLE kate;
DROP TABLE kategorija;
DROP TABLE liga;
DROP TABLE klub;
DROP TABLE zvanje;


----------------------------------------------------------
--------------------KREIRANJE TABLICA---------------------


--------ZVANJE--------
CREATE TABLE zvanje(
    zvanje_id INTEGER CONSTRAINT zvanje_pk PRIMARY KEY,
    naziv VARCHAR2(20) NOT NULL,
    dan INTEGER
);


---------KLUB---------
CREATE TABLE klub(
    klub_id INTEGER CONSTRAINT klub_pk PRIMARY KEY,
    naziv VARCHAR2(60) NOT NULL,
    drzava VARCHAR2(20) NOT NULL,
    mjesto VARCHAR2(30) NOT NULL,
    adresa VARCHAR2(60) NOT NULL,
    postanski_broj VARCHAR2(40) NOT NULL,
    predsjednik VARCHAR2(40) NOT NULL,
    email VARCHAR2(30) NOT NULL,
    kontakt_broj VARCHAR2(60),
    internetska_stranica VARCHAR2(60)
);


---------LIGA---------
CREATE TABLE liga(
    liga_id INTEGER CONSTRAINT liga_pk PRIMARY KEY,
    naziv VARCHAR2(40) NOT NULL,
    broj_kola  INTEGER NOT NULL,
    datum_pocetka DATE NOT NULL,
    datum_kraja DATE NOT NULL
);


------KATEGORIJA------
CREATE TABLE kategorija(
    kategorija_id INTEGER CONSTRAINT kategorija_pk PRIMARY KEY,
    naziv VARCHAR2(60) NOT NULL,
    disciplina VARCHAR2(7) NOT NULL,
    spol VARCHAR2(2) NOT NULL,
    donja_dobna_granica INTEGER NOT NULL,
    gornja_dobna_granica INTEGER NOT NULL
);


---------KATE---------
CREATE TABLE kate(
    kategorija_id INTEGER CONSTRAINT kate_kategorija_pk 
        PRIMARY KEY REFERENCES kategorija(kategorija_id),
    pravila VARCHAR2(120) NOT NULL
);


--------KUMITE--------
CREATE TABLE kumite(
    kategorija_id INTEGER CONSTRAINT kumite_kategorija_pk 
        PRIMARY KEY REFERENCES kategorija(kategorija_id),
    naziv VARCHAR2(20) NOT NULL,
    donja_granica_tezina INTEGER,
    gornja_granica_tezina INTEGER
);


---------KOLO---------
CREATE TABLE kolo(
    kolo_id INTEGER CONSTRAINT kolo_pk PRIMARY KEY,
    naziv VARCHAR2(40) NOT NULL,
    vrijeme DATE NOT NULL,
    adresa VARCHAR2(40) NOT NULL,
    mjesto VARCHAR2(20) NOT NULL,
    liga_id INTEGER CONSTRAINT kolo_fk_liga_id REFERENCES liga(liga_id)
);


-------PRIJAVA--------
CREATE TABLE prijava(
    prijava_id INTEGER CONSTRAINT prijava_pk PRIMARY KEY,
    kotizacija BINARY_FLOAT NOT NULL,
    datum_prijave DATE NOT NULL,
    rezultat INTEGER NOT NULL,
    nacin_prijave VARCHAR2(10) NOT NULL,
    kategorija_id INTEGER CONSTRAINT prijava_fk_kategorija 
        REFERENCES kategorija(kategorija_id),
    kolo_id INTEGER CONSTRAINT prijava_fk_kolo_id 
        REFERENCES kolo(kolo_id)
);


---------OSOBA--------
CREATE TABLE osoba(
    oib CHAR(11) CONSTRAINT osoba_pk PRIMARY KEY,
    ime VARCHAR2(20) NOT NULL,
    prezime VARCHAR2(20) NOT NULL,
    email CHAR(30),
    zvanje_id INTEGER CONSTRAINT osoba_fk_zvanje REFERENCES zvanje(zvanje_id),
    klub_id INTEGER CONSTRAINT osoba_fk_klub REFERENCES klub(klub_id)
);


----------OP----------
CREATE TABLE op(
    oib CHAR(11) NOT NULL CONSTRAINT op_fk_osoba REFERENCES osoba(oib),
    prijava_id INTEGER NOT NULL CONSTRAINT op_fk_prijava REFERENCES prijava(prijava_id),
    CONSTRAINT op_pk PRIMARY KEY(oib,prijava_id)
);

-------------------------ZAD.9.---------------------------
--zadane vrijednosti

ALTER TABLE zvanje
MODIFY dan DEFAULT 0;



ALTER TABLE klub
MODIFY internetska_stranica DEFAULT 'http://karate.hr/web/klubovi.php';




-------------------------ZAD.10.--------------------------
--uvjeti
ALTER TABLE kategorija ADD CONSTRAINT kategorija_spol_ck CHECK(spol in ('M', 'Ž'));

ALTER TABLE kategorija ADD CONSTRAINT kategorija_disciplina_ck CHECK(disciplina in ('kate', 'kumite'));

/*
INSERT INTO kategorija VALUES (15, 'Seniori kumite', 'komite', 'M', 18, 35); -- ne moze
INSERT INTO kategorija VALUES (15, 'Seniori kumite', 'kumite', 'M', 18, 35); -- moze
*/

ALTER TABLE prijava ADD CONSTRAINT prijava_nacin_ck CHECK(nacin_prijave in ('online', 'uživo'));

ALTER TABLE kategorija ADD CONSTRAINT kategorija_donja_dobna_granica_ck CHECK(donja_dobna_granica > 5);

/*
INSERT INTO kategorija VALUES (13,  'Učenici cicibani', 'kumite', 'M', 6, 8); -- moze
INSERT INTO kategorija VALUES (14,  'Učenice cicibani', 'kumite', 'Ž', 5, 8); -- ne moze

SELECT * FROM kategorija;
*/



----------------------------------------------------------
--------------------------UNOSI---------------------------


---------KLUB---------
INSERT INTO klub (klub_id, naziv, drzava, mjesto, adresa, postanski_broj, predsjednik, email, kontakt_broj ) VALUES (1, 'Podravski sokol',                  'Hrvatska', 'Pitomača',  'Stjepana Sulimanca 7a',    '33405',  'Goran Perović', 'goran.perovic@pitomaca.hr',  '098354658');
INSERT INTO klub VALUES(2, 'Osijek',                           'Hrvatska', 'Osijek',    'Kestenova 15',             '31000',    'Dražen Gorjanski',         'karateosijek04@gmail.com',     '0958628519',   'https://www.facebook.com/karateklub.osijek/');
INSERT INTO klub VALUES(3, 'Pitomača',                         'Hrvatska', 'Pitomača',  'Trg Kralja Tomislava 7',   '33405',    'Igor Petrović',            'karate.pitomaca@gmail.com',    '09947715966',  'https://karate-pitomaca.webs.com/');
INSERT INTO klub (klub_id, naziv, drzava, mjesto, adresa, postanski_broj, predsjednik, email, internetska_stranica ) VALUES (4, 'Academie Karate Bruxelles',        'Belgija',  'Bruxelles', 'Rue de Koninck 63',        '1080',     'Maître Sturbois Gilbert',  'photobenali@hotmail.com',  'https://www.facebook.com/akb1080');
INSERT INTO klub VALUES(5, 'Academie karate Shotokan Bertrix', 'Belgija',  'Bertrix',   'Rue de la Retraite 1',     '6880',     'Jules Thillen',            'bernard.bandin@skynet.be',     '061415140',    'https://aks-bertrix.business.site/');


--------ZVANJE--------
INSERT INTO zvanje (zvanje_id, naziv) VALUES (1, 'bijeli');
INSERT INTO zvanje (zvanje_id, naziv) VALUES (2, 'bijelo-žuti');
INSERT INTO zvanje (zvanje_id, naziv) VALUES (3, 'žuti');
INSERT INTO zvanje (zvanje_id, naziv) VALUES (4, 'narančasti');
INSERT INTO zvanje (zvanje_id, naziv) VALUES (5, 'crveni');
INSERT INTO zvanje (zvanje_id, naziv) VALUES (6, 'zeleni');
INSERT INTO zvanje (zvanje_id, naziv) VALUES (7, 'plavi');
INSERT INTO zvanje (zvanje_id, naziv) VALUES (8, 'ljubičasti');
INSERT INTO zvanje (zvanje_id, naziv) VALUES (9, 'smeđi');
INSERT INTO zvanje (zvanje_id, naziv) VALUES (10,'smeđe-crni');
INSERT INTO zvanje VALUES (11,'crni',        1);
INSERT INTO zvanje VALUES (12,'crni',        2);
INSERT INTO zvanje VALUES (13,'crni',        3);


---------OSOBA--------
--kumite--
--klub_id = 1   
INSERT INTO osoba VALUES ('88888888888', 'Antun',       'Tun',          'tuntun@gmail.com',         6,  1);
INSERT INTO osoba VALUES ('99999999999', 'Grga',        'Čokolin',      'gcoko@hotmail.com',        9,  1);
INSERT INTO osoba VALUES ('12121212121', 'Juraj',       'Milić',        'jmilic@gmail.com',         7,  1);
INSERT INTO osoba VALUES ('13131313131', 'Pavao',       'Pandić',       'ppandic@hotmail.com',      8,  1);
INSERT INTO osoba VALUES ('15151515151', 'Iva',         'Tadić',        'itadic@gmail.com',         10, 1);
INSERT INTO osoba VALUES ('18181818181', 'Ana',         'Anić',         'aanic@hotmail.com',        8,  1);
INSERT INTO osoba VALUES ('19191919191', 'Božica',      'Pešić',        'bpesic@gmail.com',         2,  1);
INSERT INTO osoba VALUES ('21212121212', 'Mirela',      'Jurkić',       'mjurkic@hotmail.com',      6,  1);
INSERT INTO osoba VALUES ('23232323232', 'Stjepan',     'Ribić',        'sribic@hotmail.com',       5,  1);
INSERT INTO osoba VALUES ('24242424242', 'Darija',      'Pervan',       'dpervan@gmail.com',        4,  1);
INSERT INTO osoba VALUES ('25252525252', 'Matija',      'Marić',        'mmaric@outlook.com',       3,  1);
--klub_id = 2
INSERT INTO osoba VALUES ('26262626262', 'Borna',       'Župan',        'mzupan@hotmail.com',       1,  2);
INSERT INTO osoba VALUES ('27272727272', 'Robert',      'Petkov',       'rpetkov@outlook.com',      3,  2);
INSERT INTO osoba VALUES ('28282828282', 'Nikolina',    'Bilić',        'nbilic@gmail.com',         6,  2);
INSERT INTO osoba VALUES ('29292929292', 'Petar',       'Perić',        'pperic@outlook.com',       7,  2);
INSERT INTO osoba VALUES ('31313131313', 'Ivana',       'Ivić',         'iivic@outlook.com',        8,  2);
INSERT INTO osoba VALUES ('32323232323', 'Martin',      'Dorkić',       'mdorkic@hotmail.com',      11, 2);
INSERT INTO osoba VALUES ('34343434343', 'Cecilija',    'Cilić',        'ccilic@gmail.com',         2,  2);
INSERT INTO osoba VALUES ('35353535353', 'Marija',      'Horvat',       'mhorvat@hotmail.com',      5,  2);
INSERT INTO osoba VALUES ('36363636363', 'Olivera',     'Dalić',        'odalic@outlook.com',       8,  2);
INSERT INTO osoba VALUES ('37373737373', 'Tomislav',    'Hanić',        'thanic@hotmail.com',       9,  2);
INSERT INTO osoba VALUES ('38383838383', 'Luka',        'Jukić',        'ljukic@gmail.com',         7,  2);
INSERT INTO osoba VALUES ('39393939393', 'David',       'Dadić',        'ddadic@outlook.com',       13, 2);
--klub_id = 3
INSERT INTO osoba VALUES ('66806326350', 'Ranko',       'Kovač',        'rkovac33@hotmail.com',     1,  3);
INSERT INTO osoba VALUES ('59976515121', 'Miroš',       'Horvatinčić',  'horvatincic123@gmail.com', 12, 3);
INSERT INTO osoba VALUES ('37106088193', 'Roko',        'Novak',        'rokonovak@outlook.com',    11, 3);
INSERT INTO osoba VALUES ('57423890172', 'Elizabeta',   'Nikolić',      'elinikolic@hotmail.com',   4,  3);
INSERT INTO osoba VALUES ('76467530265', 'Melita',      'Crnić',        'melitac@gmail.com',        7,  3);
INSERT INTO osoba VALUES ('40813247672', 'Antonija',    'Vidaković',    'avidakovic11@hotmail.com', 8,  3);
--klub_id = 4
INSERT INTO osoba VALUES ('11111111111', 'Thomas',      'Peeters',      'tpeeters@gmail.com',       11, 4);
INSERT INTO osoba VALUES ('22222222222', 'Nicolas',     'Janssens',     'janssensni@outlook.com',   9,  4);
INSERT INTO osoba VALUES ('33333333333', 'Maxime',      'Maes',         'maesmax@outlook.com',      8,  4);
--klub_id = 5
INSERT INTO osoba VALUES ('44444444444', 'Louis',       'Jacobs',       'loujacobs@gmail.com',      9,  5);
INSERT INTO osoba VALUES ('55555555555', 'Arthur',      'Mertens',      'arthurm@outlook.com',      10, 5);
INSERT INTO osoba VALUES ('66666666666', 'Maria',       'Willems',      'mwillems@gmail.com',       12, 5);
INSERT INTO osoba VALUES ('77777777777', 'Monique',     'Claes',        'moniquecla@outlook.com',   7,  5);
--kate--Ž--
--klub_id = 1 
INSERT INTO osoba VALUES ('07220579241', 'Davorka',     'Jurišić',      'djurisic44@hotmail.com',   5,  1);
INSERT INTO osoba VALUES ('18978793730', 'Katarina',    'Marušić',      'katamarusic@gmail.com',    7,  1);
INSERT INTO osoba VALUES ('52198421320', 'Tatjana',     'Petković',     'tpetkovic1@hotmail.com',   7,  1);
INSERT INTO osoba VALUES ('46095800211', 'Nada',        'Božić',        'bozicnada@hotmail.com',    8,  1);
INSERT INTO osoba VALUES ('17999074392', 'Branka',      'Novosel',      'bnovosel4@hotmail.com',    11, 1);
INSERT INTO osoba VALUES ('89871920820', 'Silvija',     'Čeh',          'silvijac@gmail.com',       10, 1);
INSERT INTO osoba VALUES ('81198880278', 'Suzana',      'Jakšić',       'suzijaksic@gmail.com',     9,  1);
--klub_id = 2 
INSERT INTO osoba VALUES ('95390393981', 'Gordana',     'Brajković',    'brajkovicg@gmail.com',     10, 2);
INSERT INTO osoba VALUES ('79429664778', 'Renata',      'Stolar',       'stolarr@gmail.com',        11, 2);
INSERT INTO osoba VALUES ('58401115686', 'Željka',      'Tomić',        'ztomi@hotmail.com',        6,  2);
INSERT INTO osoba VALUES ('52291519613', 'Snješka',     'Pejić',        'spejic@hotmail.com',       7,  2);
INSERT INTO osoba VALUES ('23613358235', 'Gabriela',    'Kirin',        'gkirin12@gmail.com',       6,  2);
INSERT INTO osoba VALUES ('22271460753', 'Petra',       'Bašić',        'petrab@outlook.com',       11, 2);
INSERT INTO osoba VALUES ('28524122430', 'Biljana',     'Blatarić',     'bblataric@hotmail.com',    9,  2);
--klub_id = 3 
INSERT INTO osoba VALUES ('10488376076', 'Paula',       'Rukavina',     'prukavina@hotmail.com',    10, 3);
INSERT INTO osoba VALUES ('00541914189', 'Stanija',     'Barić',        'sbaric00@gmail.com',       5,  3);
INSERT INTO osoba VALUES ('08979091139', 'Tihana',      'Vidović',      'tihvidovic@hotmail.com',   8,  3);
INSERT INTO osoba VALUES ('36992753218', 'Zvonka',      'Janković',     'jankovicz12@outlook.com',  7,  3); 
--kate_M--
--klub_id = 1 
INSERT INTO osoba VALUES ('00321136405', 'Luka',        'Mijatović',    'lmijatovic@gmail.com',     2,  1);
INSERT INTO osoba VALUES ('35908620330', 'Eduard',      'Marjanović',   'eduardm1@hotmail.com',     1,  1);
INSERT INTO osoba VALUES ('50214697157', 'Božo',        'Dujmović',     'bdujmovic8@hotmail.com',   5,  1);
INSERT INTO osoba VALUES ('59786125794', 'Ranko',       'Barić',        'rbaric@hotmail.com',       7,  1);
--klub_id = 2
INSERT INTO osoba VALUES ('36700845764', 'Šimun',       'Stolar',       'sstolar@gmail.com',        8,  2);
INSERT INTO osoba VALUES ('77151383291', 'Bruno',       'Pavlović',     'brunop5@hotmail.com',      9,  2);
INSERT INTO osoba VALUES ('92960906375', 'Josip',       'Rukavina',     'jrukavina@hotmail.com',    3,  2);
INSERT INTO osoba VALUES ('55548346563', 'Ratimir',     'Filipović',    'rfilipovic2@gmail.com',    10, 2);
INSERT INTO osoba VALUES ('97768146148', 'Ivan',        'Petrović',     'ipetrovic@outlook.com',    7,  2);
--klub_id = 3
INSERT INTO osoba VALUES ('48462986280', 'Dino',        'Stipanov',     'dstipanov@gmail.com',      6,  3);
INSERT INTO osoba VALUES ('50866819074', 'Antonio',     'Stanković',    'antoniost@hotmail.com',    11, 3);
INSERT INTO osoba VALUES ('46953355261', 'Perica',      'Matković',     'pmatkovic00@gmail.com',    4,  3);
INSERT INTO osoba VALUES ('89725694930', 'Ozren',       'Matić',        'omatic@gmail.com',         9,  3);
INSERT INTO osoba VALUES ('12927446257', 'Cvitko',      'Zagorec',      'zagorec111@gmail.com',     6,  3);


---------LIGA---------
INSERT INTO liga VALUES(1, 'Liga sjeverozapadne Hrvatske', 3, TO_DATE('2021/02/06', 'yyyy/mm/dd'), TO_DATE('2021/11/22', 'yyyy/mm/dd') );


---------KOLO---------
INSERT INTO kolo VALUES(1, '1. kolo', TO_DATE('2021/02/06 09:0:00',  'yyyy/mm/dd hh24:mi:ss'), 'Samostanski prilaz 8',              'Daruvar',      1);
INSERT INTO kolo VALUES(2, '2. kolo', TO_DATE('2021/07/09 09:00:00', 'yyyy/mm/dd hh24:mi:ss'), 'Ul. Zbora narodne garde 29',        'Virovitica',   1);
INSERT INTO kolo VALUES(3, '3. kolo', TO_DATE('2021/11/21 09:00:00', 'yyyy/mm/dd hh24:mi:ss'), 'Ulica doktora Željka Selingera 3A', 'Koprivnica',   1);


------KATEGORIJA------
--ucenici
INSERT INTO kategorija VALUES (1,  'Učenici kate',     'kate',     'M', 10, 12);
INSERT INTO kategorija VALUES (2,  'Učenice kate',     'kate',     'Ž', 10, 12);

INSERT INTO kategorija VALUES (3,  'Učenici borbe',    'kumite',   'M', 10, 12);
INSERT INTO kategorija VALUES (4,  'Učenice borbe',    'kumite',   'Ž', 10, 12);

--kadeti
INSERT INTO kategorija VALUES (5,  'Kadeti kate',      'kate',     'M', 14, 15);
INSERT INTO kategorija VALUES (6,  'Kadetkinje kate',  'kate',     'Ž', 14, 15);

INSERT INTO kategorija VALUES (7,  'Kadeti borbe',     'kumite',   'M', 14, 15);
INSERT INTO kategorija VALUES (8,  'Kadetkinje borbe', 'kumite',   'Ž', 14, 15);
--juniori
INSERT INTO kategorija VALUES (9,  'Juniori kate',     'kate',     'M', 16, 17);
INSERT INTO kategorija VALUES (10, 'Juniorke kate',    'kate',     'Ž', 16, 17);

INSERT INTO kategorija VALUES (11, 'Juniori borbe',    'kumite',   'M', 16, 17);
INSERT INTO kategorija VALUES (12, 'Juniorke borbe',   'kumite',   'Ž', 16, 17);


---------KATE---------
--ucenici
INSERT INTO kate VALUES (1,   'Dopuštene sve učeničke kate');
INSERT INTO kate VALUES (2,   'Dopuštene samo učeničke kate: Heian Sandan, Heian Yodan, Heian Godan');
--kadeti
INSERT INTO kate VALUES (5,   'Dopuštene sve kate');
INSERT INTO kate VALUES (6,   'Dopuštene sve kate');
--juniori
INSERT INTO kate VALUES (9,   'Dopuštene samo majstorske kate');
INSERT INTO kate VALUES (10,  'Dopuštene samo majstorske kate');


--------KUMITE--------
--ucenici
INSERT INTO kumite VALUES(3,  'laka', 34, 41);
INSERT INTO kumite VALUES(4,  'laka', 32, 39);
--kadeti
INSERT INTO kumite VALUES(7,  'srednja', 52, 69);
INSERT INTO kumite VALUES(8,  'srednja', 47, 54);
--juniori
INSERT INTO kumite VALUES(11, 'teška', 61, 75);
INSERT INTO kumite VALUES(12, 'teška', 49, 58);


-------PRIJAVA--------
-- - - 1.kolo - - - --
---kumite---
--klub_id = 1
INSERT INTO prijava VALUES (1,  100.00,  TO_DATE('2021/02/02', 'yyyy/mm/dd'), 6, 'online', 7,  1);
INSERT INTO prijava VALUES (2,  100.00,  TO_DATE('2021/02/05', 'yyyy/mm/dd'), 0, 'uživo',  11, 1);
INSERT INTO prijava VALUES (3,  100.00,  TO_DATE('2021/02/03', 'yyyy/mm/dd'), 8, 'online', 3,  1);
INSERT INTO prijava VALUES (4,  100.00,  TO_DATE('2021/02/03', 'yyyy/mm/dd'), 7, 'online', 7,  1);
INSERT INTO prijava VALUES (5,  100.00,  TO_DATE('2021/02/02', 'yyyy/mm/dd'), 1, 'uživo',  12, 1);
INSERT INTO prijava VALUES (6,  100.00,  TO_DATE('2021/02/02', 'yyyy/mm/dd'), 9, 'online', 8,  1);
INSERT INTO prijava VALUES (7,  100.00,  TO_DATE('2021/02/02', 'yyyy/mm/dd'), 4, 'online', 4,  1);
INSERT INTO prijava VALUES (8,  100.00,  TO_DATE('2021/02/01', 'yyyy/mm/dd'), 6, 'online', 4,  1);
INSERT INTO prijava VALUES (9,  100.00,  TO_DATE('2021/01/30', 'yyyy/mm/dd'), 5, 'uživo',  7,  1);
INSERT INTO prijava VALUES (10, 100.00,  TO_DATE('2021/01/30', 'yyyy/mm/dd'), 5, 'online', 4,  1);
INSERT INTO prijava VALUES (11, 100.00,  TO_DATE('2021/01/30', 'yyyy/mm/dd'), 7, 'online', 3,  1);
--klub_id = 2
INSERT INTO prijava VALUES (12, 100.00,  TO_DATE('2021/01/30', 'yyyy/mm/dd'), 1, 'online', 3,  1);
INSERT INTO prijava VALUES (13, 100.00,  TO_DATE('2021/01/29', 'yyyy/mm/dd'), 0, 'online', 3,  1);
INSERT INTO prijava VALUES (14, 100.00,  TO_DATE('2021/01/29', 'yyyy/mm/dd'), 4, 'uživo',  4,  1);
INSERT INTO prijava VALUES (15, 100.00,  TO_DATE('2021/01/29', 'yyyy/mm/dd'), 3, 'uživo',  7,  1);
INSERT INTO prijava VALUES (16, 100.00,  TO_DATE('2021/01/31', 'yyyy/mm/dd'), 9, 'online', 8,  1);
INSERT INTO prijava VALUES (17, 100.00,  TO_DATE('2021/01/31', 'yyyy/mm/dd'), 20, 'uživo', 11, 1);
INSERT INTO prijava VALUES (18, 100.00,  TO_DATE('2021/02/02', 'yyyy/mm/dd'), 8, 'online', 4,  1);
INSERT INTO prijava VALUES (19, 100.00,  TO_DATE('2021/02/01', 'yyyy/mm/dd'), 2, 'online', 4,  1);
INSERT INTO prijava VALUES (20, 100.00,  TO_DATE('2021/02/03', 'yyyy/mm/dd'), 6, 'uživo',  12, 1);
INSERT INTO prijava VALUES (21, 100.00,  TO_DATE('2021/02/02', 'yyyy/mm/dd'), 4, 'uživo',  7,  1);
INSERT INTO prijava VALUES (22, 100.00,  TO_DATE('2021/02/02', 'yyyy/mm/dd'), 3, 'online', 7,  1);
INSERT INTO prijava VALUES (23, 100.00,  TO_DATE('2021/02/01', 'yyyy/mm/dd'), 7, 'online', 11, 1);
--klub_id = 3
INSERT INTO prijava VALUES (24, 100.00,  TO_DATE('2021/02/01', 'yyyy/mm/dd'), 3, 'uživo',  3,  1);
INSERT INTO prijava VALUES (25, 100.00,  TO_DATE('2021/02/03', 'yyyy/mm/dd'), 0, 'uživo',  11, 1);
INSERT INTO prijava VALUES (26, 100.00,  TO_DATE('2021/02/01', 'yyyy/mm/dd'), 4, 'uživo',  11, 1);
INSERT INTO prijava VALUES (27, 100.00,  TO_DATE('2021/02/03', 'yyyy/mm/dd'), 1, 'online', 4,  1);
INSERT INTO prijava VALUES (28, 100.00,  TO_DATE('2021/02/03', 'yyyy/mm/dd'), 2, 'online', 8,  1);
INSERT INTO prijava VALUES (29, 100.00,  TO_DATE('2021/02/01', 'yyyy/mm/dd'), 6, 'uživo',  12, 1);
--klub_id = 4
INSERT INTO prijava VALUES (30, 100.00,  TO_DATE('2021/02/03', 'yyyy/mm/dd'), 2, 'online', 11, 1);
INSERT INTO prijava VALUES (31, 100.00,  TO_DATE('2021/02/01', 'yyyy/mm/dd'), 6, 'online', 3,  1);
INSERT INTO prijava VALUES (32, 100.00,  TO_DATE('2021/02/01', 'yyyy/mm/dd'), 10, 'online',7,  1);
--klub_id = 5
INSERT INTO prijava VALUES (33, 100.00,  TO_DATE('2021/02/02', 'yyyy/mm/dd'), 11, 'online',11, 1);
INSERT INTO prijava VALUES (34, 100.00,  TO_DATE('2021/02/01', 'yyyy/mm/dd'), 5, 'online', 7,  1);
INSERT INTO prijava VALUES (35, 100.00,  TO_DATE('2021/02/03', 'yyyy/mm/dd'), 7, 'online', 12, 1);
INSERT INTO prijava VALUES (36, 100.00,  TO_DATE('2021/02/01', 'yyyy/mm/dd'), 2, 'online', 12, 1);
--grupne prijave_kumite
INSERT INTO prijava VALUES (37, 100.00,  TO_DATE('2021/02/02', 'yyyy/mm/dd'), 17, 'online',7, 1);
INSERT INTO prijava VALUES (38, 100.00,  TO_DATE('2021/02/01', 'yyyy/mm/dd'), 10, 'online',7, 1);
INSERT INTO prijava VALUES (39, 100.00,  TO_DATE('2021/02/02', 'yyyy/mm/dd'), 15, 'online',4, 1);
INSERT INTO prijava VALUES (40, 100.00,  TO_DATE('2021/02/03', 'yyyy/mm/dd'), 9, 'online', 4, 1);
---kate--Ž---
--klub_id = 1
INSERT INTO prijava VALUES (41,  100.00,  TO_DATE('2021/02/02', 'yyyy/mm/dd'), 6, 'online', 6,  1);
INSERT INTO prijava VALUES (42,  100.00,  TO_DATE('2021/02/05', 'yyyy/mm/dd'), 3, 'online',  6, 1);
INSERT INTO prijava VALUES (43,  100.00,  TO_DATE('2021/02/03', 'yyyy/mm/dd'), 0, 'online', 6,  1);
INSERT INTO prijava VALUES (44,  100.00,  TO_DATE('2021/02/03', 'yyyy/mm/dd'), 7, 'online', 10,  1);
INSERT INTO prijava VALUES (45,  100.00,  TO_DATE('2021/02/02', 'yyyy/mm/dd'), 8, 'uživo',  10, 1);
INSERT INTO prijava VALUES (46,  100.00,  TO_DATE('2021/02/02', 'yyyy/mm/dd'), 1, 'online', 10, 1);
INSERT INTO prijava VALUES (47,  100.00,  TO_DATE('2021/02/02', 'yyyy/mm/dd'), 4, 'online', 10,  1);
--klub_id = 2
INSERT INTO prijava VALUES (48,  100.00,  TO_DATE('2021/02/01', 'yyyy/mm/dd'), 5, 'online', 10,  1);
INSERT INTO prijava VALUES (49,  100.00,  TO_DATE('2021/01/30', 'yyyy/mm/dd'), 3, 'uživo',  10,  1);
INSERT INTO prijava VALUES (50,  100.00,  TO_DATE('2021/01/30', 'yyyy/mm/dd'), 7, 'online', 6,  1);
INSERT INTO prijava VALUES (51,  100.00,  TO_DATE('2021/01/30', 'yyyy/mm/dd'), 7, 'online', 6,  1);
INSERT INTO prijava VALUES (52,  100.00,  TO_DATE('2021/01/30', 'yyyy/mm/dd'), 1, 'online', 6,  1);
INSERT INTO prijava VALUES (53,  100.00,  TO_DATE('2021/01/29', 'yyyy/mm/dd'), 0, 'online', 10,  1);
INSERT INTO prijava VALUES (54,  100.00,  TO_DATE('2021/01/29', 'yyyy/mm/dd'), 4, 'uživo',  10,  1);
--klub_id = 3
INSERT INTO prijava VALUES (55,  100.00,  TO_DATE('2021/01/29', 'yyyy/mm/dd'), 3, 'uživo',  10,  1);
INSERT INTO prijava VALUES (56,  100.00,  TO_DATE('2021/01/31', 'yyyy/mm/dd'), 9, 'online', 6, 1);
INSERT INTO prijava VALUES (57,  100.00,  TO_DATE('2021/01/31', 'yyyy/mm/dd'), 6, 'online', 6, 1);
INSERT INTO prijava VALUES (58,  100.00,  TO_DATE('2021/02/02', 'yyyy/mm/dd'), 8, 'online', 6,  1);
--kate--M---
--klub_id = 1
INSERT INTO prijava VALUES (59,  100.00,  TO_DATE('2021/02/01', 'yyyy/mm/dd'), 2, 'online', 1,  1);
INSERT INTO prijava VALUES (60,  100.00,  TO_DATE('2021/02/03', 'yyyy/mm/dd'), 1, 'uživo',  1, 1);
INSERT INTO prijava VALUES (61,  100.00,  TO_DATE('2021/02/02', 'yyyy/mm/dd'), 9, 'uživo',  5,  1);
INSERT INTO prijava VALUES (62,  100.00,  TO_DATE('2021/02/02', 'yyyy/mm/dd'), 3, 'online', 5,  1);
--klub_id = 2
INSERT INTO prijava VALUES (63,  100.00,  TO_DATE('2021/02/01', 'yyyy/mm/dd'), 8, 'online', 9, 1);
INSERT INTO prijava VALUES (64,  100.00,  TO_DATE('2021/02/01', 'yyyy/mm/dd'), 3, 'uživo',  9,  1);
INSERT INTO prijava VALUES (65,  100.00,  TO_DATE('2021/02/03', 'yyyy/mm/dd'), 0, 'uživo',  1, 1);
INSERT INTO prijava VALUES (66,  100.00,  TO_DATE('2021/02/01', 'yyyy/mm/dd'), 4, 'uživo',  9, 1);
INSERT INTO prijava VALUES (67,  100.00,  TO_DATE('2021/02/03', 'yyyy/mm/dd'), 5, 'online', 5,  1);
--klub_id = 3
INSERT INTO prijava VALUES (68,  100.00,  TO_DATE('2021/02/03', 'yyyy/mm/dd'), 5, 'online', 5, 1);
INSERT INTO prijava VALUES (69,  100.00,  TO_DATE('2021/02/01', 'yyyy/mm/dd'), 3, 'uživo',  9, 1);
INSERT INTO prijava VALUES (70,  100.00,  TO_DATE('2021/02/03', 'yyyy/mm/dd'), 2, 'online', 1, 1);
INSERT INTO prijava VALUES (71,  100.00,  TO_DATE('2021/02/01', 'yyyy/mm/dd'), 7, 'online', 9,  1);
INSERT INTO prijava VALUES (72,  100.00,  TO_DATE('2021/02/01', 'yyyy/mm/dd'), 9, 'online', 5,  1);
--grupne_prijave_kate
INSERT INTO prijava VALUES (73,  100.00,  TO_DATE('2021/02/02', 'yyyy/mm/dd'), 16, 'online', 6, 1);
INSERT INTO prijava VALUES (74,  100.00,  TO_DATE('2021/02/01', 'yyyy/mm/dd'), 5, 'online', 6, 1);
INSERT INTO prijava VALUES (75,  100.00,  TO_DATE('2021/02/02', 'yyyy/mm/dd'), 10, 'online', 6, 1);

--oni koji već imaju prijavljene kumite
INSERT INTO prijava VALUES (76,  100.00,  TO_DATE('2021/02/02', 'yyyy/mm/dd'), 8, 'uživo',  10, 1);
INSERT INTO prijava VALUES (77,  100.00,  TO_DATE('2021/01/30', 'yyyy/mm/dd'), 9, 'online',  1,  1);



----------OP----------
/* spoj osobe i prijave, 
više osoba može imati jednu prijavu = ekipno
jedna osoba može imati više prijava */
---KUMITE---
--klub_id = 1
INSERT INTO op VALUES ('88888888888', 1);
INSERT INTO op VALUES ('99999999999', 2);
INSERT INTO op VALUES ('12121212121', 3);
INSERT INTO op VALUES ('13131313131', 4);
INSERT INTO op VALUES ('15151515151', 5);
INSERT INTO op VALUES ('18181818181', 6);
INSERT INTO op VALUES ('19191919191', 7);
INSERT INTO op VALUES ('21212121212', 8);
INSERT INTO op VALUES ('23232323232', 9);
INSERT INTO op VALUES ('24242424242', 10);
INSERT INTO op VALUES ('25252525252', 11);
--klub_id = 2
INSERT INTO op VALUES ('26262626262', 12);
INSERT INTO op VALUES ('27272727272', 13);
INSERT INTO op VALUES ('28282828282', 14);
INSERT INTO op VALUES ('29292929292', 15);
INSERT INTO op VALUES ('31313131313', 16);
INSERT INTO op VALUES ('32323232323', 17);
INSERT INTO op VALUES ('34343434343', 18);
INSERT INTO op VALUES ('35353535353', 19);
INSERT INTO op VALUES ('36363636363', 20);
INSERT INTO op VALUES ('37373737373', 21);
INSERT INTO op VALUES ('38383838383', 22);
INSERT INTO op VALUES ('39393939393', 23);
--klub_id = 3
INSERT INTO op VALUES ('66806326350', 24);
INSERT INTO op VALUES ('59976515121', 25);
INSERT INTO op VALUES ('37106088193', 26);
INSERT INTO op VALUES ('57423890172', 27);
INSERT INTO op VALUES ('76467530265', 28);
INSERT INTO op VALUES ('40813247672', 29);
--klub_id = 4
INSERT INTO op VALUES ('11111111111', 30);
INSERT INTO op VALUES ('22222222222', 31);
INSERT INTO op VALUES ('33333333333', 32);
--klub_id = 5
INSERT INTO op VALUES ('44444444444', 33);
INSERT INTO op VALUES ('55555555555', 34);
INSERT INTO op VALUES ('66666666666', 35);
INSERT INTO op VALUES ('77777777777', 36);
--grupno
INSERT INTO op VALUES ('88888888888', 37);
INSERT INTO op VALUES ('13131313131', 37);
INSERT INTO op VALUES ('23232323232', 37);

INSERT INTO op VALUES ('29292929292', 38);
INSERT INTO op VALUES ('37373737373', 38);
INSERT INTO op VALUES ('38383838383', 38);

INSERT INTO op VALUES ('19191919191', 39);
INSERT INTO op VALUES ('21212121212', 39);
INSERT INTO op VALUES ('24242424242', 39);

INSERT INTO op VALUES ('28282828282', 40);
INSERT INTO op VALUES ('34343434343', 40);
INSERT INTO op VALUES ('35353535353', 40);
---KATE---Ž--
--klub_id = 1 
INSERT INTO op VALUES ('07220579241', 41);
INSERT INTO op VALUES ('18978793730', 42);
INSERT INTO op VALUES ('52198421320', 43);
INSERT INTO op VALUES ('46095800211', 44);
INSERT INTO op VALUES ('17999074392', 45);
INSERT INTO op VALUES ('89871920820', 46);
INSERT INTO op VALUES ('81198880278', 47);
--klub_id = 2 
INSERT INTO op VALUES ('95390393981', 48);
INSERT INTO op VALUES ('79429664778', 49);
INSERT INTO op VALUES ('58401115686', 50);
INSERT INTO op VALUES ('52291519613', 51);
INSERT INTO op VALUES ('23613358235', 52);
INSERT INTO op VALUES ('22271460753', 53);
INSERT INTO op VALUES ('28524122430', 54);
--klub_id = 3 
INSERT INTO op VALUES ('10488376076', 55);
INSERT INTO op VALUES ('00541914189', 56);
INSERT INTO op VALUES ('08979091139', 57);
INSERT INTO op VALUES ('36992753218', 58);
---kate--M--
--klub_id = 1 
INSERT INTO op VALUES ('00321136405', 59);
INSERT INTO op VALUES ('35908620330', 60);
INSERT INTO op VALUES ('50214697157', 61);
INSERT INTO op VALUES ('59786125794', 62);
--klub_id = 2
INSERT INTO op VALUES ('36700845764', 63);
INSERT INTO op VALUES ('77151383291', 64);
INSERT INTO op VALUES ('92960906375', 65);
INSERT INTO op VALUES ('55548346563', 66);
INSERT INTO op VALUES ('97768146148', 67);
--klub_id = 3
INSERT INTO op VALUES ('48462986280', 68);
INSERT INTO op VALUES ('50866819074', 69);
INSERT INTO op VALUES ('46953355261', 70);
INSERT INTO op VALUES ('89725694930', 71);
INSERT INTO op VALUES ('12927446257', 72);
--grupno_kate
INSERT INTO op VALUES ('07220579241', 73);
INSERT INTO op VALUES ('18978793730', 73);
INSERT INTO op VALUES ('52198421320', 73);

INSERT INTO op VALUES ('58401115686', 74);
INSERT INTO op VALUES ('52291519613', 74);
INSERT INTO op VALUES ('23613358235', 74);

INSERT INTO op VALUES ('00541914189', 75);
INSERT INTO op VALUES ('08979091139', 75);
INSERT INTO op VALUES ('36992753218', 75);
--oni koji već imaju prijavljene kumite, a sada i kate
INSERT INTO op VALUES ('15151515151', 76);
INSERT INTO op VALUES ('25252525252', 77);


----------------------------------------------------------
------------------------ UPITI----------------------------

-------------------------ZAD.5.---------------------------
--Jednostavni upiti

---------1---------
--Ispisati lokaciju održavanja 1.kola natjecanja.


SELECT adresa, mjesto AS "Lokacija"
FROM kolo
WHERE kolo_id = 1;

---------2---------
--Ispisati sve klubove zajedno sa pripadujicim brojevima, samo klubove koji imaju zapisan kontakt broj.
SELECT naziv, kontakt_broj
FROM klub
WHERE kontakt_broj IS NOT NULL;

---------3---------
--Ispisati sve osobe koje imaju bijeli, bijelo-žuti, žuti, narančasti pojas.
SELECT ime, prezime 
FROM osoba
WHERE zvanje_id < 5;

---------4---------
--Ispisati trajanje lige.
SELECT naziv, (datum_kraja -datum_pocetka) AS "Trajanje"
FROM liga
WHERE liga_id = 1;

---------5---------
--Ispisati koje države sudjeluju u natjecanju.
SELECT DISTINCT drzava
FROM klub;

-------------------------ZAD.6.---------------------------
--Složeni upiti

---------1---------
--Ispisati kategorije koje nitko nije prijavio.
SELECT k.naziv --vrati sve
FROM kategorija k, prijava p
WHERE k.kategorija_id <> p.kategorija_id
MINUS
SELECT DISTINCT k.naziv --vrati sve one koji IMAJU prijavu
FROM kategorija k, prijava p
WHERE k.kategorija_id = p.kategorija_id;


---------2---------
--Ispisati u kojem klubu trenira Martin Dorkić.
SELECT k.naziv AS "Naziv kluba" 
FROM klub k INNER JOIN osoba o 
USING (klub_id)
WHERE  o.ime = 'Martin' AND o.prezime = 'Dorkić';
 
---------3---------
--Ispisati sve natjecatelje kluba 'Podravski sokol' od većeg zvanja prema manjem.
SELECT o.ime || ' ' || o.prezime AS "Članovi kluba Podravski sokol"
FROM klub k, osoba o, zvanje z
WHERE k.klub_id = o.klub_id AND z.zvanje_id = o.zvanje_id AND k.naziv = 'Podravski sokol'
ORDER BY z.zvanje_id DESC;

---------4---------
--Ispisati sve natjecatelje iz kategorije borbi učenici,  sa njihovim rezultatima, po prezimenu.
SELECT o.ime || ' ' || o.prezime AS "Ime prezime", p.rezultat
FROM osoba o, op, prijava p, kategorija k, kumite ku
WHERE o.oib = op.oib AND op.prijava_id = p.prijava_id AND  p.kategorija_id = k.kategorija_id 
    AND k.kategorija_id = ku.kategorija_id AND k.kategorija_id = 3
ORDER BY o.prezime;

---------5---------
--Ispisati sve osobe koje imaju zvanje crni pojas 1. ili 2. dan, te kojem klubu pripadaju.
SELECT o.ime || ' ' || o.prezime AS "Ime i prezime", k.naziv
FROM zvanje z, osoba o, klub k
WHERE o.zvanje_id = z.zvanje_id AND o.klub_id = k.klub_id  AND z.naziv = 'crni'  AND (z.dan IN (1,2));

--koliko ima osoba u klubu (s usmenog)
SELECT COUNT(z.naziv), k.naziv, z.zvanje_id
FROM osoba o, zvanje z, klub k
WHERE o.klub_id = k.klub_id AND o.zvanje_id = z.zvanje_id
GROUP BY k.naziv, z.zvanje_id;

-------------------------ZAD.7.---------------------------
--Agregirajuće funkcije

--------1---------
--Ispisati ukupnu naplaćenu kotizaciju.
SELECT SUM(p.kotizacija) AS "Ukupna kotizacija"
FROM prijava p;

---------2---------
--Ispisuje prijave koje podrazumjevaju više članova, odnosno grupe.
SELECT prijava_id
FROM op
GROUP BY prijava_id
HAVING  COUNT(oib)>1;

---------3----------
---Ispisuje prosječne rezultate po kategorijama u kojima ima prijavljenih natjecatelja.
SELECT AVG(rezultat), kategorija_id
FROM prijava
GROUP BY kategorija_id;


---------4---------
--Ispisati broj klubova u Pitomači.
SELECT COUNT(k.mjesto) AS "Broj KK u Pitomači"
FROM klub k
WHERE mjesto = 'Pitomača';

---------5---------
--Ispisati koliko je natjecatelja ima zvanje 'crni pojas 1.dan'.
SELECT COUNT(ime) AS "Broj natjecatelja sa crnim pojasom,1.dan"
FROM osoba
WHERE zvanje_id =11;


-------------------------ZAD.8.---------------------------

--------1---------
--Ispisati najbolji rezultat postignut na natjecanju sa pripadnim imenom i prezimenom natjecatelja.
SELECT o.ime || ' ' || o.prezime AS "Ime i prezime", p.rezultat AS "Najbolji rezultat"
FROM osoba o, op, prijava p
WHERE o.oib = op.oib AND op.prijava_id = p.prijava_id AND p.rezultat = (SELECT MAX(p.rezultat) FROM prijava p);

---------2---------
--Ispisati klub_id klubova koji nemaju ni jednog predstavnika u disciplini kate.
SELECT klub_id FROM klub                        --(ispisuje klub_id od svih unesenih klubova)
MINUS
SELECT DISTINCT klub_id FROM osoba 
WHERE oib = ANY  (SELECT oib FROM op 
WHERE prijava_id = ANY(SELECT prijava_id FROM prijava 
WHERE kategorija_id = ANY(1,2,5,6,9,10)));   --(ispisuje klub_id svih klubova koji imaju predstavnika u disciplini kate)

---------3--------
--Ispisati osobe koje imaju rezultat manji od prosjecnog rezultata, a posjeduju majstorsko zvanje.
SELECT o.ime || ' ' || o.prezime AS "Ime i prezime", p.rezultat
FROM osoba o, op, prijava p
WHERE o.oib = op.oib AND op.prijava_id = p.prijava_id 
AND (p.rezultat < (SELECT AVG(p.rezultat) FROM prijava p))  AND (o.zvanje_id >= 11);

---------4--------
--Ispisati kola koja nemaju niti jednu prijavu, ta pripadaju ligi ciji je liga_id = 1
SELECT DISTINCT p.kolo_id
FROM prijava p, kolo k
WHERE k.liga_id = 1;
SELECT kolo_id FROM kolo WHERE liga_id = 1
MINUS
SELECT DISTINCT p.kolo_id 
FROM prijava p, kolo k
WHERE k.liga_id = 1;

---------5--------
--Ispisuje oib-ove natjecatelja koji se natjecu u obje discipline, kate i kumite
SELECT oib FROM op WHERE prijava_id = ANY(SELECT prijava_id FROM prijava WHERE kategorija_id = ANY(1,2,5,6,9,10))--ispisuje sve oibove vezane za kate
INTERSECT
SELECT oib FROM op WHERE prijava_id = ANY(SELECT prijava_id FROM prijava WHERE kategorija_id = ANY(3,4,7,8,11,12));--ispisuje sve oibove vezane za kumite




-------------------------ZAD.11.--------------------------
--komentari
COMMENT ON TABLE kategorija IS 'Opis svih kategorija koje su dostupne.';
COMMENT ON TABLE kate IS 'Dodatni podatci o svakoj kategoriji koja pripada disciplini kate.';
COMMENT ON TABLE kumite IS 'Dodatni podatci o svakoj kategoriji koja pripada disciplini kumite.';
COMMENT ON TABLE zvanje IS 'Dostupna zvanja/pojasevi.';
COMMENT ON TABLE klub IS 'Podatci informativnog karaktera o svakom klubu.';
COMMENT ON TABLE liga IS 'Informativni podatci o ligi.';
COMMENT ON TABLE kolo IS 'Informativni podatci o kolu';
COMMENT ON TABLE prijava IS 'Podatci o prijavi';
COMMENT ON TABLE osoba IS 'Podatci o osobi';
COMMENT ON TABLE op IS 'Poveznica između osobe (oib) i prijave (prijava_id)';


/*
SELECT *  FROM user_tab_comments WHERE table_name = 'KATEGORIJA';
SELECT *  FROM user_tab_comments WHERE table_name = 'KATE';
SELECT *  FROM user_tab_comments WHERE table_name = 'KUMITE';
SELECT *  FROM user_tab_comments WHERE table_name = 'ZVANJE';
SELECT *  FROM user_tab_comments WHERE table_name = 'KLUB';
SELECT *  FROM user_tab_comments WHERE table_name = 'LIGA';
SELECT *  FROM user_tab_comments WHERE table_name = 'KOLO';
SELECT *  FROM user_tab_comments WHERE table_name = 'PRIJAVA';
SELECT *  FROM user_tab_comments WHERE table_name = 'OSOBA';
SELECT *  FROM user_tab_comments WHERE table_name = 'OP';
*/
-------------------------ZAD.12.--------------------------
--indeksi

CREATE INDEX i_prijava_rezultat ON prijava(rezultat);
CREATE INDEX i_osoba_naziv  ON osoba(ime, prezime);

CREATE BITMAP INDEX i_nacin_prijave  ON prijava(nacin_prijave);
CREATE BITMAP INDEX i_spol_kategorija ON kategorija(spol);

-------------------------ZAD.13.--------------------------
--procedure

--Procedura za unaprijeđenje zvanja. Zvanja se ne mogu preskakati, stoga se pri svakom polaganju zvanje poveća samo za 1.

CREATE OR REPLACE PROCEDURE promjena_zvanja (
    v_oib IN osoba.oib % TYPE
    ) AS
    v_brojac INTEGER;
    BEGIN
        SELECT COUNT(*) INTO v_brojac FROM osoba WHERE oib = v_oib;

        IF v_brojac = 1 THEN
        UPDATE osoba
        SET zvanje_id = zvanje_id + 1
        WHERE oib = v_oib;
        COMMIT;
        ELSE 
        ROLLBACK; 
        END IF;
END promjena_zvanja;
/

/*
SELECT oib, zvanje_id FROM osoba;
CALL promjena_zvanja('88888888888');
*/


--Procedura za promjenu mjesta održavanja kola.

CREATE OR REPLACE PROCEDURE promjena_mjesta_odrzavanja_kola(
    v_kolo_id IN kolo.kolo_id % TYPE,
    v_mjesto IN kolo.mjesto % TYPE,
    v_adresa IN kolo.adresa % TYPE
    ) AS
    BEGIN
        UPDATE kolo
        SET mjesto = v_mjesto WHERE kolo_id = v_kolo_id;
        UPDATE kolo
        SET adresa = v_adresa WHERE kolo_id = v_kolo_id;
    COMMIT;
END;
/

/*
CALL promjena_mjesta_odrzavanja_kola (1,'Đurđevac', 'S.Radića 47');
SELECT kolo_id, mjesto, adresa FROM kolo;
*/



--Procedura za promjenu kategorije u prijavi.
CREATE OR REPLACE PROCEDURE promjena_kategorije_u_prijavi(
    v_prijava_id IN prijava.prijava_id % TYPE,
    v_kategorija_id IN prijava.kategorija_id % TYPE
    ) AS
    BEGIN
        UPDATE prijava 
        SET kategorija_id = v_kategorija_id WHERE prijava_id = v_prijava_id;
    COMMIT;
END;
/


/*
CALL promjena_kategorije_u_prijavi (1, 3);
SELECT prijava_id, kategorija_id FROM prijava;
*/


-------------------------ZAD.14.--------------------------
--okidači
---Okidač koji upozorava ako se na prijava_id koju mi pokušavamo upisati, već neko nalazi. Te ako je broj ljudi u toj prijavi već 3.

CREATE OR REPLACE TRIGGER  before_insert_op
    BEFORE INSERT ON op 
    FOR EACH ROW 
DECLARE
    brojac INTEGER; 
BEGIN 
    SELECT COUNT(*) INTO brojac FROM op  WHERE prijava_id= :NEW.prijava_id; --postoji li ta prijava
    

    IF brojac = 3 THEN
        RAISE_APPLICATION_ERROR(-20202, 'Ova grupa već ima dovoljno članova, napravi novu prijavu!');
    ELSIF brojac > 0 THEN
        dbms_output.put_line('Na ovom prijava_id je već netko osim Vas upisan. Sada je ovo grupna prijava.');
    END IF;
    
END;
/    

/*
SELECT * FROM op ORDER BY prijava_id;

SET SERVEROUTPUT ON;

INSERT INTO op VALUES ('11111111111', 75);
INSERT INTO op VALUES ('11111111111', 65);

*/



--Okidač koji će izbaciti pogrešku ako se u ligi za broj_kola navede broj manji od 2.

CREATE OR REPLACE TRIGGER broj_kola
BEFORE INSERT ON liga
FOR EACH ROW
WHEN (new.broj_kola < 2)
BEGIN
    RAISE_APPLICATION_ERROR(-20202, 'Premalen broj kola, ponovno unijeti broj_kola!');
END;
/

/*
INSERT INTO liga VALUES(2, 'Međužupanijska liga', 1, TO_DATE('2021/01/04', 'yyyy/mm/dd'), TO_DATE('2021/06/26', 'yyyy/mm/dd') ); --ne moze
INSERT INTO liga VALUES(2, 'Međužupanijska liga', 2, TO_DATE('2021/01/04', 'yyyy/mm/dd'), TO_DATE('2021/06/26', 'yyyy/mm/dd') ); --moze
SELECT * FROM liga;
*/

