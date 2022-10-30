CREATE TABLE FormEduPrograms(
ProgramStatus NVARCHAR(50) PRIMARY KEY                --Ferdi ve korparative qiraga cixartmishiq 
)

INSERT INTO FormEduPrograms VALUES			--Values add eliyirik
('Ferdi'),
('Korparotiv')

CREATE TABLE Educations(								--education adli table yaradiriq(dersin adi ve s...)
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(50),
About NVARCHAR(150),
ProgramStatus NVARCHAR(50) FOREIGN KEY REFERENCES FormEduPrograms(ProgramStatus)	--statusu reference aliriq
)

INSERT INTO Educations VALUES					
('Programming','Programming is a set of instructions given to a computer to achieve a specific result or perform a task','Ferdi'),
('Design','Design is a field that encompasses visual communication between a brand and its target audience','Korparotiv'),
('Digital Marketing','Digital Marketing is the process of conducting marketing activities using the Internet','Korparotiv')


SELECT*FROM Educations


SELECT * FROM Educations				-- education ve statusu bir yerde gostermek ucun yazmishiq
JOIN FormEduPrograms
ON Educations.ProgramStatus=FormEduPrograms.ProgramStatus



CREATE TABLE Syllabus(				--derslerin korporativ ve ya ferdi olanlarin sillabusunu qiragda yazmishiq
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(50),
)

CREATE TABLE Topic(						--derslerin korporativ ve ya ferdi olanlarin movzusunu qiragda yazmishiq
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(50),
About NVARCHAR(200)

)

CREATE TABLE SyllabusTopic(				--many to many elaqe qurmushuq 
SyllabusId INT FOREIGN KEY REFERENCES Syllabus(Id),
TopicId INT FOREIGN KEY REFERENCES Topic(Id),
PRIMARY KEY (SyllabusId,TopicId)
)





CREATE TABLE EduProgramms(				--dersler haqqinda melumatlar burada saxlanilir
Id INT PRIMARY KEY IDENTITY,
FormEduProgramStatus NVARCHAR(50) FOREIGN KEY REFERENCES FormEduPrograms(ProgramStatus), --burda ferdi ve ya korporativ olmagi avtomatik gelir
About NVARCHAR(150),
Online BIT  NOT NULL,
Prerequisites NVARCHAR(100),
Prupose NVARCHAR(100),
SyllabusId INT FOREIGN KEY REFERENCES Syllabus(Id)		--syllabusun datalarini join elemek ucun 

)

INSERT INTO Topic VALUES
('HTML','giriw'),
('C#','back giriw'),
('JS','html cani'),
('Mrketing','money')



INSERT INTO Syllabus VALUES
('Programing Syllabus'),
('Design Syllabus'),
('Digital Syllabus')


SELECT *FROM Syllabus

SELECT *FROM Topic

INSERT INTO SyllabusTopic VALUES
(1 ,2),
(1 ,3),
(1 ,1),
(2 ,4),
(3 ,4)


SELECT Syllabus.Name AS 'Syllabus Name',Topic.Name AS 'Topic Name',Topic.About AS 'Topic About'
FROM SyllabusTopic										--syllabus ve topici join etmishik
JOIN Syllabus ON SyllabusTopic.SyllabusId=Syllabus.Id
JOIN Topic ON SyllabusTopic.TopicId=Topic.Id

SELECT * FROM EduProgramms

INSERT INTO EduProgramms VALUES
('Korparotiv','salam',0,'On sert','meqsed',1),
('Korparotiv','salam',0,'On sert','meqsed',3),
('Ferdi','salam',1,'On sert','meqsed',2),
('Ferdi','salam',0,'On sert','meqsed',2),
('Korparotiv','salam',1,'On sert','meqsed',1)


SELECT Educations.Name,Educations.About AS 'Education About' , --Education haqqinda butun melumatlari join etmishik
FEP.ProgramStatus,		
EP.About,EP.Online,EP.Prerequisites,
Syllabus.Name AS 'SYLLABUS',Topic.Name AS 'TOPIC'
FROM EduProgramms AS EP
JOIN FormEduPrograms AS FEP ON EP.FormEduProgramStatus=FEP.ProgramStatus
JOIN SyllabusTopic AS ST ON EP.SyllabusId=ST.SyllabusId
JOIN Syllabus ON EP.SyllabusId=ST.SyllabusId
JOIN Topic ON ST.TopicId=Topic.Id
JOIN Educations ON Educations.ProgramStatus=FEP.ProgramStatus





CREATE TABLE GroupStatus(			--GRUPUN STATUSUNU QIRAGDA BIR TABLE YARADARAQ QEYD ETMISHIK
Name NVARCHAR(50) PRIMARY KEY)

INSERT INTO GroupStatus VALUES
('Nezerde tutulmuw'),
('Aktiv'),
('Bitmiw'),
('Legv olunmuw')


