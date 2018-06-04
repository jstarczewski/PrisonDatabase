
CREATE PROCEDURE fill_province
  AS
  BEGIN
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
END
CREATE PROCEDURE fill_city
    AS
    BEGIN
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
  ('Sztum', 22),
      ('Goleniów', 32),
  ('Kalisz', 30),
  ('Malbork', 28);
END
CREATE PROCEDURE fill_prison
    AS
  BEGIN
INSERT INTO PRISON (NAME, NUMBER_OF_PRISONER, CITY_ID)
VALUES
  ('ZK Barczewko', 2, 1),
  ('ZK Biała Podlaska', 0, 2),
  ('ZK Białystok', 0, 3),
  ('ZK Braniewo', 3, 4),
  ('ZK Brzeg', 1, 5),
  ('ZK Cieszyn', 6, 6),
  ('ZK Herby', 0, 7),
  ('ZK Iława', 0, 8),
  ('ZK Kłodzko', 0, 9),
  ('ZK Racibórz', 0, 10),
  ('ZK Siedlce', 0, 11),
  ('ZK Tarnów', 1, 13),
  ('ZK Zabrze', 0, 15),
  ('ZK Szczecin', 0, 16),
  ('ZK Łódź', 0, 17),
  ('ZK Stargard', 0, 18),
  ('ZK Sztum', 0, 20),
    ('ZK Goleniów', 0, 21),
  ('ZK Kalisz', 0, 22),
  ('ZK Malbork', 0, 23);
END
CREATE PROCEDURE fill_sentence
  AS
  BEGIN
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
END
CREATE PROCEDURE fill_prisoner
  AS
  BEGIN
INSERT INTO PRISONER (PESEL, NAME, AGE, NUMBER_OF_CRIMES, SEX, SECOND_NAME, SENTENCE_ID, CITY_ID)
VALUES
  ('93012307211', 'Dawid', 25, 1, 'M', 'Markowicz', 1, 1),
  ('65120344011', 'Krystian', 52, 2, 'M', 'Ziarkowski', 2, 2),
  ('80121212345', 'Jolanta', 38, 1, 'F', 'Rulko', 3, 2),
  ('55041454311', 'Donald', 63, 120, 'M', 'Tusk', 4, 14),
  ('00123167820', 'Katarzyna', 18, 12, 'F', 'Wadowicz', 5, 19),
  ('99090956719', 'Janusz', 19, 66, 'M', 'Tracz', 6, 12),
  ('97070712316', 'Radosław', 21, 1, 'M', 'Słowiński', 7, 3),
  ('90030457610', 'Paweł', 28, 12, 'M', 'Furmanek', 8, 20),
  ('90010198712', 'Wojciech', 28, 12, 'M', 'Krawczyk', 9, 1),
  ('90050532113', 'Paweł', 28, 3, 'M', 'Krawczyk', 10, 1),
  ('91010123221', 'Rozalia', 27, 11, 'F', 'Wojszel', 11, 1),
  ('99120222212', 'Alexis', 19, 1, 'F', 'Levefre', 12, 19),
  ('39041411111', 'Jan', 79, 1, 'M', 'Staniszewski', 13, 12),
  ('77010123123', 'Dalia', 41, 44, 'F', 'Shitenheit', 14, 14),
  ('92013009810', 'Jakub', 26, 1, 'M', 'Charkiewicz', 15, 3),
  ('98041400020', 'Krystyna', 20, 1, 'F', 'Czubówna', 16, 11),
  ('80120369420', 'Janina', 38, 69, 'F', 'Jarocka', 17, 17),
  ('81020211213', 'Norbert', 37, 111, 'M', 'Sernik', 18, 11),
  ('77070742019', 'Jan', 41, 120, 'M', 'Buch', 19, 19),
  ('77060612112', 'Jacek', 41, 11, 'M', 'Jackowski', 20, 11),
  ('98033042011', 'Tomasz', 20, 33, 'M', 'Chada', 21, 17);

select *
from PRISONER
END
  CREATE PROCEDURE fill_cell
    AS
    BEGIN
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
  (1, 0, 17),
  (1, 0, 18),
  (1, 0, 19),
  (1, 0, 20);

select *
from CELL
END
SELECT
  PRISONER.PESEL,
  SENTENCE.SINCE,
  PRISONER.NAME,
  PRISONER.SEX
FROM PRISONER, SENTENCE
WHERE PRISONER.SENTENCE_ID = SENTENCE.ID AND SENTENCE.TILL IS NULL
ALTER PROCEDURE fill_accommodation
  AS
  BEGIN
