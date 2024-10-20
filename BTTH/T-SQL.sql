--A	Câu lệnh T-SQL
--A1
declare @v_nhanvien table(
		MaNhanVien nvarchar(10),
		HoDem nvarchar(45),
		Ten nvarchar(15),
		NgaySinh date,
		GioiTinh bit,
		DiaChi nvarchar(250),
		MaPhong nvarchar(3),
		MaPhanXuong nvarchar(3)
)
--a
insert into @v_nhanvien
select *
from NHANVIEN
where (HoDem like N'% Thị %' or hodem like N'% Thị')and YEAR(ngaysinh) = 1992

select *
from @v_nhanvien
--b
update @v_nhanvien
set DiaChi = N'TP Huế'
where MaPhanXuong is null

select *
from @v_nhanvien
--c
update @v_nhanvien
set MaPhong = null
where MaPhanXuong like 'A%'
 
 select *
from @v_nhanvien
--d
delete from @v_nhanvien where MONTH(NgaySinh) between 1 and 3

select *
from @v_nhanvien

--A2
--a


select * into #v_nhanvien_Hue
from NHANVIEN
where DiaChi = N'TT Huế'

select *
from #v_nhanvien_Hue

--b
update #v_nhanvien_Hue
set MaPhong = N'TC'
where MONTH(ngaysinh) between 5 and 9

select *
from #v_nhanvien_Hue


--c
delete from #v_nhanvien_Hue
where GioiTinh = 1 or (HoDem like N'Lê %' or HoDem =N'Lê')
select *
from #v_nhanvien_Hue
