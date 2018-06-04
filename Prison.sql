
/*Czyszczenie bazy danych - tabel, procedur, truggerów, zerowanie sztucznych id*/

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

DROP TRIGGER update_city_after_insert
DROP TRIGGER insert_prison_message
DROP TRIGGER update_city_after_update
DROP TRIGGER update_city_after_update
DROP TRIGGER update_cell_after_update
DROP TRIGGER delete_incident
DROP TRIGGER delete_cell
DROP TRIGGER delete_incidents
DROP TRIGGER update_prisoners_in_cell
DROP TRIGGER update_prisoners_in_cell_after_delete
DROP TRIGGER update_prisoners_in_prison_after_delete
DROP TRIGGER update_prisoners_in_prison
DROP TRIGGER update_sentence_on_wrong_till
DROP TRIGGER update_accommodation_on_wrong_till

DROP PROCEDURE accommodate_prisoner
DROP PROCEDURE new_prison
DROP PROCEDURE update_province
DROP PROCEDURE update_city
DROP PROCEDURE update_prison
DROP PROCEDURE update_sentence
DROP PROCEDURE update_prisoner
DROP PROCEDURE update_cell
DROP PROCEDURE update_accommodation
DROP PROCEDURE update_incident
DROP PROCEDURE find_prisoners_free_before
DROP PROCEDURE find_prisoners_from_city
DROP PROCEDURE find_prisoner_sentenced_before

/*
  Tworzenie tabel w bazie
*/

CREATE TABLE PROVINCE
(
 TERYT INT NOT NULL PRIMARY KEY,
 NAME NVARCHAR(40) NOT NULL
)
CREATE TABLE CITY
(
 ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
 NAME NVARCHAR(40) NOT NULL ,
 PROVINCE_ID INT NOT NULL FOREIGN KEY REFERENCES PROVINCE(TERYT)
)
CREATE TABLE PRISON
(
 ID INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
 NAME NVARCHAR(40) NOT NULL ,
 NUMBER_OF_PRISONER INT,
 CITY_ID INT FOREIGN KEY REFERENCES CITY(ID)
)
CREATE TABLE SENTENCE
(
 ID INT IDENTITY (1,1) NOT NULL PRIMARY KEY ,
 DELINQUENCY NVARCHAR(255) NOT NULL ,
 SINCE DATETIME NOT NULL,
 TILL DATETIME,
 PRISON_ID INT FOREIGN KEY REFERENCES PRISON(ID)
)
CREATE TABLE PRISONER
(
   PESEL NVARCHAR(11) NOT NULL PRIMARY KEY ,
 NAME NVARCHAR(255) NOT NULL,
 AGE INT NOT NULL,
 NUMBER_OF_CRIMES INT,
 SEX NVARCHAR(1) NOT NULL,
 SECOND_NAME NVARCHAR(255) NOT NULL,
 SENTENCE_ID INT FOREIGN KEY REFERENCES SENTENCE(ID),
 CITY_ID INT NOT NULL FOREIGN KEY REFERENCES CITY(ID)
)
CREATE TABLE CELL
(
 ID INT IDENTITY (1,1) NOT NULL PRIMARY KEY ,
 RESIDORS_LIMIT INT NOT NULL,
 CURRENT_RESIDORS_NUMBER INT NOT NULL,
 PRISON_ID INT NOT NULL FOREIGN KEY REFERENCES PRISON(ID)
)
CREATE TABLE ACCOMMODATION
(
 ACCOMMODATION_ID INT IDENTITY (1,1) NOT NULL PRIMARY KEY ,
 SINCE DATETIME NOT NULL ,
 TILL DATETIME NOT NULL ,
 PRISONER_ID NVARCHAR(11) NOT NULL FOREIGN KEY REFERENCES PRISONER(PESEL),
 CELL_ID INT NOT NULL FOREIGN KEY REFERENCES CELL(ID)
)
CREATE TABLE INCIDENT
(
 INCIDENT_ID INT IDENTITY (1,1) NOT NULL PRIMARY KEY ,
 SHORT_DESCRIPTION NVARCHAR(255),
 TIME_OF_INCIDENT DATETIME,
 PRISONER_ID NVARCHAR(11) NOT NULL FOREIGN KEY REFERENCES PRISONER(PESEL),
 CELL_ID INT NOT NULL FOREIGN KEY REFERENCES CELL(ID)
)
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

  /*
    Tworzenie procedur zasilajacych które na koniec zostana wywołane
  */

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
CREATE PROCEDURE fill_accommodation
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


