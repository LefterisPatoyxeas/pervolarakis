-- 3.1.1 
SELECT count(bor.borrowed_id), s.name FROM borrowings bor INNER JOIN school s on s.operator_id = bor.operator_id group by s.name
-- adfadsa





-- 3.1.2
SELECT ct.category, schu.school_users_id , u.First_name, u.Last_name  FROM books b
INNER JOIN category_table ct ON b.ISBN = ct.ISBN 
INNER JOIN borrowings bor ON bor.ISBN = ct.ISBN 
INNER JOIN school_users schu ON bor.school_users_id = schu.school_users_id
INNER JOIN users u ON  u.user_id = schu.school_users_id
WHERE schu.status = "teacher"  


use library; 

-- 3.1.1 
select * from borrowings;
select sch.name, count(borrowed_id) from borrowings bor 
INNER JOIN operator op ON bor.operator_id = op.operator_id 
INNER JOIN school sch ON  sch.operator_id = op.operator_id 
GROUP BY sch.name;
-- leipoun kritiria anazitisis

-- 3.1.2
SELECT ct.category, aut.author FROM books b 
INNER JOIN category_table ct ON b.ISBN = ct.ISBN
RIGHT JOIN author_table aut ON ct.ISBN = aut.ISBN
GROUP BY aut.author ORDER BY ct.category;

SELECT ct.category, schu.school_users_id, us.First_name, us.Last_name FROM books b 
INNER JOIN category_table ct ON b.ISBN = ct.ISBN
INNER JOIN borrowings bor ON bor.ISBN = ct.ISBN
INNER JOIN school_users schu ON bor.school_users_id = schu.school_users_id
INNER JOIN users us ON us.user_id = schu.school_users_id
WHERE schu.status = "teacher" AND borrowing_date > DATE(2023-00-00) ORDER BY ct.category ASC;
-- to teleytaio etos oxi sigouro, alla exei logiki

-- 3.1.3 
select schu.school_users_id, us.First_name, us.Last_name, count(bor.borrowed_id) from books b
INNER JOIN  borrowings bor ON bor.ISBN = b.ISBN
INNER JOIN school_users schu ON bor.school_users_id = schu.school_users_id
INNER JOIN users us ON us.user_id = schu.school_users_id
WHERE year(CURDATE()) - DATE_FORMAT(schu.age,"%Y")  < 40 AND schu.status = "teacher";
-- exun daneistei ta perissotera vivlia, idk ti ennoei me ayto 

-- 3.1.4
SELECT DISTINCT aut.author FROM author_table aut
LEFT JOIN borrowings bor ON bor.ISBN = aut.ISBN
WHERE bor.borrowed_id is NULL;
-- mporei na lythei kai me subquery tha to dw argotera an ayti h lysi einai lathos
-- me subquery
select distinct aut.author from author_table aut
LEFT JOIN borrowings bor ON bor.ISBN = aut.ISBN
WHERE not exists (select 1 from borrowings inner join author_table aut1 on bor.ISBN = aut1.ISBN );

-- 3.1.5


-- 3.1.6 / hardcore 

-- 3.1.7
-- select all the authors with their respectable amount of books 
select aut.author, count(b.ISBN) as count_of_books_per_author from books b 
	inner join author_table aut on aut.ISBN = b.ISBN 
    group by aut.author;
    
-- select author with maximum books 
select z.author, max(z.count_of_books_per_author) as max_books_author from 
    (select aut.author, count(b.ISBN) as count_of_books_per_author from books b 
	inner join author_table aut on aut.ISBN = b.ISBN 
	group by aut.author) z;
    
-- answer the question
with aut_five_less_max (author,count_of_books_per_author) as
		(select aut.author, count(b.ISBN) as count_of_books_per_author from books b 
		inner join author_table aut on aut.ISBN = b.ISBN 
		group by aut.author),
	 most_books_author (max_books_author) as
		(select max(count_of_books_per_author) as max_books_author 
        from aut_five_less_max)
select *
from aut_five_less_max aflm
join most_books_author mba 
on mba.max_books_author - 5 > aflm.count_of_books_per_author;
            
 
