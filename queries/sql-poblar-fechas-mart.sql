USE [BD_ABACUS]

DECLARE @FechaDesde date,@FechaHasta date

DECLARE @Sk_Fecha int,
        @FechaEvaluada date,@Anio int,
		@Semestre nvarchar(30),@Trimestre nvarchar(30),@Mes nvarchar(30),@DiaSemana nvarchar(30)
DECLARE @NumSemestreAnio smallint,@NumTrimestreAnio smallint,@NumMesAnio smallint,
        @NumDiaSemana smallint,@NumDiaMes smallint



--Set inicial por si no coincide con los del servidor
SET DATEFORMAT dmy
SET DATEFIRST 1

BEGIN TRANSACTION
    --Borrar datos de la tabla Dim_Fechas
    TRUNCATE TABLE  Dim_Fechas
   
    --Rango de fechas a generar: del 01/01/2016 al 31/12/2013
    SELECT @FechaDesde = CAST('20180101' AS date)
	SELECT @FechaHasta = CAST('20201231' AS date)

	--Carga la variable @FechaEvaluada con el valor inicial de la @FechaDesde
	SET @FechaEvaluada = @FechaDesde
    
	--Esta línea permite agregar 2 años mas al año actual, se deja como ejemplo
	--SELECT @FechaHasta = CAST(CAST(YEAR(GETDATE())+2 AS CHAR(4)) + '1231' AS smalldatetime)

    --Inicio de BUCLE para insertar registros en la tabla Dim_Fechas
    WHILE (@FechaEvaluada <= @FechaHasta) --Mientras @FechaEvaluada sea menor o igual a la @FechaHasta
	   BEGIN
            --Obtiene el valor para el campo SK_FECHA en formato número YYYYMMDD de la @FechaEvaluada
			SELECT @Sk_Fecha = YEAR(@FechaEvaluada)*10000 + MONTH(@FechaEvaluada)*100 + DATEPART(dd, @FechaEvaluada)
            --Obtiene el año de la @FechaEvaluada
			SELECT @Anio = DATEPART(yy, @FechaEvaluada)
			--Obtiene la descripción del semestre de la @FechaEvaluada
			SELECT @Semestre = CASE
							     WHEN Month(@FechaEvaluada) <= 6 THEN 'Semestre 1' 
								 ELSE 'Semestre 2'
							   END
             --Obtiene la descripción del trimestre de la @FechaEvaluada
			SELECT @Trimestre = CASE
							     WHEN Month(@FechaEvaluada) <= 3 THEN 'Trimestre 1' 
								 WHEN Month(@FechaEvaluada) <= 6 THEN 'Trimestre 2'
								 WHEN Month(@FechaEvaluada) <= 9 THEN 'Trimestre 3'
								 ELSE 'Trimestre 4'
							   END
			 --Obtiene la descripción del mes de la @FechaEvaluada
			SELECT @Mes = CASE
								WHEN Month(@FechaEvaluada) = 1 THEN 'Enero' 
								WHEN Month(@FechaEvaluada) = 2 THEN 'Febrero'
								WHEN Month(@FechaEvaluada) = 3 THEN 'Marzo'
								WHEN Month(@FechaEvaluada) = 4 THEN 'Abril'
								WHEN Month(@FechaEvaluada) = 5 THEN 'Mayo' 
								WHEN Month(@FechaEvaluada) = 6 THEN 'Junio'
								WHEN Month(@FechaEvaluada) = 7 THEN 'Julio'
								WHEN Month(@FechaEvaluada) = 8 THEN 'Agosto'
								WHEN Month(@FechaEvaluada) = 9 THEN 'Setiembre' 
								WHEN Month(@FechaEvaluada) = 10 THEN 'Octubre'
								WHEN Month(@FechaEvaluada) = 11 THEN 'Noviembre'
								WHEN Month(@FechaEvaluada) = 12 THEN 'Diciembre'
						  END

			 --Obtiene la descripción del día de la semana de la @FechaEvaluada
			SELECT @DiaSemana = CASE
									WHEN DATEPART(dw, @FechaEvaluada) = 1 THEN 'Lunes'
									WHEN DATEPART(dw, @FechaEvaluada) = 2 THEN 'Martes'
									WHEN DATEPART(dw, @FechaEvaluada) = 3 THEN 'Miércoles'
									WHEN DATEPART(dw, @FechaEvaluada) = 4 THEN 'Jueves'
									WHEN DATEPART(dw, @FechaEvaluada) = 5 THEN 'Viernes'
									WHEN DATEPART(dw, @FechaEvaluada) = 6 THEN 'Sábado'
									WHEN DATEPART(dw, @FechaEvaluada) = 7 THEN 'Domingo' 									
								END
 
			--Obtiene la posición del semestre en el año de la @FechaEvaluada
			SELECT @NumSemestreAnio = CASE
										 WHEN Month(@FechaEvaluada) <= 6 THEN 1
										 ELSE 2
									   END

			--Obtiene la posición del trimestre en el año de la @FechaEvaluada
			SELECT @NumTrimestreAnio = CASE
										 WHEN Month(@FechaEvaluada) <= 3 THEN 1
										 WHEN Month(@FechaEvaluada) <= 6 THEN 2
										 WHEN Month(@FechaEvaluada) <= 9 THEN 3
										 ELSE 4
									   END

			--Obtiene la posición del mes en el año de la @FechaEvaluada
			SELECT @NumMesAnio = Month(@FechaEvaluada)

			--Obtiene la posición del día de la semana de la @FechaEvaluada
			SELECT @NumDiaSemana = DATEPART(dw, @FechaEvaluada)

			--Obtiene la posición del día del mes de la @FechaEvaluada
			SELECT @NumDiaMes = DAY(@FechaEvaluada)

			--Inserta el registro con los valores extraídos de la @FechaEvaluada en la tabla Dim_Fechas
	
			INSERT INTO Dim_Fechas
			(	Sk_Fecha,Fecha,Anio,Semestre,Trimestre,Mes,DiaSemana,
			    NumSemestreAnio,NumTrimestreAnio,NumMesAnio,NumDiaSemana,NumDiaMes )
			VALUES
			(   @Sk_Fecha,@FechaEvaluada,@Anio,@Semestre,@Trimestre,@Mes,@DiaSemana,
			    @NumSemestreAnio,@NumTrimestreAnio,@NumMesAnio,@NumDiaSemana,@NumDiaMes )
				
   
			--Incremento el valor de la @FechaEvaluada en un día
			SELECT @FechaEvaluada = DATEADD(DAY, 1, @FechaEvaluada)
    END
    COMMIT TRANSACTION