CREATE PROCEDURE fill_incident
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
/*
  Procedura zasilajaca wszystkie tabele
*/

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

  /*
    Szereg podobnych procedur, które dodają pojedyncze rekordy do danych tabel

  */

  CREATE PROCEDURE add_province
 @teryt INT,
 @name NVARCHAR(40)
AS
 BEGIN
 INSERT INTO PROVINCE (TERYT, NAME)
 VALUES (@teryt, @name);
 SELECT *
 FROM PROVINCE
END;
go
CREATE PROCEDURE add_city
 @province_id INT,
 @name NVARCHAR(40)
 AS
 BEGIN
 INSERT INTO CITY (PROVINCE_ID, NAME)
 VALUES (@province_id, @name);
 SELECT *
 FROM CITY
END;
drop procedure add_city
go
 CREATE PROCEDURE add_prison
 @city_id INT,
 @name NVARCHAR(40),
 @number_of_prisoners INT
 AS
 BEGIN
 INSERT INTO PRISON (NAME, NUMBER_OF_PRISONER, CITY_ID)
 VALUES (@name, @number_of_prisoners, @city_id);
 SELECT *
 FROM PRISON
 END;
go
CREATE PROCEDURE add_sentence
 @prison_id NVARCHAR(11),
 @deliquency NVARCHAR(255),
 @since DATETIME,
 @till DATETIME
 AS
 BEGIN
 INSERT INTO SENTENCE (PRISON_ID, DELINQUENCY, SINCE, TILL)
 VALUES (@prison_id, @deliquency, @since, @till);
 SELECT *
 FROM SENTENCE
 END;
 go
CREATE PROCEDURE add_prisoner
 @pesel NVARCHAR(11),
 @name NVARCHAR(255),
 @age INT,
 @sex NVARCHAR(1),
 @second_name NVARCHAR(255),
 @number_of_crimes INT,
 @sentence_id INT,
 @city_id INT
 AS
 BEGIN
 INSERT INTO PRISONER (PESEL, NAME, AGE, NUMBER_OF_CRIMES, SEX,
SECOND_NAME, SENTENCE_ID, CITY_ID)
 VALUES (@pesel,
 @name,
@age,
@number_of_crimes,
@sex,
@second_name,
@sentence_id,
@city_id);
 SELECT *
 FROM PRISONER
 END;
 go
CREATE PROCEDURE add_cell
 @residors_limit INT,
 @current_residors_number INT,
 @prison_id INT
 AS
 BEGIN
 INSERT INTO CELL (RESIDORS_LIMIT, CURRENT_RESIDORS_NUMBER,
PRISON_ID)
 VALUES (@residors_limit, @current_residors_number,
@prison_id);
 SELECT *
 FROM CELL
 END;
 go
CREATE PROCEDURE add_accomodation
 @since DATETIME,
 @till DATETIME,
 @prisoner_id INT,
 @cell_id INT
 AS
 BEGIN
 INSERT INTO ACCOMMODATION (SINCE, TILL, PRISONER_ID,
CELL_ID)
 VALUES (@since, @till, @prisoner_id, @cell_id);
 SELECT *
 FROM ACCOMMODATION
 end;
go
CREATE PROCEDURE add_incident
 @short_description NVARCHAR(255),
 @time_of_incident DATETIME,
@prisoner_id NVARCHAR(11),
 @cell_id INT
 AS
 BEGIN
 INSERT INTO INCIDENT (SHORT_DESCRIPTION,
TIME_OF_INCIDENT, PRISONER_ID, CELL_ID)
 VALUES (@short_description, @time_of_incident,
@prisoner_id, @cell_id);
 SELECT *
