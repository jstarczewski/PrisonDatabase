INSERT INTO PROVINCE (TERYT, NAME)
VALUES
  (02, 'Dolnośląskie'),
  (04, 'Kujawsko-Pomorskie'),
  (06, 'Lubelskie'),
  (08, 'Lubuskie'),
  (10, 'Łódzkie'),
  (12, 'Małopolskie'),
  (14, 'Mazowieskie'),
  (16, 'Opolskie'),
  (18, 'Podkarpackie'),
  (20, 'Podlaskie'),
  (22, 'Pomorskie'),
  (24, 'Śląskie'),
  (26, 'Świętokrzyskie'),
  (28, 'Warmińsko-Mazurskie'),
  (30, 'Wielkopolskie'),
  (32, 'Zachodnipomorskie');

SELECT *
FROM PROVINCE

INSERT INTO CITY (NAME, PROVINCE_ID)
VALUES
  ('Barczewo', 28),
  ('Biala Podlaska', 06),
  ('Białystok', 20),
  ('Braniewo', 28),
  ('Brzeg', 16),
  ('Cieszyn', 24),
  ('Herby', 24),
  ('Iława', 28),
  ('Kłodzko', 02),
  ('Racibórz', 24),
  ('Siedlce', 14),
  ('Warszawa', 14),
  ('Tarnów', 12),
  ('Kraków', 12),
  ('Zabrze', 24),
  ('Szczecin', 32),
  ('Łódź', 10),
  ('Stargard', 32),
  ('Poznań', 30),
  ('Sztum', 22);

INSERT INTO PRISON (NAME, NUMBER_OF_PRISONER, CITY_ID)
VALUES
  ('ZK Barczewko', 1, 1),
  ('ZK Biała Podlaska', 0, 2),
  ('ZK Białystok', 0, 3),
  ('ZK Braniewo', 0, 4),
  ('ZK Brzeg', 0, 5),
  ('ZK Cieszyn', 0, 6),
  ('ZK Herby', 0, 7),
  ('ZK Iława', 0, 8),
  ('ZK Kłodzko', 0, 9),
  ('ZK Racibórz', 0, 10),
  ('ZK Siedlce', 0, 11),
  ('ZK Tarnów', 0, 13),
  ('ZK Zabrze', 0, 15),
  ('ZK Szczecin', 0, 16),
  ('ZK Łódź', 0, 17),
  ('ZK Stargard', 0, 18),
  ('ZK Sztum', 0, 20);


INSERT INTO SENTENCE (DELINQUENCY, SINCE, TILL, PRISON_ID)
VALUES
  ('Morderstwo', '1999 - 03 - 12', null, 1),
  ('Napad na samolot', '2010 - 04 - 10', null, 3),
  ('Napad na bank', '2013 - 09 - 09', '2018 - 12 - 03', 1),
  ('Pobicie', '2017 - 04 - 14', null, 10),
  ('Kradzież danych osobowych', '2018 - 05 - 05', null, 1),
  ('Stalking', '2016 - 05 - 12', '2018 - 04 - 04', 4),
  ('Spożywanie substancji odużajacych w miejscu publicznym', '2014 - 04 - 20', null, 13),
  ('Nielegalny handel substancjami odużającymi', '2014 - 04 - 20', null, 13),
  ('Morderstwo', '2015 - 03 - 21', null, 5),
  ('Pobicie', '2013 - 10 - 11', '2018 - 01 - 01', 5),
  ('Stalking', '2011 - 07 - 27', '2014 - 07 - 24', 12),
  ('Stalking', '2011 - 07 - 27', '2014 - 07 - 24', 11),
  ('Morderstwo', '1977 - 12 - 31', null, 16),
  ('Handel narkotykami', '1998 - 04 - 14', '2007 - 08 - 12', 1),
  ('Stalking', '2006 - 03 - 12', '2010 - 05 - 22', 4),
  ('Napad na bank', '2011 - 03 - 03', '2013 - 09 - 08', 1),
  ('Napad na samolot', '2014 - 03 - 08', '2018 - 03 - 08', 12),
  ('Morderstwo', '1985 - 06 - 12', null, 1),
  ('Porwanie', '1992 - 02 - 13', null, 7),
  ('Porwanie', '1992 - 02 - 13', null, 6),
  ('Porwanie', '1992 - 02 - 13', null, 8);

SELECT *
FROM SENTENCE

