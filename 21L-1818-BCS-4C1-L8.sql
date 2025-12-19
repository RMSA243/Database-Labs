use master
go
drop  database ATM
go 
Create database ATM
go 
use ATM
go

create table [User](
[userId] int primary key,
[name] varchar(20) not null,
[phoneNum] varchar(15) not null,
[city] varchar(20) not null
)
go

create table CardType(
[cardTypeID] int primary key,
[name] varchar(15),
[description] varchar(40) null
)
go
create Table [Card](
cardNum Varchar(20) primary key,
cardTypeID int foreign key references  CardType([cardTypeID]),
PIN varchar(4) not null,
[expireDate] date not null,
balance float not null
)
go


Create table UserCard(
userID int foreign key references [User]([userId]),
cardNum varchar(20) foreign key references [Card](cardNum),
primary key(cardNum)
)
go
create table [Transaction](
transId int primary key,
transDate date not null,
cardNum varchar(20) foreign key references [Card](cardNum),
amount int not null
)


INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (1, N'Ali', N'03036067000', N'Narowal')
GO
INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (2, N'Ahmed', N'03036047000', N'Lahore')
GO
INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (3, N'Aqeel', N'03036063000', N'Karachi')
GO
INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (4, N'Usman', N'03036062000', N'Sialkot')
GO
INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (5, N'Hafeez', N'03036061000', N'Lahore')
GO


INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (1, N'Debit', N'Spend Now, Pay Now')
GO
INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (2, N'Credit', N'Spend Now, Pay later')
GO

INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1234', 1, N'1770', CAST(N'2022-07-01' AS Date), 43025.31)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1235', 1, N'9234', CAST(N'2020-03-02' AS Date), 14425.62)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1236', 1, N'1234', CAST(N'2019-02-06' AS Date), 34325.52)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1237', 2, N'1200', CAST(N'2021-02-05' AS Date), 24325.3)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1238', 2, N'9004', CAST(N'2020-09-02' AS Date), 34025.12)
GO

INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'1234')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'1235')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (2, N'1236')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (3, N'1238')
GO
Insert  [dbo].[UserCard] ([userID], [cardNum]) VALUES (4, N'1237')

INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (1, CAST(N'2017-02-02' AS Date), N'1234', 500)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (2, CAST(N'2018-02-03' AS Date), N'1235', 3000)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (3, CAST(N'2020-01-06' AS Date), N'1236', 2500)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (4, CAST(N'2016-09-09' AS Date), N'1238', 2000)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (5, CAST(N'2020-02-10' AS Date), N'1234', 6000)
GO


Select * from [User]
Select * from UserCard
Select * from [Card]
Select * from CardType
Select * from [Transaction]

--Q1

CREATE FUNCTION GetBalance(@Cardnumber Varchar(20))
RETURNS float
AS
BEGIN

	Declare @returnbal float
	Select @returnbal = balance from [Card] where cardNum=@Cardnumber
	RETURN @returnbal

END


Select dbo.GetBalance('1237') AS balance

--Q2


CREATE FUNCTION GetUserdetail(@usrid int)
RETURNS TABLE
AS
RETURN SELECT*
FROM [User] where userId = @usrid


select* from GetUserdetail(4)

--Q3

CREATE PROCEDURE user_detail
@Name varchar(20)
AS
BEGIN
	Select * from [User] where name = @Name
END
GO

Declare @user_name varchar(20) = 'Aqeel'
EXECUTE user_detail
@Name = @user_name

--Q4


CREATE PROCEDURE user_card_detail
@usid int
AS
	select uc.cardNum, dbo.GetBalance(uc.cardNum) AS user_balance from [User] AS u
	join UserCard As uc on u.userId = uc.userID
	where u.userId = @usid
GO


Declare @user_id int = 1
EXECUTE user_card_detail
@usid = @user_id

--Q5

CREATE FUNCTION GetUserCardBalance (@usid int)
RETURNS TABLE
AS
RETURN 
(
	select uc.cardNum, dbo.GetBalance(uc.cardNum) AS user_balance from [User] AS u
	join UserCard As uc on u.userId = uc.userID
	where u.userId = @usid
)

SELECT * FROM GetUserCardBalance(1)



--Q6

CREATE PROCEDURE NUM_CARDS
@userid int,
@numcards int OUTPUT
AS
BEGIN
	SELECT @numcards = COUNT(uc.userID) FROM [User] AS u
	right join [UserCard] AS uc ON u.userId = uc.userID
	where u.userId = @userid
	Group by uc.userID
END
GO

DECLARE @num0fcards int

EXECUTE NUM_CARDS
@userid = 1,
@numcards = @num0fcards OUTPUT

select @num0fcards AS Total_card

--Q7

CREATE PROCEDURE Login
@cardnum varchar(20),
@pin varchar(4),
@status int OUTPUT
AS
BEGIN
if exists (select * from [Card] where cardNum = @cardnum AND PIN = @pin)
	Begin
		set @status = 1
	end
	else
	Begin
		set @status = 0
	end
END
GO

Declare @result int

Execute Login
@cardnum = '1234',
@pin = '1770',
@status = @result output

select @result AS [Status]

--No we can't as a UDF cannot modify data in the database and in the case of the Login stored procedure, it modifies the output parameter @status based on the input parameters @cardNum and @PIN. 
--A user-defined function can only return a value based on the input parameters, without modifying any data in the database.


--Q8

Create procedure Up_pin
@cardnum varchar(20),
@OLD_pin varchar(4),
@pin varchar(4)
AS
BEGIN
if len(@pin) <> 4
	Begin
		PRINT 'Error, length should be 4'

	END
	ELSE IF exists (select * from [Card] where cardNum = @cardnum AND PIN = @OLD_pin)
	Begin
		
		PRINT 'Updated PIN'

		update [Card]
		set [Card].PIN = @pin
		where cardNum = @cardnum AND PIN = @OLD_pin

	end
	else
	Begin
		PRINT 'Error, not found'
	end
END
GO

EXECUTE Up_pin
@cardnum = '1235',
@OLD_pin = '9234',
@pin = '3000'

--Q9

CREATE PROCEDURE p_Withdraw
@cardNum varchar(20),
@pin varchar(4),
@amount float
AS
BEGIN

	DECLARE @status int
	EXEC Login @cardNum, @pin, @status OUTPUT

	IF @status = 1 
	BEGIN

		DECLARE @balance int
		SELECT @balance = balance FROM [Card] WHERE cardNum = @cardNum

		IF @balance >= @amount 
		BEGIN

			DECLARE @transID int
			SELECT @transID = MAX(transID) + 1 FROM [Transaction]

			INSERT INTO [Transaction] (transID, transDate, cardNum, amount, transType)
			VALUES (@transID, GETDATE(), @cardNum, @amount, 1)

			UPDATE [Card] 
			SET balance = balance - @amount 
			WHERE cardNum = @cardNum

		END
		ELSE 
		BEGIN

			SELECT @transID = MAX(transID) + 1 FROM [Transaction]

			INSERT INTO [Transaction] (transID, transDate, cardNum, amount, transType)
			VALUES (@transID, GETDATE(), @cardNum, @amount, 4)

		END

	END
	else
	Begin

		PRINT 'ERROR FAILD'

	END

END

EXECUTE p_Withdraw
@cardNum = '1324327436569', 
@PIN = '1770', 
@amount = 2000;

--No as UDF cannot modify the database or execute other statements such as SELECT, INSERT, UPDATE, or DELETE.
--and UDF are used to return a single value based on the input parameters