select * from THANHVIEN
select * from HOSOVAYVON
select * from HOSOVAYVON_THANHVIEN

--cau2
alter trigger trg_HSVayVon_TV_Insert on HOSOVAYVON_THANHVIEN 
for insert
as
begin
	update HOSOVAYVON
	set TongSoVonVay = TongSoVonVay + (select sum(sovonvay)
										from inserted
										where MaHoSo = hsvv.MaHoSo)

	from HOSOVAYVON hsvv inner join inserted i
	on hsvv.MaHoSo = i.MaHoSo
end
insert into HOSOVAYVON_THANHVIEN(MaThanhVien,MaHoSo,SoVonVay)
values('TV06','HS01',1),('TV07','HS02',1)

--cau3
--a
create proc proc_ThanhVien_Insert(@MaThanhVien nvarchar(10),
								  @HoDem nvarchar(50),
								  @Ten nvarchar(15),
								  @NgaySinh date,
								  @GioiTinh bit,
								  @NoiSinh nvarchar(250),
								  @KetQuaBoSung nvarchar(250) output)
as
begin
	if exists( select 1 from THANHVIEN where MaThanhVien = @MaThanhVien)
	begin
		set @KetQuaBoSung = N'Ma Thanh Vien da ton tai'
		return
	end
	if @GioiTinh not in (0,1)
	begin
		set @KetQuaBoSung = N'Gioi tinh khong nam trong khoan 0-1'
		return
	end
	set @KetQuaBoSung = ''
	insert into THANHVIEN(MaThanhVien,HoDem,Ten,NgaySinh,GioiTinh,NoiSinh)
	values(@MaThanhVien,@HoDem,@Ten,@NgaySinh,@GioiTinh,@NoiSinh)


end
declare @kqbs nvarchar(255)
exec proc_ThanhVien_Insert @mathanhvien=N'TV10',@HoDem=N'Pham Phuoc', @Ten= N'Tien',@NgaySinh = N'1992-02-02',@GioiTinh=1,@NoiSinh=N'TT Huế',@ketquabosung=@kqbs output
print @kqbs
select * from THANHVIEN
--b
alter proc proc_ThanhVien_NoiSinh(@NoiSinh nvarchar(50),
								   @GioiTinh bit)
as
begin
	select MaThanhVien,Concat(hodem,' ',ten) as N'Họ Tên',NgaySinh,GioiTinh,NoiSinh
	from THANHVIEN
	where NoiSinh like @NoiSinh + '%' and GioiTinh = @GioiTinh

end

exec proc_ThanhVien_NoiSinh @noisinh = N'TT' ,@gioitinh = 0
select * from THANHVIEN

--c
create proc proc_HoSo_TimKiem(@NoiSinh nvarchar(250) = N'',
							  @SoVonVay bigint,
							  @SoLuong int output)
as
begin
	if exists(select 1 from THANHVIEN where NoiSinh like '%'+ @NoiSinh + '%')
	begin
		select tv.MaThanhVien,CONCAT(tv.HoDem,' ',tv.Ten),tv.noisinh,sum(hsvvtv.SoVonVay) as TongVonVay
		from THANHVIEN tv left join HOSOVAYVON_THANHVIEN hsvvtv 
		on tv.MaThanhVien = hsvvtv.MaThanhVien
		where tv.NoiSinh like '%' + @NoiSinh + '%'
		group by tv.MaThanhVien,CONCAT(tv.HoDem,' ',tv.Ten),tv.NoiSinh
		having sum(hsvvtv.SoVonVay) >= @SoVonVay
		set @SoLuong = @@ROWCOUNT

	end
	else
	begin
		select tv.MaThanhVien,CONCAT(tv.HoDem,' ',tv.Ten),tv.noisinh,sum(hsvvtv.SoVonVay) as TongVonVay
		from THANHVIEN tv left join HOSOVAYVON_THANHVIEN hsvvtv 
		on tv.MaThanhVien = hsvvtv.MaThanhVien
		group by tv.MaThanhVien,CONCAT(tv.HoDem,' ',tv.Ten),tv.NoiSinh
		having sum(hsvvtv.SoVonVay) >= @SoVonVay
		set @SoLuong = @@ROWCOUNT



	end
	
end	
declare @sl int
exec proc_HoSo_TimKiem @NoiSinh = N'', @Sovonvay= 50000,@Soluong = @sl output
print @sl 

--d
create proc proc_ThongKeThanhVien(@NoiSinh nvarchar(250),
								  @TuThang int,
								  @DenThang int)
as
begin
	if @TuThang > @DenThang
	begin
		return
	end
	declare @tb table( thang int,
						sl int)
	declare @i int = @tuthang
	while @i <= @DenThang
	begin
		declare @tt int
		select @tt= Count(*)
		from THANHVIEN
		where NoiSinh = @NoiSinh and MONTH(NgaySinh) = @i
		insert into @tb(thang,sl)
		values(@i,@tt)
		set @i = @i + 1
	end
	select *
	from @tb
end
exec proc_ThongKeThanhVien @noisinh=N'TT Huế' ,@tuthang=9, @DenThang=12

--cau4
--a
create function func_TkeThanhVien_TongVonVay(@HoTV nvarchar(50),
											 @TongSoVonVay bigint)
returns @thongke table (mathanhvien nvarchar(10),
						hoten nvarchar(65),
						tongsovovay bigint)
begin
		   insert into @thongke
		   select tv.MaThanhVien,concat(tv.hodem,' ',tv.ten) as hoten,sum(hsvvtv.sovonvay) as tongvonvay
	       from THANHVIEN tv left join HOSOVAYVON_THANHVIEN hsvvtv
		   on tv.MaThanhVien = hsvvtv.MaThanhVien
		   where (hodem like @HoTV+' %' or hodem = @HoTV )
		   group by tv.MaThanhVien,concat(tv.hodem,' ',tv.ten)
		   having sum(hsvvtv.sovonvay) >= @TongSoVonVay
		   return

end
drop function func_TkeThanhVien_TongVonVay
select*
from dbo.func_TkeThanhVien_TongVonVay(N'Lê',1)

--b
create function func_TkeThanhVien_DayDuCacNam(@TuNam int, @DenNam int)
returns @thongke table (nam int,
						sl int)
begin
	if @TuNam > @DenNam
	begin
		return
	end
	declare @i int = @tunam
	while @i <= @DenNam
	begin
		declare @tt int
		select @tt = Count(*)
		from THANHVIEN
		where year(ngaysinh) = @i
		insert into @thongke(nam,sl)
		values(@i,@tt)
		set @i = @i +1
	end
	return
end
select *
from dbo.func_TkeThanhVien_DayDuCacNam(1992,1995)