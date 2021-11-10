CREATE DATABASE [BD_ABACUS_STAGE]
GO
USE [BD_ABACUS_STAGE]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Dim_Clientes](
	[cliente_id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](150) NOT NULL,

	/* Con nulos */
	[Referencia] [nvarchar](100) NULL,
)
GO
CREATE TABLE [dbo].[Dim_Puertos](
	[puerto_id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
)
GO
CREATE TABLE [dbo].[Dim_Transportes](
	[transporte_id] [int] IDENTITY(1,1) NOT NULL,
	[Empresa_Transporte] [nvarchar](100) NOT NULL,
	/* Con nulos */
	[Ruc_Transporte] [nvarchar](20) NULL,
)
GO
CREATE TABLE [dbo].[Dim_Mercancias](
	[mercancia_id] [int] IDENTITY(1,1) NOT NULL,
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
	[tipo_transporte_id] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] int NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
)

GO
CREATE TABLE [dbo].[Dim_Rango_CIF](
	[rango_cif_id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Valor_Minimo] [decimal](12, 3) NOT NULL,
	[Valor_Maximo] [decimal](12, 3) NOT NULL,
)

GO
CREATE TABLE [dbo].[Dim_Fechas](
	[fecha_id] [int] NOT NULL,
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
	[cliente_id] [int] NOT NULL,
	[puerto_id] [int] NOT NULL,
	[fecha_Orden_id] [int] NOT NULL,
	[fecha_Factura_id] [int] NOT NULL,
	[transporte_id] [int] NOT NULL,
	[estado_Orden_id] [int] NOT NULL,
	[tipo_Transporte_id] [int] NOT NULL,
	[mercancia_id] [int] NOT NULL,
	[rango_CIF_id] [int] NOT NULL,

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
