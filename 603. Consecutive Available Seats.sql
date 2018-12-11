#### 603. Consecutive Available Seats(Easy) ####
'''
Several friends at a cinema ticket office would like to reserve consecutive available seats.
Can you help to query all the consecutive available seats order by the seat_id using the following cinema table?
| seat_id | free |
|---------|------|
| 1       | 1    |
| 2       | 0    |
| 3       | 1    |
| 4       | 1    |
| 5       | 1    |
Your query should return the following result for the sample case above.
| seat_id |
|---------|
| 3       |
| 4       |
| 5       |
Note:
The seat_id is an auto increment int, and free is bool ('1' means free, and '0' means occupied.).
Consecutive available seats are more than 2(inclusive) seats consecutively available.
'''

#### Tips: ####
'''
1) Self join: The result of join two tables is the Cartesian product of these two tables.
2) To find the consecutive available seats, the value in the a.seat_id should be more(or less) than the value b.seat_id, 
and both of them should be free.
3) Use distinct to filter the duplicated records.


SELECT 
  distinct a.seat_id
FROM
  cinema a 
  JOIN cinema b
    ON abs(a.seat_id - b.seat_id) = 1
    AND a.free = true AND b.free = true
ORDER BY a.seat_id;


### Another solution:

SELECT 
    distinct c1.seat_id
FROM 
    cinema c1, cinema c2
WHERE 
    (c1.seat_id + 1 = c2.seat_id OR c2.seat_id + 1 = c1.seat_id) 
    AND (c1.free = true AND c2.free = true)
ORDER BY c1.seat_id;
