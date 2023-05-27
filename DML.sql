-------------------------DML part----------------------

--Displaying table data using select command
select *from student where age=20;

select student_id from attendance where status='absent';

--Updatting the data in a table
update student set first_name='hassan' where student_id=2;

--deleting row from a table
delete from student where student_id=8;

--union,intersect and except
select department_name from department where department_name like 'E%' union select department_name from department where department_name like '%C%';

--with clause
with max_student(val) as (select max(no_of_students) from department)
select * from department,max_student where department.no_of_students=max_student.val;

--aggregate function

--count how many row exist in department table
select count(*) from department;

-- give alias name to any output in select command.
select count(department_name) as number_of_department from department;

--count average in department table.
select avg(no_of_students) from department;

--count total no of students in department table.
select sum(no_of_students) from department;

--find maximun no. of students of any department from department.
select max(no_of_students) from department;

--find minimun no. of students of any department from department.
select min(no_of_students) from department;

-- group by having
select faculty,avg(no_of_students) from department group by faculty;

select faculty,avg(no_of_students) from department group by faculty having avg(no_of_students)>60;

---Nested subquery

SELECT first_name
FROM student
WHERE student_id = (
    SELECT student_id
    FROM attendance
    WHERE status = 'absent' AND date_ = TO_DATE('05/23/2023', 'MM/DD/YYYY') AND course_no = 'CSE3100'
);

--set Membership(AND,OR,NOT)

select *from department where faculty='EEE' and department_id in (select department_id from course where course_no like '%CSE%');

--some/all/exists/unique

select *from department where no_of_students >some (select no_of_students from department where no_of_students>=60);
select *from department where no_of_students > all (select no_of_students from department where no_of_students>=60);

select *from course where department_id <=5 
and exists (select *from department where faculty like '%EEE%');

--string Operation

select *from department where faculty like 'E%';

select *from department where faculty like '%E';

--join Operation

select *from department natural join course where department_id=1;
select department_name,course_name from department join course on  department.department_id=course.department_id;

--Views
create view CSE_DEPT_COURSE as select course_name from course where
department_id=(select department_id from department where department_name='CSE');













