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

#3 The names of all students and their respective supervisors
SELECT i.first_name, i.last_name, sp.Title AS SupervisorTitle
FROM interns i, supervisors sp
WHERE i.employee_id = sp.employee_id;

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
Select DISTINCT first_name, last_name, st.student_id, person_id, s.course_id, s.section_id, credits, semester, faculty_id, passfail
FROM person p, student st, roster r, section s, internship i
WHERE p.Person_Id = st.student_id
AND st.student_id = r.student_id
AND r.section_id = s.section_id
AND s.section_id = i.section_id;


# View- Supervisors
DROP VIEW if exists `supervisors`;
Create view supervisors as
SELECT p.first_name, p.last_name, Su.employee_id, Su.title, i.section_id
FROM Person p, supervisor Su, Internship i
WHERE p.person_id = Su.Employee_ID
AND Su.Employee_ID = i.Employee_ID;

#View- Instructors
DROP VIEW IF EXISTS `instructors`;
CREATE VIEW instructors as
SELECT p.first_name, p.last_name, s.section_id, s.course_id, s.semester
FROM person p, faculty f, section s
WHERE p.person_id = f.faculty_id
AND f.Faculty_Id = s.Faculty_Id;

#7 Select Student with min. credit requirement
Select first_name, last_name, sum(credits) as credits
from interns
group by student_id
having credits > 3;

#8 SELECT Sections by semester and Faculty name
SELECT *
FROM instructors
WHERE first_name = 'Zane'
AND last_name = 'Pugh'
AND semester = 'F23';

#9 Select passfail by supervisor name
SELECT i.first_name, i.last_name, i.passfail
from interns i, supervisors s
where i.section_id = s.section_id
and s.first_name = 'ann'
and s.last_name = 'davies';

#10 Student Schedule
Select section_id
FROM interns
WHERE  first_name = 'John'
AND last_name = 'Doe'
AND Semester = 'F23';
