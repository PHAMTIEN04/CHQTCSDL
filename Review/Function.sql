--C Function
--C1
create function Fn_DemSoNhanVien(@Maphong nvarchar(3))
returns int
as
begin
	declare @dem int
	select @dem = COUNT(*)
	from Phong p left join NHANVIEN nv
	on p.MaPhong = nv.MaPhong
	where p.MaPhong = @Maphong
	group by p.MaPhong, p.TenPhong
	return @dem

end
select dbo.FN_DEMSONHANVIEN(N'NV') as N'Đếm số nhân viên'  
drop function FN_Demsonhanvien
--C2
create function Fn_DemSoNhanVienPX(@maphanxuong nvarchar(3))
returns int
as
begin
	declare @dem int
	select @dem = COUNT(*)
	from PHANXUONG px left join NHANVIEN nv
	on px.MaPhanXuong = nv.MaPhanXuong
	where px.MaPhanXuong = @maphanxuong
	group by px.maphanxuong, px.tenphanxuong
	return @dem
end
select dbo.FN_DEMSONHANVIENPX(N'A1') as N'Đếm số nhân viên'  
drop function FN_DemsonhanvienPX

--C3
create function Fn_Luong_Phong(@maphong nvarchar(3))
returns decimal
as
begin
	declare @tongluong decimal
	select @tongluong =Sum(tnv.heso * 1600000)
	from Phong p left join Nhanvien nv
	on p.maphong = nv.maphong inner join
	ThuNhap_NV tnv on nv.MaNhanVien = tnv.Manhanvien
	where p.maphong = @maphong
	group by p.maphong,p.tenphong
	
	return @tongluong

end
select dbo.Fn_Luong_Phong(N'NV') as N'Tổng Lương'
drop function Fn_Luong_Phong

--C4
create function Fn_NhanVien_NamSinh(@NamSinh int)
returns int
as
begin
	declare @dem int
	select @dem = Count(*)
	from NhanVien
	where Year(ngaysinh) = @NamSinh
	return @dem

end
select dbo.Fn_NhanVien_NamSinh(2000) as N'Nhân viên có năm sinh'
drop function Fn_NhanVien_NamSinh
--C5
alter function Fn_NhanVien_NamSinh(@NamSinh int,@gioitinh bit = 1)
returns int
as
begin
	declare @dem int
	select @dem = Count(*)
	from NhanVien
	where Year(ngaysinh) = @NamSinh and gioitinh = @gioitinh
	return @dem
end
select dbo.Fn_NhanVien_NamSinh(2000,0) as N'Nhân viên có năm sinh'
--C6
create function Fn_NhanVien_Phong(@Maphong nvarchar(3))
returns table
as
	return(select *
			from NHANVIEN
			where Maphong = @Maphong)

select *
from dbo.Fn_NhanVien_Phong(N'PGD')
drop function Fn_NhanVien_Phong
--C7
create function Fn_NhanVien_DiaChi(@DiaChi nvarchar(250))
returns table
as
	return(select *
			from NHANVIEN
			where Diachi = @DiaChi)

select * from dbo.Fn_NhanVien_DiaChi(N'Đà Nẵng')
drop function Fn_NhanVien_DiaChi

--C8
create function Fn_SoNhanVien_Phong(@Maphong nvarchar(3))
returns table
as
	return(select p.maphong,p.tenphong,Count(*) as N'Tổng số nhân viên'
			from Phong p left join NHANVIEN nv
			on p.maphong = nv.maphong
			where p.maphong = @Maphong
			group by p.maphong,p.tenphong
			)

select *
from dbo.Fn_SoNhanVien_Phong(N'NV')
drop function Fn_SoNhanVien_Phong

--C9
create function Fn_Luong_NV(@Manv nvarchar(10))
returns table
as
	return(select nv.MaNhanVien,(nv.hodem + ' ' + nv.ten) as N'Họ Tên',nv.ngaysinh,nv.gioitinh,tnv.heso,
			case
			when nv.gioitinh = 1 then (tnv.HeSo * 1600000)+tnv.PhuCap
			when nv.GioiTinh = 0 then (tnv.HeSo * 1600000)+tnv.PhuCap + 500000
			End as N'Lương'
			from ThuNhap_NV tnv join NhanVien nv
			on tnv.manhanvien = nv.manhanvien
			where nv.manhanvien = @manv)
select *
from dbo.Fn_Luong_NV(N'1240210003')
drop function Fn_Luong_Nv
--C10
exec Sp_helptext Fn_Luong_NV
--C10
drop function FN_Luong_NV