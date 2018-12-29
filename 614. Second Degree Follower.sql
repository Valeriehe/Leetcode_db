#### 614. Second Degree Follower(Medium) ####

"""
In facebook, there is a follow table with two columns: followee, follower.

Please write a sql query to get the amount of each follower’s follower if he/she has one.

For example:

+-------------+------------+
| followee    | follower   |
+-------------+------------+
|     A       |     B      |
|     B       |     C      |
|     B       |     D      |
|     D       |     E      |
+-------------+------------+
should output:
+-------------+------------+
| follower    | num        |
+-------------+------------+
|     B       |  2         |
|     D       |  1         |
+-------------+------------+
Explaination:
Both B and D exist in the follower list, when as a followee, B's follower is C and D, and D's follower is E. A does not exist in follower list.
Note:
Followee would not follow himself/herself in all cases.
Please display the result in follower's alphabet order.
"""

"""
Tips:
1) Need to select distinct combination
2) Don' t need to care how many times a person appears in follower column. If a person appears too many times, join 2 tables together may be wrong.
3) Idea: GROUP BY elements in followee column and count them, then see which elements appear in follower column.
"""


SELECT 
    DISTINCT f2.follower, f1.num 
FROM
    (SELECT 
        followee, ifnull(COUNT(DISTINCT followee, follower),0) AS num 
    FROM 
        follow
    GROUP BY followee) f1 
    JOIN 
        follow f2 ON f1.followee = f2.follower
ORDER BY f2.follower;
