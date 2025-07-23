--1.Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table, and make a list of employees and details of their department.

SELECT
EMP_ID,FIRST_NAME,LAST_NAME,GENDER,DEPT
FROM employeeRecord


--2. Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is:  
-- less than two 
-- greater than four  
-- between two and four

SELECT
EMP_ID,FIRST_NAME,LAST_NAME,
GENDER,DEPT, EMP_RATING
FROM employeeRecord
WHERE EMP_RATING < 2 OR 
EMP_RATING > 4 OR 
EMP_RATING BETWEEN 2 AND 4
ORDER BY EMP_RATING ASC


--3. Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department from the employee table and then give the resultant column alias as NAME.


SELECT 
  CONCAT(First_name,' ',LAST_NAME)AS Name
FROM employeeRecord
WHERE DEPT = 'Finance';



--4.Write a query to list only those employees who have someone reporting to them. Also, show the number of reporters (including the President). 

SELECT 
e.EMP_ID,e.FIRST_NAME,e.LAST_NAME,e.ROLE,
COUNT(r.EMP_ID) AS Num_Reporters	
FROM employeeRecord e
JOIN employeeRecord r
ON e.EMP_ID = r.MANAGER_ID
GROUP BY e.EMP_ID, e.FIRST_NAME,e.ROLE, e.LAST_NAME
ORDER BY Num_Reporters DESC

--5. Write a query to list down all the employees from the healthcare and finance departments using union. Take data from the employee record table. 

SELECT 
EMP_ID, FIRST_NAME, 
LAST_NAME, GENDER,DEPT
FROM employeeRecord
WHERE DEPT ='healthcare' 
UNION
SELECT 
EMP_ID, FIRST_NAME, 
LAST_NAME, GENDER,DEPT
FROM employeeRecord
WHERE DEPT ='Finance'

--6.Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. Also, include the respective employee rating along with the max emp rating for the department.

SELECT
EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, EMP_RATING, 
MAX(EMP_RATING) OVER(PARTITION BY DEPT) AS [Avg Dept Rating] 
FROM employeeRecord


--7. Write a query to calculate the minimum and the maximum salary of the employees in each role. Take data from the employee record table.

SELECT 
ROLE, MIN(SALARY) AS [Min Salary], MAX(SALARY) AS [Max Salary]
FROM employeeRecord
GROUP BY ROLE


--8. Write a query to assign ranks to each employee based on their experience. Take data from the employee record table.

SELECT EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, EMP_RATING,
EXP,RANK() OVER(ORDER BY EXP DESC) AS RANK_EXP
FROM employeeRecord

--9. Write a query to create a view that displays employees in various countries whose salary is more than six thousand. Take data from the employee record table. 

SELECT 
EMP_ID, FIRST_NAME, LAST_NAME, COUNTRY, SALARY
FROM employeeRecord
WHERE SALARY > 6000
ORDER BY SALARY


--10. Write a nested query to find employees with experience of more than ten years. Take data from the employee record table. 

SELECT
EMP_ID, FIRST_NAME, LAST_NAME, EXP
FROM employeeRecord
WHERE EXP IN (SELECT EXP
FROM employeeRecord
WHERE EXP > 10)

--11. Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years. Take data from the employee record table.


CREATE PROCEDURE ThreeExpEmployees
AS
BEGIN
    SELECT *
    FROM employeeRecord
    WHERE EXP > 3
	ORDER BY EXP DESC;
END;

EXEC ThreeExpEmployees;


--12.Write a query using stored functions in the project table to check whether the job profile assigned to each employee in the data science team matches the organization’s set standard. 

--The standard being: 
--For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST', 
--For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST', 
--For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST', 
--For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST', 
--For an employee with the experience of 12 to 16 years assign 'MANAGER'.


CREATE FUNCTION dbo.fn_StandardJobProfile (@exp INT)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @profile VARCHAR(50)

    IF @exp <= 2
        SET @profile = 'JUNIOR DATA SCIENTIST'
    ELSE IF @exp > 2 AND @exp <= 5
        SET @profile = 'ASSOCIATE DATA SCIENTIST'
    ELSE IF @exp > 5 AND @exp <= 10
        SET @profile = 'SENIOR DATA SCIENTIST'
    ELSE IF @exp > 10 AND @exp <= 12
        SET @profile = 'LEAD DATA SCIENTIST'
    ELSE IF @exp > 12 AND @exp <= 16
        SET @profile = 'MANAGER'
    ELSE
        SET @profile = 'N/A'

    RETURN @profile
END;


SELECT 
    EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    EXP,
    ROLE AS Current_Profile,
    dbo.fn_StandardJobProfile(EXP) AS Expected_Profile
FROM dataScienceTeam;

--13. Create an index to improve the cost and performance of the query to find the employee whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan.



SELECT *
FROM employeeRecord
WHERE FIRST_NAME = 'Eric';

CREATE NONCLUSTERED INDEX idx_firstname
ON employeeRecord (FIRST_NAME);

DROP INDEX idx_firstname ON employeeRecord;

SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT * 
FROM employeeRecord 
WHERE FIRST_NAME = 'Eric';

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;



--14. Write a query to calculate the bonus for all the employees, based on their ratings and salaries (Use the formula: 5% of salary * employee rating). 


SELECT
EMP_ID,SALARY,EMP_RATING,
(SALARY *5/100)*EMP_RATING AS BONUS
FROM employeeRecord

--15.Write a query to display employee names along with the names of the projects they are assigned to.

SELECT 
e.EMP_ID,e.FIRST_NAME,e.LAST_NAME,p.PROJ_NAME
FROM employeeRecord e
INNER JOIN projectTable p
ON e.PROJ_ID = p.PROJECT_ID;

--16: .List employees,those who are not assigned to any project.

SELECT 
    e.EMP_ID,e.FIRST_NAME,e.LAST_NAME,p.PROJ_NAME
FROM employeeRecord e
LEFT JOIN projectTable p
ON e.PROJ_ID = p.PROJECT_ID
WHERE p.PROJ_NAME IS NULL


--17.List employee names, their project names, and their managers' names.

SELECT 
    e.FIRST_NAME AS Employee,
    p.PROJ_NAME,
    m.FIRST_NAME AS Manager
FROM employeeRecord e
JOIN projectTable p
    ON e.PROJ_ID = p.PROJECT_ID
LEFT JOIN employeeRecord m
    ON e.MANAGER_ID = m.EMP_ID;

--18.Show employees who manage others but also report to another manager.

SELECT DISTINCT m.EMP_ID, m.FIRST_NAME, m.LAST_NAME
FROM employeeRecord e
JOIN employeeRecord m ON e.MANAGER_ID = m.EMP_ID
WHERE m.MANAGER_ID IS NOT NULL;


--19.List projects that have only one employee assigned.

SELECT p.PROJ_NAME, COUNT(e.EMP_ID) AS Assigned_Employees
FROM projectTable p
JOIN employeeRecord e ON p.PROJECT_ID = e.PROJ_ID
GROUP BY p.PROJ_NAME
HAVING COUNT(e.EMP_ID) = 1;




--20 Find top 3 highest paid employees per department

WITH RankedSalaries AS (
    SELECT *,
    RANK() OVER (PARTITION BY DEPT ORDER BY SALARY DESC) AS rk
    FROM employeeRecord
	
)
SELECT EMP_ID, FIRST_NAME, DEPT, SALARY
FROM RankedSalaries
WHERE rk <= 3
ORDER BY DEPT ASC