FROM INCIDENT
end;


  /**
    Szereg procedur aktualizujacych wybrane wiersze

  */
 /*
  Procedura do aktualizujaca wojewodztwa
  */
CREATE PROCEDURE update_province
    @teryt     INT,
    @name      NVARCHAR(40),
    @new_teryt INT
AS
  BEGIN
    SET NOCOUNT ON
    UPDATE PROVINCE
    SET
      TERYT = ISNULL(@new_teryt, TERYT),
      NAME  = isnull(@name, NAME)
    WHERE TERYT = @teryt
  END

  SELECT *
  FROM PROVINCE
  EXEC update_province 2, 'DS Ustronie', null
/*
  Procedura do aktualizujaca miasta
  */
  CREATE PROCEDURE update_city
      @name            NVARCHAR(40),
      @province_id     INT,
      @new_name        NVARCHAR(40),
      @new_province_id INT
  AS
    BEGIN
      SET NOCOUNT ON
      DECLARE @id int = (SELECT CITY.ID
                         FROM CITY
                         WHERE CITY.NAME = @name AND CITY.PROVINCE_ID = @province_id);

      UPDATE CITY
      SET
        NAME        = ISNULL(@new_name, NAME),
        PROVINCE_ID = isnull(@new_province_id, PROVINCE_ID)
      WHERE ID = @id
    end

    select *
    from CITY

    exec update_city 'Mrągowo', 28, 'Barczewo', 28
/*
  Procedura do aktualizujaca więzienia
  */
    CREATE PROCEDURE update_prison
        @name                    NVARCHAR(40),
        @city_id                 INT,
        @new_number_of_prisoners INT,
        @new_name                NVARCHAR(40),
        @new_city_id             INT
    AS
      BEGIN
        SET NOCOUNT ON

        DECLARE @id INT = (SELECT PRISON.ID
                           FROM PRISON
                           WHERE NAME = @name AND CITY_ID = @city_id);

        UPDATE PRISON
        SET
          NAME               = ISNULL(@new_name, NAME),
          CITY_ID            = ISNULL(@new_city_id, CITY_ID),
          NUMBER_OF_PRISONER = ISNULL(@new_number_of_prisoners, NUMBER_OF_PRISONER)
        WHERE ID = @id
      end

      SELECT *
      FROM PRISON

      exec update_prison 'DS Ustronie', 1, '2', 'ZK Barczewko', 1
/*
  Procedura do aktualizujaca wyroki
  */
      CREATE PROCEDURE update_sentence
          @deliquency     NVARCHAR(255),
          @since          DATETIME,
          @till           DATETIME,
          @prison_id      INT,
          @new_deliquency NVARCHAR(255),
          @new_since      DATETIME,
          @new_till       DATETIME,
          @new_prison_id  INT
      AS
        BEGIN

              SET NOCOUNT ON
              DECLARE @id INT = (SELECT SENTENCE.ID
                                 FROM SENTENCE
                                 WHERE DELINQUENCY LIKE @deliquency AND SINCE = @since AND TILL = @till AND
                                       PRISON_ID = @prison_id);
              UPDATE SENTENCE
              SET
                DELINQUENCY = ISNULL(@new_deliquency, DELINQUENCY),
                SINCE       = @new_since,
                TILL        = @new_till,
                PRISON_ID   = ISNULL(@new_prison_id, PRISON_ID)
              WHERE ID = @id


        end

        SELECT *
        FROM SENTENCE

        EXEC update_sentence 'Morderstwo', '1999-03-12', '2018-12-03', 1, 'Zbieranie jagód', '1999-03-12', '2018-12-03', 1

