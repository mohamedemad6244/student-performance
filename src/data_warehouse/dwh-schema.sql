-- Dataset
CREATE TABLE Egyptian_Students(
    Student_ID INT PRIMARY KEY,
	Student_Name NCHAR (20) NOT NULL,
	Student_Age INT NULL,
	Student_Year NCHAR (20) NULL,
	Father_Degree NCHAR (20) NULL,
	Mother_Degree NCHAR (20) NULL,
	Education_Type NCHAR (20) NULL,
	Subject_1 FLOAT NULL,
	Subject_2 FLOAT NULL,
	Subject_3 FLOAT NULL,
	Subject_4 FLOAT NULL,
	Subject_5 FLOAT NULL,
	Subject_6 FLOAT NULL,
	Subject_7 FLOAT NULL,
	Subject_8 FLOAT NULL,
	Subject_9 FLOAT NULL,
	Subject_10 FLOAT NULL
);

-- Validate grades: Set grades outside the range [20, 100] to NULL
UPDATE Egyptian_Students
SET Subject_1 = CASE WHEN Subject_1 < 20 OR Subject_1 > 100 THEN NULL ELSE Subject_1 END,
    Subject_2 = CASE WHEN Subject_2 < 20 OR Subject_2 > 100 THEN NULL ELSE Subject_2 END,
    Subject_3 = CASE WHEN Subject_3 < 20 OR Subject_3 > 100 THEN NULL ELSE Subject_3 END,
    Subject_4 = CASE WHEN Subject_4 < 20 OR Subject_4 > 100 THEN NULL ELSE Subject_4 END,
    Subject_5 = CASE WHEN Subject_5 < 20 OR Subject_5 > 100 THEN NULL ELSE Subject_5 END,
    Subject_6 = CASE WHEN Subject_6 < 20 OR Subject_6 > 100 THEN NULL ELSE Subject_6 END,
    Subject_7 = CASE WHEN Subject_7 < 20 OR Subject_7 > 100 THEN NULL ELSE Subject_7 END,
    Subject_8 = CASE WHEN Subject_8 < 20 OR Subject_8 > 100 THEN NULL ELSE Subject_8 END,
    Subject_9 = CASE WHEN Subject_9 < 20 OR Subject_9 > 100 THEN NULL ELSE Subject_9 END,
    Subject_10 = CASE WHEN Subject_10 < 20 OR Subject_10 > 100 THEN NULL ELSE Subject_10 END;


-- Create Dim_Student table
CREATE TABLE dim_student (
    Student_ID INT PRIMARY KEY,
    Student_Name NCHAR (20),
    Student_Age INT,
    Student_Year NCHAR (20)
);



-- Insert unique student records into Dim_Student
INSERT INTO dim_student (Student_ID,Student_Name, Student_Age, Student_Year)
SELECT DISTINCT Student_ID,Student_Name, Student_Age, Student_Year
FROM Egyptian_Students;

-- Create Dim_Education_Type table
CREATE TABLE dim_education_type (
    Education_Type_ID INT IDENTITY(1,1) PRIMARY KEY,
    Education_Type NCHAR (20)
);

-- Insert unique education types into Dim_Education_Type
INSERT INTO dim_education_type (Education_Type)
SELECT DISTINCT Education_Type
FROM Egyptian_Students;




-- Create Dim_Father_Degree table
CREATE TABLE dim_father_degree (
    Father_Degree_ID INT IDENTITY(1,1) PRIMARY KEY,
    Father_Degree NCHAR (20)
);

-- Insert unique father degree records into Dim_Father_Degree
INSERT INTO dim_father_degree (Father_Degree)
SELECT DISTINCT Father_Degree
FROM Egyptian_Students;

-- Create Dim_Mother_Degree table
CREATE TABLE dim_mother_degree (
    Mother_Degree_ID INT IDENTITY(1,1) PRIMARY KEY,
    Mother_Degree NCHAR (20)
);

-- Insert unique mother degree records into Dim_Mother_Degree
INSERT INTO dim_mother_degree (Mother_Degree)
SELECT DISTINCT Mother_Degree
FROM Egyptian_Students;



CREATE TABLE Fact_Students_Performance(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Student_ID INT ,
	Father_Degree_ID INT,
    Mother_Degree_ID INT,
	Education_Type_ID INT,
	Student_Name NCHAR (20) NOT NULL,
	Student_Age INT NULL,
	Student_Year NCHAR (20) NULL,
	Father_Degree NCHAR (20) NULL,
	Mother_Degree NCHAR (20) NULL,
	Education_Type NCHAR (20) NULL,
	Subject_1 FLOAT NULL,
	Subject_2 FLOAT NULL,
	Subject_3 FLOAT NULL,
	Subject_4 FLOAT NULL,
	Subject_5 FLOAT NULL,
	Subject_6 FLOAT NULL,
	Subject_7 FLOAT NULL,
	Subject_8 FLOAT NULL,
	Subject_9 FLOAT NULL,
	Subject_10 FLOAT NULL,
	FOREIGN KEY (Student_ID) REFERENCES dim_student(Student_ID),
    FOREIGN KEY (Education_Type_ID) REFERENCES dim_education_type(Education_Type_ID),
    FOREIGN KEY (Father_Degree_ID) REFERENCES dim_father_degree(Father_Degree_ID),
    FOREIGN KEY (Mother_Degree_ID) REFERENCES dim_mother_degree(Mother_Degree_ID));




INSERT INTO Fact_Students_Performance (
    Student_ID, Father_Degree_ID, Mother_Degree_ID, Education_Type_ID, 
    Student_Name, Student_Age, Student_Year, Father_Degree, 
    Mother_Degree, Education_Type, 
    Subject_1, Subject_2, Subject_3, Subject_4, Subject_5, 
    Subject_6, Subject_7, Subject_8, Subject_9, Subject_10
)
SELECT 
    ds.Student_ID, 
    dfd.Father_Degree_ID, 
    dmd.Mother_Degree_ID, 
    det.Education_Type_ID, 
    ds.Student_Name, 
    ds.Student_Age, 
    ds.Student_Year, 
    dfd.Father_Degree, 
    dmd.Mother_Degree, 
    det.Education_Type, 
    es.Subject_1, 
    es.Subject_2, 
    es.Subject_3, 
    es.Subject_4, 
    es.Subject_5, 
    es.Subject_6, 
    es.Subject_7, 
    es.Subject_8, 
    es.Subject_9, 
    es.Subject_10
FROM Egyptian_Students es
INNER JOIN dbo.dim_student ds ON ds.student_id = es.Student_id
INNER JOIN dim_father_degree dfd ON dfd.Father_Degree = es.Father_Degree
INNER JOIN dim_mother_degree dmd ON dmd.Mother_Degree = es.Mother_Degree
INNER JOIN dim_education_type det ON det.Education_Type = es.Education_Type;
