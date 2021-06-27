--Leetcode SQL problems

--1. There is a table courses with columns: student and class. Please list out all classes which have more than or equal to 5 students.
SELECT class 
FROM 
(SELECT class, COUNT(DISTINCT student) AS num
 FROM courses
 GROUP BY class) AS temp_table
 WHERE num>= 5
 
--2. Write a SQL query to find all duplicate emails in a table named Person.
select Email from Person
group by Email
having count(Email) > 1;






