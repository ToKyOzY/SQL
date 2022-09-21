-- IS NULL, IS NOT NULL, COALESCE --
/*
IS NULL ve IS NOT NULL, Boolean operatorleridir. Bİr ifadenin NULL olup olmadığını kontrol eder
COALESCE (Birleştirme) ise bir fonksiyondur ve içerisindeki parametrelerden NULL olmayan ilk ifadeyi döndürür
*/
CREATE TABLE insanlar 
(
    ssn CHAR(9), -- Social Security Number
    isim VARCHAR(50), 
    adres VARCHAR(50) 
);
INSERT INTO insanlar VALUES('123456789', 'Ali Can', 'Istanbul');
INSERT INTO insanlar VALUES('234567890', 'Veli Cem', 'Ankara');
INSERT INTO insanlar VALUES('345678901', 'Mine Bulut', 'Izmir');
INSERT INTO insanlar (ssn, adres) VALUES('456789012', 'Bursa');
INSERT INTO insanlar (ssn, adres) VALUES('567890123', 'Denizli');
INSERT INTO insanlar (adres) VALUES('Sakarya');
INSERT INTO insanlar (ssn) VALUES('999111222');
select * from insanlar
-- isim i null olanlari sorgula
SELECT * from insanlar where isim is null
--null olmayanları işaretleyelim
select * from insanlar where isim is not null

--isim'i null olan kişilerin ismine no name atayınız
update insanlar
set isim= 'NO NAME'
where isim is null;

--tabloyu bir önceki soruyu çözmeden önceki haline geri getirin
update insanlar
set isim=null
where isim= 'NO NAME';


update insanlar 
set ssn= 000
where ssn is null;

update insanlar
set ssn= null
where ssn = '0';

--Not: çoklu değişimde her değişim için set ... where isim is null gibi
--ifade yazmamak için COALESCE(birleştirme) kullanılır.

/*
ismi null olanlara 'henuz isim girilmedi'
adresi null olanlara 'henuz adres girilmedi'
ssn'i null olanlara 'no ssn ' atayalım
*/
update insanlar
set isim = coalesce (isim, 'henuz isim girilmedi'),
adres = coalesce (adres, 'henuz adres girilmedi'),
ssn= coalesce (ssn, 'no ssn');

select * from insanlar

