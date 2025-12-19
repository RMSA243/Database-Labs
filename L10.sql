
create database university

go
create table Students
(RollNo varchar(7) primary key
,Name varchar(30)
,WarningCount int
,Department varchar(15)
)
GO
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'1', N'Ali', 0, N'CS')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'2', N'Bilal', 0, N'CS')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'3', N'Ayesha', 0, N'CS')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'4', N'Ahmed', 0, N'CS')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'5', N'Sara', 0, N'EE')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'6', N'Salman', 1, N'EE')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'7', N'Zainab', 2, N'CS')
INSERT [dbo].[Students] ([RollNo], [Name], [WarningCount], [Department]) VALUES (N'8', N'Danial', 1, N'CS')

go
create table Courses
(
CourseID int primary key,
CourseName varchar(40),
PrerequiteCourseID int,
CreditHours int
) 
GO
INSERT [dbo].[Courses] ([CourseID], [CourseName], [PrerequiteCourseID],CreditHours) VALUES (10, N'Database Systems', 20, 3)
INSERT [dbo].[Courses] ([CourseID], [CourseName], [PrerequiteCourseID],CreditHours) VALUES (20, N'Data Structures', 30,3)
INSERT [dbo].[Courses] ([CourseID], [CourseName], [PrerequiteCourseID],CreditHours) VALUES (30, N'Programing', NULL,3)
INSERT [dbo].[Courses] ([CourseID], [CourseName], [PrerequiteCourseID],CreditHours) VALUES (40, N'Basic Electronics', NULL,3)
go

go
Create table Instructors 
(
InstructorID int Primary key,
Name varchar(30),
Department varchar(7) ,
)
GO
INSERT [dbo].[Instructors] ([InstructorID], [Name], [Department]) VALUES (100, N'Ishaq Raza', N'CS')
INSERT [dbo].[Instructors] ([InstructorID], [Name], [Department]) VALUES (200, N'Zareen Alamgir', N'CS')
INSERT [dbo].[Instructors] ([InstructorID], [Name], [Department]) VALUES (300, N'Saima Zafar', N'EE')
go
Create table Semester
(
Semester varchar(15) Primary key,
[Status] varchar(10),
)
GO
INSERT [dbo].[Semester] ([Semester], [Status]) VALUES (N'Fall2016', N'Complete')
INSERT [dbo].[Semester] ([Semester], [Status]) VALUES (N'Spring2016', N'Complete')
INSERT [dbo].[Semester] ([Semester], [Status]) VALUES (N'Spring2017', N'InProgress')
INSERT [dbo].[Semester] ([Semester], [Status]) VALUES (N'Summer2016', N'Cancelled')
go
Create table Courses_Semester
(
InstructorID int Foreign key References Instructors(InstructorID),
CourseID int Foreign key References Courses(CourseID),
Semester varchar(15) Foreign key References Semester(Semester), 
Section varchar(1) ,
AvailableSeats int,
Department varchar(2)
)
GO
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (200, 10, N'Spring2017', N'D', 45, N'CS')
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (200, 10, N'Spring2017', N'C', 0, N'CS')
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (100, 10, N'Spring2017', N'A', 6, N'CS')
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (300, 40, N'Spring2017', N'A', 6, N'CS')
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (300, 40, N'Spring2016', N'A', 6, N'CS')
INSERT [dbo].[Courses_Semester] ([InstructorID], [CourseID], [Semester], [Section], [AvailableSeats], [Department]) VALUES (200, 10, N'Spring2016', N'A', 0, N'CS')

go



create table Registration
(
Semester varchar(15) Foreign key References Semester(Semester),
RollNumber  varchar(7) Foreign key References Students(RollNo),
CourseID int Foreign key References Courses(CourseID), 
Section varchar(1),
GPA float
)
INSERT [dbo].[Registration] ([Semester], [RollNumber], [CourseID], [Section],GPA) VALUES (N'Fall2016', N'1', 20, N'A', 3.3)
INSERT [dbo].[Registration] ([Semester], [RollNumber], [CourseID], [Section],GPA) VALUES (N'Fall2016', N'2', 20, N'B', 4)
INSERT [dbo].[Registration] ([Semester], [RollNumber], [CourseID], [Section],GPA) VALUES (N'Spring2016', N'1', 30, N'A', 1.0)
INSERT [dbo].[Registration] ([Semester], [RollNumber], [CourseID], [Section],GPA) VALUES (N'Fall2016', N'6', 40, N'D',0.0)
INSERT [dbo].[Registration] ([Semester], [RollNumber], [CourseID], [Section],GPA) VALUES (N'Spring2017', N'6', 40, N'D',1)


go

Create table ChallanForm
(Semester varchar(15) Foreign key References Semester(Semester),
RollNumber  varchar(7) Foreign key References Students(RollNo),
TotalDues int,
[Status] varchar(10)
)
GO
INSERT [dbo].[ChallanForm] ([Semester], [RollNumber], [TotalDues], [Status]) VALUES (N'Fall2016', N'1', 100000, N'Paid')
INSERT [dbo].[ChallanForm] ([Semester], [RollNumber], [TotalDues], [Status]) VALUES (N'Fall2016', N'2', 13333, N'Paid')
INSERT [dbo].[ChallanForm] ([Semester], [RollNumber], [TotalDues], [Status]) VALUES (N'Fall2016', N'3', 5000, N'Paid')
INSERT [dbo].[ChallanForm] ([Semester], [RollNumber], [TotalDues], [Status]) VALUES (N'Fall2016', N'4', 20000, N'Pending')


