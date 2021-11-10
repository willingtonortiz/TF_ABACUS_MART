CREATE DATABASE [BD_ABACUS]
GO
USE [BD_ABACUS]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Dim_Clientes](
	[Sk_Cliente] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](150) NOT NULL,
	/* Con nulos */
	[Referencia] [nvarchar](100) NULL,
)
GO
CREATE TABLE [dbo].[Dim_Puertos](
	[Sk_Puerto] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
)
GO
CREATE TABLE [dbo].[Dim_Transportes](
	[Sk_Transporte] [int] IDENTITY(1,1) NOT NULL,
	[Empresa_Transporte] [nvarchar](100) NOT NULL,
	/* Con nulos */
	[Ruc_Transporte] [nvarchar](20) NULL,
)
GO
CREATE TABLE [dbo].[Dim_Mercancias](
	[Sk_Mercancia] [int] IDENTITY(1,1) NOT NULL,
	[Resumen_Mercancia] [nvarchar](100) NOT NULL,
)
GO
CREATE TABLE [dbo].[Dim_Estado_Ordenes](
	[Sk_Estado_Orden] [int] IDENTITY(1,1) NOT NULL,
	[Estado] [nvarchar](32) NOT NULL,
)
GO

/* 118 - MARITIMA DEL CALLAO */
/* 235 - AEREA Y POSTAL EX-IAAC */
CREATE TABLE [dbo].[Dim_Tipo_Transporte](
	[Sk_Tipo_Transporte] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] int NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
)

GO
CREATE TABLE [dbo].[Dim_Rango_CIF](
	[Sk_Rango_CIF] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Valor_Minimo] [decimal](12, 3) NOT NULL,
	[Valor_Maximo] [decimal](12, 3) NOT NULL,
)

GO
CREATE TABLE [dbo].[Dim_Fechas](
	[Sk_Fecha] [int] NOT NULL,
	[Fecha] [date] NOT NULL,
	[Anio] [smallint] NOT NULL,

	[Mes] [nvarchar](30) NULL,
	[NumMesAnio] [smallint] NULL,

	[DiaSemana] [nvarchar](30) NULL,
	[NumDiaMes] [smallint] NULL,
	[NumDiaSemana] [smallint] NULL,

	[Trimestre] [nvarchar](30) NULL,
	[NumTrimestreAnio] [smallint] NULL,
	[Semestre] [nvarchar](30) NULL,
	[NumSemestreAnio] [smallint] NULL,
)
GO
CREATE TABLE [dbo].[FACT_Orden](
	[Sk_Cliente] [int] NOT NULL,
	[Sk_Puerto] [int] NOT NULL,
	[Sk_Fecha_Orden] [int] NOT NULL,
	[Sk_Fecha_Factura] [int] NOT NULL,
	[Sk_Transporte] [int] NOT NULL,
	[Sk_Estado_Orden] [int] NOT NULL,
	[Sk_Tipo_Transporte] [int] NOT NULL,
	[Sk_Mercancia] [int] NOT NULL,
	[Sk_Rango_CIF] [int] NOT NULL,

	[Nro_Orden] [nvarchar](32) NOT NULL,
	[Valor_Incoterm] [decimal](12, 3) NOT NULL,
	[Flete] [decimal](12, 3) NOT NULL,
	[Fob] [decimal](12, 3) NOT NULL,
	[Seguro] [decimal](12, 3) NOT NULL,
	[Cif] [decimal](12, 3) NOT NULL,
	[Veces] [int] NOT NULL,
	[Peso_Bruto] [decimal](12, 3) NOT NULL,
	[Peso_Neto] [decimal](12, 3) NOT NULL,
)


INSERT INTO [dbo].[Dim_Rango_CIF] (Nombre, Valor_Minimo, Valor_Maximo)
	VALUES ('R1', 0, 20000),
			('R2', 20001, 40000),
			('R3', 40001, 60000),
			('R4', 60001, 80000),
			('R5', 80001, 100000),
			('R6', 100001, 999999999);
