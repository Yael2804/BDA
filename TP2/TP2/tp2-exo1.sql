/*Question 1*/
SELECT dept_name
FROM department
WHERE budget in 
    (SELECT max(budget) 
    FROM department);


/*Question 2*/
SELECT name, salary
FROM teacher
WHERE salary > (
    SELECT avg(salary)
    FROM teacher);


/*Question 3*/
SELECT teacher.name, student.name, count (*)
FROM teacher, student, takes, teaches
WHERE teacher.id = teaches.id and student.id = takes.id 
    and (takes.course_id, takes.sec_id, takes.semester, takes.year) = (teaches.course_id, teaches.sec_id, teaches.semester, teaches.year)
GROUP BY teacher.name, student.name 
HAVING count(*) >= 2;


/*Question 4*/
SELECT T.teachername, T.studentname, T.totalcount
FROM (
    SELECT teacher.name teachername,
           student.name studentname,
           COUNT(*) totalcount
    FROM teacher, student, takes, teaches
    WHERE teacher.id = teaches.id
      AND student.id = takes.id
      AND (takes.course_id, takes.sec_id, takes.semester, takes.year) =
          (teaches.course_id, teaches.sec_id, teaches.semester, teaches.year)
    GROUP BY teacher.name, student.name
) T
WHERE T.totalcount >= 2
ORDER BY T.teachername;


/*Question 5*/
(SELECT student.id, student.name FROM student)
EXCEPT
(SELECT student.id, student.name 
    FROM student, takes
    WHERE takes.id = student.id and takes.year < 2009);


/*Question 6*/
SELECT *
FROM teacher
WHERE UPPER(name) LIKE 'E%';


/*Question 7*/
SELECT name
FROM teacher T1 
WHERE 3 = (
    SELECT COUNT(DISTINCT T2.salary) 
    FROM teacher T2
    WHERE T2.salary > T1.salary
);


/*Question 8*/
SELECT T1.name, T1.salary 
FROM teacher T1
WHERE 2 >= (
    SELECT COUNT(DISTINCT T2.salary) 
    FROM teacher T2
    WHERE T2.salary < T1.salary)
ORDER BY T1.salary ASC;


/*Question 9*/
SELECT S.name
FROM student S
WHERE ('Fall', 2009) IN (
    SELECT semester, year
    FROM takes
    WHERE takes.id = S.id);
    

/*Question 10*/
SELECT S.name
FROM student S
WHERE ('Fall', 2009) = SOME( 
    SELECT semester, year
    FROM takes
    WHERE takes.id = S.id);


/*Question 11*/
SELECT DISTINCT student.name
FROM takes NATURAL INNER JOIN student
WHERE takes.semester = 'Fall' AND takes.year = 2009;


/*Question 12*/
SELECT name
FROM student
WHERE EXISTS ( SELECT *
    FROM takes
    WHERE takes.id = student.id AND semester = 'Fall' AND year = 2009);


/*Question 13*/
SELECT DISTINCT A.name, B.name
FROM student A
JOIN takes TA ON A.id = TA.id
JOIN takes TB ON TA.course_id = TB.course_id AND TA.sec_id = TB.sec_id
    AND TA.semester = TB.semester AND TA.year = TB.year
JOIN student B ON B.id = TB.id
WHERE A.id <> B.id AND A.name < B.name;


/*Question 14*/
SELECT teacher.name, count(*)
FROM (takes INNER JOIN teaches 
    USING (course_id, sec_id, semester, year))
INNER JOIN teacher ON teaches.id = teacher.id
GROUP BY teacher.name, teacher.id 
ORDER BY count(*) DESC;


/*Question 15*/
SELECT teacher.name, count(course_id)
FROM (takes INNER JOIN teaches USING (course_id, sec_id, semester, year))
RIGHT OUTER JOIN teacher ON teaches.id = teacher.id
GROUP BY teacher.name, teacher.id 
ORDER BY count(course_id) DESC;


/*Question 16*/
WITH mytakes (id, course_id, sec_id, semester, year, grade) AS (
    SELECT id, course_id, sec_id, semester, year, grade
    FROM takes
    WHERE grade = 'A'
)
SELECT teacher.name, COUNT(mytakes.course_id) AS total_courses
FROM mytakes
JOIN teaches
  ON mytakes.course_id = teaches.course_id
 AND mytakes.sec_id = teaches.sec_id
 AND mytakes.semester = teaches.semester
 AND mytakes.year = teaches.year
RIGHT OUTER JOIN teacher
  ON teaches.id = teacher.id
GROUP BY teacher.name, teacher.id
ORDER BY total_courses DESC;


/*Question 17*/
SELECT teacher.name, student.name, count(*) 
FROM (teacher NATURAL JOIN teaches)
INNER JOIN (takes NATURAL JOIN student) 
USING (course_id, sec_id, semester, year) 
GROUP BY teacher.name, student.name;


/*Question 18*/
SELECT mytable.tn, mytable.sn
FROM (
    SELECT teacher.name tn, student.name sn, count(*) tc
    FROM (teacher NATURAL JOIN teaches) 
    INNER JOIN (takes NATURAL JOIN student) 
    USING (course_id, sec_id, semester, year)
    GROUP BY teacher.name, student.name) mytable 
WHERE tc >= 2;