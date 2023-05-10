#1 The names of all students who undertook an internship
SELECT p.First_name, p.Last_name
FROM Person p
JOIN Student s ON p.person_id = s.student_id
JOIN Internship i ON s.student_id = i.student_id;


#2 The names of students who passed the internship
SELECT p.first_name, p.last_name
FROM Person p
JOIN Student s ON p.person_id = s.student_id
JOIN Internship i ON s.student_id = i.student_id
WHERE i.PassFail = 1;


#3 The names of all students and their respective positions
SELECT p.First_name, p.Last_name, i.Position
FROM Person p
JOIN Student s ON p.Person_ID = s.Student_ID
JOIN Internship i ON s.Student_ID = i.Student_ID;


#4 The names of students and their respective company names
SELECT p.first_name, p.last_name, c.Name AS CompanyName
FROM Person p
JOIN Student s ON p.person_id = s.student_id
JOIN Internship i ON s.student_id = i.student_id
JOIN Company c ON i.company_id = c.company_id;


#5 The names of the students and their respective internship start date and end date
SELECT p.first_name, p.last_name, i.start_date, i.end_date
FROM Person p
JOIN Student s ON p.person_id = s.student_id
JOIN Internship i ON s.student_id = i.student_id;


#6 The course with the highest number of students
SELECT c.course_id, c.Name, COUNT(r.student_id) AS StudentCount
FROM Course c
JOIN Roster r ON c.course_id = r.course_id
GROUP BY c.course_id, c.Name
HAVING COUNT(r.student_id) = (
    SELECT MAX(StudentCount)
    FROM (
        SELECT COUNT(student_id) AS StudentCount
        FROM Roster
        GROUP BY course_id
    ) AS Counts
);


# View- Interns
DROP VIEW if exists `interns`;
Create view interns as
Select  p.first_name, p.last_name, s.Course_ID, s.Section_ID, s.semester, i.Employee_ID, i.Company_ID, i.PassFail
FROM Person p, Student st, Roster r, Section s, Internship i
WHERE p.person_id = st.Student_ID
AND st.Student_ID = r.Student_ID
AND r.Course_ID = s.Course_ID
AND r.Section_ID = s.Section_ID;


# View- Supervisors
DROP VIEW if exists `supervisors`;
Create view supervisors as
SELECT p.first_name, p.last_name, Su.employee_id, Su.title
FROM Person p, supervisor Su, Internship i
WHERE p.person_id = Su.Employee_ID
AND Su.Employee_ID = i.Employee_ID;


#View- Faculty
DROP VIEW IF EXISTS `instructors`;
CREATE VIEW instructors as
SELECT p.first_name, p.last_name, s.section_id, s.course_id
FROM person p, faculty f, section s
WHERE p.person_id = f.faculty_id
AND f.Faculty_Id = s.Faculty_Id;


#7 Select Student with min. credit requirement
SELECT p.first_name, p.last_name, sum(Credits) as credit_total
FROM person p, student st, roster r, section s
WHERE p.person_id = st.Student_Id 
AND st.Student_Id = r.student_id
AND r.Course_Id = s.Course_Id
GROUP BY first_name, last_name;



SELECT p.First_name, p.Last_name, d.Name AS Department
FROM Person p
JOIN Faculty f ON p.Person_ID = f.Faculty_ID
JOIN Department d ON f.Department_ID = d.Department_ID;




