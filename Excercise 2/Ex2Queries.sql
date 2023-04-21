CREATE DATABASE testDB;

-- 1.Write a SQL query to remove the details of an employee whose first name ends in ‘even’
select * from employees

where lower(FIRST_NAME) LIKE '%even';

DELETE FROM EMPLOYEES WHERE lower(FIRST_NAME) LIKE '%even';


-- 2. Write a query in SQL to show the three minimum values of the salary from the table.
SELECT * FROM employees
ORDER BY SALARY  
LIMIT 3;


-- 3. Write a SQL query to remove the employees table from the database
-- drop table employees;


-- 4. Write a SQL query to copy the details of this table into a new table with table name as Employee table and to delete the records in employees table
create table Employee as SELECT * FROM EMPLOYEES;

truncate table employees;

select * from Employees;


-- 5. Write a SQL query to remove the column Age from the table
ALTER table employee 
Add Age INT default(21);

-- ALTER TABLE EMPLOYEE
-- DROP COLUMN AGE;

select * from employee;


-- 6. Obtain the list of employees (their full name, email, hire_year) where they have joined the firm before 2000
select concat(first_name, ' ', last_name) as full_name, email, hire_date from employee
where year(hire_date) < 2000;


-- 7. Fetch the employee_id and job_id of those employees whose start year lies in the range of 1990 and 1999
select employee_id, job_id from employee 
where year(hire_date) between 1990 and 1999;


-- 8. Find the first occurrence of the letter 'A' in each employees Email ID. Return the employee_id, email id and the letter position
select employee_id, email id, charindex('A', email) as letter_pos from employee where letter_pos != 0;


-- 9. Fetch the list of employees(Employee_id, full name, email) whose full name holds characters less than 12
select employee_id, concat_ws('-',first_name, last_name) as full_name, email from employee
where length(full_name) <12;


-- 10. Create a unique string by hyphenating the first name, last name , and email of the employees to obtain a new field named UNQ_ID 
-- Return the employee_id, and their corresponding UNQ_ID
-- select first_name, last_name, email from employee
select employee_id, concat_ws('-',first_name, last_name, email) as UNQ_ID from employee;


-- 11. Write a SQL query to update the size of email column to 30
alter table employee
modify email
varchar(30);


-- 12. Fetch all employees with their first name , email , phone (without extension part) and extension (just the extension)  
-- Info : this mean you need to separate phone into 2 parts 
-- eg: 123.123.1234.12345 => 123.123.1234 and 12345 . first half in phone column and second half in extension column
select first_name, phone_number, split_part(phone_number,'.', -1) as extension, left(phone_number, charindex(extension, phone_number, 1)-2) as phone from employee;


-- 13. Write a SQL query to find the employee with second and third maximum salary.
select * from employee order by salary desc limit 2 offset 1;


-- 14. Fetch all details of top 3 highly paid employees who are in department Shipping and IT
select * from employee,departments where department_name not in ('Shipping', 'IT') order by salary desc limit 3;


-- 15. Display employee id and the positions(jobs) held by that employee (including the current position)
select employee_id, jobs.job_id, job_title from employee,jobs where employee.job_id = jobs.job_id union select employee_id, jobs.job_id, jobs.job_title from jobs, job_history where jobs.job_id = job_history.job_id order by employee_id;


 -- 16. Display Employee first name and date joined as WeekDay, Month Day, Year
select first_name, concat_ws(', ',dayname(hire_date),to_char(hire_date, 'mmmm'),dayofmonth(hire_date)) as date from employee;
SELECT first_name, CONCAT( 
            DECODE(EXTRACT ('dayofweek_iso',hire_date), 1, 'Monday', 2, 'Tuesday', 3, 'Wednesday', 4, 'Thursday', 5, 'Friday', 6, 'Saturday', 7, 'Sunday' ),', ',
            to_char(hire_date, 'mmmm'), ' ',
            CONCAT(DAY(hire_date), 
            CASE 
              WHEN DAY(hire_date) IN (11,12,13) THEN 'th'
              WHEN DAY(hire_date) % 10 = 1 THEN 'st'
              WHEN DAY(hire_date) % 10 = 2 THEN 'nd'
              WHEN DAY(hire_date) % 10 = 3 THEN 'rd'
              ELSE 'th'
            END),', ',
            YEAR(hire_date)
          ) as date
FROM employee;


-- 17.The company holds a new job opening for Data Engineer (DT_ENGG) with a minimum salary of 12,000 and maximum salary of 30,000 .   The job position might be removed based on market trends (so, save the changes) .   
-- - Later, update the maximum salary to 40,000 . 
-- - Save the entries as well.
-- -  Now, revert back the changes to the initial state, where the salary was 30,000
alter session set autocommit = false;
select * from departments;
insert into jobs values('DT_ENGG', 'Data Engineer', 12000, 30000);
commit;
select * from jobs;
update jobs set max_salary=40000 where job_id='DT_ENGG';
rollback;
alter session set autocommit = true;

select * from jobs;

-- 18. Find the average salary of all the employees who got hired after 8th January 1996 but before 1st January 2000 and round the result to 3 decimals
select round(avg(salary),3) as average_salary from employee where hire_date between '08-JAN-1996' and '31-DEC-1999';


-- 19.  Display  Australia, Asia, Antarctica, Europe along with the regions in the region table (Note: Do not insert data into the table)
-- A. Display all the regions
-- B. Display all the unique regions
select region_name from regions union all select 'Australia' union all select 'Australia' union all select 'Asia' union all select 'Antarctica' union all select 'Europe';
select region_name from regions union select 'Australia' union select 'Australia' union select 'Asia' union select 'Antarctica' union select 'Europe';















