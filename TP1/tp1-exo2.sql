/*Question 1*/
DESC section;

SELECT * FROM section;


/*Question 2*/
SELECT * FROM course ;


/*Question 3*/
SELECT title, dept_name FROM course;


/*Question 4*/
SELECT dept_name, budget FROM department;


/*Question 5*/
SELECT name, dept_name FROM teacher ;


/*Question 6*/
SELECT name
FROM teacher
WHERE salary>65000;


/*Question 7*/
SELECT name
FROM teacher
WHERE salary between 55000 and 85000;


/*Question 8*/
SELECT DISTINCT dept_name FROM teacher;


/*Question 9*/
SELECT name
FROM teacher
WHERE salary>65000 and dept_name='Comp. Sci.';


/*Question 10*/
SELECT *
FROM section
WHERE semester='Spring' and year=2010;


/*Question 11*/
SELECT title
FROM course
WHERE dept_name='Comp. Sci.' and credits>3;


/*Question 12*/
SELECT teacher.name, teacher.dept_name, department.building
FROM teacher, department
WHERE teacher.dept_name = department.dept_name;


/*Question 13*/
SELECT distinct student.name
FROM student, takes, course
WHERE student.id = takes.id and takes.course_id = course.course_id and course.dept_name = 'Comp. Sci.';


/*Question 14*/
SELECT distinct student.name
FROM student, teacher, takes, teaches
WHERE student.id = takes.id and takes.course_id = teaches.course_id and takes.sec_id = teaches.sec_id 
    and takes.semester = teaches.semester and takes.year = teaches.year and teaches.id = teacher.id and teacher.name = 'Einstein';


/*Question 15*/
SELECT name, course_id
FROM teacher, teaches
WHERE teacher.id = teaches.id;


/*Question 16*/
SELECT takes.course_id, takes.sec_id, takes.semester, takes.year, count (*)
FROM takes
WHERE takes.semester = 'Spring' and takes.year = 2010
GROUP BY takes.course_id, takes.sec_id, takes.semester, takes.year;


/*Question 17*/
SELECT dept_name, max(salary) 
FROM teacher
GROUP BY dept_name;


/*Question 18*/
SELECT takes.course_id, takes.sec_id, takes.semester, takes.year, count(*)
FROM takes
GROUP BY takes.course_id, takes.sec_id, takes.semester, takes.year;


/*Question 19*/
SELECT building, count(*)
FROM section
WHERE (semester, year) in (('Fall', 2009), ('Spring', 2010)) 
GROUP BY building;


/*Question 20*/
SELECT department.dept_name, count(*)
FROM section, department, teacher, teaches
WHERE (section.course_id, section.sec_id, section.semester, section.year) = (teaches.course_id, teaches.sec_id, teaches.semester, teaches.year) 
    and teaches.id = teacher.id and teacher.dept_name = department.dept_name and department.building = section.building
GROUP BY department.dept_name;


/*Question 21*/
SELECT course.title, teacher.name
FROM section, teacher, teaches, course
WHERE (section.course_id, section.sec_id, section.semester, section.year) = (teaches.course_id, teaches.sec_id, teaches.semester, teaches.year) 
    and teaches.id = teacher.id and section.course_id = course.course_id
ORDER BY course.title;


/*Question 22*/
SELECT section.semester, count(*) 
FROM section
GROUP BY section.semester;


/*Question 23*/
SELECT student.name, sum(credits)
FROM student, course, takes
WHERE student.id = takes.id and takes.course_id = course.course_id and student.dept_name != course.dept_name 
GROUP BY student.name;


/*Question 24*/
SELECT section.building, sum(course.credits) 
FROM section, course
WHERE section.course_id = course.course_id 
GROUP BY section.building;
