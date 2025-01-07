select * from NhanVien
select * from DuAn
--cau1
USE [demau1]
GO
/****** Object:  Table [dbo].[DuAn]    Script Date: 1/8/2025 1:57:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DuAn](
	[MaDuAn] [nvarchar](50) NOT NULL,
	[TenDuAn] [nvarchar](255) NOT NULL,
	[NgayBatDau] [date] NOT NULL,
	[SoNguoiThamGia] [int] NOT NULL,
 CONSTRAINT [PK_DuAn] PRIMARY KEY CLUSTERED 
(
	[MaDuAn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 1/8/2025 1:57:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[MaNhanVien] [nvarchar](50) NOT NULL,
	[HoTen] [nvarchar](50) NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[DiDong] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_NhanVien] PRIMARY KEY CLUSTERED 
(
	[MaNhanVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NhanVien_DuAn]    Script Date: 1/8/2025 1:57:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien_DuAn](
	[MaNhanVien] [nvarchar](50) NOT NULL,
	[MaDuAn] [nvarchar](50) NOT NULL,
	[NgayGiaoViec] [date] NOT NULL,
	[MoTaCongViec] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_NhanVien_DuAn] PRIMARY KEY CLUSTERED 
(
	[MaNhanVien] ASC,
	[MaDuAn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[DuAn] ([MaDuAn], [TenDuAn], [NgayBatDau], [SoNguoiThamGia]) VALUES (N'DA001', N'SmartUni', CAST(N'2022-01-01' AS Date), 0)
INSERT [dbo].[DuAn] ([MaDuAn], [TenDuAn], [NgayBatDau], [SoNguoiThamGia]) VALUES (N'DA002', N'E-Shop', CAST(N'2022-05-01' AS Date), 0)
INSERT [dbo].[DuAn] ([MaDuAn], [TenDuAn], [NgayBatDau], [SoNguoiThamGia]) VALUES (N'DA003', N'LiteCMS', CAST(N'2022-09-01' AS Date), 0)
INSERT [dbo].[NhanVien] ([MaNhanVien], [HoTen], [NgaySinh], [Email], [DiDong]) VALUES (N'NV001', N'Nguyễn Thanh An', CAST(N'1980-12-01' AS Date), N'thanhan@gmail.com', N'0914422578')
INSERT [dbo].[NhanVien] ([MaNhanVien], [HoTen], [NgaySinh], [Email], [DiDong]) VALUES (N'NV002', N'Trần Chí Hiếu', CAST(N'1985-05-17' AS Date), N'hieu85@gmail.com', N'0987454125')
INSERT [dbo].[NhanVien] ([MaNhanVien], [HoTen], [NgaySinh], [Email], [DiDong]) VALUES (N'NV003', N'Vũ Thanh Chung', CAST(N'1986-11-20' AS Date), N'chungvt@gmail.com', N'0935254771')
INSERT [dbo].[NhanVien] ([MaNhanVien], [HoTen], [NgaySinh], [Email], [DiDong]) VALUES (N'NV005', N'Lê Thị Hải Yến', CAST(N'1986-08-14' AS Date), N'lthyen@gmail.com', N'0983120547')
ALTER TABLE [dbo].[NhanVien_DuAn]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_DuAn_DuAn] FOREIGN KEY([MaDuAn])
REFERENCES [dbo].[DuAn] ([MaDuAn])
GO
ALTER TABLE [dbo].[NhanVien_DuAn] CHECK CONSTRAINT [FK_NhanVien_DuAn_DuAn]
GO
ALTER TABLE [dbo].[NhanVien_DuAn]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_DuAn_NhanVien] FOREIGN KEY([MaNhanVien])
REFERENCES [dbo].[NhanVien] ([MaNhanVien])
GO
ALTER TABLE [dbo].[NhanVien_DuAn] CHECK CONSTRAINT [FK_NhanVien_DuAn_NhanVien]
GO

--cau2
alter trigger trg_NhanVien_DuAn_Insert on NhanVien_DuAn
for insert
as
begin
	update DuAn
	set SoNguoiThamGia = SoNguoiThamGia + (select count(*)
										   from inserted i
										   where DuAn.MaDuAn=i.MaDuAn)

end
insert into NhanVien_DuAn(MaNhanVien,MaDuAn,NgayGiaoViec,MoTaCongViec)
values('NV002','DA001','2022-01-01','play game'),('NV003','DA001','2022-01-01','play game')

select * from DuAn
select * from NhanVien_DuAn

--cau3
--a
create proc proc_NhanVien_DuAn_Insert(@MaNhanVien nvarchar(50),
									  @MaDuAn nvarchar(50),
									  @MoTaCongViec nvarchar(255),
									  @KetQua nvarchar(255) output)
as
begin
	if not exists(select 1 from NhanVien where MaNhanVien = @MaNhanVien)
	begin
		set @KetQua = N'Nhan vien khong ton tai'
		return
	end
	if not exists(select 1 from DuAn where MaDuAn = @MaDuAn)
	begin
		set @KetQua = N'Du an khong ton tai'
		return
	end
	if exists(select 1 from NhanVien_DuAn where MaNhanVien = @MaNhanVien and MaDuAn = @MaDuAn)
	begin
		set @KetQua = N'Nhan vien du an da ton tai'
		return
	end
	set @KetQua = ''
	insert into NhanVien_DuAn(MaNhanVien,MaDuAn,NgayGiaoViec,MoTaCongViec)
	values(@MaNhanVien,@MaDuAn,getdate(),@MoTaCongViec)


end
declare @kq nvarchar(255)
exec proc_NhanVien_DuAn_Insert @manhanvien='NV001',@maduan='DA002',@motacongviec='play game',@ketqua=@kq output
select @kq as ketqua
select * from NhanVien
select * from DuAn
select * from NhanVien_DuAn

--b
create proc proc_DuAn_DanhSachNhanVien(@TenDuAn nvarchar(255),
									   @NgayGiaoViec date)
as
begin
	select nv.MaNhanVien,nv.HoTen,nv.Email,nv.DiDong,nvda.NgayGiaoViec,nvda.MoTaCongViec
	from NhanVien nv left join NhanVien_DuAn nvda
	on nv.MaNhanVien = nvda.MaNhanVien inner join DuAn da
	on nvda.MaDuAn = da.MaDuAn
	where da.TenDuAn = @TenDuAn and nvda.NgayGiaoViec < @NgayGiaoViec

end
exec proc_DuAn_DanhSachNhanVien @tenduan ='SmartUni' ,@NgayGiaoViec = '2026-01-01'

--c
create proc proc_NhanVien_TimKiem(@Trang int =1,
								  @SoDongMoiTrang int =20,
								  @HoTen nvarchar(50) = N'',
								  @Tuoi int,
								  @SoLuong int output)
as
begin
	declare @from int
	set @from = (@trang -1)*@SoDongMoiTrang
	if @HoTen = N''
	begin
		select MaNhanVien,HoTen,NgaySinh,year(GETDATE()) - year(ngaysinh),Email,DiDong
		from NhanVien
		where year(GETDATE()) - year(ngaysinh) >= @Tuoi
		order by MaNhanVien
		offset @from rows
		fetch next @sodongmoitrang rows only
		set @SoLuong = @@ROWCOUNT
		return
	end
		select MaNhanVien,HoTen,NgaySinh,year(GETDATE()) - year(ngaysinh),Email,DiDong
		from NhanVien
		where hoten like '%'+@hoten+'%'and year(GETDATE()) - year(ngaysinh) >= @Tuoi
		order by MaNhanVien
		offset @from rows
		fetch next @sodongmoitrang rows only
		set @SoLuong = @@ROWCOUNT


end
declare @sl int
exec proc_NhanVien_TimKiem @trang =1 ,@sodongmoitrang=2,@hoten =N'A',@tuoi=45,@SoLuong=@sl output
select @sl as soluong

--d
create proc proc_ThongKeGiaoViec(@MaDuAn nvarchar(50),
								 @TuNgay date,
								 @DenNgay date)
as
begin
	if @TuNgay > @DenNgay
	begin
		return
	end
	declare @tb table (ngay date,
					   sl int)
	declare @i date = @tungay
	while @i<=@DenNgay
	begin
		declare @tt int
		select @tt = count(*)
		from NhanVien_DuAn nvda inner join DuAn da
		on nvda.MaDuAn = da.MaDuAn
		where nvda.MaDuAn = @MaDuAn and nvda.NgayGiaoViec = @i
		insert into @tb(ngay,sl)
		values(@i,@tt)
		set @i = DATEADD(day,1,@i)

	end
	select *
	from @tb
	

end

exec proc_ThongKeGiaoViec @maduan= 'DA002',@tungay='2022-01-01',@denngay='2022-01-02'
select * from NhanVien_DuAn
select * from DuAn
--cau4
--a
alter function func_TkeDuAn(@TuNam int,
							 @DenNam int)
returns table
as
	return (select year(NgayBatDau) as namthuchien,Count(*) as soluongduan
			from DuAn
			where year(NgayBatDau) between @TuNam and @DenNam
			group by year(NgayBatDau)
			)
select * from dbo.func_TkeDuAn(2023,2024)

--b
create function func_TkeDuAn_DayDuCacNam(@TuNam int, @DenNam int)
returns @tke table(namthuchien int,
				   soluongduan int)
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
		select @tt = Count(*)
		from DuAn
		where year(ngaybatdau) = @i
		insert into @tke(namthuchien,soluongduan)
		values(@i,@tt)
		set @i = @i + 1

	end
	return

end
select * from dbo.func_TkeDuAn_DayDuCacNam(2022,2024)
--5
create login login_new with password = '123'
create user user1_22t1020763 for login login_new

grant select
on nhanvien
to user1_22t1020763
with grant option
grant insert
on nhanvien
to user1_22t1020763
with grant option

grant execute
on dbo.proc_NhanVien_DuAn_Insert
to user1_22t1020763
with grant option

grant execute
on dbo.proc_DuAn_DanhSachNhanVien
to user1_22t1020763
with grant option

grant execute
on dbo.proc_NhanVien_TimKiem
to user1_22t1020763
with grant option

grant execute
on dbo.proc_ThongKeGiaoViec
to user1_22t1020763
with grant option

grant select
on dbo.func_TkeDuAn
to user1_22t1020763
with grant option

grant select
on dbo.func_TkeDuAn_DayDuCacNam
to user1_22t1020763
with grant option