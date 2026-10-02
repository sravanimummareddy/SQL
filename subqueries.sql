-- SQL SUBQUERIES
-- Topics:
-- 1. Subquery with WHERE
-- 2. Subquery with AVG()
-- 3. Subquery with MAX()
-- 4. Subquery with MIN()
-- 5. Subquery with IN
-- 6. Subquery with NOT IN
-- 7. Subquery with EXISTS
-- 8. Subquery with GROUP BY
-- 9. Correlated Subquery

-- =====================================================
-- 1. CREATE TABLE
-- =====================================================

CREATE TABLE Students (
    student_id INT,
    name VARCHAR(50),
    department VARCHAR(50),
    marks INT,
    city VARCHAR(50)
);


-- =====================================================
-- 2. INSERT DATA
-- =====================================================

INSERT INTO Students VALUES
(1, 'Sravani', 'CSE', 85, 'Guntur'),
(2, 'Anjali', 'ECE', 78, 'Bapatla'),
(3, 'Priya', 'CSE', 92, 'Guntur'),
(4, 'Sneha', 'IT', 88, 'Vijayawada'),
(5, 'Divya', 'CSE', 75, 'Guntur'),
(6, 'Keerthi', 'ECE', 81, 'Bapatla'),
(7, 'Harika', 'IT', 95, 'Vijayawada'),
(8, 'Pooja', 'CSE', 89, 'Guntur');


-- =====================================================
-- 3. VIEW TABLE
-- =====================================================

SELECT * FROM Students;


-- =====================================================
-- 4. SUBQUERY WITH AVG()
-- =====================================================
-- Find students who scored above the average marks.

SELECT name, marks
FROM Students
WHERE marks > (
    SELECT AVG(marks)
    FROM Students
);


-- =====================================================
-- 5. SUBQUERY WITH MAX()
-- =====================================================
-- Find the student who scored the highest marks.

SELECT name, marks
FROM Students
WHERE marks = (
    SELECT MAX(marks)
    FROM Students
);


-- =====================================================
-- 6. SUBQUERY WITH MIN()
-- =====================================================
-- Find the student who scored the lowest marks.

SELECT name, marks
FROM Students
WHERE marks = (
    SELECT MIN(marks)
    FROM Students
);


-- =====================================================
-- 7. SUBQUERY WITH SUM()
-- =====================================================
-- Find students whose marks are greater than
-- half of the total marks.

SELECT name, marks
FROM Students
WHERE marks > (
    SELECT SUM(marks) / 2
    FROM Students
);


-- =====================================================
-- 8. SUBQUERY WITH COUNT()
-- =====================================================
-- Find students if the total number of students
-- is greater than 5.

SELECT *
FROM Students
WHERE (
    SELECT COUNT(*)
    FROM Students
) > 5;


-- =====================================================
-- 9. SUBQUERY WITH IN
-- =====================================================
-- Find students who belong to departments
-- having an average mark greater than 80.

SELECT name, department, marks
FROM Students
WHERE department IN (
    SELECT department
    FROM Students
    GROUP BY department
    HAVING AVG(marks) > 80
);


-- =====================================================
-- 10. SUBQUERY WITH NOT IN
-- =====================================================
-- Find students who are not from departments
-- having an average mark greater than 80.

SELECT name, department, marks
FROM Students
WHERE department NOT IN (
    SELECT department
    FROM Students
    GROUP BY department
    HAVING AVG(marks) > 80
);


-- =====================================================
-- 11. SUBQUERY WITH DISTINCT
-- =====================================================
-- Find students who belong to cities
-- where students from CSE are present.

SELECT name, city
FROM Students
WHERE city IN (
    SELECT DISTINCT city
    FROM Students
    WHERE department = 'CSE'
);


-- =====================================================
-- 12. SUBQUERY WITH EXISTS
-- =====================================================
-- Check whether at least one CSE student exists.

SELECT name, department
FROM Students AS S
WHERE EXISTS (
    SELECT 1
    FROM Students
    WHERE department = 'CSE'
);


-- =====================================================
-- 13. SUBQUERY WITH NOT EXISTS
-- =====================================================
-- Check whether a condition does not exist.

SELECT name, department
FROM Students AS S
WHERE NOT EXISTS (
    SELECT 1
    FROM Students
    WHERE department = 'AIML'
);


-- =====================================================
-- 14. SUBQUERY WITH ORDER BY
-- =====================================================
-- Find students who scored above average
-- and display them from highest to lowest.

SELECT name, marks
FROM Students
WHERE marks > (
    SELECT AVG(marks)
    FROM Students
)
ORDER BY marks DESC;


-- =====================================================
-- 15. SUBQUERY WITH MULTIPLE CONDITIONS
-- =====================================================
-- Find CSE students whose marks are greater
-- than the average marks of all students.

SELECT name, department, marks
FROM Students
WHERE department = 'CSE'
AND marks > (
    SELECT AVG(marks)
    FROM Students
);


-- =====================================================
-- 16. FIND SECOND HIGHEST MARKS
-- =====================================================

SELECT MAX(marks) AS second_highest_marks
FROM Students
WHERE marks < (
    SELECT MAX(marks)
    FROM Students
);


-- =====================================================
-- 17. FIND STUDENT WITH SECOND HIGHEST MARKS
-- =====================================================

SELECT name, marks
FROM Students
WHERE marks = (
    SELECT MAX(marks)
    FROM Students
    WHERE marks < (
        SELECT MAX(marks)
        FROM Students
    )
);


-- =====================================================
-- 18. CORRELATED SUBQUERY
-- =====================================================
-- Find students whose marks are greater than
-- the average marks of their own department.

SELECT S1.name, S1.department, S1.marks
FROM Students AS S1
WHERE S1.marks > (
    SELECT AVG(S2.marks)
    FROM Students AS S2
    WHERE S2.department = S1.department
);


-- =====================================================
-- 19. REAL-TIME STYLE QUERY
-- =====================================================
-- Find students who scored more than the
-- average marks of CSE students.

SELECT name, department, marks
FROM Students
WHERE marks > (
    SELECT AVG(marks)
    FROM Students
    WHERE department = 'CSE'
);


-- =====================================================
-- 20. REAL-TIME APPLICATION EXAMPLE
-- =====================================================
-- Find students whose marks are greater than
-- the highest marks of ECE students.

SELECT name, department, marks
FROM Students
WHERE marks > (
    SELECT MAX(marks)
    FROM Students
    WHERE department = 'ECE'
);


