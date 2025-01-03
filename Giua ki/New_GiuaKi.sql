select * from THANHVIEN
select * from HOSOVAYVON_THANHVIEN
select * from HOSOVAYVON

--cau2
alter trigger trg_HSVayVon_TV_Insert on HOSOVAYVON_THANHVIEN
for insert
as
begin
	update HOSOVAYVON
	set TongSoVonVay = tongsovonvay+  (select Sum(Sovonvay)
						from inserted
						where MaHoSo = hs.MaHoSo
						)
	from HOSOVAYVON hs inner join inserted i 
	on hs.MaHoSo = i.MaHoSo

end
insert into HOSOVAYVON_THANHVIEN(MaThanhVien,MaHoSo,SoVonVay)
values(N'TV09',N'HS03',1)
--Cau3
--a
create proc proc_ThanhVien_Insert(@MaThanhVien nvarchar(10),
								  @HoDem nvarchar(50),
								  @Ten nvarchar(15),
								  @NgaySinh date,
								  @GioiTinh bit,
								  @NoiSinh nvarchar(250),
								  @KetQuaBoSung nvarchar(250) output
								  )
as
begin
	if exists(select 1 from THANHVIEN where MaThanhVien = @MaThanhVien)
	begin
		set @KetQuaBoSung = N'Trung khoa chinh'
		return
	end
	if @GioiTinh not in (0,1)
	begin
		set @KetQuaBoSung = N'Gioi tinh khong hop le'
		return
	end
	set @KetQuaBoSung = ''
	insert into THANHVIEN(MaThanhVien,HoDem,Ten,NgaySinh,GioiTinh,NoiSinh)
	values(@MaThanhVien,@HoDem,@Ten,@NgaySinh,@GioiTinh,@NoiSinh)
end
declare @ketquabosungg nvarchar(255)
exec proc_ThanhVien_Insert @mathanhvien=N'TV12' , @HoDem=N'Phạm Phước' ,@Ten =N'Tiến' ,@NgaySinh= '2004-01-01', @GioiTinh= a, @NoiSinh =N'Huế' , @KetQuaBoSung = @KetQuaBoSungg output
print @ketquabosungg

--b
create proc proc_ThanhVien_NoiSinh(@NoiSinh nvarchar(50),
								   @GioiTinh bit)
as
begin
	select *
	from THANHVIEN
	where NoiSinh like @NoiSinh + '%' and GioiTinh = @GioiTinh

end
exec proc_ThanhVien_NoiSinh @noisinh= N'H', @GioiTinh = 1
--c
alter proc proc_HoSo_TimKiem(@NoiSinh nvarchar(250) = N'',
							  @SoVonVay bigint,
							  @SoLuong int output)
as
begin
	if exists(select 1 from THANHVIEN where NoiSinh like '%' + @NoiSinh + '%')
	begin
		select tv.MaThanhVien ,sum(hstv.SoVonVay) as tong
		from THANHVIEN tv left join HOSOVAYVON_THANHVIEN hstv
		on tv.MaThanhVien = hstv.MaThanhVien
		where NoiSinh like '%' + @NoiSinh +'%' 
		group by tv.MaThanhVien
		having sum(hstv.SoVonVay)>= @SoVonVay
		set @SoLuong = @@ROWCOUNT
	end
	else
	begin
		select tv.MaThanhVien ,sum(hstv.SoVonVay) as tong
		from THANHVIEN tv left join HOSOVAYVON_THANHVIEN hstv
		on tv.MaThanhVien = hstv.MaThanhVien
		group by tv.MaThanhVien
		having sum(hstv.SoVonVay)>= @SoVonVay
		set @SoLuong = @@ROWCOUNT
	end
end
declare @sl int 
exec proc_HoSo_TimKiem @noisinh = N'Huế',@sovonvay = 1,@SoLuong = @sl output
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
	declare @tb table(thang int,
					  sl int)
	declare @i int = @tuthang
	while @i <= @DenThang
	begin
		declare @tt int
		select @tt = Count(*)
		from THANHVIEN
		where NoiSinh = @NoiSinh and MONTH(ngaysinh) = @i

		insert into @tb(thang,sl)
		values(@i,@tt)
		set @i = @i + 1
	end
	select *
	from @tb
end
exec proc_ThongKeThanhVien @noisinh =N'Huế',@tuthang = 1,@denthang=12

--cau4
--a
alter function func_TkeThanhVien_TongVonVay(@HoTV nvarchar(50),
											 @TongSoVonVay bigint)
returns @thongketsv table ( mathanhvien nvarchar(10),
							hoten nvarchar(65),
							tongsovonvay bigint)
begin
	insert into @thongketsv
	select tv.MaThanhVien,CONCAT(tv.HoDem,' ',tv.Ten),sum(hstv.SoVonVay)
	from THANHVIEN tv left join HOSOVAYVON_THANHVIEN hstv
	on tv.MaThanhVien = hstv.MaThanhVien
	where HoDem like @HoTV + '%' 
	group by tv.MaThanhVien,CONCAT(tv.HoDem,' ',tv.Ten)
	having sum(hstv.SoVonVay) >= @TongSoVonVay
	return
end
select *
from dbo.func_TkeThanhVien_TongVonVay(N'Lê',100000)
select * from THANHVIEN
select * from HOSOVAYVON_THANHVIEN
--b
create function func_TkeThanhVien_DayDuCacNam(@TuNam int,
											  @DenNam int)
returns @thongke table(nam int,
						sl int)
as
begin
	if @TuNam > @DenNam
	begin
		return
	end
	declare @i int = @tunam
	while @i <= @DenNam
	begin
		declare @tt int
		select @tt = count(*)
		from THANHVIEN
		where YEAR(ngaysinh) = @i
		insert into @thongke(nam,sl)
		values(@i,@tt)
		set @i = @i + 1
	end	
	return

end

select *
from dbo.func_TkeThanhVien_DayDuCacNam(1992,1995)