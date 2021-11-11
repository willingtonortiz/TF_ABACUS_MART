CREATE DATABASE [BD_ABACUS_MART]
GO
USE [BD_ABACUS_MART]
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

	CONSTRAINT [PK_Dim_Clientes] PRIMARY KEY CLUSTERED ([Sk_Cliente] ASC)
)
GO
CREATE TABLE [dbo].[Dim_Puertos](
	[Sk_Puerto] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,

	CONSTRAINT [PK_Dim_Puertos] PRIMARY KEY CLUSTERED ([Sk_Puerto] ASC)
)
GO
CREATE TABLE [dbo].[Dim_Transportes](
	[Sk_Transporte] [int] IDENTITY(1,1) NOT NULL,
	[Empresa_Transporte] [nvarchar](100) NOT NULL,
	/* Con nulos */
	[Ruc_Transporte] [nvarchar](20) NULL,

	CONSTRAINT [PK_Dim_Transportes] PRIMARY KEY CLUSTERED ([Sk_Transporte] ASC)
)
GO
CREATE TABLE [dbo].[Dim_Mercancias](
	[Sk_Mercancia] [int] IDENTITY(1,1) NOT NULL,
	[Resumen_Mercancia] [nvarchar](100) NOT NULL,

	CONSTRAINT [PK_Dim_Mercancias] PRIMARY KEY CLUSTERED ([Sk_Mercancia] ASC)
)
GO
CREATE TABLE [dbo].[Dim_Estado_Ordenes](
	[Sk_Estado_Orden] [int] IDENTITY(1,1) NOT NULL,
	[Estado] [nvarchar](32) NOT NULL,

	CONSTRAINT [PK_Dim_Estado_Ordenes] PRIMARY KEY CLUSTERED ([Sk_Estado_Orden] ASC)
)
GO

/* 118 - MARITIMA DEL CALLAO */
/* 235 - AEREA Y POSTAL EX-IAAC */
CREATE TABLE [dbo].[Dim_Tipo_Transporte](
	[Sk_Tipo_Transporte] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] int NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,

	CONSTRAINT [PK_Dim_Tipo_Transporte] PRIMARY KEY CLUSTERED ([Sk_Tipo_Transporte] ASC)
)

GO
CREATE TABLE [dbo].[Dim_Rango_CIF](
	[Sk_Rango_CIF] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Valor_Minimo] [decimal](12, 3) NOT NULL,
	[Valor_Maximo] [decimal](12, 3) NOT NULL,

	CONSTRAINT [PK_Dim_Rango_CIF] PRIMARY KEY CLUSTERED ([Sk_Rango_CIF] ASC)
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

	CONSTRAINT [PK_Dim_Fechas] PRIMARY KEY CLUSTERED ([Sk_Fecha] ASC)
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

-- Creating Foreign keys
ALTER TABLE [dbo].[FACT_Orden] ADD CONSTRAINT FK_FACT_Orden_Sk_Cliente FOREIGN KEY (Sk_Cliente) REFERENCES [dbo].[Dim_Clientes] (Sk_Cliente)
ALTER TABLE [dbo].[FACT_Orden] ADD CONSTRAINT FK_FACT_Orden_Sk_Puerto FOREIGN KEY (Sk_Puerto) REFERENCES [dbo].[Dim_Puertos] (Sk_Puerto)
ALTER TABLE [dbo].[FACT_Orden] ADD CONSTRAINT FK_FACT_Orden_Sk_Fecha_Orden FOREIGN KEY (Sk_Fecha_Orden) REFERENCES [dbo].[Dim_Fechas] (Sk_Fecha)
ALTER TABLE [dbo].[FACT_Orden] ADD CONSTRAINT FK_FACT_Orden_Sk_Fecha_Factura FOREIGN KEY (Sk_Fecha_Factura) REFERENCES [dbo].[Dim_Fechas] (Sk_Fecha)
ALTER TABLE [dbo].[FACT_Orden] ADD CONSTRAINT FK_FACT_Orden_Sk_Transporte FOREIGN KEY (Sk_Transporte) REFERENCES [dbo].[Dim_Transportes] (Sk_Transporte)
ALTER TABLE [dbo].[FACT_Orden] ADD CONSTRAINT FK_FACT_Orden_Sk_Estado_Orden FOREIGN KEY (Sk_Estado_Orden) REFERENCES [dbo].[Dim_Estado_Ordenes] (Sk_Estado_Orden)
ALTER TABLE [dbo].[FACT_Orden] ADD CONSTRAINT FK_FACT_Orden_Sk_Tipo_Transporte FOREIGN KEY (Sk_Tipo_Transporte) REFERENCES [dbo].[Dim_Tipo_Transporte] (Sk_Tipo_Transporte)
ALTER TABLE [dbo].[FACT_Orden] ADD CONSTRAINT FK_FACT_Orden_Sk_Mercancia FOREIGN KEY (Sk_Mercancia) REFERENCES [dbo].[Dim_Mercancias] (Sk_Mercancia)
ALTER TABLE [dbo].[FACT_Orden] ADD CONSTRAINT FK_FACT_Orden_Sk_Rango_CIF FOREIGN KEY (Sk_Rango_CIF) REFERENCES [dbo].[Dim_Rango_CIF] (Sk_Rango_CIF)


-- Inserting Business Data
INSERT INTO [dbo].[Dim_Rango_CIF] (Nombre, Valor_Minimo, Valor_Maximo)
	VALUES ('R1', 0, 20000),
			('R2', 20001, 40000),
			('R3', 40001, 60000),
			('R4', 60001, 80000),
			('R5', 80001, 100000),
			('R6', 100001, 999999999);
