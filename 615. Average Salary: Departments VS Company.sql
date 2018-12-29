#### 615. Average Salary: Departments VS Company(Hard) ####

"""
Given two tables as below, write a query to display the comparison result (higher/lower/same) of the average salary of employees in a department to the company's average salary.
Table: salary
| id | employee_id | amount | pay_date   |
|----|-------------|--------|------------|
| 1  | 1           | 9000   | 2017-03-31 |
| 2  | 2           | 6000   | 2017-03-31 |
| 3  | 3           | 10000  | 2017-03-31 |
| 4  | 1           | 7000   | 2017-02-28 |
| 5  | 2           | 6000   | 2017-02-28 |
| 6  | 3           | 8000   | 2017-02-28 |
The employee_id column refers to the employee_id in the following table employee.
| employee_id | department_id |
|-------------|---------------|
| 1           | 1             |
| 2           | 2             |
| 3           | 2             |
So for the sample data above, the result is:
| pay_month | department_id | comparison  |
|-----------|---------------|-------------|
| 2017-03   | 1             | higher      |
| 2017-03   | 2             | lower       |
| 2017-02   | 1             | same        |
| 2017-02   | 2             | same        |
Explanation
In March, the company's average salary is (9000+6000+10000)/3 = 8333.33...
The average salary for department '1' is 9000, which is the salary of employee_id '1' since there is only one employee in this department. So the comparison result is 'higher' since 9000 > 8333.33 obviously.
The average salary of department '2' is (6000 + 10000)/2 = 8000, which is the average of employee_id '2' and '3'. So the comparison result is 'lower' since 8000 < 8333.33.
With he same formula for the average salary comparison in February, the result is 'same' since both the department '1' and '2' have the same average salary with the company, which is 7000.
"""

"""
Tips:
1) JOIN salary with employee to add department_id and calculate the department average salary
2) Create a temporary table that has company average by each pay month, then join this table with the above big table
3) date_format
"""

SELECT 
    S.pay_month, S.department_id, 
    (CASE WHEN S.department_avg > T.company_avg THEN 'higher' 
          WHEN S.department_avg < T.company_avg THEN 'lower' 
          ELSE 'same' END) AS comparison
FROM
    (SELECT 
        date_format(pay_date, '%Y-%m') AS pay_month, 
        employee.department_id, 
        AVG(salary.amount) AS department_avg
    FROM 
        salary
            LEFT JOIN 
        employee ON salary.employee_id = employee.employee_id
    GROUP BY pay_month, employee.department_id) AS S        # tip 1
        JOIN (SELECT avg(amount) as company_avg,  date_format(pay_date, '%Y-%m') as pay_month
              FROM salary
              GROUP BY date_format(pay_date, '%Y-%m')) AS T     #tip 2
        ON S.pay_month = T.pay_month
ORDER BY S.department_id;
