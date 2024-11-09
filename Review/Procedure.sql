--B Procedure
--B1
create proc hienthi_thongtin_nhanvien(@maphong nvarchar(3))
as
begin
	select MaNhanVien,HoDem,Ten,NgaySinh,MaPhong
	from NHANVIEN
	where MaPhong = @maphong
end

exec hienthi_thongtin_nhanvien @maphong=N'TC'

--B2
create proc hienthi_hsl_caonhat(@n int)
as
begin
	select Top (@n) tnv.MaNhanVien,nv.HoDem,nv.Ten,nv.NgaySinh,tnv.HeSo
	from THUNHAP_NV tnv inner join NHANVIEN nv
	on tnv.MaNhanVien = nv.MaNhanVien
end

exec hienthi_hsl_caonhat @n = 1

--B3
create proc tongsonhanvien_pb(@mapb nvarchar(3))
as
begin
	select p.MaPhong,p.TenPhong,Count(*) as N'Tổng số nhân viên'
	from PHONG p left join NHANVIEN nv
	on p.MaPhong = nv.MaPhong
	where p.MaPhong = @mapb
	group by p.MaPhong,p.TenPhong

end

exec tongsonhanvien_pb @mapb = N'NV'

--B4
create proc tongtienluong_pb(@mapb nvarchar(3))
as
begin
	select p.MaPhong,p.TenPhong,Sum(tnv.HeSo * 1600000) as N'Tổng tiền lương'
	from Phong p left join NHANVIEN nv
	on p.MaPhong = nv.MaPhong inner join THUNHAP_NV tnv
	on nv.MaNhanVien = tnv.MaNhanVien
	where p.MaPhong = @mapb
	group by p.MaPhong,p.TenPhong
	
end

exec tongtienluong_pb @mapb = N'PGD'

--B5
create proc Sp_Nhanvien_ThangSinh(@x int =1,@y int =12)
as
begin
	select * 
	from NHANVIEN
	where Month(NgaySinh) between @x and @y
end

exec Sp_Nhanvien_ThangSinh @x=5,@y=10

--B6
alter proc Sp_Nhanvien_ThangSinh(@x int =1,@y int =12 ,@namsinh int = 1992)
as
begin
	select * 
	from NHANVIEN
	where (Month(NgaySinh) between @x and @y) and YEAR(NgaySinh) = @namsinh
end
exec Sp_Nhanvien_ThangSinh
--b7
create proc hienthi_hsl(@x decimal(3, 2),@y decimal(3, 2))
as
begin
	select nv.MaNhanVien, nv.HoDem, nv.Ten,nv.NgaySinh,tnv.HeSo,(tnv.HeSo*1600000)+tnv.PhuCap as N'Lương'
	from NHANVIEN nv inner join THUNHAP_NV tnv
	on nv.MaNhanVien = tnv.MaNhanVien
	where tnv.HeSo between @x and @y

end

exec hienthi_hsl @x=0.0,@y=3.0

--b8
create proc tongsonhanvien_pb_n(@n int)
as
begin
	select p.MaPhong,p.TenPhong,Count(*) as N'Tổng số nhân viên'
	from PHONG p left join NHANVIEN nv
	on p.MaPhong = nv.MaPhong
	group by p.MaPhong,p.TenPhong
	having Count(*) > @n

end

exec tongsonhanvien_pb_n @n=5
--b9
create proc bosung_nv(@mnv nvarchar(10),@hd nvarchar(45),@ten nvarchar(15),@ns date,@gt bit,@dc nvarchar(250),@mp nvarchar(3),@mpx nvarchar(3))
as
begin
	if exists(select 1 from NHANVIEN where MaNhanVien = @mnv)
		return
	if not exists(select 1 from Phong where MaPhong = @mp )
		return
	if not exists(select 1 from PHANXUONG where MaPhanXuong = @mpx) 
		return
	insert into THUNHAP_NV(MaNhanVien,HeSo,PhuCap)
	values(@mnv,0,0)
	insert into NHANVIEN(MaNhanVien,HoDem,Ten,NgaySinh,GioiTinh,DiaChi,MaPhong,MaPhanXuong)
	values(@mnv,@hd,@ten,@ns,@gt,@dc,@mp,@mpx)

end
drop proc dbo.bosung_nv
select * from NHANVIEN
select * from PHONG
select * from PHANXUONG
select * from THUNHAP_NV
exec bosung_nv @mnv =N'14T1020765', @hd =N'Phạm Phước',@ten =N'An',@ns='2004-11-17' ,@gt=1,@dc=N'TT Huế',@mp='NV',@mpx='A1'
--B10
create proc tongsonv_mpx(@mpx nvarchar(3))
as
begin
	if not exists(select 1 from PHANXUONG where MaPhanXuong = @mpx)
		begin
		print N'Mã phân xưởng không tồn tại'
		return
		end
	select px.MaPhanXuong,px.TenPhanXuong,Count(*) as N'Tổng số nhân viên'
	from PHANXUONG px left join NHANVIEN nv
	on px.MaPhanXuong = nv.MaPhanXuong
	where px.MaPhanXuong = @mpx
	group by px.MaPhanXuong,px.TenPhanXuong
end
drop proc tongsonv_mpx
exec tongsonv_mpx @mpx=N'A11'

--b11
exec sp_helptext Sp_Nhanvien_thangsinh

--b12
drop proc Sp_Nhanvien_ThangSinh