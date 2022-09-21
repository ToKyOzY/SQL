CREATE TABLE workers
(
  id CHAR(9),
  name VARCHAR(50),
  state VARCHAR(50),
  salary SMALLINT,
  company VARCHAR(20)
);
INSERT INTO workers VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO workers VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO workers VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO workers VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO workers VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO workers VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO workers VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');

SELECT * FROM workers;

--toplam salary degeri 2500 uzeri olan her bir calışan için salary toplamını bulun
select name, sum(salary) as "total salary" 
from workers
group by name 
having sum(salary)>2500; --->group by ardından where kullanılmaz

--birden fazla çalışanı olan her bir state icin calışan toplamlarını bulun
select state, count(state) as number_of_employees 
from workers
group by state
having count(state)>1; --having; group by ardından filtreleme icin kullanılır

--her bir state icin degeri 3000'den az olan max salary degerini bulun
select state, max(salary)
from workers
group by state
having max(salary)<3000;

--her bir company için degeri 2000'den fazla olan min salary degerini bul
select company, min(salary) as min_salary
from workers
group by company
having min(salary)>2000;

--tekrarsız isimleri cagırın
select distinct name --distinct clause cagırılan terimlerden tekrarlı olanların sadece birincisini alır
from workers;

--name degerlerini company kelime uzunluklarına göre sıralayın
select name, company
from workers
order by length(company);

--tum name ve state degerlerini aynı sutunda cagıraırak her bir sütun degerinin uzunluguna gröe sıraalyın
--oncat() fonksiyonu birden fazla sütun veya String degerini birleştirmek için kullanılır
--1. yol:
select concat(name,' - ', state) as name_and_state
from workers
order by length(name) + length(state);

--2.yol:
select name || ' ' || state || ' ' ||length(name)+length(state) as "Name and Satates"
from workers
order by length(name)+length(state);

/*
Union Operator: 1) iki sorgu (query) sonucunu birleştirmek için kullanılır
				2) Tekrarsız(unique) recordları verir
				3) Tek bir sütuna çok sütun koyabiliriz
				4) Tek bir sütuna çok sütun koyarken mevcut data durumuna dikkat etmek gerekir
*/
--salary degeri 3000'den yüksek olan state degerlerini ve salary degeri 2000'den küçük olan name degerlerini tekrarsız olarak bulun.
select state, salary as "Name and State"
from workers
where salary > 3000

UNION

select name, salary 
from workers 
where salary<2000;

--salary degerş 3000'den yuksek olan state degerlerini ve 2000'den kucuk olan name degerlerini tekrarlı olarak bulun
select state, salary as "Name and State"
from workers
where salary > 3000

UNION all --> union ile ayı işi yapar ancak, tekrarlı degerleri de verir

select name, salary 
from workers 
where salary<2000;

--salary 1000'den yuksek 2000'den az olan ortak name degerlerini bulun
select name
from workers
where salary>1000

INTERSECT--> INTERSECT Operator: iki sorgu (query) sonucunun ortak(common) degerleriini verir. Unique (tekrarsız) recordları verir. 

select name 
from workers
where salary<2000;

--salary 2000'den az olan company degeri IBM, APPLE ya da MICROSOFT olan ortak name degerlerini bulun
select name 
from workers
where salary<2000

INTERSECT

select name 
from workers
where company in('IBM', 'APPLE','MICROSOFT');

--Except Operator: Bir sorgu sonucundan başka bir sorgu sonucunu çıkarak için kullanılır.Unique(tekrarsız) recordları verir.
--salary degeri 3000'den az ve GOOGLE'da çalışmayan name degerlerini bulun

select name
from workers
where salary <3000
EXCEPT
select name 
from workers
where company= 'GOOGLE';

CREATE TABLE my_companies
(
  company_id CHAR(3),
  company_name VARCHAR(20)
);
INSERT INTO my_companies VALUES(100, 'IBM');
INSERT INTO my_companies VALUES(101, 'GOOGLE');
INSERT INTO my_companies VALUES(102, 'MICROSOFT');
INSERT INTO my_companies VALUES(103, 'APPLE');

SELECT * FROM my_companies;
-------------------------
CREATE TABLE orders
(
  company_id CHAR(3),
  order_id CHAR(3),
  order_date DATE
);
INSERT INTO orders VALUES(101, 11, '17-Apr-2020');
INSERT INTO orders VALUES(102, 22, '18-Apr-2020');
INSERT INTO orders VALUES(103, 33, '19-Apr-2020');
INSERT INTO orders VALUES(104, 44, '20-Apr-2020');
INSERT INTO orders VALUES(105, 55, '21-Apr-2020');

SELECT * FROM orders;

/*
JOINS: 1) INNER JOIN: Ortak (common) detayı verir
	   2) Left JOIN: Birinci table'in tum datasını verir
	   3) RIGHT JOIN: İKinci table'ın tum datasını verir
	   4) FULL JOIN: İki table'ın da tüm datasını verir
	   5) SELF JOIN: Tek table üzerinde çalıırken iki table 
*/

--1) INNER JOIN
--Ortak companyler için company_name, order_id ve order_date degerlerini çağırın.

select mc.company_name, o.order_id, o.order_date
from my_companies mc INNER JOIN orders o
ON mc.company_id =o.company_id;

--2) LEFT JOIN
--my_companies table'ındaki companyler için order_id ve order_date degerlerini çagırın

select mc.company_name, o.order_id, o.order_date
from my_companies mc LEFT JOIN orders o
ON mc.company_id = o.company_id; 

--3) RIGHT JOIN
--Orders table'ındaki company'ler için company_name, company_id ve order_date degerlerini çagırın.

select mc.company_name, o.company_id, o.order_date
from my_companies mc RIGHT JOIN orders o
ON mc.company_id = o.company_id; 

--4) FULL JOIN
--iki table'dan da company_name, order_id ve order_date degerlerini cagırın


select mc.company_name, o.order_id, o.order_date
from orders o full JOIN my_companies mc
ON mc.company_id = o.company_id;
 
 --5) SELF JOIN
CREATE TABLE workers
(
  id CHAR(2),
  name VARCHAR(20),
  title VARCHAR(60),
  manager_id CHAR(2)
);
INSERT INTO workers VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO workers VALUES(2, 'John Walker', 'QA', 3);
INSERT INTO workers VALUES(3, 'Angie Star', 'QA Lead', 4);
INSERT INTO workers VALUES(4, 'Amy Sky', 'CEO', 5);

SELECT * FROM workers;

--workers tablosunu kullanarak çalışanların yöneticilerini gösteren bir tablo hazırlayın.
select employee.name AS Employee, manager.name AS Manager 
from workers employee FULL JOIN workers manager
ON employee.manager_id=manager.id;



