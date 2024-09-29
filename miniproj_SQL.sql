use 360db;
select * from data2;


# First moment Business Decission #
# mean measuring
	SELECT AVG(Quantity) AS Mean_Quantity
	FROM data2;
	#  mean = 2.237034949267193;  
##The approx mean quantity purchased is 2.237034949267193 units.

	SELECT AVG(Final_Cost) AS mean_Final_Cost
	FROM data2;
#  Final_Cost_mean = 124.66426578353834;
	
	SELECT AVG(Final_Sales) AS mean_Final_Sales
	FROM data2;
#   Final_Cost_Sales = 124.66426578353834;

##The mean for both Final_Cost and Final_Sales is 124.66426578353834, indicating an approximately equal average cost and sales value.

# Median :
			SELECT Quantity AS median_Quantity
			FROM (
			SELECT Quantity, ROW_NUMBER() OVER (ORDER BY Quantity) AS row_num,
			COUNT(*) OVER () AS total_count
			FROM data2
			) AS subquery
			WHERE row_num = (total_count + 1) / 2 OR row_num = (total_count + 2) / 2;
# median_Quantity = 1;
														
			SELECT Final_Cost AS median_Final_Cost
			FROM (
			SELECT Final_Cost, ROW_NUMBER() OVER (ORDER BY Final_Cost) AS row_num,
			COUNT(*) OVER () AS total_count
			FROM data2
			) AS subquery
			WHERE row_num = (total_count + 1) / 2 OR row_num = (total_count + 2) / 2;
# median_Final_Cost = 53.67

			SELECT Final_Sales AS median_Final_Sales
			FROM (
			SELECT Final_Sales, ROW_NUMBER() OVER (ORDER BY Final_Sales) AS row_num,
			COUNT(*) OVER () AS total_count
			FROM data2
			) AS subquery
			WHERE row_num = (total_count + 1) / 2 OR row_num = (total_count + 2) / 2;
# median_Final_Sales = 86.424;

			SELECT RtnMRP AS median_RtnMRP
			FROM (
			SELECT RtnMRP, ROW_NUMBER() OVER (ORDER BY RtnMRP) AS row_num,
			COUNT(*) OVER () AS total_count
			FROM data2
			) AS subquery
			WHERE row_num = (total_count + 1) / 2 OR row_num = (total_count + 2) / 2;
#  median_RtnMRP = 40.1;
#Mode 
			SELECT DrugName AS mode_DrugName
			FROM (
			SELECT DrugName, COUNT(*) AS frequency
			FROM data2
			GROUP BY DrugName
			ORDER BY frequency DESC
			LIMIT 1
			) AS subquery;
            
# Mode type = SODIUM CHLORIDE IVF 100ML  
#The mode for the DrugName is "SODIUM CHLORIDE IVF 100ML," indicating that this drug name occurs most frequently in the dataset

			SELECT SubCat AS mode_SubCat
			FROM (
			SELECT SubCat, COUNT(*) AS frequency
			FROM data2
			GROUP BY SubCat
			ORDER BY frequency DESC
			LIMIT 1
			) AS subquery;
# Mode SubCat = INJECTIONS

			SELECT SubCat1 AS mode_SubCat1
			FROM (
			SELECT SubCat1, COUNT(*) AS frequency
			FROM data2
			GROUP BY SubCat1
			ORDER BY frequency DESC
			LIMIT 1
			) AS subquery;
# mode_SubCat1 = INTRAVENOUS & OTHER STERILE SOLUTIONS
															
                                                            # Second Moment Business Decision/Measures of Dispersion
										
                                        						# Variance
                                                                
SELECT VARIANCE(Quantity) AS Quantity_variance
FROM data2;
# Quantity_variance = 26.379130103626334;    #  mean = 2.237034949267193;  

SELECT VARIANCE(Final_Cost) AS Final_Cost_variance
FROM data2;

#Final_Cost_variance = 216178.8730230874    ##  mean = 124.66426578353834; 

SELECT VARIANCE(Final_sales) AS Final_sales_variance
FROM data2;

#Final_sales_variance = 450646.7490743917;	# mean = 124.66426578353834;

