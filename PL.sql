--variable declaration and print value
set serveroutput on
declare 
department_id department.department_id%type;
department_name department.department_name%type;
no_of_students number;
begin
select department_id,department_name,no_of_students into department_id,department_name,no_of_students from department where department_id=1;
dbms_output.put_line('DEPT_id: '||department_id|| ' DEPT_name: '||department_name || ' no_of_student: '||no_of_students);
end;
/

--Insert and set default value

set serveroutput on
declare 
department_id department.department_id%type:=9;
department_name department.department_name%type:='MME';
faculty department.faculty%type:='ME';
no_of_students number:=30;
begin
insert into department values(department_id,department_name,faculty,no_of_students);
end;
/

--Row type

set serveroutput on
declare 
  dept_row department%rowtype;
begin
  select department_id, department_name, faculty, no_of_students 
  into dept_row.department_id, dept_row.department_name, dept_row.faculty, dept_row.no_of_students 
  from department 
  where department_id = 4;
end;
/

--Cursor and row count
set serveroutput on
declare 
cursor dept_cursor is select * from department;
dept_row department%rowtype;
begin
open dept_cursor;
fetch dept_cursor into dept_row.department_id, dept_row.department_name, dept_row.faculty, dept_row.no_of_students;
while dept_cursor%found loop
dbms_output.put_line('DEPT_id: '||dept_row.department_id|| ' DEPT_name: '||dept_row.department_name || ' faculty: ' ||dept_row.faculty|| ' no_of_student: '||dept_row.no_of_students);
dbms_output.put_line('Row count: '|| dept_cursor%rowcount);
fetch dept_cursor into dept_row.department_id, dept_row.department_name, dept_row.faculty, dept_row.no_of_students;
end loop;
close dept_cursor;
end;
/ 

--loop
set serveroutput on
declare 
  counter1 number;
  last_name2 student.last_name%type;
  TYPE NAMEARRAY IS VARRAY(5) OF student.last_name%type; 
  A_NAME NAMEARRAY:=NAMEARRAY();
begin
  counter1:=1;
  for x in 1..5 
  loop
    select last_name into last_name2 from student where student_id=x;
    A_NAME.EXTEND();
    A_NAME(counter1):=last_name2;
    counter1:=counter1+1;
  end loop;
  counter1:=1;
  WHILE counter1<=A_NAME.COUNT 
    LOOP 
    DBMS_OUTPUT.PUT_LINE(A_NAME(counter1)); 
    counter1:=counter1+1;
  END LOOP;
end;
/

--Array without extend () function

set serveroutput on
declare 
  counter1 number;
  last_name2 student.last_name%type;
  TYPE NAMEARRAY IS VARRAY(5) OF student.last_name%type; 
  A_NAME NAMEARRAY:=NAMEARRAY('name 1', 'name 2', 'name 3', 'name 4', 'name 5'); 
begin
  counter1:=1;
  for x in 1..5 
  loop
    select last_name into last_name2 from student where student_id=x;
    A_NAME(counter1):=last_name2;
    counter1:=counter1+1;
  end loop;
  counter1:=1;
  WHILE counter1<=A_NAME.COUNT 
    LOOP 
    DBMS_OUTPUT.PUT_LINE(A_NAME(counter1)); 
    counter1:=counter1+1;
  END LOOP;
end;
/

--if/else if /else

DECLARE
   counter NUMBER := 1;
   no_of_students department.no_of_students%TYPE;
   CURSOR dept_cursor IS SELECT * FROM department;
   dept_row department%ROWTYPE;
BEGIN
   OPEN dept_cursor;
   LOOP
      FETCH dept_cursor INTO dept_row;
      
      IF dept_cursor%FOUND THEN
         IF dept_row.no_of_students >= 120 THEN
            DBMS_OUTPUT.PUT_LINE(dept_row.department_name || ' is a big department');
         ELSIF dept_row.no_of_students < 120 AND dept_row.no_of_students >= 60 THEN
            DBMS_OUTPUT.PUT_LINE(dept_row.department_name || ' is a small department');
         ELSE
            DBMS_OUTPUT.PUT_LINE(dept_row.department_name || ' is the smallest department');
         END IF;
      END IF;
      
      EXIT WHEN dept_cursor%NOTFOUND;
   END LOOP;
   
   CLOSE dept_cursor;
END;
/

--Procedure

CREATE OR REPLACE PROCEDURE proc2(
  var1 IN NUMBER,
  var2 OUT VARCHAR2,
  var3 IN OUT NUMBER
)
AS
  t_show CHAR(30);
BEGIN
  t_show := 'From procedure: ';
  SELECT first_name into var2
  FROM student
  WHERE student_id IN (
    SELECT student_id
    FROM attendance
    WHERE status = 'absent' AND date_ = TO_DATE('05/23/2023', 'MM/DD/YYYY') AND course_no = 'CSE3100'
    );
  var3 := var1 + 1; 
  DBMS_OUTPUT.PUT_LINE(t_show || var2);
END;
/

set serveroutput on
declare 
attendance_id attendance.attendance_id%type:=12;
course_name course.course_name%type;
extra number;
begin
proc2(attendance_id,course_name,extra);
end;
/

-- function

set serveroutput on
create or replace function fun(var1 in varchar) return varchar AS
value department.department_name%type;
begin
  select department_name into value from department where department_id=var1; 
   return value;
end;
/

set serveroutput on
declare 
value varchar(20);
begin
value:=fun(5);
DBMS_OUTPUT.PUT_LINE(value);
end;
/







