#### 597. Friend Requests I: Overall Acceptance Rate(Easy) ####

'''
In social network like Facebook or Twitter, people send friend requests and accept others’ requests as well. Now given two tables as below:
Table: friend_request
| sender_id | send_to_id |request_date|
|-----------|------------|------------|
| 1         | 2          | 2016_06-01 |
| 1         | 3          | 2016_06-01 |
| 1         | 4          | 2016_06-01 |
| 2         | 3          | 2016_06-02 |
| 3         | 4          | 2016-06-09 |
Table: request_accepted
| requester_id | accepter_id |accept_date |
|--------------|-------------|------------|
| 1            | 2           | 2016_06-03 |
| 1            | 3           | 2016-06-08 |
| 2            | 3           | 2016-06-08 |
| 3            | 4           | 2016-06-09 |
| 3            | 4           | 2016-06-10 |
Write a query to find the overall acceptance rate of requests rounded to 2 decimals, which is the number of acceptance divide the number of requests.
For the sample data above, your query should return the following result.
|accept_rate|
|-----------|
|       0.80|
Note:
The accepted requests are not necessarily from the table friend_request. In this case, you just need to simply count the total accepted requests (no matter whether they are in the original requests), and divide it by the number of requests to get the acceptance rate.
It is possible that a sender sends multiple requests to the same receiver, and a request could be accepted more than once. In this case, the ‘duplicated’ requests or acceptances are only counted once.
If there is no requests at all, you should return 0.00 as the accept_rate.
Explanation: There are 4 unique accepted requests, and there are 5 requests in total. So the rate is 0.80.
'''


'''
Tips:
1) Distinct rows based on multiple columns: distinct funtion
2) Every derived table must have its own alias (SELECT *** FROM *** AS *)
3) Select distinct rows -> new table -> select count(*) from new table
'''

SELECT
ROUND(
    ifnull(
        (SELECT COUNT(*) 
         FROM (SELECT distinct requester_id, accepter_id FROM request_accepted) AS B)
         /
        (SELECT COUNT(*) 
         FROM (SELECT distinct sender_id, send_to_id FROM friend_request) AS A), 
        0), 
    2) as accept_rate;
