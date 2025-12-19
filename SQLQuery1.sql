create database assign

CREATE TABLE Creator (
  creatorID INT NOT NULL,
  Name VARCHAR(50) NOT NULL,
  age INT,
  city VARCHAR(50),
  contact VARCHAR(50),
  dob DATE,
  email VARCHAR(50),
  trainerId INT,
  PRIMARY KEY (creatorID),
  FOREIGN KEY (trainerId) REFERENCES Creator(creatorID)
);

CREATE TABLE Artpieces (
  artID INT NOT NULL,
  artname VARCHAR(50) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  quantity_available INT NOT NULL,
  PRIMARY KEY (artID)
);

CREATE TABLE Art_piece_Detail (
  artID INT NOT NULL,
  creatorid INT NOT NULL,
  releasedate DATE,
  type VARCHAR(50),
  PRIMARY KEY (artID, creatorid),
  FOREIGN KEY (artID) REFERENCES Artpieces(artID),
  FOREIGN KEY (creatorid) REFERENCES Creator(creatorID)
);

CREATE TABLE Sale (
  saleID INT NOT NULL,
  artID INT NOT NULL,
  dateofsale DATE NOT NULL,
  quantity INT NOT NULL,
  paymentmethod VARCHAR(50),
  city VARCHAR(50),
  PRIMARY KEY (saleID),
  FOREIGN KEY (artID) REFERENCES Artpieces(artID)
);

-- Adding 5 rows in Creator table
INSERT INTO Creator (creatorID, Name, age, city, contact, dob, email, trainerId)
VALUES
  (1, 'John', 30, 'New York', '1234567890', '1991-01-01', 'john@example.com', NULL),
  (2, 'Mary', 25, 'Los Angeles', '0987654321', '1996-05-10', 'mary@example.com', 1),
  (3, 'David', 40, 'Chicago', '5555555555', '1981-12-15', 'david@example.com', NULL),
  (4, 'Sarah', 35, 'San Francisco', '7777777777', '1986-08-03', 'sarah@example.com', 1),
  (5, 'Robert', 28, 'Houston', '9999999999', '1993-03-25', 'robert@example.com', 3);


  INSERT INTO Creator (creatorID, Name, age, city, contact, dob, email, trainerId)
VALUES
  (8, 'John', 30, 'Lahore', '1234567890', '1991-01-01', 'john@example.com', NULL),
  (7, 'Mary', 25, 'Islamabad', '0987654321', '1996-05-10', 'mary@example.com', 1)


    INSERT INTO Creator (creatorID, Name, age, city, contact, dob, email, trainerId)
VALUES
  (13, 'John', 30, 'Lahore', '1234567890', '1800-01-01', 'john@example.com', NULL)
-- Adding 5 rows in Artpieces table
INSERT INTO Artpieces (artID, artname, price, quantity_available)
VALUES
  (1, 'Mona Lisa', 1000.00, 5),
  (2, 'The Starry Night', 1500.00, 3),
  (3, 'The Persistence of Memory', 1200.00, 7),
  (4, 'The Scream', 800.00, 2),
  (5, 'The Last Supper', 2000.00, 4);


  INSERT INTO Artpieces (artID, artname, price, quantity_available)
VALUES
  (9, 'Mona Lisa', 1000.00, 5)
-- Adding 5 rows in Art_piece_Detail table
INSERT INTO Art_piece_Detail (artID, creatorid, releasedate, type)
VALUES
  (1, 1, '1503-01-01', 'Oil painting'),
  (2, 3, '1889-06-01', 'Oil painting'),
  (3, 2, '1931-01-01', 'Surrealist painting'),
  (4, 4, '1893-01-01', 'Expressionist painting'),
  (5, 1, '1495-01-01', 'Mural');

  INSERT INTO Art_piece_Detail (artID, creatorid, releasedate, type)
VALUES
  (9, 13, '2023-02-13', 'Oil painting')

  INSERT INTO Sale (saleID, artID, dateofsale, quantity, paymentmethod,city)
VALUES
  (14, 9, '2023-01-02', 1, 'Credit card','Lahore')

  update Sale
  set quantity = 2
  where saleID = 12

-- Adding 5 rows in Sale table
INSERT INTO Sale (saleID, artID, dateofsale, quantity, paymentmethod,city)
VALUES
  (1, 2, '2022-02-15', 1, 'Credit card','Lahore'),
  (2, 3, '2022-02-14', 2, 'Cash', 'Karachi'),
  (3, 2, '2022-02-13', 1, 'Debit card', 'Karachi')
)

  SELECT c1.creatorID, c1.Name AS creator_name, c1.trainerId,
       c2.Name AS trainer_name, COUNT(DISTINCT apd.artID) AS num_art_pieces