CREATE TABLE Groups (				--QRUPLAR BURADA SAXLANILIR MESELEN P325
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(50),
Status NVARCHAR(50) FOREIGN KEY REFERENCES GroupStatus(Name), --BURDA GroupStatus`dan BIR BASHA REFERENCE ALIRIQ
StartDay DATE ,
ProbablyEndDay DATE,
EndDay DATE,
EducationId INT FOREIGN KEY REFERENCES Educations(Id), --HANSI TEHSIL OLDUGUNU REFERENCE ALIRIQ


)


INSERT INTO Groups VALUES
('P325','Aktiv','2022-05-05','2022-12-11','2024-02-12',1)


SELECT Groups.Name AS 'GROUP NAME',		--QRUP VE TEHSILI JOIN ETMISHIK
Groups.Status AS 'Group status',
Groups.StartDay,Groups.ProbablyEndDay,Groups.EndDay,
Educations.Name AS 'Education Name',
Educations.About AS 'Education About',
Educations.ProgramStatus AS 'Education Status'
FROM Groups										
JOIN Educations ON Groups.EducationId=Educations.Id 





CREATE TABLE EduType(			--TEHSILIN TIPINI AYRI BIR TABLE `A CIXARTMISHIQ
Name NVARCHAR(50) PRIMARY KEY
)

CREATE TABLE Candidate(			--NAMIZED TABLE`I
Id INT IDENTITY PRIMARY KEY,
Name NVARCHAR(50) ,
Surname NVARCHAR(50),
FatherName NVARCHAR(50),
Info NVARCHAR(100),
Type NVARCHAR(50) FOREIGN KEY REFERENCES EduType(Name), --EDUTYPEDAN BIR BASHA REFERENCE ALIRIQ.
Email NVARCHAR(50) UNIQUE
)

SELECT * FROM Candidate


INSERT INTO EduType		
VALUES('Adi'),
('Bakalavr'),
('Master')


INSERT INTO Candidate
VALUES('Cavid','Qafarli','Iqbal','Haqqinda melumat','Bakalavr','cavid@gmail.com')


SELECT * FROM Candidate

CREATE TABLE Students					--TELEBE TABLE
(
Id INT IDENTITY PRIMARY KEY,
BirthDate DATE,
Fincode NVARCHAR(50) UNIQUE,
Seria NVARCHAR(50) UNIQUE,
GroupId INT FOREIGN KEY REFERENCES Groups(Id),		--GROUP TABLE DAN REFERENCE ALIRIQ
CandidateId INT FOREIGN KEY REFERENCES Candidate(Id) --CANDIDATE DEN REFERENCE ALIRIQ       ADLARINI SOYADLARINI VE S... SAXLAMAQ UCUN
)

INSERT INTO Students VALUES
('2001-05-06','74FF87','AZE12345',1,1)

SELECT Candidate.Name,Candidate.Surname,Candidate.Email, Candidate.FatherName,		--TELEBE HAQQINDA BUTUN MELUMATLARI JOIN ETMISHIK
Candidate.Info,Students.Fincode , Students.Seria,Students.BirthDate,
Groups.Name,Groups.StartDay,Groups.EndDay,Groups.Status
FROM Students
JOIN Groups ON Students.GroupId=Groups.Id
JOIN Candidate ON Students.CandidateId=Candidate.Id

 
 CREATE TABLE Mentors(				---MENTOR TABLE
 Id INT IDENTITY PRIMARY KEY,
 Salary DECIMAL(18,2),
 PhoneNumber NVARCHAR(50),
 Address NVARCHAR(100),
 StudentId INT FOREIGN KEY REFERENCES Students(Id) --- MENTORUN ADINI SOYADINI VE S LERI SAXLAMAQ UCUN
 )

 CREATE TABLE GroupMentor(				--QRUPLA MENTORU BIRLESHDIRMEK UCUN MANY TO MANY ELAQE
 GroupId INT FOREIGN KEY REFERENCES Groups(Id),
 MentorId INT FOREIGN KEY REFERENCES Mentors(Id)
 PRIMARY KEY(GroupId,MentorId)
 )
 SELECT * FROM Mentors
 INSERT INTO Mentors VALUES
 (250.50,'+994513100090','Baki',1)

 INSERT INTO GroupMentor VALUES(1,1)

 SELECT * FROM Candidate

 
INSERT INTO Candidate
VALUES('Eshqin','Ferecov','Ebil','Haqqinda melumat','Master','eshqin@gmail.com'),
('Kamil','Memmedov','Telman','Haqqinda melumat','Adi', 'kamil@gmail.com')


SELECT * FROM Students

INSERT INTO Groups VALUES
('P326','Nezerde tutulmuw','2023-03-12','2024-12-11','2025-02-12',2),
('P322','Bitmiw','2021-03-12','2022-12-11','2022-02-12',3)



INSERT INTO Students VALUES
('2000-05-06','74FF37','AZE1781232345',2,4),
('1998-01-02','74FF2237','AZE178123232345',3,3)


SELECT * FROM Educations
SELECT * FROM FormEduPrograms
SELECT * FROM Syllabus
SELECT * FROM Topic
SELECT * FROM SyllabusTopic
SELECT * FROM EduProgramms
SELECT * FROM GroupStatus
SELECT * FROM Groups
SELECT * FROM EduType
SELECT * FROM Candidate
SELECT * FROM Students
SELECT * FROM Mentors
SELECT * FROM GroupMentor