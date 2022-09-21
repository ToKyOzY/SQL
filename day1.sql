/*
DDl - DATA DEFINITION LANG:DATACREATE -ALTER - DROP
/*
--CREATE - TABLO OLUSTURMA --

CREATE table ogrenci(
ogr_no int,
ogr_isim varchar(30),
notlar real,
yas int,
adres varchar(50),
kayit_tarih date

);
-- VAROLAN TABLODAN YENI BIR TABLO OLUSTURMA

CREATE table ogr_notlari
AS 
SELECT ogr_no, notlar FROM ogrenci;

SELECT * FROM ogrenci;

SELECT * FROM ogr_notlari;