FROM Creator c1
JOIN Art_piece_Detail apd ON apd.creatorid = c1.creatorID
JOIN Creator c2 ON c2.creatorID = c1.trainerId
GROUP BY c1.creatorID, c1.Name, c1.trainerId, c2.Name
HAVING COUNT(DISTINCT apd.artID) > (
  SELECT COUNT(DISTINCT apd2.artID)
  FROM Art_piece_Detail apd2
  WHERE apd2.creatorid = c1.trainerId
)

delete from Art_piece_Detail
where artID = 5

update Artpieces
set price = 15000
where artID = 2

select * from Creator

SELECT c.creatorID,c.Name FROM Creator AS c 
	JOIN Art_piece_Detail AS asd ON c.creatorID = asd.creatorID
	JOIN Artpieces AS a ON asd.artID = a.artID

	WHERE a.artID NOT IN ( SELECT artID FROM Sale)


SELECT c.creatorID, c.Name, AVG(s.quantity * a.price) as avg_price FROM Creator AS c

	JOIN Art_piece_Detail AS ad ON c.creatorID = ad.creatorID
	JOIN Artpieces AS a ON ad.artID = a.artID
	JOIN Sale AS S ON a.artID = S.artID
		WHERE S.dateofsale > '2023-12-31'
		GROUP BY c.creatorID, c.Name
		HAVING AVG(S.quantity * a.price) > 10000

INSERT INTO Sale (saleID, artID, dateofsale, quantity, paymentmethod)
VALUES
  (7, 2, '2024-02-15', 1, 'Credit card')


  select ap.artID,ap.artname,ap.price,ap.quantity_available from Artpieces as ap join Sale as s ON ap.artID= s.artID
	where ap.artID IN(
	  select artID from Artpieces
	  Except
	  select artID from Sale)

	 OR ap.quantity_available > s.quantity


	 SELECT a.artID,a.artname FROM Artpieces AS a
		JOIN Sale AS S ON a.artID = S.artID
		WHERE S.dateofsale BETWEEN '1999-01-01' AND '2004-12-31'


		INSERT INTO Sale (saleID, artID, dateofsale, quantity, paymentmethod)
VALUES
  (6, 2, '2004-02-15', 1, 'Credit card')

  SELECT ap.artID, ap.artname FROM Artpieces AS ap
	JOIN Art_piece_Detail AS apd ON apd.artID = ap.artID
	WHERE CONVERT(date, apd.releasedate) = CONVERT(date, GETDATE())
	AND ap.artname LIKE 'Z%Z'


	INSERT INTO Art_piece_Detail (artID, creatorid, releasedate, type)
VALUES
  (8, 1, '2023-02-23', 'Oil paint')

  INSERT INTO Artpieces (artID, artname, price, quantity_available)
VALUES
  (8, 'Zona tsZ', 1000.00, 5)

  SELECT ap.artID, ap.artname, c.Name AS CreatorName FROM Artpieces ap

	JOIN Art_piece_Detail apd ON ap.artID = apd.artID
	JOIN Creator c ON apd.creatorid = c.creatorID
	JOIN Sale s ON ap.artID = s.artID

	GROUP BY ap.artID, ap.artname, c.Name
	HAVING SUM(s.quantity) =(
		  SELECT MAX(t_sales) FROM (

			SELECT artID, SUM(quantity) AS t_sales FROM Sale
			GROUP BY artID

		  ) AS t_s

	)

select * from Creator
where Name like 'A____'


INSERT INTO Creator (creatorID, Name, age, city, contact, dob, email, trainerId)
VALUES
  (21, 'Ahm', 30, 'New York', '1234567890', '1991-01-01', 'john@example.com', NULL)

  SELECT DISTINCT c.creatorID ,c.Name FROM Creator AS c
	JOIN Art_piece_Detail AS apd ON c.creatorID = apd.creatorid
	JOIN Artpieces AS a ON a.artID = apd.artID
	JOIN Sale AS S ON S.artID = a.artID
	WHERE S.city = 'Karachi'
 EXCEPT
 SELECT DISTINCT c.creatorID ,c.Name FROM Creator AS c
	JOIN Art_piece_Detail AS apd ON c.creatorID = apd.creatorid
	JOIN Artpieces AS a ON a.artID = apd.artID
	JOIN Sale AS S ON S.artID = a.artID
	WHERE S.city = 'Lahore'