/*
  Procedura do aktualizujaca wiezniow
  */
        CREATE PROCEDURE update_prisoner
            @pesel            NVARCHAR(11),
            @name             NVARCHAR(255),
            @age              INT,
            @number_of_crimes INT,
            @sex              NVARCHAR(1),
            @second_name      NVARCHAR(255),
            @sentence_id      INT,
            @city_id          INT
        AS
          BEGIN
            SET NOCOUNT ON
            UPDATE PRISONER
            SET
              PESEL            = ISNULL(@pesel, PESEL),
              NAME             = ISNULL(@name, NAME),
              AGE              = ISNULL(@age, AGE),
              NUMBER_OF_CRIMES = ISNULL(@number_of_crimes, NUMBER_OF_CRIMES),
              SEX              = ISNULL(@sex, SEX),
              SECOND_NAME      = ISNULL(@second_name, SECOND_NAME),
              SENTENCE_ID      = ISNULL(@sentence_id, SENTENCE_ID),
              CITY_ID          = ISNULL(@city_id, CITY_ID)
            WHERE PESEL = @pesel
          end

          select *
          from prisoner

          exec update_prisoner '00123167820', 'Katarzyna', 18, 12, 'F', 'Wadowicz', 5, 19
/*
  Procedura do aktualizujaca cele
  */

          CREATE PROCEDURE update_cell
              @residors_limit              INT,
              @current_residors_number     INT,
              @prison_id                   INT,
              @new_residors_limit          INT,
              @new_current_residors_number INT,
              @new_prison_id               INT
          AS
            BEGIN
              SET NOCOUNT ON

              DECLARE @id INT = (SELECT CELL.ID
                                 FROM CELL
                                 WHERE RESIDORS_LIMIT = @residors_limit AND
                                       CURRENT_RESIDORS_NUMBER = @current_residors_number AND PRISON_ID = @prison_id);

              UPDATE CELL
              SET
                RESIDORS_LIMIT          = ISNULL(@new_residors_limit, RESIDORS_LIMIT),
                CURRENT_RESIDORS_NUMBER = ISNULL(@new_current_residors_number, CURRENT_RESIDORS_NUMBER),
                PRISON_ID               = ISNULL(@new_prison_id, PRISON_ID)
              WHERE ID = @id
            end

            select *
            from CELL
            exec update_cell 1, 1, 1, 1, 1, 1

            exec update_cell 43, 1, 1, 3;
            select *
            from cell
            select *
            from PRISONER
            select *
            from SENTENCE
            /*
  Procedura do aktualizujaca zakwaterowanie
  */

            CREATE PROCEDURE update_accommodation

                @since           DATETIME,
                @till            DATETIME,
                @prisoner_id     NVARCHAR(11),
                @cell_id         INT,
                @new_since       DATETIME,
                @new_till        DATETIME,
                @new_prisoner_id NVARCHAR(11),
                @new_cell_id     INT
            AS
              BEGIN



                    SET NOCOUNT ON

                    DECLARE @id INT = (SELECT ACCOMMODATION.ACCOMMODATION_ID
                                       FROM ACCOMMODATION
                                       WHERE PRISONER_ID = @prisoner_id AND SINCE = @since AND TILL = @till AND
                                             CELL_ID = @cell_id);

                    UPDATE ACCOMMODATION
                    SET
                      SINCE       = ISNULL(@new_since, SINCE),
                      TILL        = ISNULL(@new_till, TILL),
                      PRISONER_ID = ISNULL(@new_prisoner_id, PRISONER_ID),
                      CELL_ID     = ISNULL(@new_cell_id, CELL_ID)
                    WHERE ACCOMMODATION_ID = @id

                  end


              select *
              from ACCOMMODATION
              exec update_accommodation '1998-04-14', '2017-08-12', '77010123123', 12, '1998-04-14', '2007-08-12',
                                        '77010123123', 11

              /*
  Procedura do aktualizujaca incydent
  */
              CREATE PROCEDURE update_incident
                  @short_description     NVARCHAR,
                  @time_of_incident      DATETIME,
                  @prisoner_id           NVARCHAR(11),
                  @cell_id               INT,
                  @new_short_description NVARCHAR,
                  @new_time_of_incident  DATETIME,
                  @new_prisoner_id       NVARCHAR(11),
                  @new_cell_id           INT


              AS
                BEGIN
                  SET NOCOUNT ON
                  DECLARE @id INT = (SELECT INCIDENT.INCIDENT_ID
                                     FROM INCIDENT
                                     WHERE
                                       SHORT_DESCRIPTION LIKE @short_description AND TIME_OF_INCIDENT = @time_of_incident
                                       AND PRISONER_ID = @prisoner_id AND CELL_ID = @cell_id);

                  UPDATE INCIDENT
                  SET
                    SHORT_DESCRIPTION = ISNULL(@new_short_description, SHORT_DESCRIPTION),
                    TIME_OF_INCIDENT  = ISNULL(@new_time_of_incident, TIME_OF_INCIDENT),
                    PRISONER_ID       = ISNULL(@new_prisoner_id, PRISONER_ID),
                    CELL_ID           = ISNULL(@new_cell_id, CELL_ID)
                  WHERE INCIDENT_ID = @id
                end


                exec update_incident 'Próba ucieczki z celi', '2003-07-12', '77010123123', 11,
                                     'Próba zjedzenia wspólokatora', '2013-07-12', '77010123123', 11


                exec update_incident 	'Spozywanie substancji psychoaktwynych',	'2016-12-01 00:00:00.000'	,'80120369420',	18, 	'Spozywanie miesa w piatek',
                                      '2016-12-01 00:00:00.000'	,'80120369420',	18


                SELECT INCIDENT.INCIDENT_ID
                FROM INCIDENT
                WHERE
                  SHORT_DESCRIPTION = 'Próba ucieczki z celi' AND TIME_OF_INCIDENT = '2003-07-12'
                  AND PRISONER_ID = '77010123123' AND CELL_ID = 11
                select *
                from INCIDENT

                /*	Procedura dodająca więźnia, tworząca dla niego wyrok, dodająca go do więzienia,
                wkładająca go do celi  i tworząca zakwaterowanie,
                sprawdza czy istnieje więzień o tym samym peselu, sprawdza podstawowe bledy */

  CREATE PROCEDURE accommodate_prisoner

    @pesel            NVARCHAR(11),
    @name             NVARCHAR(255),
    @second_name      NVARCHAR(255),
    @age              INT,
    @sex              NVARCHAR(1),
    @city_name        NVARCHAR(40),
    @deliquency       NVARCHAR(255),
    @number_of_crimes INT,
    @prison_name      NVARCHAR(255),
    @since            DATETIME,
    @till             DATETIME,
    @cell_id          INT



