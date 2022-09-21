/*
select - like koşulu-
Lıke : sorgulama yaparken belirli kalıp ifadeleri kulanabilmemizi sağlar
ILIKE : Sorgulama yaparken buyuk/kucuk harfe duyarsız olarak eşleştirir
LIKE: ~~
ILIKE: ~~*
NOT LIKE : !~~
NOT ILIKE : !~~*

% --> 0 veya daha fazla karakteri belirtir
_ --> tek bir karakteri belirtir
*/

--ismi A harfi ile baslayan personeli listele
select * from personel where isim like 'A%';

--ismi t harfi ile biten personeli listele
select * from personel where isim like '%t';

--isminin 2. harfi e olan personeli listeleyiniz
select * from personel where isim like '_e%';

--'a' ile başlayıp 'n' ile biten personel isimlerini listeleyiniz
select isim from personel where isim ~~*'a%n' 

--ikinci karakteri 'a' ve dördüncü karakteri 'u' olan personel isimlerini listeleyiniz
select isim from personel where isim ilike '_a_u%'

--içinde 'e've 'r ' bulunan personel isimlerini listeleyiniz
select isim from personel where isim ~~* '%e%' and isim ~~*'%r%';

--2. harfi e olup diger harflerinde y olan personeli listeleyin
select isim from personel where isim like '_e%y%' ;

--a harfi olmayan personeli listeleyin
select * from personel where isim not like '%a%';

--1. harfi A ve 7. harfi a olan personeli listeleyin
select * from personel where isim like 'A_____a%';

--sondan 2. harfi r olan isim degerlerini listeleyin
select isim from personel where isim like '%r_';