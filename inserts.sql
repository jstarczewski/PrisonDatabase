CREATE OR ALTER PROCEDURE add_province
    @teryt INT,
    @name  NVARCHAR(40)
AS
  BEGIN
    INSERT INTO PROVINCE (TERYT, NAME)
    VALUES (@teryt, @name);
    SELECT *
    FROM PROVINCE
  END;

CREATE OR ALTER PROCEDURE add_city
      @province_id INT,
      @name        NVARCHAR(40)
  AS
    BEGIN
      INSERT INTO CITY (PROVINCE_ID, NAME)
      VALUES (@province_id, @name);
      SELECT *
      FROM CITY
    END
    CREATE OR ALTER PROCEDURE add_prison
        @city_id             INT,
        @name                NVARCHAR(40),
        @number_of_prisoners INT
    AS
      BEGIN
        INSERT INTO PRISON (NAME, NUMBER_OF_PRISONER, CITY_ID)
        VALUES (@name, @number_of_prisoners, @city_id);
        SELECT *
        FROM PRISON
      END
CREATE OR ALTER PROCEDURE add_sentence
          @prison_id  NVARCHAR(11),
          @deliquency NVARCHAR(255),
          @since      DATETIME,
          @till       DATETIME
      AS
        BEGIN
          INSERT INTO SENTENCE (PRISON_ID, DELINQUENCY, SINCE, TILL)
          VALUES (@prison_id, @deliquency, @since, @till);
          SELECT *
          FROM SENTENCE
        END
CREATE OR ALTER PROCEDURE add_prisoner
            @pesel            NVARCHAR(11),
            @name             NVARCHAR(255),
            @age              INT,
            @sex              NVARCHAR(1),
            @second_name      NVARCHAR(255),
            @number_of_crimes INT,
            @sentence_id      INT,
            @city_id          INT
        AS
          BEGIN
            INSERT INTO PRISONER (PESEL, NAME, AGE, NUMBER_OF_CRIMES, SEX, SECOND_NAME, SENTENCE_ID, CITY_ID)
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
          END
CREATE OR ALTER PROCEDURE add_cell
              @residors_limit          INT,
              @current_residors_number INT,
              @prison_id               INT
          AS
            BEGIN
              INSERT INTO CELL (RESIDORS_LIMIT, CURRENT_RESIDORS_NUMBER, PRISON_ID)
              VALUES (@residors_limit, @current_residors_number, @prison_id);
              SELECT *
              FROM CELL
            END
CREATE OR ALTER PROCEDURE add_accomodation
                @since       DATETIME,
                @till        DATETIME,
                @prisoner_id INT,
                @cell_id     INT
            AS
              BEGIN
                INSERT INTO ACCOMMODATION (SINCE, TILL, PRISONER_ID, CELL_ID)
                VALUES (@since, @till, @prisoner_id, @cell_id);
                SELECT *
                FROM ACCOMMODATION
              end

CREATE OR ALTER PROCEDURE add_incident
                  @short_description NVARCHAR(255),
                  @time_of_incident  DATETIME,
                  @prisoner_id       NVARCHAR(11),
                  @cell_id           INT
              AS
  BEGIN
                  INSERT INTO INCIDENT (SHORT_DESCRIPTION, TIME_OF_INCIDENT, PRISONER_ID, CELL_ID)
                  VALUES (@short_description, @time_of_incident, @prisoner_id, @cell_id);
                  SELECT *
                  FROM INCIDENT
                end