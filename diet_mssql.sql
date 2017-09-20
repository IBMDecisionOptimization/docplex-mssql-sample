--
-- Create databse
--

-- Comment the following lines if you already have a database for testing
USE master;
IF EXISTS(SELECT * from sys.databases where name='diet_sample_db')
DROP DATABASE diet_sample_db
CREATE DATABASE diet_sample_db
GO
-- If you have a database for testing, please edit the following line:
USE diet_sample_db;

-- Delete table if it exists
BEGIN TRY
	DROP TABLE diet_food;
END TRY
BEGIN CATCH
END CATCH
-- Create table to insert data
CREATE TABLE diet_food (
	name	VARCHAR(30) NOT NULL,
	unit_cost	FLOAT,
	qmin	FLOAT,
	qmax	FLOAT)
-- Bulk insert data from csv, skipping the first row (considered as header)
INSERT INTO diet_food
VALUES
	('Frozen Broccoli',0.16,0,10),
	('Carrots Raw',0.07,0,10),
	('Celery Raw',0.04,0,10), 
    ('Frozen Corn',0.18,0,10),
    ('Lettuce IcebergRaw',0.02,0,10),
    ('Peppers Sweet Raw',0.53,0,10),
    ('Potatoes Baked',0.06,0,10), 
    ('Tofu',0.31,0,10),
    ('Spaghetti W/ Sauce',0.78,0,10),
    ('TomatoRedRipeRaw',0.27,0,10),
    ('Apple Raw w/Skin',0.24,0,10),
    ('Banana',0.15,0,10), 
    ('Grapes',0.32,0,10),
    ('Kiwifruit Raw Fresh',0.49,0,10),
    ('Oranges',0.15,0,10),
    ('Bagels',0.16,0,10),
    ('Wheat Bread',0.05,0,10),
    ('White Bread',0.06,0,10),
    ('Oatmeal Cookies',0.09,0,10),
    ('Apple Pie',0.16,0,10),
    ('Chocolate Chip Cookies',0.03,0,10),
    ('Cap''N Crunch',0.31,0,10),
    ('Cheerios',0.28,0,10),
    ('Corn Flakes Kellogg''S',0.28,0,10),
    ('Raisin Bran Kellogg''S',0.34,0,10),
    ('Rice Krispies',0.32,0,10),
    ('Special K',0.38,0,10),
    ('Oatmeal',0.82,0,10), 
    ('Malt-O-Meal Choc',0.52,0,10),
    ('Couscous',0.39,0,10),
    ('White Rice',0.08,0,10),
    ('Macaroni cooked',0.17,0,10),
    ('Peanut Butter',0.07,0,10), 
    ('Popcorn Air-Popped',0.04,0,10),
    ('Pretzels',0.12,0,10),
    ('Tortilla Chips',0.19,0,10),
    ('Tomato Soup',0.39,0,10);
GO



-- Delete table if it exists
BEGIN TRY
	DROP TABLE diet_nutrients;
END TRY
BEGIN CATCH
END CATCH
-- Create table to insert data
CREATE TABLE diet_nutrients (
	name	VARCHAR(30) NOT NULL,
	qmin	FLOAT,
	qmax	FLOAT)
-- Bulk insert data from csv, skipping the first row (considered as header)
INSERT INTO diet_nutrients
VALUES
	('Calories',2000,2250),
	('Cholesterol',0,300),
	('Total_Fat',0,65),
	('Sodium',0,2400),
	('Carbohydrates',0,300),
	('Dietary_Fiber',25,100),
	('Protein',50,100),
	('Vit_A',5000,50000),
	('Vit_C',50,20000),
	('Calcium',800,1600),
	('Iron',10,30);
GO

	
-- Delete table if it exists
BEGIN TRY
	DROP TABLE diet_food_nutrients;
END TRY
BEGIN CATCH
END CATCH
-- Create table to insert data
CREATE TABLE diet_food_nutrients (
	name	VARCHAR(30) NOT NULL,
	Calories	FLOAT,
	Cholesterol	FLOAT,
	Total_Fat	FLOAT,
	Sodium	FLOAT,
	Carbohydrates	FLOAT,
	Dietary_Fiber	FLOAT,
	Protein	FLOAT,
	Vit_A	FLOAT,
	Vit_C	FLOAT,
	Calcium	FLOAT,
	Iron	FLOAT)
