--2.1
declare @a float,@b float
set @a = 5
set @b = 10
print concat(@a,' + ',@b,' = ', @a+@b)
print concat(@a,' - ',@b,' = ', @a-@b)
print concat(@a,' * ',@b,' = ', @a*@b)
print concat(@a,' / ',@b,' = ', 1.0*@a/@b)

--2.2
declare @cdate date,@quy int
set @cdate = GETDATE()
set @quy = month(@cdate)/3

print concat(N'Tháng hiện tại là: ',month(@cdate),N'; Quý của tháng hiện tại là: Quý ',@quy,'.')

--2.3
declare @i int = 2
declare @n int = 5
declare @s1 int = 1
declare @s2 float = 1
while(@i <= @n)
begin
	set @s1 = @s1 + @i
	set @s2 = @s2 + 1.0*1/@i
	set @i = @i + 1
end
print concat('S1 = ',@s1)
print concat('S2 = ',@s2)

--2.4
DECLARE @noisinh nvarchar(250) = N'Huế'
DECLARE @masinhvien nvarchar(10)
DECLARE @hodem nvarchar(45)
DECLARE @ten nvarchar(15)
DECLARE @ngaysinh date

SELECT top 1 @masinhvien = MaSinhVien,
       @hodem = HoDem,
       @ten = Ten,
       @ngaysinh = NgaySinh
FROM SINHVIEN
WHERE NoiSinh LIKE '%' + @noisinh + '%'

SELECT @masinhvien as masv,
       @hodem as hodem,
       @ten as ten,
       @ngaysinh as ngaysinh

--2.5
--a
declare @v_sinhvien table(
		 v_masinhvien nvarchar(10),
		 v_malop nvarchar(15),
		 v_hodem nvarchar(45),
		 v_ten nvarchar(15),
		 v_ngaysinh date,
		 v_gioitinh bit,
		 v_noisinh nvarchar(250)
)
insert into @v_sinhvien(v_masinhvien,v_malop,v_hodem,v_ten,v_ngaysinh,v_gioitinh,v_noisinh)
select * 
from SINHVIEN
where MONTH(NgaySinh) between 1 and 6
select *
from @v_sinhvien

--b
select *
from @v_sinhvien
where v_hodem like N'Nguyễn%' or YEAR(v_ngaysinh) = 1991

--c
update @v_sinhvien
set v_noisinh = N'TP Huế'
where v_masinhvien like '%03'
select *
from @v_sinhvien

--d
delete @v_sinhvien
where v_hodem like N'%Thị%'
select *
from @v_sinhvien

--2.6
create table #v_sinhvien_KD(
		 v_masinhvien nvarchar(10),
		 v_malop nvarchar(15),
		 v_hodem nvarchar(45),
		 v_ten nvarchar(15),
		 v_ngaysinh date,
		 v_gioitinh bit,
		 v_noisinh nvarchar(250)
)

--a
insert into #v_sinhvien_KD(v_masinhvien,v_malop,v_hodem,v_ten,v_ngaysinh,v_gioitinh,v_noisinh)
select * 
from SINHVIEN
where masinhvien like N'KD%' or gioitinh = 1
select *
from #v_sinhvien_KD

--b
select *
from #v_sinhvien_KD
where v_noisinh like N'%Huế' or v_hodem not like N'Nguyễn%'
--c
update #v_sinhvien_KD
set v_noisinh = N'Quảng Bình'
where v_hodem like 'Lê%'
select *
from #v_sinhvien_KD

--d
delete #v_sinhvien_KD
where v_masinhvien like N'%01'
select *
from #v_sinhvien_KD


















--Tường minh: Bảng được khai báo rõ ràng, tồn tại lâu dài, dùng CREATE TABLE.
--Không tường minh: Bảng tạm thời, chỉ tồn tại trong thời gian phiên làm việc, dùng DECLARE với TABLE hoặc CREATE TABLE với bảng tạm (#).