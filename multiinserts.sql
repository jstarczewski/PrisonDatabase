ALTER PROCEDURE accommodate_prisoner

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
    @cell_id INT

AS
  BEGIN

    DECLARE @prison_id INT = (SELECT PRISON.ID FROM PRISON WHERE PRISON.NAME = @prison_name);
    DECLARE @city_id INT = (SELECT CITY.ID FROM CITY WHERE CITY.NAME = @city_name);

    IF EXISTS(SELECT CELL.ID
              FROM CELL
              WHERE CELL.CURRENT_RESIDORS_NUMBER < CELL.RESIDORS_LIMIT
                    AND CELL.ID = @cell_id
                    AND CELL.PRISON_ID = @prison_id)
       AND NOT EXISTS(SELECT *
                      FROM PRISONER
                      WHERE PRISONER.PESEL = @pesel)
      AND EXISTS(SELECT * FROM CITY
       WHERE  CITY.ID = @city_id)
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
        exec update_cell @cell_id, null, 1, @prison_id;
         SET NOCOUNT ON
    UPDATE PRISON
      SET
        NUMBER_OF_PRISONER = NUMBER_OF_PRISONER+1
      WHERE ID=@prison_id
      END
    ELSE
      BEGIN
        PRINT N'Nie udało sie wykonac procedury, możliwe błędy to: Osoba o takim PESELU juz istnieje, Nie istnieje miasto, z którego pochodzi osoba, cela nie jest w tym samym więzieniu jakie wskazano, cela jest pełna';
      END
  END
  drop procedure accommodate_prisoner

  SELECT CITY.NAME AS [city name], PRISON.NAME as [prison name], CELL.ID
    FROM CITY, PRISON, CELL
  WHERE PRISON.ID = CELL.PRISON_ID AND PRISON.CITY_ID = CITY.ID AND CELL.CURRENT_RESIDORS_NUMBER < CELL.RESIDORS_LIMIT

  EXEC accommodate_prisoner 'ZK Stargard', 'Ucieczka przed pasami', '03-03-2003', '12-04-2010', '21233123973', 'Krystian', 19, 'M', 'Brudsy', 3,
                        'Braniewo',39;
  SELECT * FROM PRISON


  CREATE PROCEDURE new_prison
      @city_id             INT,
      @name                NVARCHAR(40),
      @residors_limit      INT

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
      SELECT *
      FROM CELL
    END
    drop procedure new_prison
EXEC new_prison 15, 'DS HWDP', 2

    SELECT CITY.ID FROM CITY WHERE CITY.NAME = 'Braniewo'

    SELECT IDENT_CURRENT('PRISON')
  select * from PRISON

