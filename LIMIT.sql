--LIMIT --
--kisiler tablosundan ilk 5 kisiyi listeleyiniz
select * from kisiler;
select * from kisiler limit 5;

--ilk 2 veriden sonra 5 veriyi listeleyin
select * from kisiler limit 5 OFFSET 2;

--id degeri 5 den buyuk olan ilk 2 veriyi listeleyiniz
select * from kisiler where id>5 limit 2;

--aası en yuksek kişinin bilgilerini listeleyin
select * from kisiler order by maas desc limit 3;

--en yuksek maası alan 4. 5. 6. kişilerin bilgilerini listeyin
select * from kisiler order by maas desc limit 3 offset 3;

