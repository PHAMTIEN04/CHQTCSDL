--Bài Kiểm Tra:Nhóm 1 Phạm Phước Tiến
--Câu 1:
USE [NHOM_1_PHAMPHUOCTIEN]
GO
/****** Object:  Table [dbo].[HOSOVAYVON]    Script Date: 11/11/2024 6:06:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HOSOVAYVON](
	[MaHoSo] [nvarchar](10) NOT NULL,
	[LaiSuat] [float] NOT NULL,
	[TongSoVonVay] [bigint] NULL,
 CONSTRAINT [PK_HOSOVAYVON] PRIMARY KEY CLUSTERED 
(
	[MaHoSo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HOSOVAYVON_THANHVIEN]    Script Date: 11/11/2024 6:06:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HOSOVAYVON_THANHVIEN](
	[MaThanhVien] [nvarchar](10) NOT NULL,
	[MaHoSo] [nvarchar](10) NOT NULL,
	[SoVonVay] [bigint] NULL,
 CONSTRAINT [PK_HOSOVAYVON_THANHVIEN] PRIMARY KEY CLUSTERED 
(
	[MaThanhVien] ASC,
	[MaHoSo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[THANHVIEN]    Script Date: 11/11/2024 6:06:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[THANHVIEN](
	[MaThanhVien] [nvarchar](10) NOT NULL,
	[HoDem] [nvarchar](50) NOT NULL,
	[Ten] [nvarchar](15) NOT NULL,
	[NgaySinh] [date] NULL,
	[GioiTinh] [bit] NULL,
	[NoiSinh] [nvarchar](250) NULL,
 CONSTRAINT [PK_THANHVIEN] PRIMARY KEY CLUSTERED 
(
	[MaThanhVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[HOSOVAYVON] ([MaHoSo], [LaiSuat], [TongSoVonVay]) VALUES (N'HS01', 0.6, 77000)
INSERT [dbo].[HOSOVAYVON] ([MaHoSo], [LaiSuat], [TongSoVonVay]) VALUES (N'HS02', 0.4, 8000)
INSERT [dbo].[HOSOVAYVON] ([MaHoSo], [LaiSuat], [TongSoVonVay]) VALUES (N'HS03', 0.7, 37000)
INSERT [dbo].[HOSOVAYVON] ([MaHoSo], [LaiSuat], [TongSoVonVay]) VALUES (N'HS04', 0.6, 83000)
INSERT [dbo].[HOSOVAYVON] ([MaHoSo], [LaiSuat], [TongSoVonVay]) VALUES (N'HS05', 0.9, 0)
INSERT [dbo].[HOSOVAYVON] ([MaHoSo], [LaiSuat], [TongSoVonVay]) VALUES (N'HS06', 0.7, 101000)
INSERT [dbo].[HOSOVAYVON_THANHVIEN] ([MaThanhVien], [MaHoSo], [SoVonVay]) VALUES (N'TV01', N'HS01', 15000)
INSERT [dbo].[HOSOVAYVON_THANHVIEN] ([MaThanhVien], [MaHoSo], [SoVonVay]) VALUES (N'TV01', N'HS02', 8000)
INSERT [dbo].[HOSOVAYVON_THANHVIEN] ([MaThanhVien], [MaHoSo], [SoVonVay]) VALUES (N'TV02', N'HS01', 27000)
INSERT [dbo].[HOSOVAYVON_THANHVIEN] ([MaThanhVien], [MaHoSo], [SoVonVay]) VALUES (N'TV03', N'HS01', 35000)
INSERT [dbo].[HOSOVAYVON_THANHVIEN] ([MaThanhVien], [MaHoSo], [SoVonVay]) VALUES (N'TV03', N'HS06', 56000)
INSERT [dbo].[HOSOVAYVON_THANHVIEN] ([MaThanhVien], [MaHoSo], [SoVonVay]) VALUES (N'TV06', N'HS03', 37000)
INSERT [dbo].[HOSOVAYVON_THANHVIEN] ([MaThanhVien], [MaHoSo], [SoVonVay]) VALUES (N'TV06', N'HS06', 45000)
INSERT [dbo].[HOSOVAYVON_THANHVIEN] ([MaThanhVien], [MaHoSo], [SoVonVay]) VALUES (N'TV07', N'HS04', 69000)
INSERT [dbo].[HOSOVAYVON_THANHVIEN] ([MaThanhVien], [MaHoSo], [SoVonVay]) VALUES (N'TV09', N'HS04', 14000)
INSERT [dbo].[THANHVIEN] ([MaThanhVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'TV01', N'Nguyễn Thị', N'Huế', CAST(N'1993-08-05' AS Date), 0, N'Đà Nẵng')
INSERT [dbo].[THANHVIEN] ([MaThanhVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'TV02', N'Lê Văn', N'Lý', CAST(N'1992-09-21' AS Date), 1, N'TT Huế')
INSERT [dbo].[THANHVIEN] ([MaThanhVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'TV03', N'Lê Thị Hồng', N'Nga', CAST(N'1991-07-24' AS Date), 0, NULL)
INSERT [dbo].[THANHVIEN] ([MaThanhVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'TV04', N'Lương Nguyễn Nguyệt', N'Loan', CAST(N'1992-12-24' AS Date), 0, N'TT Huế')
INSERT [dbo].[THANHVIEN] ([MaThanhVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'TV05', N'Nguyễn Thanh', N'Lĩnh', CAST(N'1992-04-21' AS Date), 1, N'Đà Nẵng')
INSERT [dbo].[THANHVIEN] ([MaThanhVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'TV06', N'Võ Văn', N'Hậu', CAST(N'1992-09-21' AS Date), 1, N'Quảng Bình')
INSERT [dbo].[THANHVIEN] ([MaThanhVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'TV07', N'Võ Thị Thu', N'Hằng', CAST(N'1993-05-21' AS Date), 0, N'Hà Nội')
INSERT [dbo].[THANHVIEN] ([MaThanhVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'TV08', N'Trần Thị Khánh', N'Hòa', CAST(N'1992-06-24' AS Date), 0, NULL)
INSERT [dbo].[THANHVIEN] ([MaThanhVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'TV09', N'Đỗ Thị Ngọc', N'Huyền', CAST(N'1991-03-29' AS Date), 0, N'Hà Nội')
ALTER TABLE [dbo].[THANHVIEN]  WITH CHECK ADD  CONSTRAINT [FK_THANHVIEN_THANHVIEN1] FOREIGN KEY([MaThanhVien])
REFERENCES [dbo].[THANHVIEN] ([MaThanhVien])
GO
ALTER TABLE [dbo].[THANHVIEN] CHECK CONSTRAINT [FK_THANHVIEN_THANHVIEN1]
GO

--Câu 2:
create trigger trg_HSVayVon_TV_Insert on dbo.HOSOVAYVON_THANHVIEN
for insert
as
begin
	declare @mhs nvarchar(10)
	select @mhs = mahoso
	from inserted
	update HOSOVAYVON
	set TongSoVonVay = TongSoVonVay +(select Sum(i.SoVonVay)
							from inserted i 
							where MaHoSo=@mhs
							)
	where MaHoSo = @mhs

end

insert into HOSOVAYVON_THANHVIEN(MaThanhVien,MaHoSo,SoVonVay)
values(N'TV06',N'HS01',10000)
select *
from HOSOVAYVON
select *
from HOSOVAYVON_THANHVIEN
--Câu 3:
--Câu 3a:
create proc proc_ThanhVien_Insert(@MaThanhVien nvarchar(10),
								  @HoDem nvarchar(50),
								  @Ten	nvarchar(15),
								  @NgaySinh date,
								  @GioiTinh bit,
								  @NoiSinh nvarchar(250),
								  @KetQuaBoSung nvarchar(255) output
									)
as
begin
	if exists(select 1 from THANHVIEN where MaThanhVien = @MaThanhVien)
		begin
			set @KetQuaBoSung = N'Mã Thành Viên đã tồn tại'
			return
		end
	if @GioiTinh NOT IN (0,1)
	begin
		set @KetQuaBoSung = N'Giới Tính không tồn tại'
		return
	end
	insert into THANHVIEN(MaThanhVien,HoDem,Ten,NgaySinh,GioiTinh,NoiSinh)
	values(@MaThanhVien,@HoDem,@Ten,@NgaySinh,@GioiTinh,@NoiSinh)
	set @KetQuaBoSung = N''
end

exec proc_ThanhVien_Insert @mathanhvien=N'TV10',@hodem=N'Phạm Phước',@ten=N'Tiến',@ngaysinh='1992-02-02' ,@gioitinh=1 ,@noisinh=N'TT Huế',@KetQuaBoSung =''

select *
from THANHVIEN

--Câu 3b:
create proc proc_ThanhVien_NoiSinh(@NoiSinh nvarchar(50),
								   @GioiTinh bit)
as
begin
	select MaThanhVien,CONCAT(hodem,' ',ten) as N'Họ Tên',NgaySinh,GioiTinh,NoiSinh
	from THANHVIEN
	where (NoiSinh like @NoiSinh + '%') and GioiTinh = @GioiTinh

end
exec proc_ThanhVien_NoiSinh @noisinh=N'H',@gioitinh=0
select * from THANHVIEN
--Câu 3c:
create proc proc_HoSo_TimKiem(@NoiSinh nvarchar(250) = N'',
							  @SoVonVay bigint,
							  @SoLuong int output	
								)
as
begin
	if exists (select 1 from THANHVIEN where noisinh = @noisinh)
		begin
			select tv.MaThanhVien,CONCAT(tv.hodem,' ',tv.ten) as N'Họ Tên',tv.NoiSinh,hs.SoVonVay
			from THANHVIEN tv left join HOSOVAYVON_THANHVIEN hs
			on hs.MaThanhVien = tv.MaThanhVien 
			where (tv.NoiSinh like '%'+@NoiSinh+'%') and @SoVonVay <= Sum(hs.SoVonVay)
		end

end
exec proc_HoSo_TimKiem @noisinh=N'TT Huế' ,@SoVonVay=22222
--Câu 3d:
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
						tong int)
	declare @i int = @tuthang
	while @i <= @DenThang
	begin	
		declare @tt int
		select @tt= Count(*)
		from THANHVIEN
		where MONTH(ngaysinh)=@i and NoiSinh =@NoiSinh
		insert into @tb(thang,tong) values(@i,@tt)
		set @i = @i + 1
	end
	select *
	from @tb
end
exec proc_ThongKeThanhVien @noisinh=N'Hà Nội' ,@TuThang=1 ,@DenThang=12
select *
from THANHVIEN
--Câu 4:
--Câu 4a:
create function func_TkeThanhVien_TongVonVay(@HoTV nvarchar(50),
											 @TongSoVonVay bigint)
returns table
as
	return(select tv.MaThanhVien,(tv.hodem + ' ' + tv.Ten) as N'Họ Tên',Sum(hstv.SoVonVay) as N'Tổng Vốn Vay'
			from HOSOVAYVON_THANHVIEN hstv right join THANHVIEN tv
			on hstv.MaThanhVien = tv.MaThanhVien
			where (tv.HoDem like @HoTV +' %' or tv.HoDem = @HoTV)
			group by tv.MaThanhVien,tv.HoDem,tv.Ten
			having Sum(hstv.SoVonVay) >= @TongSoVonVay)

select *
from dbo.func_TkeThanhVien_TongVonVay(N'Lê',26000)

--Câu 4b:
create function func_TkeThanhVien_DayDuCacNam(@TuNam int,
											  @DenNam int)
returns @thongke table(namsinh int,
						soluong int)
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
		select @tt = COUNT(*)
		from THANHVIEN
		where YEAR(ngaysinh) = @i
		
		insert into @thongke(namsinh,soluong) values(@i,@tt)
		set @i = @i + 1
	end
	return
end

select *
from dbo.func_TkeThanhVien_DayDuCacNam(1991,1994)