AS
  BEGIN

    DECLARE @prison_id INT = (SELECT PRISON.ID
                              FROM PRISON
                              WHERE PRISON.NAME = @prison_name);
    DECLARE @city_id INT = (SELECT CITY.ID
                            FROM CITY
                            WHERE CITY.NAME = @city_name);

    IF EXISTS(SELECT CELL.ID
              FROM CELL
              WHERE CELL.CURRENT_RESIDORS_NUMBER < CELL.RESIDORS_LIMIT
                    AND CELL.ID = @cell_id
                    AND CELL.PRISON_ID = @prison_id)
       AND NOT EXISTS(SELECT *
                      FROM PRISONER
                      WHERE PRISONER.PESEL = @pesel)
       AND EXISTS(SELECT *
                  FROM CITY
                  WHERE CITY.ID = @city_id)
      BEGIN
        INSERT INTO SENTENCE (PRISON_ID, DELINQUENCY, SINCE, TILL)
        VALUES (@prison_id, @deliquency, @since, @till);
        SELECT *
        FROM SENTENCE

        INSERT INTO PRISONER (PESEL, NAME, AGE, NUMBER_OF_CRIMES, SEX, SECOND_NAME, SENTENCE_ID, CITY_ID)
        VALUES (@pesel,
                @name,
                @age,
                @number_of_crimes,
                @sex,
                @second_name,
                (SELECT IDENT_CURRENT('SENTENCE')),
                @city_id)
        INSERT INTO ACCOMMODATION (SINCE, TILL, PRISONER_ID, CELL_ID)
        VALUES (@since, @till, @pesel, @cell_id);
        exec update_cell @cell_id, null, 1, @prison_id, null, null;
        SET NOCOUNT ON
        UPDATE PRISON
        SET
          NUMBER_OF_PRISONER = NUMBER_OF_PRISONER + 1
        WHERE ID = @prison_id

      END
    ELSE
      BEGIN
        PRINT N'Nie udało sie wykonac procedury, możliwe błędy to: Osoba o takim PESELU juz istnieje, Nie istnieje miasto, z którego pochodzi osoba, cela nie jest w tym samym więzieniu jakie wskazano, cela jest pełna';
      END
  END

