USE [master]
GO

/****** Object:  Database [CovidData]    Script Date: 7/25/2022 10:22:46 PM ******/
CREATE DATABASE [CovidData]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CovidData', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\CovidData.mdf' , SIZE = 204800KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CovidData_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\CovidData_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CovidData].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [CovidData] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [CovidData] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [CovidData] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [CovidData] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [CovidData] SET ARITHABORT OFF 
GO

ALTER DATABASE [CovidData] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [CovidData] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [CovidData] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [CovidData] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [CovidData] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [CovidData] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [CovidData] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [CovidData] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [CovidData] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [CovidData] SET  DISABLE_BROKER 
GO

ALTER DATABASE [CovidData] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [CovidData] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [CovidData] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [CovidData] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [CovidData] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [CovidData] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [CovidData] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [CovidData] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [CovidData] SET  MULTI_USER 
GO

ALTER DATABASE [CovidData] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [CovidData] SET DB_CHAINING OFF 
GO

ALTER DATABASE [CovidData] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [CovidData] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [CovidData] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [CovidData] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO

ALTER DATABASE [CovidData] SET QUERY_STORE = OFF
GO

ALTER DATABASE [CovidData] SET  READ_WRITE 
GO


