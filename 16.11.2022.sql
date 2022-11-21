--Case Study
--Bir okul i�in bir veritaban� sistemi geli�tirilecektir. Bu sistemde rapor olarak;
--(Ogrenci notlar� Vize ve Final olarak tutulacak)

CREATE DATABASE OkulDB
GO
USE OkulDB
GO
CREATE TABLE Ogrenciler(OgrenciID int IDENTITY PRIMARY KEY,
													 OgrAd varchar(20),
													 OgrAdSoyad varchar(20))
CREATE TABLE Dersler(DersID int IDENTITY(10,1) PRIMARY KEY,
													 DersAdi varchar(20),
													 Kredi tinyint)
CREATE TABLE Egitmenler(EgitmenID int IDENTITY(100,1) PRIMARY KEY,
													   AdSoyad varchar(50))
CREATE TABLE Ogrenci_Ders(ODID int IDENTITY PRIMARY KEY,
														   OgrenciID int REFERENCES Ogrenciler(OgrenciID),
														   DersID int REFERENCES Dersler(DersID),
														   Vize int,
														   Final int,
														   Ortalama AS (Vize+Final)/2)
CREATE TABLE Egitmen_Ders(EDID int IDENTITY PRIMARY KEY,
														   EgitmenID int REFERENCES Egitmenler(EgitmenID),
														   DersID int REFERENCES Dersler(DersID))

INSERT INTO Ogrenciler VALUES ('Cevdet','Korkmaz'),('Selami','Dursun'),('Dursun','Durmas�n'),
('Kemal','Kendir'),('Derya','Deniz')

INSERT INTO Egitmenler VALUES ('Ersin K�lyutmaz'),('Cavit Mavi'),('Zafer Muzaffer')

INSERT INTO Dersler VALUES ('MAT101',3),('MAT102',4),('TAR�H',2),('POL�FON�',0),('�NG�L�ZCE',3)

INSERT INTO Ogrenci_Ders VALUES 
(1,10,30,80),(1,11,20,60),(1,13,60,70),
(2,12,72,70),(2,14,40,40),
(3,11,60,70),(3,13,50,50),(3,14,50,60),
(4,11,46,56),
(5,11,54,23),(5,12,43,87),(5,13,43,12),(5,14,65,34)

INSERT INTO Egitmen_Ders VALUES 
(100,11),(100,10),
(102,14),
(101,13),(101,12)

SELECT * FROM Ogrenciler
SELECT * FROM Egitmenler
SELECT * FROM Dersler
SELECT * FROM Ogrenci_Ders
SELECT * FROM Egitmen_Ders

--1-Bir dersi alan ��renci listesi

SELECT Ogrenciler.OgrenciID, Ogrenciler.OgrAd, Ogrenciler.OgrAdSoyad, Dersler.DersAdi
FROM     Dersler INNER JOIN
                  Ogrenci_Ders ON Dersler.DersID = Ogrenci_Ders.DersID INNER JOIN
                  Ogrenciler ON Ogrenci_Ders.OgrenciID = Ogrenciler.OgrenciID
WHERE  (Dersler.DersAdi = 'Mat102')

--2-Bir e�itmenin verdi�i dersler

SELECT Egitmenler.AdSoyad, Dersler.DersAdi, Dersler.Kredi
FROM     Dersler INNER JOIN
                  Egitmen_Ders ON Dersler.DersID = Egitmen_Ders.DersID INNER JOIN
                  Egitmenler ON Egitmen_Ders.EgitmenID = Egitmenler.EgitmenID
WHERE  (Egitmenler.AdSoyad = 'Cavit Mavi')

--3-Bir ��rencinin ald��� dersler
SELECT Ogrenciler.OgrAd, Ogrenciler.OgrAdSoyad, Dersler.DersAdi, Dersler.Kredi
FROM     Dersler INNER JOIN
                  Ogrenci_Ders ON Dersler.DersID = Ogrenci_Ders.DersID INNER JOIN
                  Ogrenciler ON Ogrenci_Ders.OgrenciID = Ogrenciler.OgrenciID
WHERE  (Ogrenciler.OgrAd = 'Cevdet') AND (Ogrenciler.OgrAdSoyad = 'Korkmaz')
--4-Transkript
SELECT Dersler.DersAdi, Dersler.Kredi, Ogrenci_Ders.Final, Ogrenci_Ders.Vize, Ogrenci_Ders.Ortalama
FROM     Dersler INNER JOIN
                  Ogrenci_Ders ON Dersler.DersID = Ogrenci_Ders.DersID INNER JOIN
                  Ogrenciler ON Ogrenci_Ders.OgrenciID = Ogrenciler.OgrenciID
WHERE  (Ogrenciler.OgrAd = 'Cevdet') AND (Ogrenciler.OgrAdSoyad = 'Korkmaz')

--K�s�tlar (CONSTRAINTS)
--1-PK
--2-FK
--3-Unique
--4-Default
--5-Check
--6-NULL

--3-Unique
--��erisindeki de�erin uniq olmas� istenildi�i durumlarda kullan�l�r

--4-Default
--Kullan�c� bir alana bo� de�er girerse varsay�lan de�er gelir

--5-Check
--Girilen de�erin belirli aral�klarda olmas�n� sa�lar
--Bir �ablona g�re yazmaya zorlar

USE Calisma
CREATE TABLE Cns_Urunler(UrunID int IDENTITY PRIMARY KEY,
														  UrunAdi varchar(100),
														   UrunKodu varchar(5),
														   Fiyat money,
														   Renk varchar(15))

DROP TABLE Cns_Urunler

--KOD �LE KISITLAR
CREATE TABLE Cns_Urunler(UrunID int IDENTITY PRIMARY KEY,
														  UrunAdi varchar(100) UNIQUE NOT NULL,
														   UrunKodu varchar(5) CHECK (UrunKodu Like '[A-F][A-Z][0-9][0-9][0-9]'),
														   Fiyat money CHECK(Fiyat>0 AND Fiyat<1000) NOT NULL,
														   Renk varchar(15) DEFAULT 'Lacivert')


--Foreign KEY Rules

--Cascade
--Set NULL
--Set Default

--T-SQL PROGRAMLAMA
--De�i�ken tan�mlama
DECLARE @ID int --DE�ER TANIMLAMA
SET @ID=12 -- ��ER�S�NE DE�ER ATAMA
PRINT @ID --MESSAGES KISMINDA 12 DE�ER�N� G�STER
SELECT @ID -- ID DE�ER�N� SE