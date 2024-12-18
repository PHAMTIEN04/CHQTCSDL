USE [QLNHANSU]
GO
/****** Object:  Table [dbo].[NHANVIEN]    Script Date: 10/19/2024 5:32:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHANVIEN](
	[MaNhanVien] [nvarchar](10) NOT NULL,
	[HoDem] [nvarchar](45) NOT NULL,
	[Ten] [nvarchar](15) NOT NULL,
	[NgaySinh] [date] NULL,
	[GioiTinh] [bit] NULL,
	[DiaChi] [nvarchar](250) NULL,
	[MaPhong] [nvarchar](3) NULL,
	[MaPhanXuong] [nvarchar](3) NULL,
 CONSTRAINT [PK_NHANVIEN] PRIMARY KEY CLUSTERED 
(
	[MaNhanVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PHANXUONG]    Script Date: 10/19/2024 5:32:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHANXUONG](
	[MaPhanXuong] [nvarchar](3) NOT NULL,
	[TenPhanXuong] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PHANXUONG] PRIMARY KEY CLUSTERED 
(
	[MaPhanXuong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PHONG]    Script Date: 10/19/2024 5:32:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHONG](
	[MaPhong] [nvarchar](3) NOT NULL,
	[TenPhong] [nvarchar](50) NOT NULL,
	[SoDienThoai] [nvarchar](15) NULL,
 CONSTRAINT [PK_PHONG] PRIMARY KEY CLUSTERED 
(
	[MaPhong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[THUNHAP_NV]    Script Date: 10/19/2024 5:32:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[THUNHAP_NV](
	[MaNhanVien] [nvarchar](10) NOT NULL,
	[HeSo] [decimal](3, 2) NULL,
	[PhuCap] [decimal](15, 0) NULL,
 CONSTRAINT [PK_THUNHAP_NV] PRIMARY KEY CLUSTERED 
(
	[MaNhanVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'11D4021169', N'Phan Phú', N'Sinh', CAST(N'1992-04-21' AS Date), 1, N'Đà Nẵng', N'GD', NULL)
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'1240210007', N'Phạm Thị Lan', N'Anh', CAST(N'1992-04-30' AS Date), 0, N'TT Huế', N'PGD', NULL)
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'1240210008', N'Trần Thị Đông', N'Anh', CAST(N'1994-07-21' AS Date), 0, N'Đà Nẵng', N'PGD', NULL)
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'1240210017', N'Võ Thị', N'Bích', CAST(N'1992-07-11' AS Date), 0, N'Đà Nẵng', N'PGD', NULL)
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'1240210027', N'Lê Thị Thùy', N'Dung', CAST(N'1993-01-21' AS Date), 0, N'Đà Nẵng', N'TC', NULL)
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'1240210046', N'Mai Thị Ngân', N'Hàng', CAST(N'1993-09-21' AS Date), 0, N'TT Huế', N'TC', NULL)
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'1240210054', N'Trần Thị Mỹ', N'Hạnh', CAST(N'1992-05-21' AS Date), 0, N'Đà Nẵng', N'TC', NULL)
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'1240210075', N'Lê Thị Bích', N'Hoài', CAST(N'1992-04-21' AS Date), 0, N'TT Huế', N'TC', NULL)
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'1240210081', N'Hoàng Thị', N'Hợp', CAST(N'1992-09-11' AS Date), 0, N'TT Huế', N'NS', NULL)
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'1240210082', N'Nguyễn Thị', N'Huế', CAST(N'1993-08-05' AS Date), 0, N'Đà Nẵng', N'NS', NULL)
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'1240210096', N'Trần Thị', N'Huyền', CAST(N'1993-12-26' AS Date), 0, N'TT Huế', N'NS', NULL)
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'1240210142', N'Lê Thị', N'Lý', CAST(N'1992-09-21' AS Date), 0, N'Đà Nẵng', N'NS', NULL)
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'1240210156', N'Lê Thị Hồng', N'Nga', CAST(N'1991-07-24' AS Date), 0, N'Đà Nẵng', N'NV', N'A1')
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'1240210397', N'Phan Thị Kim', N'Hiền', CAST(N'1992-03-21' AS Date), 0, N'TT Huế', N'NV', N'A1')
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'1240210400', N'Lê Ngô Đức', N'Hiếu', CAST(N'1994-01-27' AS Date), 1, N'TT Huế', N'NV', N'A1')
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'1240210401', N'Nguyễn Thị Thanh', N'Hiền', CAST(N'1993-03-28' AS Date), 0, N'TT Huế', N'NV', N'A1')
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'1240210425', N'Đặng Thị Thùy', N'Kim', CAST(N'1993-08-29' AS Date), 0, N'TT Huế', N'NV', N'A1')
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'1240210435', N'Lương Nguyễn Nguyệt', N'Loan', CAST(N'1992-12-24' AS Date), 0, N'Đà Nẵng', N'NV', N'A1')
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'1240210451', N'Nguyễn Thị Quỳnh', N'My', CAST(N'1992-04-21' AS Date), 0, N'TT Huế', N'NV', N'A2')
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'12D4021612', N'Nguyễn Thanh', N'Lĩnh', CAST(N'1992-04-21' AS Date), 1, N'Đà Nẵng ', N'NV', N'A2')
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'13D4011271', N'Cao Thị Ngọc', N'Anh', CAST(N'1992-11-27' AS Date), 0, N'Hà Nội', N'NV', N'A2')
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'13D4011272', N'Đoàn Ngọc', N'Anh', CAST(N'1992-01-11' AS Date), 0, N'Hà Nội', N'NV', N'A2')
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'13D4011282', N'Vũ Thị Ngọc', N'Diệp', CAST(N'1994-01-21' AS Date), 0, N'Hà Nội', N'NV', N'A2')
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'13D4011285', N'Nguyễn Thị', N'Dung', CAST(N'1994-08-28' AS Date), 0, N'Hà Nội', N'NV', N'A2')
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'13D4011289', N'Trần Văn', N'Đạt', CAST(N'1992-02-11' AS Date), 1, N'Hà Nội', N'NV', N'X1')
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'13D4011293', N'Võ Văn', N'Hậu', CAST(N'1992-09-21' AS Date), 1, N'Hà Nội', N'NV', N'X1')
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'13D4011294', N'Võ Thị Thu', N'Hằng', CAST(N'1993-05-21' AS Date), 0, N'Hà Nội', N'NV', N'X1')
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'13D4011301', N'Trần Thị Khánh', N'Hòa', CAST(N'1992-06-24' AS Date), 0, N'Hà Nội', N'NV', N'X3')
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'13D4011304', N'Đỗ Thị Ngọc', N'Huyền', CAST(N'1991-03-29' AS Date), 0, N'Hà Nội', N'NV', N'X3')
INSERT [dbo].[NHANVIEN] ([MaNhanVien], [HoDem], [Ten], [NgaySinh], [GioiTinh], [DiaChi], [MaPhong], [MaPhanXuong]) VALUES (N'13D4011305', N'Nguyễn Thị Diễm', N'Hương', CAST(N'1994-02-26' AS Date), 0, N'Hà Nội', N'NV', N'X3')
INSERT [dbo].[PHANXUONG] ([MaPhanXuong], [TenPhanXuong]) VALUES (N'A1', N'Phân xưởng A1')
INSERT [dbo].[PHANXUONG] ([MaPhanXuong], [TenPhanXuong]) VALUES (N'A2', N'Phân xưởng A2')
INSERT [dbo].[PHANXUONG] ([MaPhanXuong], [TenPhanXuong]) VALUES (N'X1', N'Phân xưởng X1')
INSERT [dbo].[PHANXUONG] ([MaPhanXuong], [TenPhanXuong]) VALUES (N'X2', N'Phân xưởng X2')
INSERT [dbo].[PHANXUONG] ([MaPhanXuong], [TenPhanXuong]) VALUES (N'X3', N'Phân xưởng X3')
INSERT [dbo].[PHANXUONG] ([MaPhanXuong], [TenPhanXuong]) VALUES (N'X4', N'Phân xưởng X4')
INSERT [dbo].[PHONG] ([MaPhong], [TenPhong], [SoDienThoai]) VALUES (N'GD', N'Phòng giám đốc', N'0543825645')
INSERT [dbo].[PHONG] ([MaPhong], [TenPhong], [SoDienThoai]) VALUES (N'NS', N'Phòng nhân sự', N'0543829941')
INSERT [dbo].[PHONG] ([MaPhong], [TenPhong], [SoDienThoai]) VALUES (N'NV', N'Phòng nhân viên', N'0543828848')
INSERT [dbo].[PHONG] ([MaPhong], [TenPhong], [SoDienThoai]) VALUES (N'PGD', N'Phòng phó giám đốc', N'0543825891')
INSERT [dbo].[PHONG] ([MaPhong], [TenPhong], [SoDienThoai]) VALUES (N'TC', N'Phòng tài chính', N'0543826545')
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'11D4021169', CAST(4.65 AS Decimal(3, 2)), CAST(350000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'1240210007', CAST(3.66 AS Decimal(3, 2)), CAST(300000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'1240210008', CAST(3.33 AS Decimal(3, 2)), CAST(200000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'1240210017', CAST(3.66 AS Decimal(3, 2)), CAST(200000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'1240210027', CAST(3.33 AS Decimal(3, 2)), CAST(170000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'1240210046', CAST(4.98 AS Decimal(3, 2)), CAST(170000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'1240210054', CAST(3.33 AS Decimal(3, 2)), CAST(170000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'1240210075', CAST(3.33 AS Decimal(3, 2)), CAST(170000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'1240210081', CAST(4.32 AS Decimal(3, 2)), CAST(150000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'1240210082', CAST(2.67 AS Decimal(3, 2)), CAST(150000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'1240210096', CAST(4.32 AS Decimal(3, 2)), CAST(150000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'1240210142', CAST(4.32 AS Decimal(3, 2)), CAST(150000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'1240210156', CAST(2.67 AS Decimal(3, 2)), CAST(140000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'1240210397', CAST(2.34 AS Decimal(3, 2)), CAST(140000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'1240210400', CAST(2.67 AS Decimal(3, 2)), CAST(140000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'1240210401', CAST(3.66 AS Decimal(3, 2)), CAST(140000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'1240210425', CAST(2.67 AS Decimal(3, 2)), CAST(140000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'1240210435', CAST(2.67 AS Decimal(3, 2)), CAST(140000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'1240210451', CAST(3.66 AS Decimal(3, 2)), CAST(140000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'12D4021612', CAST(2.67 AS Decimal(3, 2)), CAST(140000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'13D4011271', CAST(2.67 AS Decimal(3, 2)), CAST(140000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'13D4011272', CAST(2.67 AS Decimal(3, 2)), CAST(140000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'13D4011282', CAST(2.34 AS Decimal(3, 2)), CAST(120000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'13D4011285', CAST(2.34 AS Decimal(3, 2)), CAST(120000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'13D4011289', CAST(3.33 AS Decimal(3, 2)), CAST(120000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'13D4011293', CAST(2.34 AS Decimal(3, 2)), CAST(120000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'13D4011294', CAST(2.34 AS Decimal(3, 2)), CAST(120000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'13D4011301', CAST(2.34 AS Decimal(3, 2)), CAST(120000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'13D4011304', CAST(3.33 AS Decimal(3, 2)), CAST(120000 AS Decimal(15, 0)))
INSERT [dbo].[THUNHAP_NV] ([MaNhanVien], [HeSo], [PhuCap]) VALUES (N'13D4011305', CAST(2.34 AS Decimal(3, 2)), CAST(120000 AS Decimal(15, 0)))
ALTER TABLE [dbo].[NHANVIEN]  WITH CHECK ADD  CONSTRAINT [FK_NHANVIEN_PHANXUONG] FOREIGN KEY([MaPhanXuong])
REFERENCES [dbo].[PHANXUONG] ([MaPhanXuong])
GO
ALTER TABLE [dbo].[NHANVIEN] CHECK CONSTRAINT [FK_NHANVIEN_PHANXUONG]
GO
ALTER TABLE [dbo].[NHANVIEN]  WITH CHECK ADD  CONSTRAINT [FK_NHANVIEN_PHONG] FOREIGN KEY([MaPhong])
REFERENCES [dbo].[PHONG] ([MaPhong])
GO
ALTER TABLE [dbo].[NHANVIEN] CHECK CONSTRAINT [FK_NHANVIEN_PHONG]
GO
ALTER TABLE [dbo].[NHANVIEN]  WITH CHECK ADD  CONSTRAINT [FK_NHANVIEN_THUNHAP_NV] FOREIGN KEY([MaNhanVien])
REFERENCES [dbo].[THUNHAP_NV] ([MaNhanVien])
GO
ALTER TABLE [dbo].[NHANVIEN] CHECK CONSTRAINT [FK_NHANVIEN_THUNHAP_NV]
GO
