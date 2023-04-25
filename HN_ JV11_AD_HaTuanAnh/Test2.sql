create database test2;
use test2;
create table Students(
	StudentID int primary key,
    StudentName varchar(50),
    age int,
    email varchar(100)
);
create table Classes(
	ClassID int primary key,
    ClassName varchar(50)
);
create table ClassStudent(
	StudentID int,
    ClassID int,
    foreign key (StudentID) references Students(StudentID),
    foreign key (ClassID) references Classes(ClassID)
);
create table Subjects(
	SubjectID int primary key,
    SubjectName varchar(50)
);
create table Marks(
	Mark  int,
    SubjectID int,
    StudentID int,
    foreign key (SubjectID) references Subjects(SubjectID),
    foreign key (StudentID) references Students(StudentID)
);
insert into students values
(1,"Nguyen Quang An",18,"an@yahoo.com"),
(2,"Nguyen Cong Vinh",20,"vinh@gmail.com"),
(3,"Nguyen Van Quyen",19,"quyen"),
(4,"Pham Thanh Binh",25,"binh@com"),
(5,"Nguyen Van Tai Em",30,"taiem@sport.vn");
select * from Marks;
insert into classes values(1,"C0706L"),(2,"C0708G");
insert into ClassStudent values(1,1),(2,1),(3,2),(4,2),(5,2);
insert into Subjects values(1,"SQL"),(2,"Java"),(3,"C"),(4,"Visua Basic");
insert into Marks values(8,1,1),(4,2,1),(9,1,1),(7,1,3),(3,1,4),(5,2,5),(8,3,3),(1,3,5),(3,2,4);

-- 1. Hien thi danh sach tat ca cac hoc vien
select *from Students;
-- 2. Hien thi danh sach tat ca cac mon hoc
select *from Subjects;
-- 3. Tinh diem trung binh
select  s.StudentName, avg(mark) as "Điểm trung bình"
from Students s join Marks m on s.StudentId=m.StudentID group by s.StudentId;
-- 4. Hien thi mon hoc nao co hoc sinh thi duoc diem cao nhat
select * from Subjects s join Marks m on s.subjectId=m.subjectId where m.mark = (select max(mark) from marks);
-- 5. Danh so thu tu cua diem theo chieu giam
select (select @stt:=@stt+1) as `stt`,m.* from (select @stt:=0) r , marks m order by m.mark desc;
-- 6. Thay doi kieu du lieu cua cot SubjectName trong bang Subjects thanh
-- nvarchar(max)
alter table Subjects modify SubjectName nvarchar(255);
-- 7. Cap nhat them dong chu « Day la mon hoc « vao truoc cac ban ghi tren cot
-- SubjectName trong bang Subjects
select*from Subjects;
update Subjects set SubjectName = concat("Đây là môn học ",SubjectName);
-- 8. Viet Check Constraint de kiem tra do tuoi nhap vao trong bang Student yeu
-- cau Age >15 va Age < 50
alter table Students add constraint checkAge check(Age > 15 and Age < 50);
-- 9. Loai bo tat ca quan he giua cac bang
alter table Marks drop foreign key marks_ibfk_1;
alter table Marks drop foreign key marks_ibfk_2;
alter table classstudent drop foreign key classstudent_ibfk_1;
alter table classstudent drop foreign key classstudent_ibfk_2;
-- 10.Xoa hoc vien co StudentID la 1
delete from students where StudentID = 1;
select*from students;
-- 11.Trong bang Student them mot column Status co kieu du lieu la Bit va co gia
-- tri Default la 1
alter table Students add column `Status` bit default 1;
-- 12.Cap nhap gia tri Status trong bang Student thanh 0
update Students set `Status` = 0;