select * from Students
select * from Courses
select * from Instructors
select * from Registration
select * from Semester
select * from Courses_Semester
select * from ChallanForm


--Q1

CREATE TRIGGER no_deletion
ON Students
INSTEAD OF DELETE
AS
BEGIN

  PRINT 'You don''t have the permission to delete the student'

END

DELETE FROM Students 
WHERE RollNo = 3;

--Q2

CREATE TRIGGER No_insertion
ON Courses
INSTEAD OF INSERT
AS
BEGIN

    PRINT 'You don''t have the permission to Insert a new Course'

END

INSERT INTO Courses
VALUES (50, 'History',NULL,4)

--Q3

CREATE TABLE Notify
(
    NotificationID INT PRIMARY KEY,
    StudentID VARCHAR(7) FOREIGN KEY REFERENCES Students(RollNo),
    NotificationString VARCHAR(100)
);

CREATE PROCEDURE Success_in_Reg
@CourseID INT,
@StudentID VARCHAR(7)
AS
BEGIN

    DECLARE @pre_req_passed Int
    DECLARE @seats_available INT
    DECLARE @notification_str VARCHAR(150)

    SELECT @pre_req_passed = 1 FROM Registration
    WHERE RollNumber = @StudentID AND CourseID = (
														SELECT PrerequiteCourseID FROM Courses
														WHERE CourseID = @CourseID
		   										 )


    IF @pre_req_passed IS NULL
    BEGIN

        SET @notification_str = 'You have to pass its prerequisite before registering for this course.'

        INSERT INTO Notify (StudentID, NotificationString)
        VALUES (@StudentID, @notification_str)
        RETURN

    END

    SELECT @seats_available = AvailableSeats FROM Courses_Semester
    WHERE CourseID = @CourseID AND Semester = (
												SELECT TOP 1 Semester
												FROM Semester
												WHERE Status = 'Open'
												ORDER BY Semester DESC
											  )


    IF (@seats_available <= 0)
    BEGIN

        SET @notification_str = 'Sorry, No available seats for this course.'

        INSERT INTO Notify (StudentID, NotificationString)
        VALUES (@StudentID, @notification_str)
        RETURN


    END

    INSERT INTO Registration (Semester, RollNumber, CourseID)
    VALUES (
			(SELECT TOP 1 Semester
			 FROM Semester
			 WHERE Status = 'Open'
			 ORDER BY Semester DESC), @StudentID, @CourseID)


    SET @notification_str = 'Registeration Successful, enjoy studying this course.'

    INSERT INTO Notify (StudentID, NotificationString)
    VALUES (@StudentID, @notification_str)


END



CREATE TRIGGER Registration_Trigger
ON Registration
AFTER INSERT
AS
BEGIN

    DECLARE @crse_id INT
    DECLARE @std_id VARCHAR(7)

    SELECT @crse_id = CourseID, @std_id = RollNumber FROM inserted

    EXECUTE Success_in_Reg 
	@crse_id, 
	@std_id

END


--Q4

CREATE TRIGGER CheckFee_dues
ON Registration
FOR INSERT
AS
BEGIN
    DECLARE @Rollnum varchar(7)
    DECLARE @Total_Dues int
    
    SELECT @Rollnum = i.RollNumber, @Total_Dues = cf.TotalDues
    FROM inserted i
    JOIN ChallanForm cf ON i.Semester = cf.Semester AND i.RollNumber = cf.RollNumber
	where [Status]='Pending'
    
    IF (@Total_Dues > 20000)
    begin 

		RAISERROR('Student %s has greater than 20,000 dues, please pay them before inrollment', 16, 1, @Rollnum)
        ROLLBACK TRANSACTION

	end 
	else
	begin

		print'No dues.'

	end

END



--Q5

CREATE TRIGGER no_Deletion_stop
ON dbo.Courses_Semester
INSTEAD OF DELETE
AS
BEGIN

  DECLARE @availableseats int;

  SELECT @availableseats = d.AvailableSeats FROM deleted d
  
  IF (@availableseats < 10)
  BEGIN

    PRINT 'not possible';

  END
  ELSE
  BEGIN

    DELETE FROM Courses_Semester
    WHERE InstructorID IN (SELECT InstructorID FROM deleted)
			  AND CourseID IN (SELECT CourseID FROM deleted)
			  AND Semester IN (SELECT Semester FROM deleted)
			  AND Section IN (SELECT Section FROM deleted);

    PRINT 'Successfully deleted';

  END

END



DELETE FROM Courses_Semester 
WHERE InstructorID = 200 AND CourseID = 10 AND Semester = 'Spring2017' AND Section = 'C' 


--Q6

create trigger stopping_instructors
on database
FOR DROP_TABLE,ALTER_TABLE
AS
begin

	declare @T_name varchar(150)
	set @T_name = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]','varchar(128)')

	if(@T_name='Instructors')
	begin

		print'You are not allowed to drop or modify the table named Intructors'

	end

END


alter table Instructors

add coun int
