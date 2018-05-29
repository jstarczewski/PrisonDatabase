
CREATE PROCEDURE update_province
@teryt INT,
@name NVARCHAR(40)
  AS
BEGIN
  SET NOCOUNT ON
  UPDATE PROVINCE
    SET
      TERYT = ISNULL(@teryt, TERYT),
      NAME = isnull(@name, NAME)
  WHERE TERYT = @teryt
END

CREATE PROCEDURE update_city
  @id INT,
  @name NVARCHAR(40),
  @province_id INT
  AS
  BEGIN
    SET NOCOUNT ON
    UPDATE CITY
      SET
        NAME = ISNULL(@name, NAME),
        PROVINCE_ID = isnull(@province_id, PROVINCE_ID)
    WHERE ID=@id
  end

CREATE PROCEDURE update_prison
@id INT,
@name NVARCHAR(40),
@city_id INT
AS
  BEGIN
    SET NOCOUNT ON
    UPDATE PRISON
      SET
        NAME = ISNULL(@name, NAME),
        CITY_ID = ISNULL(@city_id, CITY_ID)
    WHERE ID=@id
  end

CREATE PROCEDURE update_sentence
@id INT,
@deliquency NVARCHAR(255),
@since DATETIME,
@till DATETIME,
@prison_id INT
  AS
BEGIN
  IF @since < @till
    BEGIN
      SET NOCOUNT ON
  UPDATE SENTENCE
    SET
      DELINQUENCY = ISNULL(@deliquency, DELINQUENCY),
      SINCE = ISNULL(@since, SINCE),
      TILL = ISNULL(@till, TILL),
      PRISON_ID = ISNULL(@prison_id, PRISON_ID)
  WHERE ID=@id
    end
  ELSE
    BEGIN
      PRINT N'Data poczatku odbywania wyroku jest później niz końca';
    end

end

CREATE PROCEDURE update_prisoner
@pesel NVARCHAR(11),
@name NVARCHAR(255),
@age INT,
@number_of_crimes INT,
@sex NVARCHAR(1),
@second_name NVARCHAR(255),
@sentence_id INT,
@city_id INT
  AS
  BEGIN
    SET NOCOUNT ON
    UPDATE PRISONER
      SET
        PESEL = ISNULL(@pesel, PESEL),
        NAME = ISNULL(@name, NAME),
        AGE = ISNULL(@age, AGE),
        NUMBER_OF_CRIMES = ISNULL(@number_of_crimes, NUMBER_OF_CRIMES),
        SEX = ISNULL(@sex, SEX),
        SECOND_NAME = ISNULL(@second_name, SECOND_NAME),
        SENTENCE_ID = ISNULL(@sentence_id, SENTENCE_ID),
        CITY_ID = ISNULL(@city_id, CITY_ID)
    WHERE PESEL = @pesel
  end
CREATE PROCEDURE update_cell
  @id INT,
  @residors_limit INT,
  @current_residors_number INT,
  @prison_id INT
  AS
  BEGIN
    SET NOCOUNT ON
    UPDATE CELL
      SET
        RESIDORS_LIMIT = ISNULL(@residors_limit, RESIDORS_LIMIT),
        CURRENT_RESIDORS_NUMBER = ISNULL(@current_residors_number, CURRENT_RESIDORS_NUMBER),
        PRISON_ID = ISNULL(@prison_id, PRISON_ID)
    WHERE ID = @id
  end

  exec update_cell 43, 1,1,3;
  select * from cell
  select* from PRISONER
  select * from SENTENCE
alter PROCEDURE update_accommodation
@id INT,
@since DATETIME,
@till DATETIME,
@prisoner_id NVARCHAR(11),
@cell_id INT
  AS
  BEGIN

    IF @since < @till BEGIN

       SET NOCOUNT ON
    UPDATE ACCOMMODATION
      SET
        SINCE = ISNULL(@since, SINCE),
        TILL = ISNULL(@till, TILL),
        PRISONER_ID = ISNULL(@prisoner_id, PRISONER_ID),
        CELL_ID = ISNULL(@cell_id, CELL_ID)
    WHERE ACCOMMODATION_ID = @id

    end
    ELSE
    BEGIN
      PRINT N'Data zakonczenia zakwaterowania jest wczesniej niż końca';
    end

  end

CREATE PROCEDURE update_incident
@id INT,
@short_description NVARCHAR,
@time_of_incident DATETIME,
@prisoner_id INT,
@cell_id INT
  AS
  BEGIN
    SET NOCOUNT ON
    UPDATE INCIDENT
      SET
        SHORT_DESCRIPTION = ISNULL(@short_description, SHORT_DESCRIPTION),
        TIME_OF_INCIDENT = ISNULL(@time_of_incident, TIME_OF_INCIDENT),
        PRISONER_ID = ISNULL(@prisoner_id, PRISONER_ID),
        CELL_ID = ISNULL(@cell_id, CELL_ID)
    WHERE INCIDENT_ID = @id
  end

