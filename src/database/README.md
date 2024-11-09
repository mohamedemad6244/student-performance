# SQL Analysis Queries

**1st Query:** Retrieve All Student Information

**Question**: What are the details of all the students in the dataset?

```sql
SELECT Student_Name, Student_Age, Student_Year, Father_Degree, Mother_Degree, Education_Type,

Subject_1, Subject_2, Subject_3, Subject_4, Subject_5,

Subject_6, Subject_7, Subject_8, Subject_9, Subject_10

FROM Egyptian_Students;
```

**Description**: This query provides all available student information across all attributes, offering a complete view of the dataset.  
**Logic**: It selects all columns from the dataset to show each student’s details.

---

**2nd Query:** Retrieve the average grade for Subject_1

**Question**: What is the average grade of all students in Subject_1?

```sql
SELECT AVG(Subject_1) as avg_subject_1_grade

FROM Egyptian_Students;
```

**Description**: This query returns the average grade for Subject_1 to assess the overall student performance in this subject.  
**Logic**: It calculates the average grade in Subject_1 using the AVG() function.

---

**3rd Query: List students with parents having higher education degrees**

**Question**: Which students have both parents with at least a Bachelor’s degree?

```sql
SELECT Student_Name, Father_Degree, Mother_Degree

FROM Egyptian_Students

WHERE Father_Degree IN ('Bachelor', 'Master', 'PhD')

AND Mother_Degree IN ('Bachelor', 'Master', 'PhD');
```

