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

--B9
create proc bosung_nhanvien(@MaNhanVien nvarchar(10),
							@HoDem nvarchar(45),
							@Ten nvarchar(15),
							@NgaySinh date,
							@GioiTinh bit,
							@DiaChi nvarchar(250),
							@MaPhong nvarchar(3),
							@MaPhanXuong nvarchar(3))
as
begin
	if exists(select 1 from NHANVIEN where manhanvien = @manhanvien)
		return
	if not exists(select 1 from PHONG where MaPhong = @MaPhong)
		return
	if not exists(select 1 from PHANXUONG where maphanxuong = @maphanxuong)
		return
	insert into ThuNhap_NV(MaNhanVien,HeSo,PhuCap)
	values(@MaNhanVien,0,0)
	insert into NHANVIEN(MaNhanVien,HoDem,Ten,NgaySinh,GioiTinh,DiaChi,MaPhong,MaPhanXuong)
	values(@MaNhanVien,@HoDem,@Ten,@NgaySinh,@GioiTinh,@DiaChi,@MaPhong,@MaPhanXuong)

end
drop proc bosung_nhanvien
exec bosung_nhanvien @manhanvien =N'14T1020763', @hodem =N'Phạm Phước',@ten =N'Tiến',@ngaysinh='2004-11-17' ,@gioitinh=1,@diachi=N'TT Huế',@maphong='NV',@maphanxuong='A1'
select * 
from NHANVIEN
select * 
from THUNHAP_NV

delete from dbo.THUNHAP_NV
where MaNhanVien = N'14T1020763'

delete from dbo.NHANVIEN
where MaNhanVien = N'14T1020763'

--B10
create proc tongnhanvien_px(@mpx nvarchar(3))
as
begin
	if not exists(select 1 from PHANXUONG where maphanxuong = @mpx)
		begin
			print N'Mã phân xưởng không tồn tại'
			return
		end
	select px.MaPhanXuong,px.TenPhanXuong,Count(nv.MaNhanVien) as N'Tổng số nhân viên' 
	from PHANXUONG px left join NHANVIEN nv on px.MaPhanXuong = nv.MaPhanXuong
	where px.MaPhanXuong = @mpx
	group by px.MaPhanXuong,px.TenPhanXuong
end

exec tongnhanvien_px @mpx = N'X3'
select *
from NHANVIEN
drop proc tongnhanvien_px

--B11
exec sp_helptext Sp_Nhanvien_ThangSinh 
--B12

drop proc Sp_Nhanvien_ThangSinh 
--3.16
alter proc proc_TK_SV_ThangSinh(@tuthang int,@denthang int)
as
begin
	if (@TuThang > @DenThang or @TuThang < 1 or @TuThang > 12 or @DenThang < 1 or @DenThang > 12)
		return
	declare @tb table(thang int,
						tong int
						)
	declare @i int = @tuthang
	while @i <= @denthang
		begin
			declare @tt int
			select @tt = Count(*)
			from NhanVien
			Where MONTH(ngaysinh) = @i

			insert into @tb(thang,tong) values(@i,@tt)
			set @i = @i + 1
		end
	select *
	from @tb
end

exec proc_TK_SV_ThangSinh @tuthang= 1,@denthang=12

select * from nhanvien

--3.18
create proc proc_TK_SV_NgaySinh_Lop(@tungay date,@denngay date,@maphong nvarchar(3))
as
begin
	if @tungay > @denngay
		return

	declare @tb table (
						ngay date,
						tong int
						)
	declare @i date = @tungay
	while @i <= @denngay
		begin
			declare @tt int
			select @tt = Count(*)
			from NHANVIEN
			where NgaySinh = @i and MaPhong = @maphong

			insert into @tb(ngay,tong) values(@i,@tt)
			set @i = DATEADD(DAY,1,@i)
		end
	select *
	from @tb

end

exec proc_TK_SV_NgaySinh_Lop @tungay='1997-11-17',@denngay='2000-01-01' ,@maphong=N'NV'