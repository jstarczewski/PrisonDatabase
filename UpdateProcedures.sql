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

      ALTER PROCEDURE update_sentence
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


        ALTER PROCEDURE update_prisoner
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
            ALTER PROCEDURE update_accommodation

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
              ALTER PROCEDURE update_incident
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