INSERT INTO PRISONER (PESEL, NAME, AGE, NUMBER_OF_CRIMES, SEX, SECOND_NAME, SENTENCE_ID, CITY_ID)
VALUES
  ('93012307211', 'Dawid', 25, 1, 'M', 'Markowicz', 47, 1),
  ('65120344011', 'Krystian', 52, 2, 'M', 'Ziarkowski', 48, 2),
  ('80121212345', 'Jolanta', 38, 1, 'F', 'Rulko', 49, 2),
  ('55041454311', 'Donald', 63, 120, 'M', 'Tusk', 50, 14),
  ('00123167820', 'Katarzyna', 18, 12, 'F', 'Wadowicz', 51, 19),
  ('99090956719', 'Janusz', 19, 66, 'M', 'Tracz', 52, 12),
  ('97070712316', 'Radosław', 21, 1, 'M', 'Słowiński', 53, 3),
  ('90030457610', 'Paweł', 28, 12, 'M', 'Furmanek', 54, 20),
  ('90010198712', 'Wojciech', 28, 12, 'M', 'Krawczyk', 55, 1),
  ('90050532113', 'Paweł', 28, 3, 'M', 'Krawczyk', 56, 1),
  ('91010123221', 'Rozalia', 27, 11, 'F', 'Wojszel', 57, 1),
  ('99120222212', 'Alexis', 19, 1, 'F', 'Levefre', 58, 19),
  ('39041411111', 'Jan', 79, 1, 'M', 'Staniszewski', 59, 12),
  ('77010123123', 'Dalia', 41, 44, 'F', 'Shitenheit', 60, 14),
  ('92013009810', 'Jakub', 26, 1, 'M', 'Charkiewicz', 61, 3),
  ('98041400020', 'Krystyna', 20, 1, 'F', 'Czubówna', 62, 11),
  ('80120369420', 'Janina', 38, 69, 'F', 'Jarocka', 63, 17),
  ('81020211213', 'Norbert', 37, 111, 'M', 'Sernik', 64, 11),
  ('77070742019', 'Jan', 41, 120, 'M', 'Buch', 65, 19),
  ('77060612112', 'Jacek', 41, 11, 'M', 'Jackowski', 66, 11),
  ('98033042011', 'Tomasz', 20, 33, 'M', 'Chada', 67, 17);

select *
from PRISONER

INSERT INTO CELL (RESIDORS_LIMIT, CURRENT_RESIDORS_NUMBER, PRISON_ID)
VALUES
  (1, 1, 1),
  (2, 0, 5),
  (3, 3, 4),
  (6, 6, 6),
  (3, 1, 1),
  (4, 0, 13),
  (1, 1, 12),
  (3, 1, 5),
  (1, 0, 1),
  (5, 0, 16),
  (1, 0, 14),
  (1, 0, 9),
  (1, 0, 1),
  (1, 0, 2),
  (1, 0, 3),
  (1, 0, 4),
  (1, 0, 5),
  (1, 0, 6),
  (1, 0, 7),
  (1, 0, 8),
  (1, 0, 9),
  (1, 0, 10),
  (1, 0, 11),
  (1, 0, 12),
  (1, 0, 13),
  (1, 0, 14),
  (1, 0, 15),
  (1, 0, 16),
  (1, 0, 17);

select *
from CELL

SELECT
  PRISONER.PESEL,
  SENTENCE.SINCE,
  PRISONER.NAME,
  PRISONER.SEX
FROM PRISONER, SENTENCE
WHERE PRISONER.SENTENCE_ID = SENTENCE.ID AND SENTENCE.TILL IS NULL

INSERT INTO ACCOMMODATION (SINCE, TILL, PRISONER_ID, CELL_ID)
VALUES
  ('1998-04-14 00:00:00.000', '2007-08-12 00:00:00.000', '77010123123', 40),
  ('2014-03-08 00:00:00.000', '2018-03-08 00:00:00.000', '80120369420', 47),

  ('2013-09-09 00:00:00.000', '2018-12-03 00:00:00.000', '80121212345', 48),

  ('2013-10-11 00:00:00.000', '2018-01-01 00:00:00.000', '90050532113', 49),
  ('2011-07-27 00:00:00.000', '2014-07-24 00:00:00.000', '91010123221', 50),
  ('2006-03-12 00:00:00.000', '2010-05-22 00:00:00.000', '92013009810', 51),
  ('2011-03-03 00:00:00.000', '2013-09-08 00:00:00.000', '98041400020', 54),
  ('2016-05-12 00:00:00.000', '2017-04-04 00:00:00.000', '99090956719', 58),
  ('2011-07-27 00:00:00.000', '2014-07-24 00:00:00.000', '99120222212', 57),
  ('2018-05-05', NULL, '00123167820', 30),
  ('2010-04-10', NULL, '65120344011', 32),
  ('2017-04-14 00:00:00.000', NULL, '55041454311', 32),
  ('2010-04-10 00:00:00.000', NULL, '65120344011', 32),
  ('1992-02-13 00:00:00.000', NULL, '77060612112', 33),
  ('1992-02-13 00:00:00.000', NULL, '77070742019', 33),
  ('1985-06-12 00:00:00.000', NULL, '81020211213', 33),
  ('2015-03-21 00:00:00.000', NULL, '90010198712', 33),
  ('2014-04-20 00:00:00.000', NULL, '90030457610', 33),
  ('1999-03-12 00:00:00.000', NULL, '93012307211', 33),
  ('2014-04-20 00:00:00.000', NULL, '97070712316', 34),
  ('1992-02-13 00:00:00.000', NULL, '98033042011', 36);

select *
from ACCOMMODATION

SELECT
  SENTENCE.SINCE,
  SENTENCE.TILL,
  PRISONER.PESEL,
  PRISONER.SEX
FROM SENTENCE, PRISONER
WHERE SENTENCE.ID = PRISONER.SENTENCE_ID AND TILL IS NOT NULL

select * from ACCOMMODATION

INSERT INTO INCIDENT (SHORT_DESCRIPTION, TIME_OF_INCIDENT, PRISONER_ID, CELL_ID)
VALUES
  ('Pobicie ')