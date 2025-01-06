select * from NhanVien
select * from DuAn
select * from NhanVien_DuAn

--cau2
alter trigger trg_NhanVien_DuAn_Insert on NhanVien_DuAn
for insert
as
begin
	update DuAn
	set SoNguoiThamGia = SoNguoiThamGia + (select count(*)
										   from inserted i
										   where i.MaDuAn = d.MaDuAn)
	from DuAn d left join inserted i
	on d.MaDuAn = i.MaDuAn

end
insert into NhanVien_DuAn(MaNhanVien,MaDuAn,NgayGiaoViec,MoTaCongViec)
values('NV001','DA002','2000-01-01','Play Game'),('NV001','DA003','2000-01-01','Play Game'),('NV002','DA002','2000-01-01','Play Game')

--cau3
--a
create proc proc_NhanVien_DuAn_Insert(@MaNhanVien nvarchar(50),
									  @MaDuAn nvarchar(50),
									  @MoTaCongViec nvarchar(255),
									  @KetQua nvarchar(255) output)
as
begin
	if not exists(select 1 from NhanVien where MaNhanVien =@MaNhanVien)
	begin
		set @KetQua = N'Nhan vien khong ton tai'
		return
	end
	if not exists(select 1 from DuAn where MaDuAn =@MaDuAn)
	begin
		set @KetQua = N'Du an khong ton tai'
		return
	end
	if exists(select 1 from NhanVien_DuAn where MaNhanVien =@MaNhanVien and MaDuAn=@MaDuAn)
	begin
		set @KetQua = N'Nhan vien du an da ton tai'
		return
	end
	insert into NhanVien_DuAn(MaNhanVien,MaDuAn,NgayGiaoViec,MoTaCongViec)
	values(@MaNhanVien,@MaDuAn,getdate(),@MoTaCongViec)
	set @KetQua = ''
end
declare @kq nvarchar(255) 
exec proc_NhanVien_DuAn_Insert @manhanvien='NV001',@maduan='DA001',@motacongviec=N'Play Game',@KetQua=@kq output
select @kq as ketqua
--b
create proc proc_DuAn_DanhSachNhanVien(@TenDuAn nvarchar(255),
									   @NgayGiaoViec date)
as
begin
	select nv.MaNhanVien,nv.HoTen,nv.Email,nv.DiDong,nvda.NgayGiaoViec,nvda.NgayGiaoViec 
	from NhanVien nv left join NhanVien_DuAn nvda
	on nv.MaNhanVien = nvda.MaNhanVien inner join DuAn da
	on nvda.MaDuAn = da.MaDuAn
	where da.TenDuAn=@TenDuAn and NgayGiaoViec <@NgayGiaoViec
end
exec proc_DuAn_DanhSachNhanVien @tenduan ='LiteCMS',@ngaygiaoviec = '2026-01-01'
--c
alter proc proc_NhanVien_TimKiem(@trang int = 1,
								  @SoDongMoiTrang int = 20,
								  @HoTen nvarchar(50) = N'',
								  @Tuoi int,
								  @SoLuong int output)
as
begin
	declare @from int
	set @from = (@trang-1)*@SoDongMoiTrang
	if @HoTen = N''
	begin
		select *
		from NhanVien
		where year(getdate()) - year(ngaysinh) >=@Tuoi
		order by MaNhanVien
		offset @from rows
		fetch next @sodongmoitrang rows only
		set @SoLuong = @@ROWCOUNT
		return
	end
		select *
		from NhanVien
		where HoTen like '%' + @HoTen + '%' and year(getdate()) - year(ngaysinh) >=@Tuoi
		order by MaNhanVien
		offset @from rows
		fetch next @sodongmoitrang rows only
		set @SoLuong = @@ROWCOUNT
end
declare @sl int
exec proc_NhanVien_TimKiem @trang=1,@sodongmoitrang=1,@hoten='',@tuoi=40,@soluong=@sl output
select @sl as soluong

--D
alter proc proc_ThongKeGiaoViec(@MaDuAn nvarchar(50),
								 @TuNgay date,
								 @DenNgay date)
as
begin
	if @TuNgay > @DenNgay
	begin
		return
	end
	declare @tb table(ngay date,
					  sl int)
	declare @i date = @tungay
	while @i <= @DenNgay
	begin
		declare @tt int
		select @tt = count(*)
		from NhanVien_DuAn
		where NgayGiaoViec = @i
		insert into @tb(ngay,sl)
		values(@i,@tt)
		set @i = DATEADD(day,1,@i)
	end
	select *
	from @tb

end
exec proc_ThongKeGiaoViec @maduan= 'NV001',@tungay='2025-01-06',@denngay='2025-01-07'
select *
from DuAn

--Cau4
--a
create function func_TkeDuAn(@tunam int,
							 @dennam int)
returns table
as
	return(select YEAR(ngaybatdau)as nam,Count(*) as sl
		   from DuAn
		   where YEAR(ngaybatdau) between @tunam and @dennam
		   group by YEAR(ngaybatdau))

select * from dbo.func_TkeDuAn(2022,2023)

--b
create function func_TkeDuAn_DayDuCacNam(@tunam int,
										 @dennam int)
returns @tke table(nam int,
				   sl int)
as
begin
	if @tunam > @dennam
	begin
		return
	end
	declare @i int = @tunam
	while @i <= @dennam
	begin
		declare @tt int
		select @tt = count(*)
		from DuAn
		where year(NgayBatDau) = @i
		insert into @tke(nam,sl)
		values(@i,@tt)
		set @i = @i +1
	end
	return

end
select *
from func_TkeDuAn_DayDuCacNam(2022,2024)
--cau5
create login user_new with password = '123'
create user user_22t1020763 for login user_new
grant select
on nhanvien
to user_22t1020763
with grant option
grant insert
on nhanvien
to user_22t1020763
with grant option
grant execute
on dbo.proc_NhanVien_DuAn_Insert
to user_22t1020763
with grant option
grant execute
on dbo.proc_DuAn_DanhSachNhanVien
to user_22t1020763
with grant option
grant execute
on dbo.proc_NhanVien_TimKiem
to user_22t1020763
with grant option
grant execute
on dbo.proc_ThongKeGiaoViec
to user_22t1020763
with grant option
grant select
on dbo.func_TkeDuAn
to user_22t1020763
with grant option
grant select
on dbo.func_TkeDuAn_DayDuCacNam
to user_22t1020763
with grant option