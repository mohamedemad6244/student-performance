Improved_SQL_Queries 
 -- This query retrieves details of all students in the dataset..
SELECT DISTINCT Student_Name, Student_Age, Student_Year, Father_Degree, Mother_Degree, Education_Type, 
       Subject_1, Subject_2, Subject_3, Subject_4, Subject_5, 
       Subject_6, Subject_7, Subject_8, Subject_9, Subject_10
FROM Egyptian_Students;

-- This query calculates the average grade of all students in Subject_1.
SELECT AVG(Subject_1) AS avg_subject_1_grade 
FROM Egyptian_Students;

-- .This query lists students whose parents both have at least a Bachelors degree.
SELECT Student_Name, Father_Degree, Mother_Degree
FROM Egyptian_Students
WHERE (Father_Degree IN ('Bachelor', 'Master', 'PhD')) 
  AND (Mother_Degree IN ('Bachelor', 'Master', 'PhD'));

-- . This query retrieves names of students enrolled in the IGCSE education type.
SELECT DISTINCT Student_Name, Education_Type
FROM Egyptian_Students
WHERE Education_Type = 'IGCSE';

-- . This query counts the number of students enrolled in each type of education.
SELECT Education_Type, COUNT(*) AS student_count
FROM Egyptian_Students
GROUP BY Education_Type;

-- . - This query identifies the most common education levels of students' parents
SELECT Father_Degree, Mother_Degree, COUNT(*) AS count
FROM Egyptian_Students
GROUP BY Father_Degree, Mother_Degree
ORDER BY count DESC;

-- .This query returns names of students who scored higher than 90% in Subject_5.
SELECT Student_Name, Subject_5
FROM Egyptian_Students
WHERE Subject_5 > 90;

-- . This query calculates the average grades for each subject across different education types.
SELECT Education_Type, AVG(Subject_1) AS avg_subject_1, AVG(Subject_2) AS avg_subject_2,
       AVG(Subject_3) AS avg_subject_3, AVG(Subject_4) AS avg_subject_4,
       AVG(Subject_5) AS avg_subject_5, AVG(Subject_6) AS avg_subject_6,
       AVG(Subject_7) AS avg_subject_7, AVG(Subject_8) AS avg_subject_8,
       AVG(Subject_9) AS avg_subject_9, AVG(Subject_10) AS avg_subject_10
FROM Egyptian_Students
GROUP BY Education_Type;

-- This query calculates the percentage of students who scored more than 80% in all subjects.
SELECT (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Egyptian_Students)) AS percentage
FROM Egyptian_Students
WHERE Subject_1 > 80 AND Subject_2 > 80 AND Subject_3 > 80 AND Subject_4 > 80 
  AND Subject_5 > 80 AND Subject_6 > 80 AND Subject_7 > 80 AND Subject_8 > 80 
  AND Subject_9 > 80 AND Subject_10 > 80;


-- This query counts students grouped by parental education levels and education type.
SELECT Father_Degree, Mother_Degree, Education_Type, COUNT(*) as student_count
FROM Egyptian_Students
GROUP BY Father_Degree, Mother_Degree, Education_Type;


-- This query identifies students who scored below 50% in more than three subjects.
SELECT Student_Name
FROM (
    SELECT Student_Name, 
           (CASE WHEN Subject_1 < 50 THEN 1 ELSE 0 END + 
            CASE WHEN Subject_2 < 50 THEN 1 ELSE 0 END + 
            CASE WHEN Subject_3 < 50 THEN 1 ELSE 0 END + 
            CASE WHEN Subject_4 < 50 THEN 1 ELSE 0 END + 
            CASE WHEN Subject_5 < 50 THEN 1 ELSE 0 END + 
            CASE WHEN Subject_6 < 50 THEN 1 ELSE 0 END + 
            CASE WHEN Subject_7 < 50 THEN 1 ELSE 0 END + 
            CASE WHEN Subject_8 < 50 THEN 1 ELSE 0 END + 
            CASE WHEN Subject_9 < 50 THEN 1 ELSE 0 END + 
            CASE WHEN Subject_10 < 50 THEN 1 ELSE 0 END) AS subjects_below_50
    FROM Egyptian_Students
) AS StudentGrades
WHERE subjects_below_50 > 3;



-- This query counts students who have at least one parent with an advanced degree.
SELECT COUNT(*) as student_count
FROM Egyptian_Students
WHERE Father_Degree IN ('Master', 'PhD') 
   OR Mother_Degree IN ('Master', 'PhD');


SELECT Student_Name, Subject_1, Subject_2, Subject_3, Subject_4, Subject_5, 
       Subject_6, Subject_7, Subject_8, Subject_9, Subject_10
FROM Egyptian_Students
WHERE Subject_1 > 80 AND Subject_2 > 80 AND Subject_3 > 80 AND Subject_4 > 80 
  AND Subject_5 > 80 AND Subject_6 > 80 AND Subject_7 > 80 AND Subject_8 > 80 
  AND Subject_9 > 80 AND Subject_10 > 80;


-- This query counts the number of students in each age group (14-18 years old).
SELECT Student_Age, COUNT(*) as student_count
FROM Egyptian_Students
GROUP BY Student_Age;


-- This query calculates the average grades based on the education levels of parents.
SELECT Father_Degree, Mother_Degree, 
       AVG(Subject_1) as avg_subject_1, AVG(Subject_2) as avg_subject_2,
       AVG(Subject_3) as avg_subject_3, AVG(Subject_4) as avg_subject_4,
       AVG(Subject_5) as avg_subject_5, AVG(Subject_6) as avg_subject_6,
       AVG(Subject_7) as avg_subject_7, AVG(Subject_8) as avg_subject_8,
       AVG(Subject_9) as avg_subject_9, AVG(Subject_10) as avg_subject_10
FROM Egyptian_Students
GROUP BY Father_Degree, Mother_Degree;