/*
  Procedura znajdujaca wiezniow z danego miast
*/
    CREATE PROCEDURE find_prisoners_from_city
  @city_name NVARCHAR(40)
  AS
  BEGIN
    SELECT PRISONER.NAME AS IMIĘ,
      PRISONER.SECOND_NAME AS NAZWISKO,
      PRISONER.AGE AS WIEK,
      SENTENCE.SINCE AS OD,
      SENTENCE.DELINQUENCY AS PRZEWINIENIE
      FROM PRISONER, SENTENCE, CITY
      WHERE CITY.NAME LIKE @city_name
    AND CITY.ID = PRISONER.CITY_ID
    AND PRISONER.SENTENCE_ID = SENTENCE.ID
  END

  select * from PRISONER
  select * from CITY

  EXEC find_prisoners_from_city 'Barczewo'


      /*
      Procedura znajdujaca skazanych przed danym rokiem
      */

CREATE PROCEDURE find_prisoner_sentenced_before
  @since DATETIME
  AS
  BEGIN
     SELECT PRISONER.NAME AS IMIĘ,
      PRISONER.SECOND_NAME AS NAZWISKO,
      PRISONER.AGE AS WIEK,
      SENTENCE.SINCE AS OD,
      SENTENCE.TILL AS DO,
      SENTENCE.DELINQUENCY AS PRZEWINIENIE
      FROM PRISONER, SENTENCE, CITY
      WHERE DATEDIFF(YEAR, @since, SENTENCE.SINCE) < 0
    AND CITY.ID = PRISONER.CITY_ID
    AND PRISONER.SENTENCE_ID = SENTENCE.ID

  END

  EXEC find_prisoner_sentenced_before '1999-12-2'

  /*
    Procedura znajdujaca wypuszczonych przed danym rokiem
  */
CREATE PROCEDURE find_prisoners_free_before
    @till DATETIME
    AS
  BEGIN
     SELECT PRISONER.NAME AS IMIĘ,
      PRISONER.SECOND_NAME AS NAZWISKO,
      PRISONER.AGE AS WIEK,
      SENTENCE.SINCE AS OD,
      SENTENCE.TILL AS DO,
      SENTENCE.DELINQUENCY AS PRZEWINIENIE
      FROM PRISONER, SENTENCE, CITY
      WHERE DATEDIFF(YEAR, @till, SENTENCE.TILL) < 0
    AND CITY.ID = PRISONER.CITY_ID
    AND PRISONER.SENTENCE_ID = SENTENCE.ID
    AND SENTENCE.TILL IS NOT NULL


  END

  drop procedure find_prisoners_free_before

  select * from prisoner

  EXEC find_prisoners_free_before '2019-01-20'




  SELECT
    CITY.NAME   AS [city name],
    PRISON.NAME as [prison name],
    PRISON.ID
  FROM CITY, PRISON, CELL, SENTENCE, PRISONER
  WHERE PRISON.ID = CELL.PRISON_ID AND PRISON.CITY_ID = CITY.ID AND CELL.CURRENT_RESIDORS_NUMBER < CELL.RESIDORS_LIMIT