drop table Sale

SELECT a.artID, a.artname,a.price FROM Creator c

		JOIN Art_piece_Detail AS apd ON c.creatorID = apd.creatorid
		JOIN Artpieces AS a ON a.artID = apd.artID
		JOIN Sale AS S ON S.artID = a.artID
			WHERE S.paymentmethod = 'debit card'
			AND c.creatorID IN (
			  SELECT trainerId
			  FROM Creator
			)


 SELECT a.artID,a.artname, a.price FROM Artpieces AS a
		JOIN Sale AS S ON a.artID = S.artID
		WHERE S.dateofsale BETWEEN '1999-01-01' AND '2004-12-31'



select * from Creator

SELECT ap.artID, ap.artname, ap.price FROM Artpieces ap
	JOIN Art_piece_Detail apd ON apd.artID = ap.artID
	JOIN Sale S ON S.artID = ap.artID
	WHERE S.quantity >= ap.quantity_available AND S.dateofsale <= DATEADD(day, 2, apd.releasedate)

	SELECT t.creatorID, t.Name FROM Creator AS t
			WHERE NOT EXISTS (
			  SELECT ap.creatorid
			  FROM Art_piece_Detail AS ap
			  JOIN Creator AS c ON ap.creatorid = c.creatorID
			  JOIN Artpieces AS a ON a.artID = ap.artID
				  WHERE c.trainerId IN (
					select trainerId from Creator
				  ) AND a.quantity_available > 0 
			)


	SELECT c.creatorID, c.Name FROM Creator c
	WHERE c.city IN ('Lahore', 'Karachi') AND c.city != 'Islamabad'

SELECT TOP 3 ap.artname, SUM(S.quantity) AS total_quantity_sold FROM Artpieces AS ap
	JOIN Sale S ON ap.artID = S.artID
	GROUP BY ap.artID, ap.artname
	ORDER BY total_quantity_sold DESC


select * from sale

SELECT c.creatorID ,c.Name FROM Creator AS c
	JOIN Artpieces AS a ON c.creatorID = a.creatorID
	JOIN Sale AS S ON a.artID = S.artID
		WHERE S.city = 'Lahore' AND NOT EXISTS (SELECT s2.city FROM Sale s2
												  WHERE s2.artID = S.artID
												  AND s2.city != 'Lahore'
												)

SELECT ap.artID ,ap.artname FROM Artpieces ap
JOIN Art_piece_Detail apd ON ap.artID = apd.artID
WHERE DATEDIFF(day, apd.releasedate, GETDATE()) > 10 OR DATEDIFF(day, apd.releasedate, GETDATE()) < 10

select * from Art_piece_Detail


SELECT c.Name, SUM(S.quantity * ap.price) AS earns FROM Creator AS c
	JOIN Art_piece_Detail AS a ON c.creatorID = a.creatorID
	JOIN Artpieces AS ap ON a.artID = ap.artID
	JOIN Sale S ON a.artID = S.artID
		GROUP BY c.creatorID, c.Name
		HAVING SUM(s.quantity * ap.price) > 50000

SELECT c.creatorID ,c.Name, c.dob FROM Creator AS c
	JOIN Art_piece_Detail apd ON apd.creatorid = c.creatorID
	WHERE c.dob < DATEADD(year, -100, GETDATE()) AND c.dob IS NOT NULL AND apd.artID IN (
								SELECT s.artID FROM Sale s WHERE s.dateofsale < GETDATE()
							)



select * from Art_piece_Detail

SELECT c.Name, c.city, SUM(s.quantity) AS SumOfArtPiecesSold FROM Creator AS c
	JOIN Art_piece_Detail a ON c.creatorID = a.creatorID
	JOIN Sale s ON a.artID = s.artID
	GROUP BY c.Name, c.city
	, MIN(s.dateofsale) AS EarliestSale

SELECT c.Name, a.artID AS FastestSellingArtPieceID FROM Creator AS c
		JOIN Art_piece_Detail AS a ON c.creatorID = a.creatorID
		JOIN Sale AS s ON a.artID = s.artID
		GROUP BY c.creatorID, c.Name, a.artID
		HAVING MIN(s.dateofsale) = (
			SELECT MIN(dateofsale) FROM Sale AS s2 
			WHERE s2.artID = a.artID
		)