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

CREATE TRIGGER insert_prison_message
  ON PRISON
  AFTER INSERT
AS
  BEGIN
    PRINT N'PRISON ADDED';
  end
 exec add_prison 3,'DS Ustronie', 3

ALTER TRIGGER update_city_after_update
  ON PRISONER
  AFTER UPDATE
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

        exec update_prisoner @pesel, null, null, null, null, null, null, @city_id, null
      end
  end
  drop trigger update_city_after_update

  select * from PRISONER, SENTENCE where PRISONER.SENTENCE_ID = SENTENCE.ID AND SENTENCE.DELINQUENCY LIKE 'Stalking'

  select * from SENTENCE

  exec update_sentence 'Stalking', '2016-05-12', '2018-04-04',	4, 'Stalking',	'2016-05-12',	'2013-04-12',	null



  select * from SENTENCE

CREATE TRIGGER update_cell_after_update
  ON CELL
  AFTER UPDATE
AS
  BEGIN
    PRINT N'CELL UPDATED';
  end

 exec update_cell 1, 1, 1, 1, 1, 1


CREATE TRIGGER delete_incident
  ON INCIDENT
  AFTER DELETE
AS
  BEGIN
    PRINT N'INCIDENT DELETED';
  end

CREATE TRIGGER delete_cell
  ON CELL
  AFTER DELETE
AS
  BEGIN
    PRINT N'CELL DELETED';
  end



  delete from INCIDENT

CREATE TRIGGER delete_incidents
  ON PRISONER
  AFTER DELETE
AS
  BEGIN
    IF NOT EXISTS(SELECT *
                  FROM INCIDENT, PRISONER
                  WHERE INCIDENT.PRISONER_ID = PRISONER.PESEL)
      BEGIN
        DECLARE @pesel NVARCHAR(11) = (SELECT INCIDENT.PRISONER_ID
                                       FROM
                                         PRISONER, INCIDENT
                                       WHERE (NOT EXISTS(SELECT *
                                                         FROM INCIDENT, PRISONER
                                                         WHERE INCIDENT.PRISONER_ID = PRISONER.PESEL)))
        DELETE FROM dbo.INCIDENT
        WHERE dbo.INCIDENT.PRISONER_ID = @pesel
      end
  end

  delete from PRISONER

  drop trigger delete_incidents


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

CREATE TRIGGER update_prisoners_in_cell_after_delete
  ON ACCOMMODATION
  AFTER DELETE
AS
  BEGIN
    DECLARE @cell_id INT = (SELECT CELL.ID
                            FROM ACCOMMODATION, CELL
                            WHERE ACCOMMODATION.CELL_ID = CELL.ID AND
                                  ACCOMMODATION.ACCOMMODATION_ID = (SELECT IDENT_CURRENT('ACCOMMODATION')));
    UPDATE CELL
    SET
      CURRENT_RESIDORS_NUMBER = CURRENT_RESIDORS_NUMBER - 1
    WHERE ID = @cell_id

  end

CREATE TRIGGER update_prisoners_in_prison_after_delete
  on ACCOMMODATION
  AFTER DELETE
AS
  BEGIN
    DECLARE @prison_id INT = (SELECT CELL.PRISON_ID
                              FROM ACCOMMODATION, CELL, PRISON
                              WHERE ACCOMMODATION.CELL_ID = CELL.ID AND
                                    CELL.PRISON_ID = PRISON.ID AND
                                    ACCOMMODATION.ACCOMMODATION_ID = (SELECT IDENT_CURRENT('ACCOMMODATION')));
    UPDATE PRISON
    SET
      NUMBER_OF_PRISONER = NUMBER_OF_PRISONER - 1
    WHERE ID = @prison_id
  end



CREATE TRIGGER update_prisoners_in_prison
  on ACCOMMODATION
  AFTER INSERT
AS
  BEGIN
    DECLARE @prison_id INT = (SELECT CELL.PRISON_ID
                              FROM ACCOMMODATION, CELL, PRISON
                              WHERE ACCOMMODATION.CELL_ID = CELL.ID AND
                                    CELL.PRISON_ID = PRISON.ID AND
                                    ACCOMMODATION.ACCOMMODATION_ID = (SELECT IDENT_CURRENT('ACCOMMODATION')));
    UPDATE PRISON
    SET
      NUMBER_OF_PRISONER = NUMBER_OF_PRISONER + 1
    WHERE ID = @prison_id
  end
 select * from ACCOMMODATION

SELECT *
FROM PRISONER
delete from DBO.PRISONER
WHERE dbo.PRISONER.PESEL = '99031112333'

drop trigger delete_incidents
SELECT *
FROM INCIDENT



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


exec update_sentence 3, 'Napad na bank', '2013-09-09', '2018-12-03', 1
