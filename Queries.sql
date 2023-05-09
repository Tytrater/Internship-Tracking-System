# View- Interns
DROP VIEW if exists `interns`;
Create view interns as
Select  p.first_name, p.last_name, s.Course_ID, s.Section_ID, s.semester, i.Employee_ID, i.Company_ID, i.PassFail
FROM Person p, Student st, Roster r, Section s, Internship i
WHERE p.person_id = st.Student_ID
AND st.Student_ID = r.Student_ID
AND r.Course_ID = s.Course_ID
AND r.Section_ID = s.Section_ID
AND s.Course_ID = i.Course_ID;

# View- Supervisors
DROP VIEW if exists `supervisors`;
Create view supervisors as
SELECT p.first_name, p.last_name, Su.employee_id
FROM Person p, Supervisior Su, Internship i
WHERE p.person_id = Su.Employee_ID
AND Su.Employee_ID = i.Employee_ID;

#SELECT Sections by Facutly _ID
SELECT S.Course_ID, S.Semester
FROM Faculty F, Section S
WHERE F.Faculty_ID = S.Faculty_ID;

# Intern Names by Company
Select first_name, last_name
FROM interns
WHERE Company_ID = 555;

# Intern Names by Supervisor
Select it.first_name, it.last_name
FROM interns it, supervisors sups
WHERE it.Employee_ID = sups.employee_id;

# Student Pass Fail by supervisor
SELECT it.first_name, it.last_name, it.PassFail
FROM interns it, supervisors sups
WHERE it.employee_ID = sups.employee_ID;

#Student Schedule
Select Course_ID
FROM interns
WHERE  first_name = 'John'
AND last_name = 'Doe'
AND Semester = 'Fall 2023';

# Select Student with min. credit requirement
SELECT p.first_name, p.last_name, sum(Credits) as credit_total
FROM person p, student st, roster r, section s
WHERE p.person_id = st.Student_Id 
AND st.Student_Id = r.student_id
AND r.Course_Id = s.Course_Id
GROUP BY first_name, last_name;