INSERT INTO ACCOMMODATION (SINCE, TILL, PRISONER_ID, CELL_ID)
VALUES
  ('1998-04-14 00:00:00.000', '2007-08-12 00:00:00.000', '77010123123', 11),
  ('2014-03-08 00:00:00.000', '2018-03-08 00:00:00.000', '80120369420', 18),
  ('2013-09-09 00:00:00.000', '2018-12-03 00:00:00.000', '80121212345', 19),
  ('2013-10-11 00:00:00.000', '2018-01-01 00:00:00.000', '90050532113', 20),
  ('2011-07-27 00:00:00.000', '2014-07-24 00:00:00.000', '91010123221', 21),
  ('2006-03-12 00:00:00.000', '2010-05-22 00:00:00.000', '92013009810', 22),
  ('2011-03-03 00:00:00.000', '2013-09-08 00:00:00.000', '98041400020', 25),
  ('2016-05-12 00:00:00.000', '2017-04-04 00:00:00.000', '99090956719', 29),
  ('2011-07-27 00:00:00.000', '2014-07-24 00:00:00.000', '99120222212', 28),
  ('2018-05-05', NULL, '00123167820', 1),
  ('2010-04-10', NULL, '65120344011', 3),
  ('2017-04-14 00:00:00.000', NULL, '55041454311', 3),
  ('2010-04-10 00:00:00.000', NULL, '65120344011', 3),
  ('1992-02-13 00:00:00.000', NULL, '77060612112', 4),
  ('1992-02-13 00:00:00.000', NULL, '77070742019', 4),
  ('1985-06-12 00:00:00.000', NULL, '81020211213', 4),
  ('2015-03-21 00:00:00.000', NULL, '90010198712', 4),
  ('2014-04-20 00:00:00.000', NULL, '90030457610', 4),
  ('1999-03-12 00:00:00.000', NULL, '93012307211', 4),
  ('2014-04-20 00:00:00.000', NULL, '97070712316', 5),
  ('1992-02-13 00:00:00.000', NULL, '98033042011', 6);

select *
from ACCOMMODATION
END

SELECT
  SENTENCE.SINCE,
  SENTENCE.TILL,
  PRISONER.PESEL,
  PRISONER.SEX
FROM SENTENCE, PRISONER
WHERE SENTENCE.ID = PRISONER.SENTENCE_ID AND TILL IS NOT NULL

select * from ACCOMMODATION


ALTER PROCEDURE fill_incident
  AS
  BEGIN
INSERT INTO INCIDENT (SHORT_DESCRIPTION, TIME_OF_INCIDENT, PRISONER_ID, CELL_ID)
VALUES
    ('Próba ucieczki z celi', '2003-07-12 00:00:00.000', '77010123123', 11),
  ('Spożywanie substancji psychoaktwynych','2016-12-01 00:00:00.000', '80120369420', 18),
  ('Przemyt sztućców','2013-09-10 00:00:00.000', '80121212345', 19),
  ('Próba ucieczki z celi' ,'2017-10-11 00:00:00.000', '90050532113', 20),
  ('Natarczywe niszczenie mienia','2014-07-23 00:00:00.000', '91010123221', 21),
  ('Kradzież munduru funkcjonariusza służby więziennej','2006-03-13 00:00:00.000', '92013009810', 21),
  ('Natarczywe niszczenie mienia','2012-12-24 00:00:00.000', '98041400020', 25),
  ('Próba ucieczki z celi','2016-10-11 00:00:00.000', '99090956719', 29),
  ( 'Nielegalne rozprowadzanie czasopismy erotycznych','2011-08-27 00:00:00.000', '99120222212', 28),
  ( 'Nielegalne rozprowadzanie czasopismy erotycznych','2012-03-17 00:00:00.000', '99120222212', 28),
  ( 'Nielegalne rozprowadzanie czasopismy erotycznych','2013-01-30 00:00:00.000', '99120222212', 28),
  ( 'Nielegalne rozprowadzanie czasopismy erotycznych','2014-04-14 00:00:00.000', '99120222212', 28),
  ('Spożywanie środków psychoaktywnych','2018-04-20 00:00:00.000', '55041454311', 3),
  ('Próba ucieczki z celi','2010-04-11 00:00:00.000', '65120344011', 3),
  ('Natarczywe niszczenie mienia','2001-03-11 00:00:00.000', '77060612112', 4),
  ('Spożywanie substancji psychoaktywnych', '1993-04-20 00:00:00.000', '77070742019', 4),
  ('Spożywanie substancji psychoaktywnych', '1994-04-20 00:00:00.000', '77070742019', 4),
  ('Spożywanie substancji psychoaktywnych', '1995-04-20 00:00:00.000', '77070742019', 4),
  ('Spożywanie substancji psychoaktywnych', '1996-04-20 00:00:00.000', '77070742019', 4),
  ('Spożywanie substancji psychoaktywnych', '1997-04-20 00:00:00.000', '77070742019', 4),
  ('Spożywanie substancji psychoaktywnych', '1998-04-20 00:00:00.000', '77070742019', 4);

SELECT * FROM INCIDENT
END

CREATE PROCEDURE fill_all
  AS
  BEGIN
    EXEC fill_province
    EXEC fill_city
    EXEC fill_prison
    EXEC fill_sentence
    EXEC fill_prisoner
    EXEC fill_cell
    EXEC fill_accommodation
    EXEC fill_incident
  end
  exec fill_all

  SELECT * FROM CELL
  SELECT * FROM ACCOMMODATION

  delete from Incident
  delete from Accommodation
  delete from CELL
  delete from Prisoner
  delete from Sentence
  delete from Prison
  delete from City
  delete from Province

  select * from PRISON
    SELECT * FROM CITY
  SELECT * FROM PRISON
  SELECT * FROM SENTENCE
  SELECT * FROM PRISONER
  select * from INCIDENT

DBCC CHECKIDENT(CITY, RESEED, 0)
DBCC CHECKIDENT(PRISON, RESEED, 0)
DBCC CHECKIDENT(SENTENCE, RESEED, 0)
DBCC CHECKIDENT(CELL, RESEED, 0)
DBCC CHECKIDENT(ACCOMMODATION, RESEED, 0)
DBCC CHECKIDENT(INCIDENT, RESEED, 0)