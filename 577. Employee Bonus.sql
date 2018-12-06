#### Select all employee's name and bonus whose bonus is < 1000. (Easy) ####
'''
Table:Employee

+-------+--------+-----------+--------+
| empId |  name  | supervisor| salary |
+-------+--------+-----------+--------+
|   1   | John   |  3        | 1000   |
|   2   | Dan    |  3        | 2000   |
|   3   | Brad   |  null     | 4000   |
|   4   | Thomas |  3        | 4000   |
+-------+--------+-----------+--------+
empId is the primary key column for this table.
Table: Bonus

+-------+-------+
| empId | bonus |
+-------+-------+
| 2     | 500   |
| 4     | 2000  |
+-------+-------+
empId is the primary key column for this table.

Example ouput:

+-------+-------+
| name  | bonus |
+-------+-------+
| John  | null  |
| Dan   | 500   |
| Brad  | null  |
+-------+-------+
'''

#### Tips:
'''
1) Left Join tables and add where condition to select
2) Inclusding Null: where c1 or c2
'''


SELECT 
    E.name, B.bonus
FROM 
    Employee AS E
        LEFT JOIN 
    Bonus AS B ON E.empId = B.empId
WHERE 
    B.bonus < 1000 OR B.bonus IS NULL;