SELECT
    CITY.NAME   AS [city name],
    PRISON.NAME as [prison name],
    PRISONER.NAME
  FROM CITY, PRISON, CELL, SENTENCE, PRISONER
  WHERE PRISON.ID = CELL.PRISON_ID AND PRISON.CITY_ID = CITY.ID AND PRISONER.SENTENCE_ID = SENTENCE.ID AND SENTENCE.PRISON_ID = PRISON.ID
  AND PRISONER.CITY_ID = PRISON.CITY_ID


  SELECT *
  FROM PRISON


/*Procedura tworząca nowe więzienie i cele w nim.*/



  CREATE PROCEDURE new_prison
      @city_id        INT,
      @name           NVARCHAR(40),
      @residors_limit INT

  AS
    BEGIN
      INSERT INTO PRISON (NAME, NUMBER_OF_PRISONER, CITY_ID)
      VALUES (@name, 0, @city_id);

      declare @id INT = (SELECT IDENT_CURRENT('PRISON'));
      INSERT INTO CELL (RESIDORS_LIMIT, CURRENT_RESIDORS_NUMBER, PRISON_ID)
      VALUES
        (@residors_limit, 0, @id),
        (@residors_limit, 0, @id),
        (@residors_limit, 0, @id),
        (@residors_limit, 0, @id),
        (@residors_limit, 0, @id),
        (@residors_limit, 0, @id);

    END
    drop procedure new_prison
    EXEC new_prison 15, 'DS Ustronie', 2

    SELECT CITY.ID
    FROM CITY
    WHERE CITY.NAME = 'Braniewo'

    SELECT IDENT_CURRENT('PRISON')
    select *
    from PRISON

      select * from cell

    /*
    Trigger aktualizujacy misto osadzone gdy skazano go na dozywocie, zmienia miasto na miasto wiezienia
    */

  ALTER TRIGGER update_city_after_insert
  ON PRISONER
  AFTER INSERT
AS
  BEGIN
    IF EXISTS(SELECT
                CITY.NAME,
                PRISONER.NAME,
                PRISONER.SECOND_NAME,
                PRISONER.CITY_ID,
                PRISON.CITY_ID
              FROM
                PRISONER, SENTENCE, CITY, PRISON
              WHERE PRISONER.CITY_ID = CITY.ID
                    AND PRISONER.SENTENCE_ID = SENTENCE.ID
                    AND SENTENCE.TILL IS NULL
                    AND SENTENCE.PRISON_ID = PRISON.ID
                    AND PRISON.CITY_ID != PRISONER.CITY_ID
    )
      BEGIN
        DECLARE @pesel NVARCHAR(11) = (SELECT PRISONER.PESEL
                                       FROM
                                         PRISONER, SENTENCE, CITY, PRISON
                                       WHERE PRISONER.CITY_ID = CITY.ID
                                             AND PRISONER.SENTENCE_ID = SENTENCE.ID
                                             AND SENTENCE.TILL IS NULL
                                             AND SENTENCE.PRISON_ID = PRISON.ID
                                             AND PRISON.CITY_ID != PRISONER.CITY_ID
                                             AND SENTENCE.ID = (SELECT IDENT_CURRENT('SENTENCE')))
        DECLARE @city_id INT = (SELECT PRISON.CITY_ID
                                FROM
                                  PRISONER, SENTENCE, CITY, PRISON
                                WHERE PRISONER.CITY_ID = CITY.ID
                                      AND PRISONER.SENTENCE_ID = SENTENCE.ID
                                      AND SENTENCE.TILL IS NULL
                                      AND SENTENCE.PRISON_ID = PRISON.ID
                                      AND PRISON.CITY_ID != PRISONER.CITY_ID
                                      AND PRISONER.PESEL = @pesel);

        exec update_prisoner @pesel, null, null, null, null, null, null, @city_id
      end
  end

    /**

    Trigger wyswietlajacy wiadomość, ze zostalo dodane wiezienie
     */

  CREATE TRIGGER insert_prison_message
  ON PRISON
  AFTER INSERT
AS
  BEGIN
    PRINT N'PRISON ADDED';
  end
 exec add_prison 3,'DS Ustronie', 3

    /* Trigger wyswietlajacy wiadomość, ze zostalo usuniety incydent
     */

  CREATE TRIGGER delete_incident
  ON INCIDENT
  AFTER DELETE