-- Bulk insert data from csv, skipping the first row (considered as header)
INSERT INTO diet_food_nutrients
VALUES
    ('Frozen Broccoli',73.8,0,0.8,68.2,13.6,8.5,8,5867.4,160.2,159,2.3),
    ('Carrots Raw',23.7,0,0.1,19.2,5.6,1.6,0.6,15471,5.1,14.9,0.3),
    ('Celery Raw',6.4,0,0.1,34.8,1.5,0.7,0.3,53.6,2.8,16,0.2),
    ('Frozen Corn',72.2,0,0.6,2.5,17.1,2,2.5,106.6,5.2,3.3,0.3),
    ('Lettuce IcebergRaw',2.6,0,0,1.8,0.4,0.3,0.2,66,0.8,3.8,0.1),
    ('Peppers Sweet Raw',20,0,0.1,1.5,4.8,1.3,0.7,467.7,66.1,6.7,0.3),
    ('Potatoes Baked',171.5,0,0.2,15.2,39.9,3.2,3.7,0,15.6,22.7,4.3),
    ('Tofu',88.2,0,5.5,8.1,2.2,1.4,9.4,98.6,0.1,121.8,6.2),
    ('Spaghetti W/ Sauce',358.2,0,12.3,1237.1,58.3,11.6,8.2,3055.2,27.9,80.2,2.3),
    ('TomatoRedRipeRaw',25.8,0,0.4,11.1,5.7,1.4,1,766.3,23.5,6.2,0.6),
    ('Apple Raw w/Skin',81.4,0,0.5,0,21,3.7,0.3,73.1,7.9,9.7,0.2),
    ('Banana',104.9,0,0.5,1.1,26.7,2.7,1.2,92.3,10.4,6.8,0.4),
    ('Grapes',15.1,0,0.1,0.5,4.1,0.2,0.2,24,1,3.4,0.1),
    ('Kiwifruit Raw Fresh',46.4,0,0.3,3.8,11.3,2.6,0.8,133,74.5,19.8,0.3),
    ('Oranges',61.6,0,0.2,0,15.4,3.1,1.2,268.6,69.7,52.4,0.1),
    ('Bagels',78,0,0.5,151.4,15.1,0.6,3,0,0,21,1),
    ('Wheat Bread',65,0,1,134.5,12.4,1.3,2.2,0,0,10.8,0.7),
    ('White Bread',65,0,1,132.5,11.8,1.1,2.3,0,0,26.2,0.8),
    ('Oatmeal Cookies',81,0,3.3,68.9,12.4,0.6,1.1,2.9,0.1,6.7,0.5),
    ('Apple Pie',67.2,0,3.1,75.4,9.6,0.5,0.5,35.2,0.9,3.1,0.1),
    ('Chocolate Chip Cookies',78.1,5.1,4.5,57.8,9.3,0,0.9,101.8,0,6.2,0.4),
    ('Cap''N Crunch',119.6,0,2.6,213.3,23,0.5,1.4,40.6,0,4.8,7.5),
    ('Cheerios',111,0,1.8,307.6,19.6,2,4.3,1252.2,15.1,48.6,4.5),
    ('Corn Flakes Kellogg''S',110.5,0,0.1,290.5,24.5,0.7,2.3,1252.2,15.1,0.9,1.8),
    ('Raisin Bran Kellogg''S',115.1,0,0.7,204.4,27.9,4,4,1250.2,0,12.9,16.8),
    ('Rice Krispies',112.2,0,0.2,340.8,24.8,0.4,1.9,1252.2,15.1,4,1.8),
    ('Special K',110.8,0,0.1,265.5,21.3,0.7,5.6,1252.2,15.1,8.2,4.5),
    ('Oatmeal',145.1,0,2.3,2.3,25.3,4,6.1,37.4,0,18.7,1.6),
    ('Malt-O-Meal Choc',607.2,0,1.5,16.5,128.2,0,17.3,0,0,23.1,47.2),
    ('Couscous',100.8,0,0.1,4.5,20.9,1.3,3.4,0,0,7.2,0.3),
    ('White Rice',102.7,0,0.2,0.8,22.3,0.3,2.1,0,0,7.9,0),
    ('Macaroni cooked',98.7,0,0.5,0.7,19.8,0.9,3.3,0,0,4.9,1),
    ('Peanut Butter',188.5,0,16,155.5,6.9,2.1,7.7,0,0,13.1,0.6),
    ('Popcorn Air-Popped',108.3,0,1.2,1.1,22.1,4.3,3.4,55.6,0,2.8,0.8),
    ('Pretzels',108,0,1,486.2,22.5,0.9,2.6,0,0,10.2,1.2),
    ('Tortilla Chips',142,0,7.4,149.7,17.8,1.8,2,55.6,0,43.7,0.4),
    ('Tomato Soup',170.7,0,3.8,1744.4,33.2,1,4.1,1393,133,27.6,3.5);
GO

--
-- Create tables for results
--
-- Delete table if it exists
BEGIN TRY
	DROP TABLE results_kpi;
END TRY
BEGIN CATCH
END CATCH
-- Create table to insert data
CREATE TABLE results_kpi (
	name	VARCHAR(30),
	quantity	FLOAT)

	
-- Delete table if it exists
BEGIN TRY
	DROP TABLE results_var;
END TRY
BEGIN CATCH
END CATCH
-- Create table to insert data
CREATE TABLE results_var (
	name	VARCHAR(30),
	quantity	FLOAT)