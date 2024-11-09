--A T-SQL
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

--a)
insert into @v_nhanvien
select *
from NHANVIEN 
where (hodem like N'% Thị %' or hodem like N'% Thị') and year(ngaysinh)= 1992

select * from @v_nhanvien

--b)
update @v_nhanvien
set DiaChi = N'TP Huế'
where MaPhanXuong is null

select * from @v_nhanvien

--c)
update @v_nhanvien
set MaPhong = null
where MaPhanXuong like N'A%'


select * from @v_nhanvien

--d)
delete @v_nhanvien
where Month(ngaysinh) between 1 and 3

select * from @v_nhanvien

--A2
--a
select * into #v_nhanvien_Hue
from NHANVIEN
where DiaChi = N'TT Huế'
select * from #v_nhanvien_Hue
drop table #v_nhanvien_Hue
--b
update #v_nhanvien_Hue
set Maphong = N'TC'
where MONTh(ngaysinh) between 5 and 9

select * from #v_nhanvien_Hue

--c
delete #v_nhanvien_Hue
where gioitinh = 1 or (hodem like N'Lê %' or hodem = N'Lê')

select * from #v_nhanvien_Hue