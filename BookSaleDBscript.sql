USE [master]
GO
/****** Object:  Database [BookSaleDB]    Script Date: 11/11/2020 3:35:40 PM ******/
CREATE DATABASE [BookSaleDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BookSale', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\BookSale.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BookSale_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\BookSale_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BookSaleDB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BookSaleDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BookSaleDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BookSaleDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BookSaleDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BookSaleDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BookSaleDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [BookSaleDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BookSaleDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [BookSaleDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BookSaleDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BookSaleDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BookSaleDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BookSaleDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BookSaleDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BookSaleDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BookSaleDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BookSaleDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BookSaleDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BookSaleDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BookSaleDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BookSaleDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BookSaleDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BookSaleDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BookSaleDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BookSaleDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BookSaleDB] SET  MULTI_USER 
GO
ALTER DATABASE [BookSaleDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BookSaleDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BookSaleDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BookSaleDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [BookSaleDB]
GO
/****** Object:  StoredProcedure [dbo].[spAddNewBook]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[spAddNewBook](@BookID int, @BookTitle nvarchar(50), @Author nvarchar(100), @Publisher nvarchar(50), @PublishDate date, @Price float, @Quantity int)
AS
BEGIN
	INSERT INTO 
		tblBooks(BookTitle, Author, Publisher, PublishDate, Price, Quantity)
	VALUES
		(@BookTitle, @Author, @Publisher, @PublishDate, @Price, @Quantity)
END;


/* Update a book from table by id */

GO
/****** Object:  StoredProcedure [dbo].[spAddNewCustomer]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[spAddNewCustomer](@PhoneNo varchar(50), @CustomerName nvarchar(50), @Address nvarchar(100), @Email nvarchar(100))
AS
BEGIN
	INSERT INTO 
		tblCustomer(PhoneNo, CustomerName, Address, Email)
	VALUES
		(@PhoneNo, @CustomerName, @Address, @Email)
END;
GO
/****** Object:  StoredProcedure [dbo].[spAddNewOrder]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[spAddNewOrder](@OrderID nvarchar(100), @TotalPrice float, @DateOfReceipt datetime, @PhoneNo nvarchar(50))
AS
BEGIN
	INSERT INTO 
		tblOrders(OrderID, TotalPrice, DateOfReceipt, PhoneNo)
	VALUES
		(@OrderID, @TotalPrice, @DateOfReceipt, @PhoneNo)
END;

GO
/****** Object:  StoredProcedure [dbo].[spAddNewOrderDetail]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[spAddNewOrderDetail](@OrderDetailID int, @OrderID nvarchar(100), @BookID int, @Quantity int)
AS
BEGIN
	INSERT INTO 
		tblOrderDetail(OrderID, BookID, Quantity)
	VALUES
		(@OrderID, @BookID, @Quantity)
END;
GO
/****** Object:  StoredProcedure [dbo].[spDeleteAllOrderDetails]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[spDeleteAllOrderDetails](@OrderID nvarchar(50))
AS
BEGIN
	DELETE
	FROM
		tblOrderDetail
	WHERE
		OrderID=@OrderID
END;

/* Add an orderdetail to the table */

GO
/****** Object:  StoredProcedure [dbo].[spDeleteBook]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[spDeleteBook](@BookID int)
AS
BEGIN
	DELETE
	FROM
		tblBooks
	WHERE
		BookID=@BookID
END;

/* Search book by name */

GO
/****** Object:  StoredProcedure [dbo].[spDeleteCustomer]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[spDeleteCustomer](@PhoneNo varchar(20))
AS
BEGIN
	DELETE
	FROM
		tblCustomer
	WHERE
		PhoneNo=@PhoneNo
END;
GO
/****** Object:  StoredProcedure [dbo].[spDeleteOrder]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[spDeleteOrder](@OrderID nvarchar(100))
AS
BEGIN
	DELETE
	FROM
		tblOrders
	WHERE
		OrderID=@OrderID
END;
GO
/****** Object:  StoredProcedure [dbo].[spGenerateOrderID]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[spGenerateOrderID]
AS
BEGIN
	SELECT
		NEWID()
	AS
		OrderID
END;
GO
/****** Object:  StoredProcedure [dbo].[spGetAllCustomers]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[spGetAllCustomers]
AS
BEGIN
	SELECT
		PhoneNo,
		CustomerName,
		Address,
		Email
	FROM
		tblCustomer
END;
GO
/****** Object:  StoredProcedure [dbo].[spGetAllOrder]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[spGetAllOrder]
AS
BEGIN
	SELECT
		OrderID,
		DateOfReceipt,
		TotalPrice,
		PhoneNo
	FROM
		tblOrders
END;

/* Add a new order to table */

GO
/****** Object:  StoredProcedure [dbo].[spGetAllOrderDetails]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[spGetAllOrderDetails](@OrderID nvarchar(100))
AS
BEGIN
	SELECT
		a.OrderDetailID,
		a.OrderID,		
		a.BookID,
		b.BookTitle,
		a.Quantity
	FROM
		tblOrderDetail a JOIN tblBooks b ON a.BookID=b.BookID
	WHERE
		a.OrderID=@OrderID
		
END;
GO
/****** Object:  StoredProcedure [dbo].[spGetBookById]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[spGetBookById](@BookID int)
AS
BEGIN
	SELECT
		BookID,
		BookTitle,
		Author,
		Publisher,
		PublishDate,
		Price,
		Quantity
	FROM
		tblBooks
	WHERE
		BookID=@BookID
END;


/* Get all books from table */

GO
/****** Object:  StoredProcedure [dbo].[spGetBooks]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[spGetBooks]
AS
BEGIN
	SELECT
		BookID,
		BookTitle,
		Author,
		Publisher,
		PublishDate,
		Price,
		Quantity
	FROM
		tblBooks
END;


/* Add a new book to table */

GO
/****** Object:  StoredProcedure [dbo].[spGetBooksByTitle]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[spGetBooksByTitle](@BookTitle nvarchar(50))
AS
BEGIN
	SELECT
		BookID,
		BookTitle,
		Author,
		Publisher,
		PublishDate,
		Price,
		Quantity
	FROM
		tblBooks
	WHERE
		BookTitle LIKE '%'+@BookTitle+'%'
END;
GO
/****** Object:  StoredProcedure [dbo].[spGetCustomerByPhone]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[spGetCustomerByPhone](@PhoneNo varchar(50))
AS
BEGIN
	SELECT
		CustomerName,
		Address,
		Email
	FROM
		tblCustomer
	WHERE
		PhoneNo=@PhoneNo
END;


/* Get all customers */

GO
/****** Object:  StoredProcedure [dbo].[spGetOrderById]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[spGetOrderById](@OrderID nvarchar(100))
AS
BEGIN
	SELECT
		OrderID,
		DateOfReceipt,
		TotalPrice,
		PhoneNo
	FROM
		tblOrders
	WHERE
		OrderID=@OrderID
END;
GO
/****** Object:  StoredProcedure [dbo].[spGetOrderByPhone]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[spGetOrderByPhone](@PhoneNo nvarchar(50))
AS
BEGIN
	SELECT
		OrderID,
		DateOfReceipt,
		TotalPrice,
		PhoneNo
	FROM
		tblOrders
	WHERE
		PhoneNo=@PhoneNo
END;

/* Get all orders from table */

GO
/****** Object:  StoredProcedure [dbo].[spLogin]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[spLogin](@Username varchar(50), @Password varchar(50))
AS
BEGIN
	SELECT
		Username,
		Role
	FROM
		tblAccounts
	WHERE
			Username=@Username
		AND
			Password=@Password
END;
GO
/****** Object:  StoredProcedure [dbo].[spUpdateBook]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[spUpdateBook](@BookID int, @BookTitle nvarchar(50), @Author nvarchar(100), @Publisher nvarchar(50), @PublishDate date, @Price float, @Quantity int)
AS
BEGIN
	UPDATE  
		tblBooks
	SET
		BookTitle=@BookTitle,
		Publisher=@Publisher,
		Author=@Author,
		PublishDate=@PublishDate,
		Price=@Price,
		Quantity=@Quantity
	WHERE
		BookID=@BookID
END;


/* Delete a book from table by id */

GO
/****** Object:  StoredProcedure [dbo].[spUpdateBookQuantity]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[spUpdateBookQuantity](@BookID int, @Quantity int)
AS
BEGIN
	UPDATE tblBooks
	SET Quantity=Quantity-@Quantity
	WHERE BookID=@BookID
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateCustomer]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[spUpdateCustomer](@PhoneNo varchar(20), @CustomerName nvarchar(50), @Address nvarchar(100), @Email nvarchar(100))
AS
BEGIN
	UPDATE  
		tblCustomer
	SET
		CustomerName=@CustomerName,
		Address=@Address,
		Email=@Email
	WHERE
		PhoneNo=@PhoneNo
END;
GO
/****** Object:  StoredProcedure [dbo].[spUpdateOrder]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[spUpdateOrder](@OrderID nvarchar(50), @DateOfReceipt datetime, @TotalPrice float, @PhoneNo nvarchar(12))
AS
BEGIN
	UPDATE  
		tblOrders
	SET
		DateOfReceipt=@DateOfReceipt,
		TotalPrice=@TotalPrice,
		PhoneNo = @PhoneNo
	WHERE
		OrderID=@OrderID
END;


/* Delete an order from table by id */

GO
/****** Object:  Table [dbo].[tblAccounts]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblAccounts](
	[Username] [varchar](24) NOT NULL,
	[Password] [varchar](24) NOT NULL,
	[Role] [bit] NOT NULL,
 CONSTRAINT [PK_tblAccounts] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblBooks]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblBooks](
	[BookID] [int] IDENTITY(1,1) NOT NULL,
	[BookTitle] [nvarchar](50) NOT NULL,
	[Author] [nvarchar](100) NOT NULL,
	[Publisher] [nvarchar](50) NOT NULL,
	[PublishDate] [date] NOT NULL,
	[Price] [float] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_tblBooks] PRIMARY KEY CLUSTERED 
(
	[BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblCustomer]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblCustomer](
	[PhoneNo] [varchar](50) NOT NULL,
	[CustomerName] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_tblCustomer] PRIMARY KEY CLUSTERED 
(
	[PhoneNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblOrderDetail]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrderDetail](
	[OrderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [nvarchar](100) NULL,
	[BookID] [int] NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK_tblOrderDetail] PRIMARY KEY CLUSTERED 
(
	[OrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblOrders]    Script Date: 11/11/2020 3:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblOrders](
	[OrderID] [nvarchar](100) NOT NULL,
	[PhoneNo] [varchar](50) NOT NULL,
	[DateOfReceipt] [datetime] NOT NULL,
	[TotalPrice] [float] NOT NULL,
 CONSTRAINT [PK_tblOrders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[tblOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_tblOrderDetail_tblBooks] FOREIGN KEY([BookID])
REFERENCES [dbo].[tblBooks] ([BookID])
GO
ALTER TABLE [dbo].[tblOrderDetail] CHECK CONSTRAINT [FK_tblOrderDetail_tblBooks]
GO
ALTER TABLE [dbo].[tblOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_tblOrderDetail_tblOrders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[tblOrders] ([OrderID])
GO
ALTER TABLE [dbo].[tblOrderDetail] CHECK CONSTRAINT [FK_tblOrderDetail_tblOrders]
GO
ALTER TABLE [dbo].[tblOrders]  WITH CHECK ADD  CONSTRAINT [FK_tblOrders_tblCustomer] FOREIGN KEY([PhoneNo])
REFERENCES [dbo].[tblCustomer] ([PhoneNo])
GO
ALTER TABLE [dbo].[tblOrders] CHECK CONSTRAINT [FK_tblOrders_tblCustomer]
GO
USE [master]
GO
ALTER DATABASE [BookSaleDB] SET  READ_WRITE 
GO
