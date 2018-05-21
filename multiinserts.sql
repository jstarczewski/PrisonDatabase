CREATE PROCEDURE accommodate_prisoner
    @prison_id        NVARCHAR(11),
    @deliquency       NVARCHAR(255),
    @since            DATETIME,
    @till             DATETIME,
    @pesel            NVARCHAR(11),
    @name             NVARCHAR(255),
    @age              INT,
    @sex              NVARCHAR(1),
    @second_name      NVARCHAR(255),
    @number_of_crimes INT,
    @city_id          INT,
    @cell_id          INT
AS
  BEGIN
         IF EXISTS(SELECT CELL.ID
                FROM CELL
                WHERE CELL.CURRENT_RESIDORS_NUMBER < CELL.RESIDORS_LIMIT
                      AND CELL.ID = @cell_id
                      AND CELL.PRISON_ID = @prison_id)
            AND NOT EXISTS(SELECT * FROM PRISONER
           WHERE PRISONER.PESEL = @pesel)
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
            @city_id);
          INSERT INTO ACCOMMODATION (SINCE, TILL, PRISONER_ID, CELL_ID)
          VALUES (@since, @till, @pesel, @cell_id);
          SELECT *
          FROM ACCOMMODATION

        exec update_cell @cell_id, null ,1, @prison_id;
        END
      ELSE
        BEGIN
          PRINT N'Cela jest pełna';
        END
END
drop procedure accommodate_prisoner

  EXEC accommodate_prisoner 14, 'Kradzież', '12-03-2017', '12-04-2018', '99123312231', 'Jakub', 19, 'M','Węgajny', 3, 3, 55;

  SELECT *
  FROM CELL
  select *from PRISONER
  select* from PRISON

