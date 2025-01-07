select * from SinhVien
select * from LopHocPhan
select * from LopHocPhan_SinhVien
--cau2
alter trigger trg_LopHocPhan_SinhVien_Insert on LopHocPhan_SinhVien
for insert
as
begin
	update LopHocPhan
	set SoSinhVienDangKy = SoSinhVienDangKy + (select count(*)
											   from inserted i
											   where i.MaLopHocPhan =l.MaLopHocPhan)
	from LopHocPhan l inner join inserted i 
	on l.MaLopHocPhan = i.MaLopHocPhan

end
insert into LopHocPhan_SinhVien(MaLopHocPhan,MaSinhVien,NgayDangKy)
values('L0001','SV003','2025-01-01'),('L0001','SV004','2025-01-01')

--cau3
--a
alter proc proc_LopHocPhan_SinhVien_Insert(@MaLopHocPhan nvarchar(50),
											@MaSinhVien nvarchar(50),
											@KetQua nvarchar(255) output)
as
begin
	if not exists(select 1 from SinhVien where MaSinhVien = @MaSinhVien)
	begin
		set @KetQua = N'Sinh viên không tồn tại'
		return
	end
	if not exists(select 1 from LopHocPhan where MaLopHocPhan = @MaLopHocPhan)
	begin
		set @KetQua = N'Lớp học phần không tồn tại'
		return
	end
	if exists(select 1 from LopHocPhan_SinhVien where MaLopHocPhan = @MaLopHocPhan and MaSinhVien= @MaSinhVien)
	begin
		set @KetQua = N'Lớp học phần của sinh viên đã tồn tại'
		return
	end
	set @KetQua = N''
	insert into LopHocPhan_SinhVien(MaLopHocPhan,MaSinhVien,NgayDangKy)
	values(@MaLopHocPhan,@MaSinhVien,getdate())

end
declare @kq nvarchar(255)
exec proc_LopHocPhan_SinhVien_Insert @MaLopHocPhan='L0002',@masinhvien='SV001',@ketqua=@kq output
select @kq as ketqua
--b
alter proc proc_LopHocPhan_SinhVien_SelectByLop(@MaLopHocPhan nvarchar(50),
												 @TenLop nvarchar(50))
as
begin
	select s.MaSinhVien,s.HoTen,s.NgaySinh,s.NoiSinh
	from SinhVien s left join LopHocPhan_SinhVien ls
	on s.MaSinhVien = ls.MaSinhVien
	where s.TenLop = @TenLop and ls.MaLopHocPhan = @MaLopHocPhan
	order by s.HoTen asc
	
end
exec proc_LopHocPhan_SinhVien_SelectByLop @MaLopHocPhan='L0001',@TenLop='Tin K44A'
select * from SinhVien
select * from LopHocPhan_SinhVien

--c
create proc proc_SinhVien_TimKiem(@Trang int =1,
								  @SoDongMoiTrang int =20,
								  @HoTen nvarchar(50) = N'',
								  @Tuoi int,
								  @SoLuong int output)
as
begin
	declare @from int
	set @from = (@trang-1)*@SoDongMoiTrang
	if @HoTen = N''
	begin
		select MaSinhVien,HoTen,NgaySinh,NoiSinh,TenLop
		from SinhVien
		where YEAR(getdate()) - YEAR(ngaysinh) >= @Tuoi
		order by MaSinhVien
		offset @from rows
		fetch next @sodongmoitrang rows only
		set @SoLuong = @@ROWCOUNT
		return
	end
		select MaSinhVien,HoTen,NgaySinh,NoiSinh,TenLop
		from SinhVien
		where hoten like '%' + @hoten + '%' and YEAR(getdate()) - YEAR(ngaysinh) >= @Tuoi
		order by MaSinhVien
		offset @from rows
		fetch next @sodongmoitrang rows only
		set @SoLuong = @@ROWCOUNT

end
declare @sl int
exec proc_SinhVien_TimKiem @trang = 1,@sodongmoitrang=1,@hoten='T',@tuoi=10,@soluong=@sl output
select @sl as soluong
select * from SinhVien
--d
create proc proc_ThongKeDangKyHoc(@MaLopHocPhan nvarchar(50),
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
	declare @i date = @TuNgay
	while @i <= @DenNgay
	begin
		declare @tt int
		select @tt = Count(*)
		from LopHocPhan_SinhVien
		where MaLopHocPhan = @MaLopHocPhan and NgayDangKy =@i
		insert into @tb(ngay,sl)
		values(@i,@tt)
		set @i = DATEADD(day,1,@i)

	end
	select *
	from @tb
end
exec proc_ThongKeDangKyHoc @MaLopHocPhan='L0002',@TuNgay='2025-01-07',@DenNgay='2025-01-08'
select * from LopHocPhan_SinhVien
--cau4
--a
create function func_TkeKhoiLuongDangKyHoc(@MaSinhVien nvarchar(50),
										   @TuNam int,
										   @DenNam int)
returns table
as
	return(select year(ls.NgayDangKy)as nam,sum(l.sotinchi) as tongsotinchi
		   from LopHocPhan_SinhVien ls inner join LopHocPhan l
		   on ls.MaLopHocPhan = l.MaLopHocPhan
		   where ls.MaSinhVien = @MaSinhVien and year(ls.NgayDangKy) between @TuNam and @DenNam
		   group by year(ls.NgayDangKy))
			

select *
from dbo.func_TkeKhoiLuongDangKyHoc('SV003',2021,2026)
select * from LopHocPhan
select * from LopHocPhan_SinhVien

--b
alter function func_TkeKhoiLuongDangKyHoc_DayDuNam(@MaSinhVien nvarchar(50),
													@TuNam int,
													@DenNam int)
returns @tke table(nam int,
				   tongsotinchi int)
as
begin
	if @TuNam > @DenNam
	begin
		return
	end
	declare @i int = @TuNam
	while @i <= @DenNam
	begin
		declare @tt int
		select @tt = isnull(sum(l.SoTinChi),0)
		from LopHocPhan_SinhVien ls inner join LopHocPhan l
		on ls.MaLopHocPhan = l.MaLopHocPhan
		where ls.MaSinhVien = @MaSinhVien and year(ls.NgayDangKy) = @i
		insert into @tke(nam,tongsotinchi)
		values(@i,@tt)
		set @i = @i +1
	end
	return

end
select * from dbo.func_TkeKhoiLuongDangKyHoc_DayDuNam('SV005',2024,2026)

--cau5
create login new_login with password = '123'
create user user_22t1020763 for login new_login

grant select
on sinhvien
to user_22t1020763
with grant option

grant update
on sinhvien
to user_22t1020763
with grant option

grant execute
on dbo.proc_LopHocPhan_SinhVien_Insert
to user_22t1020763
with grant option

grant execute
on dbo.proc_LopHocPhan_SinhVien_SelectByLop
to user_22t1020763
with grant option

grant execute
on dbo.proc_SinhVien_TimKiem
to user_22t1020763
with grant option

grant execute
on dbo.proc_ThongKeDangKyHoc
to user_22t1020763
with grant option

grant select
on dbo.func_TkeKhoiLuongDangKyHoc
to user_22t1020763
with grant option

grant select
on dbo.func_TkeKhoiLuongDangKyHoc_DayDuNam
to user_22t1020763
with grant option