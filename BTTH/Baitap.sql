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

--B Thủ tục
--B1
create proc hienthi_nhanvien_mp(@maphong nvarchar(3))
as
begin
	select MaNhanVien,HoDem,Ten,NgaySinh,MaPhong
	from NhanVien
	where MaPhong = @maphong
end

exec hienthi_nhanvien @maphong = N'TC'

--B2
create proc hienthi_nhanvien_hsl(@n int)
as
begin
	select Top (@n) nv.MaNhanVien,nv.HoDem,nv.Ten,nv.NgaySinh,tn.HeSo
	from THUNHAP_NV tn left join NHANVIEN nv on tn.MaNhanVien = nv.MaNhanVien
	order by tn.HeSo desc,nv.NgaySinh desc
end
exec hienthi_nhanvien_hsl @n = 10

--B3
create proc tongnhanvien_pb(@mpb nvarchar(3))
as
begin
	select p.MaPhong,p.TenPhong,count(*) as N'Tổng số nhân viên'
	from PHONG p left join NHANVIEN nv on p.MaPhong = nv.MaPhong
	where p.MaPhong = @mpb
	group by P.MaPhong,p.TenPhong
end	

exec tongnhanvien_pb @mpb=N'NV'
drop proc tongnhanvien_pb
--B4
create proc tongtienluong_pb(@mpb nvarchar(3))
as
begin
	select p.MaPhong,p.TenPhong, SUM(tn.HeSo * 1600000) as N'Tổng Tiền Lương'
	from PHONG p left join NHANVIEN nv on p.MaPhong = nv.MaPhong
	join THUNHAP_NV tn on nv.MaNhanVien = tn.MaNhanVien
	where p.MaPhong = @mpb
	group by p.MaPhong,p.TenPhong
	
end
drop proc tongtienluong_pb
exec dbo.tongtienluong_pb @mpb=N'NV'

--B5
create proc Sp_Nhanvien_ThangSinh(@x int = 1,@y int = 12)
as
begin
	if @x > @y 
		return
	select *
	from NHANVIEN
	where MONTH(ngaysinh) between @x and @y

end

exec Sp_Nhanvien_ThangSinh 
drop proc Sp_Nhanvien_ThangSinh
--B6
create proc Sp_Nhanvien_ThangSinh(@namsinh int = 1992,@x int = 1,@y int = 12)
as
begin
	if @x > @y 
		return
	select *
	from NHANVIEN
	where (MONTH(ngaysinh) between @x and @y) and Year(NgaySinh) = @namsinh

end

exec Sp_Nhanvien_ThangSinh 

--B7
create proc nhanvien_hsl(@x decimal(3, 2),@y decimal(3, 2))
as
begin
	select nv.MaNhanVien,nv.HoDem,nv.Ten,nv.NgaySinh,tn.HeSo,(tn.HeSo * 1600000 + tn.PhuCap) as N'Lương'
	from NHANVIEN nv join THUNHAP_NV tn on nv.MaNhanVien = tn.MaNhanVien
	where tn.HeSo between @x and @y
end
exec  nhanvien_hsl @x =3.0 ,@y = 3.0

--B8
create proc tongnhanvien_tung_pb(@n int)
as
begin
	select p.MaPhong,p.TenPhong,count(*) as N'Tổng số nhân viên'
	from PHONG p left join NHANVIEN nv on p.MaPhong = nv.MaPhong
	group by P.MaPhong,p.TenPhong
	having count(*) > @n
end	
drop proc tongnhanvien_tung_pb
exec tongnhanvien_tung_pb @n=10