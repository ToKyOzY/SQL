--SELECT - SIMILAR TO - REGEX(Regular expressions) --
/*
SIMILAR TO : Daha karmaşık pattern(kalıp) ile sorgulama işlemleri için SIMILAR TO kullanılabilir.
sadece PostgreSQL de ullanılır. Büyük küçük harf önemlidir

REGEX : Herhangi bir kod, med'in içerisinde istenen yazı veya kod parçasının aranıp bulunmasını sağlayan
kendine ait bir sözz dizimi olan bir yapıdır. MySQL de (REGEXP_LIKE) olarak kullanılır
PostgreSQL 'de' "~" karakteri ile kullanılır.
*/
CREATE TABLE kelimeler
(
id int,
kelime VARCHAR(50),
harf_sayisi int
);
    INSERT INTO kelimeler VALUES (1001, 'hot', 3);
    INSERT INTO kelimeler VALUES (1002, 'hat', 3);
    INSERT INTO kelimeler VALUES (1003, 'hit', 3);
    INSERT INTO kelimeler VALUES (1004, 'hbt', 3);
    INSERT INTO kelimeler VALUES (1005, 'hct', 3);
    INSERT INTO kelimeler VALUES (1006, 'adem', 4);
    INSERT INTO kelimeler VALUES (1007, 'selim', 5);
    INSERT INTO kelimeler VALUES (1008, 'yusuf', 5);
    INSERT INTO kelimeler VALUES (1009, 'hip', 3);
    INSERT INTO kelimeler VALUES (1010, 'HOT', 3);
    INSERT INTO kelimeler VALUES (1011, 'hOt', 3);
    INSERT INTO kelimeler VALUES (1012, 'h9t', 3);
    INSERT INTO kelimeler VALUES (1013, 'hoot', 4);
    INSERT INTO kelimeler VALUES (1014, 'haaat', 5);
    INSERT INTO kelimeler VALUES (1015, 'hooooot', 5);
    INSERT INTO kelimeler VALUES (1016, 'booooot', 5);
    INSERT INTO kelimeler VALUES (1017, 'bolooot', 5
								  							
select * from kelimeler 
	
--  İçerisinde 'ot' veya 'at' bulunan kelimeleri listeleyiniz
-- Veya işlemi için | karakteri kullanılır

--Similar to ile								  
select * from kelimeler where kelime SIMILAR TO '%(at|ot|OT|oT|Ot|AT|aT|At)%';
--Like ile	
select * from kelimeler where kelime ilike '%at%' or kelime ilike '%ot%';	
select * from kelimeler where kelime ~~* '%at%' or '%ot%';								  
--Regex ile
select * from kelimeler where kelime ~*'ot' or kelime ~* 'at'; --* olunca buyuk kucuk farketmez
								  
--ho veya hi ile başlayan kelimeleri listeleyiniz
select * from kelimeler where kelime similar to 'ho%|hi%';
								  
select * from kelimeler where kelime like 'ho%' or kelime 'hi%';
								  
select * from kelimeler where kelime ~ 'ho%' or kelime ~ 'hi%';	
select * from kelimeler where kelime ~* 'h[oi](.*)'; --Regex'te ".(nokta) bir karakteri temsil eder"
--Regex'de 2. karakter için köşeli parantez kullanılır. * hepsi anlamına kulanılır

-- sonu t veya m ile bitenleri listeleyin
--SIMILAR TO ile								 
select * from kelimeler where kelime similar to '%t|%m';
--regex ile
select * from kelimeler where kelime ~* '(.*)[tm]$' --$ karakteri bitişi gösterir

--h ile başlayan t ile biten 3 harfli kelimeleri listeleyin
select *from kelimeler where kelime ilike 'h_t';								  
select * from kelimeler where kelime ~* 'h(.)t$';
select * from kelimeler where kelime similar to 'h[a-z,A-Z,0-9]t';
								  
--ilk karakteri h son karakteri t ve ikinci karakteri a'dan e'ye herhangi bir karakter olan 								  
--kelime degerlerini çağırın
select kelime from kelimeler where kelime similar to 'h[a-e]%t';
select kelime from kelimeler where kelme ~* 'h[a-e](.*)t';

--ilk karakteri s, a veya y olan "kelime" degerlerini çağırın
select * from kelimeler where kelime~'^[say](.*)'; --^başlangıcı temsil eder

--son karakteri m, a veya f olan kelime gruplarını çağırın
select * from kelimeler where kelime ~ '(.*)[maf]$';								  

--ilk harfi h, son harfi t olup 2. harfi a veya i olan 3 harfli kelimelerin tüm bilgilerini sorgulayalım								  
select * from kelimeler where kelime similar to 'h[a|i]t';
select * from kelimeler where kelime  ~ '^h[a|i]t$';
								  
----İlk harfi 'b' dan ‘s' ye bir karakter olan ve ikinci harfi herhangi bir karakter olup 
--üçüncü harfi ‘l' olan “kelime" değerlerini çağırın. 								  
select * from kelimeler where kelime ~'^[b-s].l(.*)';								  
								  
--içrisinde en az 2 adet o  o barındıran kelimelerin tüm bilgilerini listeleyiniz
select * from kelimeler where kelime similar to '%[o][o]%';								  
select * from kelimeler where kelime similar to '%[o]{2}%';--süslü parantez içinde belirttiğimiz rakam bir önceki 
								                           --köeli parantez içinde kaç tane oldugunu gösterir
--içerisinde en az 4 adet oooo barındıran kelimelerin tüm bilgilerini getir
select * from kelimeler where kelime similar to '%[o]{4}%';

----'a', 's' yada 'y' ile başlayan VE 'm' yada 'f' ile biten "kelime" değerlerini çağırın.								  
select kelime from kelimeler where kelime ~ '^[a|s|y](.*)[m|f]$';
								  
								  
								  
								  
								  
								  
								  