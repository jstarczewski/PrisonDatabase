CREATE TRIGGER update_city_after_insert
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

CREATE TRIGGER insert_prison
  ON PRISON
  AFTER INSERT
AS
  BEGIN
    PRINT N'PRISON ADDED';
  end

CREATE TRIGGER update_city_after_update
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

        exec update_prisoner @pesel, null, null, null, null, null, null, @city_id
      end
  end

CREATE TRIGGER update_cell_after_update
  ON CELL
  AFTER UPDATE
AS
  BEGIN
    PRINT N'PRISON ADDED';
  end


CREATE TRIGGER delete_incident
  ON INCIDENT
  AFTER DELETE
AS
  BEGIN
    PRINT N'INCIDENT DELETED';
  end

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

  end


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

SELECT *
FROM PRISONER
delete from DBO.PRISONER
WHERE dbo.PRISONER.PESEL = '99031112333'

drop trigger delete_incidents
SELECT *
FROM INCIDENT