**Description**: This query lists students whose parents both have a higher education degree (Bachelor's or above).  
**Logic**: It filters for students where both the father and mother have a degree of at least Bachelor.

---

**4th Query:** Identify students in the IGCSE program

**Question**: Which students are enrolled in the IGCSE education type?

```sql
SELECT Student_Name, Education_Type

FROM Egyptian_Students

WHERE Education_Type = 'IGCSE';
```

**Description**: This query retrieves the names of students participating in the IGCSE program.  
**Logic**: It filters students by their Education_Type being "IGCSE."

---

**5th Query:** Count students by education type

**Question**: How many students are enrolled in each type of education?

```sql
SELECT Education_Type, COUNT(*) as student_count

FROM Egyptian_Students

GROUP BY Education_Type;
```

**Description**: This query provides the number of students enrolled in each education type, helping identify which programs are the most popular.  
**Logic**: It groups the students by Education_Type and counts the entries in each group.

---

**6th Query:** Determine the most common parental education levels

**Question**: What are the most common education levels of students' parents?

```sql
SELECT Father_Degree, Mother_Degree, COUNT(*) as count

FROM Egyptian_Students

GROUP BY Father_Degree, Mother_Degree

ORDER BY count DESC;
```

**Description**: This query identifies the most common education levels of the parents in the dataset.  
**Logic**: It groups students by both Father_Degree and Mother_Degree and counts how often each combination occurs.

---

**7th Query:** List students with grades above 90% in Subject_5

**Question**: Which students scored higher than 90% in Subject_5?

```sql
SELECT Student_Name, Subject_5

FROM Egyptian_Students

WHERE Subject_5 > 90;
```

**Description**: This query returns the names and grades of students who achieved more than 90% in Subject_5.  
**Logic**: It filters students whose grades in Subject_5 exceed 90.

---

**8th Query:** Calculate average grades by education type

**Question**: What are the average grades for students in each education type?

```sql
SELECT Education_Type, AVG(Subject_1) as avg_subject_1, AVG(Subject_2) as avg_subject_2,

AVG(Subject_3) as avg_subject_3, AVG(Subject_4) as avg_subject_4,

AVG(Subject_5) as avg_subject_5, AVG(Subject_6) as avg_subject_6,

AVG(Subject_7) as avg_subject_7, AVG(Subject_8) as avg_subject_8,

AVG(Subject_9) as avg_subject_9, AVG(Subject_10) as avg_subject_10

FROM Egyptian_Students

GROUP BY Education_Type;
```

**Description**: This query calculates the average grades for each subject across different education types (IGCSE, IB, Thanweya).  
**Logic**: It groups students by Education_Type and uses the AVG() function to compute the average grade for each subject.

---

**9th Query:** Find percentage of students with grades above 80% in all subjects

**Question**: What percentage of students scored more than 80% in all subjects?

```sql
SELECT (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Egyptian_Students)) AS percentage

FROM Egyptian_Students

WHERE Subject_1 > 80 AND Subject_2 > 80 AND Subject_3 > 80 AND Subject_4 > 80

AND Subject_5 > 80 AND Subject_6 > 80 AND Subject_7 > 80 AND Subject_8 > 80

AND Subject_9 > 80 AND Subject_10 > 80;
```

**Description**: This query calculates the percentage of students with grades above 80% in all subjects.  
**Logic**: It counts students with grades over 80% in all 10 subjects and divides by the total number of students to calculate the percentage.

---

**10th Query:** Count students by parental education and education type

**Question**: How many students are enrolled in each education type based on their parents' education levels?

```sql
SELECT Father_Degree, Mother_Degree, Education_Type, COUNT(*) as student_count

FROM Egyptian_Students

GROUP BY Father_Degree, Mother_Degree, Education_Type;
```

**Description**: This query counts the number of students grouped by parental education levels and education type.  
**Logic**: It groups students by Father_Degree, Mother_Degree, and Education_Type, and counts the occurrences.

---

**11th Query:** List students with grades below 50% in more than 3 subjects

**Question**: Which students have scored below 50% in more than three subjects?

```sql
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
```

**Description**: This query identifies students who have underperformed in more than three subjects with scores below 50%.  
**Logic**: It counts how many subjects each student scored below 50% and filters those with more than three low scores.

---

**12th Query:** Count students with at least one parent having a Master’s or PhD degree

**Question**: How many students have at least one parent with a Master’s or PhD degree?

```sql
SELECT COUNT(*) as student_count

FROM Egyptian_Students

WHERE Father_Degree IN ('Master', 'PhD')

OR Mother_Degree IN ('Master', 'PhD');
```

**Description**: This query provides the number of students who have at least one parent with an advanced degree (Master's or PhD).  
**Logic**: It counts students where either the father or mother has an education level of Master’s or PhD.

---

**13th Query:** List students with grades over 80% in all subjects

**Question**: Which students scored more than 80% in all subjects?

```sql
SELECT Student_Name, Subject_1, Subject_2, Subject_3, Subject_4, Subject_5,

Subject_6, Subject_7, Subject_8, Subject_9, Subject_10

FROM Egyptian_Students

WHERE Subject_1 > 80 AND Subject_2 > 80 AND Subject_3 > 80 AND Subject_4 > 80

AND Subject_5 > 80 AND Subject_6 > 80 AND Subject_7 > 80 AND Subject_8 > 80

AND Subject_9 > 80 AND Subject_10 > 80;
```

**Description**: This query lists students who have excelled with scores above 80% in every subject.  
**Logic**: It filters students by their grades, requiring that all subject scores be greater than 80%.

---

**14th Query:** Count students by their age group

**Question**: How many students are there in each age group (14-18 years old)?

```sql
SELECT Student_Age, COUNT(*) as student_count

FROM Egyptian_Students

GROUP BY Student_Age;
```

**Description**: This query counts the number of students in each age group, helping to analyze the distribution of ages in the dataset.  
**Logic**: It groups students by their age and counts how many students fall into each group.

---

**15th Query:** Calculate the average grades of students by parental education

**Question**: What are the average grades of students based on their parental education levels?

```sql
SELECT Father_Degree, Mother_Degree,

AVG(Subject_1) as avg_subject_1, AVG(Subject_2) as avg_subject_2,

AVG(Subject_3) as avg_subject_3, AVG(Subject_4) as avg_subject_4,

AVG(Subject_5) as avg_subject_5, AVG(Subject_6) as avg_subject_6,

AVG(Subject_7) as avg_subject_7, AVG(Subject_8) as avg_subject_8,

AVG(Subject_9) as avg_subject_9, AVG(Subject_10) as avg_subject_10

FROM Egyptian_Students

GROUP BY Father_Degree, Mother_Degree;
```

**Description**: This query calculates the average grades in all subjects for students based on the education levels of their parents.  
**Logic**: It groups students by Father_Degree and Mother_Degree, then uses the AVG() function to calculate average grades.