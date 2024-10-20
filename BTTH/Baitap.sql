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

--D Trigger
--D1
create trigger bosung_nv on NhanVien
after insert
as
begin
	declare @manv nvarchar(10)
	select @manv = manhanvien 
	from inserted
	insert into THUNHAP_NV(MaNhanVien,HeSo,PhuCap)
	values(@manv,0.0,0)
end
-- Disable the foreign key constraint temporarily
alter table NHANVIEN nocheck constraint FK_THUNHAP_NV_NHANVIEN

insert into NHANVIEN(MaNhanVien,HoDem,Ten,NgaySinh,GioiTinh,DiaChi,MaPhong,MaPhanXuong)
values(N'22T1020763',N'Tiến',N'Pro','1997-11-17',1,N'TP Huế','NV','A1')
select *
from NHANVIEN
select * 
from THUNHAP_NV
drop trigger bosung_nv

--D2
create trigger Trg_Update_Phucap on THUNHAP_NV
for update
as
begin
	declare @mnv nvarchar(10)
	declare @hsl_cu decimal(3,2)
	declare @hsl_moi decimal(3,2)
	select @hsl_cu = HeSo
	from THUNHAP_NV
	select @hsl_moi = HeSo,@mnv = MaNhanVien
	from inserted 
	update THUNHAP_NV
	set PhuCap = Phucap +( ( @hsl_moi- @hsl_cu ) * 100000)
	where MaNhanVien = @mnv
end

update THUNHAP_NV
set HeSo = 5.0
where MaNhanVien = '1240210017'
select * from THUNHAP_NV
drop trigger Trg_Update_PhuCap



--D3
create trigger Trg_ThuNhap_Update_PhuCap on ThuNhap_NV
for update
as
begin
	declare @mnv nvarchar(10)
	declare @hsl_cu decimal(3,2)
	declare @hsl_moi decimal(3,2)
	select @hsl_cu = HeSo
	from THUNHAP_NV
	select @hsl_moi = HeSo,@mnv = MaNhanVien
	from inserted 
	update THUNHAP_NV
	set PhuCap = ( ( @hsl_moi- @hsl_cu ) * 100000)
	where HeSo = @hsl_moi
end 
select * from THUNHAP_NV
update THUNHAP_NV
set HeSo = 3.0
where MaNhanVien = '1240210017'
drop trigger Trg_ThuNhap_Update_PhuCap

--D4
create trigger Trg_xoa_nhanvien on nhanvien 
for delete
as
begin
	delete NHANVIEN
	where MaNhanVien in (select MaNhanVien from deleted)
end
delete NHANVIEN
where MaNhanVien = '1240210007'
delete THUNHAP_NV
where MaNhanVien = '1240210008'
drop trigger Trg_xoa_nhanvien
select * from NHANVIEN
select * from THUNHAP_NV

--D5
exec sp_helptext Trg_update_phucap

--D6
drop trigger Trg_update_phucap
