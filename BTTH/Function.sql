--C Hàm(Function)
--c1
create function Fn_DemSoNhanVien(@maphong nvarchar(3))
returns int
as
begin
	declare @sosv int
	select @sosv= Count(nv.MaNhanVien)
	from PHONG p left join NHANVIEN nv
	on p.MaPhong = nv.MaPhong
	where p.MaPhong = @maphong
	group by p.MaPhong
	return @sosv 
end

select dbo.Fn_DemSoNhanVien(N'PGD') as N'Số sinh viên'
--c2
create function Fn_DemSoNhanVienPX(@maphanxuong nvarchar(3))
returns int
as
begin
	declare @sosv int
	select @sosv= Count(nv.MaNhanVien)
	from PHANXUONG px left join NHANVIEN nv
	on px.MaPhanXuong = nv.MaPhanXuong
	where px.MaPhanXuong = @maphanxuong
	group by px.MaPhanXuong
	return @sosv 
end
select dbo.Fn_DemSoNhanVienPX(N'A1') as N'Số sinh viên'

--c3
create function Fn_Luong_Phong(@maphong nvarchar(3))
returns decimal(15,1)
as 
begin
	declare @luong decimal(15,1)
	select @luong = SUM(tn.HeSo * 1600000)
	from Phong p left join Nhanvien nv on p.MaPhong = nv.MaPhong 
	join THUNHAP_NV tn on nv.MaNhanVien = tn.MaNhanVien
	where p.MaPhong = @maphong
	group by p.MaPhong
	return @luong
end

select dbo.Fn_Luong_Phong(N'TC') as N'Tổng tiền lương'

--C4
create function Fn_NhanVien_NamSinh(@namsinh int)
returns int
as
begin
	declare @tong int
	select @tong = Count(*)
	from NHANVIEN
	where YEAR(NgaySinh) = @namsinh
	return @tong
end

select dbo.Fn_NhanVien_NamSinh(1992) as N'Tổng năm sinh'
--C5
alter function Fn_NhanVien_NamSinh(@namsinh int,@gioitinh bit = 1)
returns int
as
begin
	declare @tong int
	select @tong = Count(*)
	from NHANVIEN
	where YEAR(NgaySinh) = @namsinh and GioiTinh =@gioitinh
	return @tong
end
select dbo.Fn_NhanVien_NamSinh(2004,0)
--C6
create function Fn_NhanVien_Phong(@maphong nvarchar(3))
returns table
as
	return(
		select *
		from NHANVIEN
		where MaPhong = @maphong
	)

select * 
from dbo.Fn_NhanVien_Phong(N'NV')

--C7
create function Fn_NhanVien_DiaChi(@diachi nvarchar(250))
returns table
as
	return(
		select *
		from NHANVIEN
		where DiaChi = @diachi
	)
select *
from dbo.Fn_NhanVien_DiaChi(N'TT Huế')
--C8
create function Fn_Sonhanvien_Phong(@maphong nvarchar(3))
returns table
as
	return(
		select p.MaPhong,p.TenPhong,COUNT(nv.MaNhanVien) as N'Tổng số nhân viên'
		from PHONG p left join NHANVIEN nv 
		on p.MaPhong = nv.MaPhong
		where p.MaPhong = @maphong
		group by p.MaPhong,p.TenPhong
	)

select *
from dbo.Fn_Sonhanvien_Phong(N'PGD')

--C9
create function Fn_Luong_NV(@manv nvarchar(10))
returns table
as
	return(
		select nv.MaNhanVien,concat(nv.HoDem,' ',nv.Ten)as N'Họ Tên',nv.NgaySinh,nv.GioiTinh,tn.HeSo,
			case 
			when nv.gioitinh = 1 then tn.HeSo *1600000 + tn.phucap
			when nv.gioitinh = 0 then tn.Heso *1600000 + tn.phucap + 500000
			end as N'Lương'
		from NHANVIEN nv join THUNHAP_NV tn
		on nv.MaNhanVien = tn.MaNhanVien
		where nv.MaNhanVien = @manv
	)

select *
from dbo.Fn_Luong_NV(N'11D4021169')

--C10
exec sp_helptext Fn_Luong_NV

--C11
drop function Fn_Sonhanvien_Phong
