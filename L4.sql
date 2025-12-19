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

select c.cardTypeID, count(Distinct userID) AS total_card_unique_users from UserCard AS uc 
join card AS c ON c.cardNum = uc.cardNum
group by cardTypeID

--there is one extra insert in user card table

--Q2

select u.name, uc.cardNum from [User] AS u
join UserCard AS uc ON u.userId = uc.userID
join Card AS c ON c.cardNum = uc.cardNum
where c.balance between 2000 AND 4000

--Q3
--a)

select name from [user]
where userId IN(
	Select userId from [User]
	Except
	select userID from UserCard
	)

--user:4 has been added in UserCard table

--Q3
--b)

select u.name from [User] AS u
left join UserCard AS uc ON uc.userID = u.userId
where uc.cardNum is NULL


--Q4
--a)
select [Card].cardNum AS card_ID, CardType.name AS Card_type_Name, [User].name AS owner_name from [User], UserCard,[Card] ,CardType,[Transaction]
Intersect
select [Card].cardNum AS card_ID, CardType.name AS Card_type_Name, [User].name AS owner_name from [User], UserCard,[Card] ,CardType,[Transaction]
where UserCard.userID = [User].userId AND UserCard.cardNum = [Card].cardNum AND [Card].cardTypeID = CardType.cardTypeID AND [Transaction].cardNum = [Card].cardNum AND [Card].[cardNum] NOT IN (
																												SELECT DISTINCT [Transaction].[cardNum]
																												FROM [Transaction]
																												WHERE YEAR([Transaction].[transDate]) >= YEAR(GETDATE()) - 1
																											)


--Q4
--b)

select distinct[Card].cardNum AS card_ID, CardType.name AS Card_type_Name, [User].name AS owner_name from [Card]
	join CardType ON [Card].cardTypeID = CardType.[cardTypeID]
	JOIN UserCard ON [Card].cardNum = UserCard.cardNum
	JOIN [User] ON UserCard.userID = [User].userId
	LEFT JOIN [Transaction] ON [Card].cardNum = [Transaction].cardNum
		WHERE YEAR([Transaction].transDate) < YEAR(GETDATE()) - 1


--Q5

SELECT CardType.name AS cardType, COUNT(distinct [card].cardNum) AS total_num_of_Cards FROM [Card]
	JOIN CardType ON [Card].cardTypeID = CardType.cardTypeID
	JOIN [Transaction] ON [Card].cardNum = [Transaction].cardNum
	WHERE YEAR([Transaction].transDate) BETWEEN 2015 AND 2017
	GROUP BY [CardType].name
	HAVING SUM([Transaction].amount) > 6000

-- Card type's total cards, whose total sum of transactions is greater than 6000

--Q6

SELECT [User].userId, [User].name, [User].phoneNum, [User].city, [Card].cardNum, CardType.name AS Card_Type_Name FROM [User]
	JOIN UserCard ON [User].userId = UserCard.userID
	JOIN [Card] ON UserCard.cardNum = [Card].cardNum
	JOIN CardType ON [Card].cardTypeID = CardType.cardTypeID
		WHERE [Card].[expireDate] BETWEEN GETDATE() AND DATEADD(MONTH, 3, GETDATE())

--Q7

SELECT u.userId, u.name FROM [User] AS u
	JOIN UserCard AS uc ON u.userId = uc.userID
	JOIN (
    SELECT c.cardNum, SUM(c.balance) AS total_Balance FROM [Card] AS c
    GROUP BY c.cardNum
	) AS CardBalance ON uc.cardNum = CardBalance.cardNum
	GROUP BY u.userId, u.name
	HAVING SUM([CardBalance].total_Balance) >= 5000

--Q8

SELECT C1.cardNum, C1.expireDate, C2.cardNum, C2.expireDate
FROM Card C1, Card C2
WHERE C1.cardNum != C2.cardNum AND YEAR(C1.expireDate) = YEAR(C2.expireDate)

--Q9

SELECT u1.userId, u1.name, U2.userId, U2.name FROM [User] u1, [User] U2
WHERE u1.userId != U2.userId AND LEFT(u1.name, 1) = LEFT(U2.name, 1)

--All possible pairs

--Q10

SELECT u.name, u.userId FROM [User] u
	JOIN UserCard uc1 ON u.userId = uc1.userId
	JOIN UserCard uc2 ON u.userId = uc2.userId
	JOIN Card c1 ON uc1.cardNum = c1.cardNum AND c1.cardTypeID = 1
	JOIN Card c2 ON uc2.cardNum = c2.cardNum AND c2.cardTypeID = 2
	WHERE uc1.cardNum != uc2.cardNum


--Q11

SELECT u.city AS City, COUNT(distinct u.userId) AS Num_Of_Users, SUM(c.balance) AS Total_Amount_of_users FROM [User] u
	JOIN UserCard uc ON u.userId = uc.userId
	JOIN [Card] c ON uc.cardNum = c.cardNum
	GROUP BY u.city



