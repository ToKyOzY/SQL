CREATE TABLE calisanlar
(
id CHAR(5) PRIMARY KEY, -- not null + unique
isim VARCHAR(50) UNIQUE, -- UNIQUE --> Bir sutundaki tüm değerlerin BENZERSİZ yani tek olmasını sağlar
maas int NOT NULL, -- NOT NULL --> Bir sutunun NULL içermemesini yani boş olmamasını sağlar
ise_baslama DATE
);
create table calisanlar2(
id CHAR(5),
isim VARCHAR(50),
maas int NOT NULL,
ise_baslama DATE,
Constraint pk_id Primary key(id),
Constraint isim_unq UNIQUE(isim)
);
INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10010', Mehmet Yılmaz, 5000, '2018-04-14'); --Unique
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); --NOT NULL
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); --UNIQUE
--INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); --NOT NULL
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
--INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); --PRIMARY KEY
--INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); --PRIMARY KEY
--INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); -- PRIMARY KEY
select * from calisanlar

-- FOREIGN KEY--
CREATE TABLE adresler
(
adres_id char(5),
sokak varchar(20),
cadde varchar(30),
sehir varchar(20),
CONSTRAINT id_fk FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
);
INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');
select * from adresler;

Insert Into adresler values('10012','Ağa Sok', '30.Cad.','Antep'); 
--parent tabloda olmayan id ile child tabloya ekleme yapamayız

Insert Into adresler values(NULL,'Ağa Sok', '30.Cad.','Antep');

--Calisanlar id ile adresler tablosundaki adres_id ile eşleşenlere bakmak için
select *from calisanlar, adresler Where calisanlar.id=adresler.adres_id;

DROP table calisanlar
--Parent tabloyu yani primary key olan tabloyu silmek istediginizde tabloyu silmez
--önce child tabloyu silmemiz gerekir

delete from calisanlar where id='10002';--> parent

delete from adresler where adres_id='10002';-->child

drop table calisanlar;

--ON DELETE CASCADE --
--Her defasında önce child tablodaki verileri silmek yerine
--ON DELETE CASCADE silme özelliğini aktif hale getirebiliriz
--Bunun için FK olan satırın en sonuna ON DELETE cascade komutunu yazmamız yeterli

CREATE TABLE talebeler
(
id CHAR(3) primary key,  
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);

CREATE TABLE notlar( 
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
ON DELETE CASCADE
);
INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90); 

select *from talebeler;
select * from notlar;

delete from notlar where talebe_id='123';
delete from talebeler where id='126'; --ON DELETE CASCADE kullandıgımız için Parent table'dan direkt silebildik
--parent table'dan sildigimiz iiçin child table'dan da silinmiş olur
delete from talebeler;

Drop table talebeler cascade;--Parent tabloyu kaldırmak istersek Drop table tabla_adi'dan sonra
--CASCADE komutunu kullanırız

--Talebeler tablosundaki isim sutununa not null kısıtlaması ekleyiniz ve veri tipini varchar(30) olarak degiştiririz

alter table talebeler 
alter column isim type varchar(30),
alter column isim set not null;
--talebeler tablosundaki yazılı notu kısmına 60'dan buyuk sayı girilebilsin
alter table talebeler 
add constraint sinir check(yazili_notu>60);
--CHECK kısıtlaması ile tablodaki istedigmiz sutunu sınırlandırabiliriz
--yukarıdaki 60'ı sınır olarak blirledigimiz için bunu eklemedi


insert into talebeler values (127,'Mustafa Bak', 'Can',45 );

create table ogrencilerr(
id int, 
isim varchar(45),
adres varchar(100),
sinav_notu int
);
Create table ogrenci_adres
AS
SELECT id, adres from ogrencilerr;
select * from ogrencilerr
select * from ogrenci_adres

--tablodaki bir sutuna PRIMARY KEY ekleme
alter table ogrencilerr
add primary key( id);
--Primary key'de 2. yol
alter table ogrencilerr
add constraint pk_id primary key(id);

--PK'dan sonra FK ataması
alter table ogrenci_adres
add foreign key (id)references ogrencilerr;

--PK'yi Constraint silme
alter table ogrenci_adres drop constraint ogrenci_adres_id_fkey;

--yazılı notu 85'den buyuk olan talebe bilgilerini getir
select * from talebeler where yazili_notu>85;

--ismi Mustafa Bak olan talebelerin tum bilgilerini getirin
select * from talebeler where isim='Mustafa Bak';

--select komutunda --BETWEEN koşulu
--Between belirttiginiz iki veri arasındaki bilgileri listeler
--Between de belirttigimiz ögelerde listelemeye dahildir

create table personel
(
id char(4),
isim varchar(30),
maas int
);
insert into personel values('1001', 'Ali Can', 70000);
insert into personel values('1002', 'Veli Mert', 85000);
insert into personel values('1003', 'Ayşe Tan', 65000);
insert into personel values('1004', 'Derya Soylu', 95000);
insert into personel values('1005', 'Yavuz Bal', 80000);
insert into personel values('1006', 'Sena Beyaz', 100000);

/*
    AND (ve): Belirtilen şartların her ikiside gerçekleşiyorsa o kayıt listelenir
Bir tanesi gerçekleşmezse listelemez
    Select * from matematik sinav1 > 50 AND sınav2 > 50
Hem sınav1 hemde sınav2 alanı, 50'den büyük olan kayıtları listeler
    OR (VEYA): Belirtilen şartlardan biri gerçekleşirse, kayıt listelenir
    select * From matematik sınav>50 OR sınav2>50 
Hem sınav1 veya sınav2 alanı, 50 den büyük olan kayıtları listeler    
*/

select * from personel;
--id'si 1003 ile 1005 arasında olan personel bilgisini listeleyiniz
select * from personel WHERE id BETWEEN '1003' and '1005';

--2. yol
select *from personel where id>='1003' and id>='1005';

--Derya soylu ile yavuz bal arasındaki personel bilgisini listeleyin
select * from personel where isim between 'Derya Soylu' and 'Yavuz Bal';

--Maasi 70000 ve ismi Sena olan personeli listele
select * from personel where maas =70000 or isim='Sena';

--IN : Birden fazla mantıksal ifade ile tanımlayabileegimiz durumları tek komutta yazabilme imkanı verir.
--Farklı sutunlar için IN kullanılamaz

--id'si 1001,1002 ve 1004 olan personelin bilgilerini listele
select * from personel where id='1001' or id='1002' or id='1004';
--2.yol
select * from personel where id in ('1001','1002','1004');

--Maasi sadece 70000, 100000 olan personeli listele
select * from personel where maas in (70000,100000);