AS
  BEGIN
    PRINT N'INCIDENT DELETED';
  end
    /*
 Trigger wyswietlajacy wiadomość, ze zostala usunieta cela
     */
CREATE TRIGGER delete_cell
  ON CELL
  AFTER DELETE
AS
  BEGIN
    PRINT N'CELL DELETED';
  end
/*
     Trigger cofajace nielogiczne zmiany odnosnie czasu odsiadki
     */

CREATE TRIGGER update_sentence_on_wrong_till
  ON SENTENCE
  FOR UPDATE
AS
BEGIN
IF UPDATE(TILL)
	UPDATE SENTENCE
	SET TILL = d.TILL
			from deleted d
			JOIN SENTENCE s ON (s.ID = d.ID)
		where d.ID IN (SELECT d.ID
					FROM deleted d
					JOIN inserted i ON(i.ID = d.ID)
					WHERE d.SINCE > i.TILL
			)
  PRINT N'Proba zmiany daty wyjscia na mniejsza nie wejscia';
END

    /*
     Trigger cofajace nielogiczne zmiany odnosnie czasu zakwaterowania
     */

drop trigger update_sentence_on_wrong_till

ALTER TRIGGER update_accommodation_on_wrong_till
  ON ACCOMMODATION
  FOR UPDATE
AS
BEGIN
IF UPDATE(TILL)
	UPDATE ACCOMMODATION
	SET TILL = d.TILL
			from deleted d
			JOIN ACCOMMODATION a ON (a.ACCOMMODATION_ID = d.ACCOMMODATION_ID)
		where d.ACCOMMODATION_ID IN (SELECT d.ACCOMMODATION_ID
					FROM deleted d
					JOIN inserted i ON(i.ACCOMMODATION_ID = d.ACCOMMODATION_ID)
					WHERE d.SINCE > i.TILL
			)
  PRINT N'Proba zmiany daty konca kwaterunku na wczesniejsza niz poczatek';
END

  select * from ACCOMMODATION

  exec update_accommodation '2013-09-09', '2011-12-03', '80121212345', 19

          exec update_accommodation '1998-04-14', '2017-08-12', '77010123123', 12, '1998-04-14', '1977-08-12',
                                        '77010123123', 11

SELECT * FROM SENTENCE

    /*
      Trigger wyswietlajacy wiadomosc o aktualizacji celo
    */

  CREATE TRIGGER update_cell_after_update
  ON CELL
  AFTER UPDATE
AS
  BEGIN
    PRINT N'CELL UPDATED';
  end

 exec update_cell 1, 1, 1, 1, 1, 1


  EXEC accommodate_prisoner  '99031119931', 'Krystian', 'Czajnik', 19, 'M', 'Warszawa', 'Napad na bank', 12, 'ZK Stargard', '2018-02-03', '2020-01-01', 10

    /**
      Trigger aktualizujacy ilosc wieznio w celi po dodaniu wieznia
    */

CREATE TRIGGER update_prisoners_in_cell
  ON ACCOMMODATION
  AFTER INSERT
AS
  BEGIN
    DECLARE @cell_id INT = (SELECT CELL.ID
                            FROM ACCOMMODATION, CELL
                            WHERE ACCOMMODATION.CELL_ID = CELL.ID AND
                                  ACCOMMODATION.ACCOMMODATION_ID = (SELECT IDENT_CURRENT('ACCOMMODATION')));
    UPDATE CELL
    SET
      CURRENT_RESIDORS_NUMBER = CURRENT_RESIDORS_NUMBER + 1
    WHERE ID = @cell_id
 PRINT N'Dodano wieznia do celi';
  end

   EXEC accommodate_prisoner  '99031119931', 'Krystian', 'Czajnik', 19, 'M', 'Warszawa', 'Napad na bank', 12, 'ZK Stargard', '2018-02-03', '2020-01-01', 10


/*
  Inne triggery i ogól pracy nad projektem na github/jstarczewski/PrisonDatabase
*/