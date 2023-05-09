CREATE TABLE person(
person_id int unique NOT NULL auto_increment,
first_name varchar(30) NOT NULL,
last_name varchar(30) NOT NULL,
email varchar(30) NOT NULL,
is_supervisior tinyint,
is_student tinyint,
is_faculty tinyint,
is_deptChair tinyint
);


insert into person(first_name, last_name, email, is_supervisior, is_student, is_faculty, is_deptChair) values ("John","Doe","John.doe@gmail.com", True, False, False, False);
insert into person(first_name, last_name, email, is_supervisior, is_student, is_faculty, is_deptChair) values ("Jane","Smith","jane.smith@gmail.com", False, True, False, False);
select * from person where is_supervisior = 1;
select * from person;

create table Supervisior(
Employee_Id int references person(person_id),
Title varchar(30)
);

insert into Supervisior(Employee_Id, Title) values(1, "Manager");
select * from person p left join Supervisior s on p.person_id=s.Employee_Id;

create table Student(
Student_Id int references person(person_id),
Enrollment_date date
);

create table Faculty(
Faculty_Id int references person(person_id),
Tenure boolean
);


create table Deptchair(
Admin_Id int references person(person_id)
);

create table Department(
Department_Id int not null unique auto_increment,
Dept_name varchar(30),
Admin_Id int references Deptchair(Admin_Id)
);

create table Course(
Course_Id int not null unique auto_increment,
Credits int,
Course_name varchar(30),
Department_id int references Department(Department_Id)
);

create table Section(
Section_Id int not null unique auto_increment,
Course_Id int references Course(Course_Id),
Credits int,
Semester varchar(30),
Faculty_Id int references Faculty(Faculty_Id)
);


create table Roster(
Course_Id int references Section(Course_Id),
Section_Id int references Section(Section_Id),
Student_Id int references Student(Student_Id)
);

create table Company(
Company_Id int,
Company_name varchar(30)
);
Alter table Company add primary key(Company_Id);

create table Internship(
Internship_Id int unique not null auto_increment,
Start_date Date,
End_date date,
Position varchar(30),
PassFail boolean,
Employee_Id int references Supervisior(Employee_Id),
Course_Id int references Section(Course_Id),
Company_Id int references Company(Company_Id)
);