SELECT VARIANCE(RtnMRP) AS RtnMRP_variance
FROM data2;

#RtnMRP_variance = 33276.1052217922 ; 




SELECT STDDEV(Quantity) AS Quantity_stddev
FROM data2;

#Quantity_stddev = 5.136061730901054;

SELECT 
		STDDEV(Final_Cost) AS Final_Cost_stddev,
        STDDEV(Final_Sales) AS Final_Sales_stddev,
        STDDEV(RtnMRP) AS RtnMRP_stddev
       FROM data2;

# Final_Cost_stddev = 464.9503984545958
# Final_Sales_stddev = 671.3022784665576
# RtnMRP_stddev = 182.417392870834
# Tool_stddev = 63.6510
 
 #inference
 #in process temperature,air temperature and torque according to values points are clustered around the mean value of them.
 #for rotational_speed and tool_wear standard deviaton values are high so data is scattered and far from mean 

#Range#

SELECT 
		MAX(Quantity) - MIN(Quantity) AS Quantity_range,
		MAX(Final_Cost) - MIN(Final_Cost) AS Final_Cost_range,
		MAX(Final_Sales) - MIN(Final_Sales) AS Final_Sales_range,
		MAX(RtnMRP) - MIN(RtnMRP) AS RtnMRP_range
		FROM data2;

#inferences

#Quantity_range: 150
#Final_Cost_range: 33,138
#Final_Sales_range: 39,490
#RtnMRP_range: 8,014
#Inferences:
#In the case of air_temperature and Process_temperature, the mean and median values are very close, suggesting that the data is normally distributed and contains no outliers.
#For Rotational_speed, the mean is greater than the median (mean > median), indicating positive skewness, and likely outliers in the data.
#Torque and Tool_wear have mean and median values that are nearly the same, indicating that the data is normally distributed with no outliers                        


# Third and Fourth Moment Business Decision
-- skewness and kurtosis 

SELECT
    (
        SUM(POWER(Quantity - (SELECT AVG(Quantity) FROM data2), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Quantity) FROM  data2), 3))
    ) AS skewness,
	(
        (SUM(POWER(Quantity - (SELECT AVG(Quantity) FROM data2), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Quantity) FROM data2), 4))) - 3
    ) AS kurtosis
FROM data2;

# Skewness_Quantity =11.329761331895137
# Kurtosis_Quantity =179.77965727174112
#Skewness_Quantity = 11.33 (Strong positive skewness, indicating data concentrated on the left with a long right tail)
#Kurtosis_Quantity = 179.78 (Excess kurtosis, indicating heavy tails and a sharp peak, suggesting many outliers and extreme values)


SELECT
    (
        SUM(POWER(Final_Cost - (SELECT AVG(Final_Cost) FROM data2), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Final_Cost) FROM  data2), 3))
    ) AS skewness,
	(
        (SUM(POWER(Final_Cost - (SELECT AVG(Final_Cost) FROM data2), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Final_Cost) FROM data2), 4))) - 3
    ) AS kurtosis
FROM data2;

# Skewness_Final_Cost = 34.52565474605864
# Kurtosis_ Final_Cost = 2025.698223192802

SELECT
    (
        SUM(POWER(Final_Sales - (SELECT AVG(Final_Sales) FROM data2), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Final_Sales) FROM  data2), 3))
    ) AS skewness,
	(
        (SUM(POWER(Final_Sales - (SELECT AVG(Final_Sales) FROM data2), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Final_Sales) FROM data2), 4))) - 3
    ) AS kurtosis
FROM data2;

# Skewness_ Final_Sales = 21.03500742428124
# Kurtosis_ Final_Sales = 949.5966981960341



SELECT
    (
        SUM(POWER(RtnMRP - (SELECT AVG(RtnMRP) FROM data2), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(RtnMRP) FROM  data2), 3))
    ) AS skewness,
	(
        (SUM(POWER(RtnMRP - (SELECT AVG(RtnMRP) FROM data2), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(RtnMRP) FROM data2), 4))) - 3
    ) AS kurtosis
FROM data2;

# Skewness_ RtnMRP = 15.78267888962822
# Kurtosis_RtnMRP =  402.6778682259439
                     
                        