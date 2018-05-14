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

SELECT * FROM PROVINCE

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
      ('ZK Barczewko',0, 1),
      ('ZK Biała Podlaska',0, 2),
      ('ZK Białystok',0, 3),
      ('ZK Braniewo',0, 4),
      ('ZK Brzeg',0, 5),
      ('ZK Cieszyn',0, 6),
      ('ZK Herby',0, 7),
      ('ZK Iława',0, 8),
      ('ZK Kłodzko',0, 9),
      ('ZK Racibórz',0, 10),
      ('ZK Siedlce',0, 11),
      ('ZK Tarnów',0, 13),
      ('ZK Zabrze',0, 15),
      ('ZK Szczecin',0, 16),
      ('ZK Łódź',0, 17),
      ('ZK Stargard',0, 18),
      ('ZK Sztum',0, 20);
select * from CITY
