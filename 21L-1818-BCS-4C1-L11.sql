
create database lab11




CREATE TABLE Department (
  dept_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);

CREATE TABLE Course (
  course_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  credit_hrs INT NOT NULL,
  dept_id INT NOT NULL,
  FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Section (
  section_id INT PRIMARY KEY,
  course_id INT NOT NULL,
  capacity INT NOT NULL,
  FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

CREATE TABLE Faculty (
  faculty_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  dept_id INT NOT NULL,
  FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Student (
  roll_no INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  dept_id INT NOT NULL,
  batch INT NOT NULL,
  FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Enrolled (
  student_roll_no INT NOT NULL,
  section_id INT NOT NULL,
  PRIMARY KEY (student_roll_no, section_id),
  FOREIGN KEY (student_roll_no) REFERENCES Student(roll_no),
  FOREIGN KEY (section_id) REFERENCES Section(section_id)
);


INSERT INTO Department (dept_id, name)
VALUES
  (1, 'Computer Science'),
  (2, 'Electrical Engineering'),
  (3, 'Mechanical Engineering');

INSERT INTO Course (course_id, name, credit_hrs, dept_id)
VALUES
  (101, 'Programming Fundamentals', 3, 1),
  (102, 'Data Structures and Algorithms', 4, 1),
  (201, 'Circuits and Systems', 4, 2),
  (202, 'Digital Signal Processing', 3, 2),
  (301, 'Thermodynamics', 3, 3),
  (302, 'Fluid Mechanics', 3, 3);

INSERT INTO Section (section_id, course_id, capacity)
VALUES
  (1, 101, 50),
  (2, 101, 40),
  (3, 102, 60),
  (4, 201, 30),
  (5, 201, 35),
  (6, 202, 25),
  (7, 301, 20),
  (8, 301, 25),
  (9, 302, 30);

INSERT INTO Faculty (faculty_id, name, dept_id)
VALUES
  (1001, 'John Smith', 1),
  (1002, 'Emily Johnson', 2),
  (1003, 'Michael Brown', 3);

INSERT INTO Student (roll_no, name, dept_id, batch)
VALUES
  (1001, 'Alice Jones', 1, 2023),
  (1002, 'Bob Smith', 1, 2022),
  (1003, 'Charlie Brown', 2, 2023),
  (1004, 'Daisy Johnson', 3, 2022);

INSERT INTO Enrolled (student_roll_no, section_id)
VALUES
  (1001, 1),
  (1002, 1),
  (1003, 4),
  (1004, 7),
  (1004, 8);


--Q1

create table Auditing(
audit_id INT PRIMARY KEY,
Last_change_on date default getdate()

);


create trigger rec_change
on Student
For update, insert, delete
AS
	DECLARE @a_id INT

	if exists (Select top 1 audit_id from Auditing
	order by audit_id DESC)
	BEGIN
		
		Select top 1 @a_id = audit_id + 1 from Auditing
		order by audit_id DESC

		insert into Auditing
		values(@a_id,GETDATE())

	END
	ELSE
	BEGIN
		
		insert into Auditing
		values(0,GETDATE())

	END



create trigger rec_change2
on Department
For update, insert, delete
AS
	DECLARE @a_id INT

	if exists (Select top 1 audit_id from Auditing
	order by audit_id DESC)
	BEGIN
		
		Select top 1 @a_id = audit_id + 1 from Auditing
		order by audit_id DESC

		insert into Auditing
		values(@a_id,GETDATE())

	END
	ELSE
	BEGIN
		
		insert into Auditing
		values(0,GETDATE())

	END


create trigger rec_change3
on Faculty
For update, insert, delete
AS
	DECLARE @a_id INT

	if exists (Select top 1 audit_id from Auditing
	order by audit_id DESC)
	BEGIN
		
		Select top 1 @a_id = audit_id + 1 from Auditing
		order by audit_id DESC

		insert into Auditing
		values(@a_id,GETDATE())

	END
	ELSE
	BEGIN
		
		insert into Auditing
		values(0,GETDATE())

	END



Update Department
set name = 'CIVIL Engineering'
where dept_id = 3

Update Faculty
set name = 'Peter'
where faculty_id = 1003



Select * from Faculty
select * from Department
Select * from Auditing


--Q2

disable trigger rec_change
on Student

disable trigger rec_change2
on Department

disable trigger rec_change3
on Faculty



alter table Auditing
add Description varchar(100)



create trigger Up_rec_change
on Student
For update, insert, delete
AS
	DECLARE @a_id INT

	if exists (Select top 1 audit_id from Auditing
	order by audit_id DESC)
	BEGIN
		
		Select top 1 @a_id = audit_id + 1 from Auditing
		order by audit_id DESC

		insert into Auditing
		values(@a_id,GETDATE(),'Changes in Student Table')

	END
	ELSE
	BEGIN
		
		insert into Auditing
		values(0,GETDATE(),'Changes in Student Table')

	END



create trigger Up_rec_change2
on Department
For update, insert, delete
AS
	DECLARE @a_id INT

	if exists (Select top 1 audit_id from Auditing
	order by audit_id DESC)
	BEGIN
		
		Select top 1 @a_id = audit_id + 1 from Auditing
		order by audit_id DESC

		insert into Auditing
		values(@a_id,GETDATE(),'Changes in Department Table')

	END
	ELSE
	BEGIN
		
		insert into Auditing
		values(0,GETDATE(),'Changes in Department Table')

	END


create trigger Up_rec_change3
on Faculty
For update, insert, delete
AS
	DECLARE @a_id INT

	if exists (Select top 1 audit_id from Auditing
	order by audit_id DESC)
	BEGIN
		
		Select top 1 @a_id = audit_id + 1 from Auditing
		order by audit_id DESC

		insert into Auditing
		values(@a_id,GETDATE(),'Changes in Faculty Table')

	END
	ELSE
	BEGIN
		
		insert into Auditing
		values(0,GETDATE(),'Changes in Faculty Table')

	END


insert into Student (roll_no, name, dept_id, batch)
values(1005, 'Mubashir Hamza', 3, 2021)

select * from Student
select * from Auditing


--Q3

CREATE VIEW Course_Section_view
AS

	SELECT c.course_id, c.name AS Course_Name, c.credit_hrs, s.section_id, s.capacity FROM Course AS c
	JOIN Section as s ON c.course_id = s.course_id;



CREATE TRIGGER Enrolled_Registration
ON Enrolled
AFTER INSERT
AS
BEGIN

    SELECT * FROM Course_Section_view

END


--Q4

CREATE PROCEDURE Registeration_For_Section
@student_roll_no INT,
@section_id INT
AS
BEGIN

    INSERT INTO Enrolled (student_roll_no, section_id)
    VALUES (@student_roll_no, @section_id)

    
    SELECT * FROM Course_Section_view AS csv
	WHERE csv.section_id = @section_id


END



CREATE TRIGGER enrolled_2_registration
ON Enrolled
FOR INSERT
AS
BEGIN


    DECLARE @student_roll INT;
    DECLARE @sec_id INT;
    
    SELECT @student_roll = inserted.student_roll_no, @sec_id = inserted.section_id FROM inserted
    
    EXECUTE Registeration_For_Section
	@student_roll_no = @student_roll,
	@section_id = @sec_id

END



--Q5

update Department
set name = 'MG'
where dept_id = 3

create trigger stop_change
on Department
instead of update, insert, delete
As
	print 'Sorry, You are not allowed to change the department table.'
	rollback



update Department
set name = 'CV'
where dept_id = 3



-- Q6

create trigger stop_DDL_change
on database
FOR DROP_TABLE, ALTER_TABLE
AS
	print 'Sorry, ALTER and DROP a table is not allowed.'
	rollback
;

