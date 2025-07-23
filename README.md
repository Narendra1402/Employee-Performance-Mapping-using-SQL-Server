# 🚀 ScienceQtech - Employee Performance Mapping

An end-to-end SQL project for **ScienceQtech**, focused on exploring, optimizing, and analyzing employee and project data for actionable HR insights. 

[🎥Explanation video](https://www.youtube.com/watch?v=Jfd7gPI9pew)

## 🧠 About ScienceQtech

ScienceQtech is a startup specializing in Data Science, with work spanning fraud detection, self-driving cars, drug discovery, customer sentiment, supply chain, and more.

With the appraisal cycle approaching, the HR team requested a full-fledged SQL-based report analyzing employees, their roles, performance, and project engagements.



## 🎯 Purpose & Objectives

- **Goal:** Extract, analyze, and optimize employee-related data for better business decisions.
- **Role:** Data Analyst (Junior DBA)
- **Key Tasks:**
  - Wrote and optimized SQL queries.
  - Built views, stored procedures, functions, and indexes.
  - Used CTEs, ranking functions, and window functions for advanced analysis.



## 🔑 Key Deliverables

✅ Solved 20+ business questions\
✅ Created reusable views, stored procedures, and UDFs\
✅ Improved performance with indexing & optimization



## 🗂️ Datasets Used

| Table             | Description                                |
| ----------------- | ------------------------------------------ |
| `employeeRecord`  | Master employee data (personal & job info) |
| `projectTable`    | Info on projects and assignments           |
| `dataScienceTeam` | Subset of employees in the DS department   |



## 🧾 Sample Questions Solved

```sql
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
FROM employeeRecord;
```

```sql
SELECT EMP_ID, FIRST_NAME, LAST_NAME, ROLE, EXP,
       RANK() OVER (ORDER BY EXP DESC) AS RANK_EXP
FROM employeeRecord;
```

```sql
CREATE FUNCTION dbo.fn_StandardJobProfile (@exp INT)
RETURNS VARCHAR(50)
AS
BEGIN
  -- Logic to assign titles based on experience
END;
```

```sql
WITH RankedSalaries AS (
  SELECT *, RANK() OVER (PARTITION BY DEPT ORDER BY SALARY DESC) AS rk
  FROM employeeRecord
)
SELECT EMP_ID, FIRST_NAME, DEPT, SALARY
FROM RankedSalaries
WHERE rk <= 3;
```



## 📊 Techniques & Features

- ✅ **Joins (INNER, LEFT, SELF)**
- ✅ **Window Functions (RANK, MAX OVER)**
- ✅ **Views, Stored Procedures, and Functions**
- ✅ **Indexing for Performance**
- ✅ **Nested Queries & CTEs**
- ✅ **Real-World Business Problem Solving**



## 🏁 Conclusion

This project showcases how SQL can be leveraged not just for querying, but for real business insight generation, workflow optimization, and performance tuning. It demonstrates the value of structured data analytics for HR and organizational strategy.



## 💡 How to Use

1. Clone the repository
2. Restore or connect your SQL Server database
3. Run scripts in `scripts/` folder in sequence
4. Review output and optimize as needed




## 🔗 Connect With Me  
Feel free to explore more of my projects and reach out:  
- [LinkedIn](https://www.linkedin.com/in/narendrasingh1402)
- [YouTube](https://www.youtube.com/@Analyst_Hive)  
- [Portfolio](https://narendra1402.github.io/)




