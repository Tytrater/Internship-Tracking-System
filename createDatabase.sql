DROP DATABASE `internship_tracking_system`;
CREATE DATABASE  IF NOT EXISTS `internship_tracking_system`;
USE `internship_tracking_system`;
DROP TABLE IF EXISTS `Person`;

CREATE TABLE `Person` (
  `Person_Id` int NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `address` varchar(50) NOT NULL,
  `email` varchar(30) NOT NULL,
  `is_supervisior` tinyint NOT NULL,
  `is_student` tinyint NOT NULL,
  `is_faculty` tinyint NOT NULL,
  `is_deptchair` tinyint NOT NULL,
  PRIMARY KEY (`Person_Id`)
);


CREATE TABLE `Supervisor`(
`Employee_Id` int NOT NULL,
`title` varchar(30),
PRIMARY KEY(`Employee_Id`),
FOREIGN KEY(`Employee_Id`) REFERENCES `Person`(`Person_Id`)
);

CREATE TABLE `Student`(
`Student_Id` int NOT NULL,
`enrollment_date` date NOT NULL,
PRIMARY KEY(`Student_Id`),
FOREIGN KEY(`Student_Id`) REFERENCES `Person`(`Person_Id`)
);

CREATE TABLE `Faculty` (
`Faculty_Id` int NOT NULL,
`tenure` BOOLEAN NOT NULL,
PRIMARY KEY(`Faculty_Id`),
FOREIGN KEY(`Faculty_Id`) REFERENCES `Person`(`Person_Id`)
);

CREATE TABLE `Deptchair`(
`Admin_Id` int NOT NULL,
PRIMARY KEY(`Admin_Id`),
FOREIGN KEY(`Admin_Id`) REFERENCES `Person`(`Person_Id`)
);

CREATE TABLE `Department`(
`Dept_Id` int not null,
`Name` varchar(30) not null,
`admin_id` int not null,
PRIMARY KEY(`Dept_Id`),
FOREIGN KEY(`admin_id`) REFERENCES `Deptchair`(`Admin_Id`)
);

CREATE TABLE `Course`(
`Course_Id` int not null,
`credits` int not null,
`name` varchar(30),
`dept_id` int not null,
PRIMARY KEY(`Course_Id`),
FOREIGN KEY(`dept_id`) references `Department`(`Dept_Id`)
);

CREATE TABLE Section(
`Section_Id` int not null,
`course_id` int not null,
`credits` int not null,
`semester` varchar(30) not null,
`faculty_id` int not null,
PRIMARY KEY(`Section_Id`),
FOREIGN KEY(`course_id`) references `Course`(`Course_Id`),
FOREIGN KEY(`faculty_id`) references `Faculty`(`Faculty_Id`)
);

CREATE TABLE Roster(
`course_id` int not null,
`section_id` int not null,
`student_id` int not null,
FOREIGN KEY(`course_id`) references `Course`(`Course_Id`),
FOREIGN KEY(`section_id`) references `Section`(`Section_Id`),
FOREIGN KEY(`student_id`) references `Student`(`Student_Id`)
);

CREATE TABLE Company(
`Company_Id` int not null,
`name` varchar(30) not null,
PRIMARY KEY(`Company_Id`)
);

CREATE TABLE `Internship`(
`Internship_Id` int not null,
`start_date` date not null,
`end_date` date not null,
`student_id` int not null,
`position` varchar(30) not null,
`passfail` boolean,
`employee_id` int not null,
`section_id` int not null,
`company_id` int not null,

PRIMARY KEY(`Internship_Id`),
FOREIGN KEY(`student_id`) REFERENCES `Student`(`Student_Id`),
FOREIGN KEY(`employee_id`) REFERENCES `Supervisor`(`Employee_Id`),
FOREIGN KEY(`section_id`) REFERENCES `Section`(`section_id`),
FOREIGN KEY(`company_id`) REFERENCES `Company`(`Company_Id`)
);

insert into Person(person_id, first_name, last_name, address, email, is_supervisior, is_student, is_faculty, is_deptChair) values 
(1, "John","Doe","Boulder City","John.doe@gmail.com", False, True, False, False),
(2, "Jane","Smith","Carson City","jane.smith@gmail.com", False, True, False, False), 
(3, "Cristian","Solis","Elko","chris.solace@gmail.com", False, True, False, False), 
(4, "Brice","Dyer","Las Vegas","Byrce.Dyer@gmail.com", False, True, False, False), 
(5, "Karina","Spears","Las Vegas","k.spears@gmail", False, True, False, False), 
(6, "Amiah","Walsh","Las Vegas","A.Walsh@gmail.com", True, False, False, True), 
(7, "Skyla","Little","Reno","SkyLit@gmail.com", True, False, False, True), 
(8, "Zane","Pugh","Reno","zane.pugh@gmail.com", True, False, True, False), 
(9, "Ann","Davies","Long Beach","Ann.Davies@gmail.com", True, False, True, False), 
(10, "Carley","Nolan","Long Beach","CNolan@gmail.com", True, False, True, False);

insert into Supervisor(Title, Employee_Id) values
("Lead", 6),
("Coordinator", 7),
("Supervisor", 8),
("Lead", 9),
("Coordinator", 10);

select * from Person p left join Supervisor s on p.Person_Id = s.Employee_Id;

insert into Student (Enrollment_date, student_id) values
(20210826, 1), 
(20210826, 2),
(20220826, 3),
(20220826, 4),
(20230114, 5);

select * from Person p left join Student s on p.Person_Id=s.Student_id;

insert into Faculty (Tenure, faculty_id) values
(1,8), 
(0,9),
(1,10);

select * from Person p left join Faculty f on p.Person_id=f.Faculty_Id;

insert into Deptchair (admin_id) values (6), (7);

insert into Department (name, admin_id, Dept_Id) values 
("MIS",6, 9), 
("BUSI",7, 10);

insert into Course (name, credits, dept_id, course_id) values 
("DatabaseManagement", 3, 9, 1), 
("ProjectManagement", 3, 10, 2), 
("ManagerialAccounting", 3, 9, 3);


insert into Section (Course_Id, Credits, semester, faculty_id, section_id) values 
(1, 3, "F23", 8, 16), 
(2, 3, "S24", 9, 17), 
(3, 3, "S24", 10, 18);

Insert into Roster (course_ID, section_ID, student_ID) values
(1, 16, 1),
(2, 17, 1),
(3, 18, 1),
(1, 16, 2) ,
(2, 17, 3),
(2, 17, 4),
(3, 18, 5);

insert into Company (Company_ID, name) values
(1,"MGMGrand"),
(2, "CaesarsEntertainment"),
(3, "BoydGaming");



insert into Internship (Internship_Id, start_date, end_date, student_id, position, Company_ID, PassFail, Employee_ID, section_Id) values
(1, 20230827, 20231210, 1, "DatabaseManager", 1, 1, 6, 16),
(2, 20230827, 20231210, 2, "DataEntryClerk", 1, 1, 7, 16),
(3, 20240117, 20241210, 3, "JrAcctManager", 2, 1, 8, 17),
(4, 20240117, 20241210,4, "ProjectManager", 2, 1, 9, 17),
(5,20240117, 20240510,5, "EntryAccountant", 3,1, 10, 18);

