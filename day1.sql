USE [DIEMTUYENSINH]
GO
/****** Object:  Table [dbo].[DIEMTS]    Script Date: 9/9/2024 6:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIEMTS](
	[MaSinhVien] [nvarchar](10) NOT NULL,
	[Diemmon1] [decimal](3, 1) NULL,
	[Diemmon2] [decimal](3, 1) NULL,
	[Diemmon3] [decimal](3, 1) NULL,
 CONSTRAINT [PK_DIEMTS] PRIMARY KEY CLUSTERED 
(
	[MaSinhVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LOP]    Script Date: 9/9/2024 6:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOP](
	[MaLop] [nvarchar](15) NOT NULL,
	[TenLop] [nvarchar](50) NULL,
 CONSTRAINT [PK_LOP] PRIMARY KEY CLUSTERED 
(
	[MaLop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SINHVIEN]    Script Date: 9/9/2024 6:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SINHVIEN](
	[MaSinhVien] [nvarchar](10) NOT NULL,
	[MaLop] [nvarchar](15) NULL,
	[HoDem] [nvarchar](45) NULL,
	[Ten] [nvarchar](15) NULL,
	[NgaySinh] [date] NULL,
	[GioiTinh] [bit] NULL,
	[NoiSinh] [nvarchar](250) NULL,
 CONSTRAINT [PK_SINHVIEN] PRIMARY KEY CLUSTERED 
(
	[MaSinhVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SINHVIEN_HO_LE]    Script Date: 9/9/2024 6:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SINHVIEN_HO_LE](
	[MaSinhVien] [nvarchar](10) NOT NULL,
	[MaLop] [nvarchar](15) NULL,
	[HoDem] [nvarchar](45) NULL,
	[Ten] [nvarchar](15) NULL,
	[NgaySinh] [date] NULL,
	[GioiTinh] [bit] NULL,
	[NoiSinh] [nvarchar](250) NULL,
 CONSTRAINT [PK_SINHVIEN_HO_LE] PRIMARY KEY CLUSTERED 
(
	[MaSinhVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[DIEMTS] ([MaSinhVien], [Diemmon1], [Diemmon2], [Diemmon3]) VALUES (N'DL01', CAST(9.1 AS Decimal(3, 1)), CAST(8.2 AS Decimal(3, 1)), CAST(9.4 AS Decimal(3, 1)))
INSERT [dbo].[DIEMTS] ([MaSinhVien], [Diemmon1], [Diemmon2], [Diemmon3]) VALUES (N'DL02', CAST(7.5 AS Decimal(3, 1)), CAST(6.9 AS Decimal(3, 1)), CAST(8.1 AS Decimal(3, 1)))
INSERT [dbo].[DIEMTS] ([MaSinhVien], [Diemmon1], [Diemmon2], [Diemmon3]) VALUES (N'DL03', CAST(4.9 AS Decimal(3, 1)), CAST(5.7 AS Decimal(3, 1)), CAST(8.7 AS Decimal(3, 1)))
INSERT [dbo].[DIEMTS] ([MaSinhVien], [Diemmon1], [Diemmon2], [Diemmon3]) VALUES (N'DL04', CAST(7.8 AS Decimal(3, 1)), CAST(8.5 AS Decimal(3, 1)), CAST(6.8 AS Decimal(3, 1)))
INSERT [dbo].[DIEMTS] ([MaSinhVien], [Diemmon1], [Diemmon2], [Diemmon3]) VALUES (N'KD01', CAST(7.4 AS Decimal(3, 1)), CAST(7.8 AS Decimal(3, 1)), CAST(4.2 AS Decimal(3, 1)))
INSERT [dbo].[DIEMTS] ([MaSinhVien], [Diemmon1], [Diemmon2], [Diemmon3]) VALUES (N'KD02', CAST(2.1 AS Decimal(3, 1)), CAST(6.8 AS Decimal(3, 1)), CAST(4.2 AS Decimal(3, 1)))
INSERT [dbo].[DIEMTS] ([MaSinhVien], [Diemmon1], [Diemmon2], [Diemmon3]) VALUES (N'KD03', CAST(7.4 AS Decimal(3, 1)), CAST(8.3 AS Decimal(3, 1)), CAST(5.5 AS Decimal(3, 1)))
INSERT [dbo].[DIEMTS] ([MaSinhVien], [Diemmon1], [Diemmon2], [Diemmon3]) VALUES (N'KD04', CAST(5.9 AS Decimal(3, 1)), CAST(6.8 AS Decimal(3, 1)), CAST(4.9 AS Decimal(3, 1)))
INSERT [dbo].[DIEMTS] ([MaSinhVien], [Diemmon1], [Diemmon2], [Diemmon3]) VALUES (N'KD05', CAST(7.8 AS Decimal(3, 1)), CAST(3.7 AS Decimal(3, 1)), CAST(4.2 AS Decimal(3, 1)))
INSERT [dbo].[DIEMTS] ([MaSinhVien], [Diemmon1], [Diemmon2], [Diemmon3]) VALUES (N'TM01', CAST(9.4 AS Decimal(3, 1)), CAST(8.8 AS Decimal(3, 1)), CAST(9.6 AS Decimal(3, 1)))
INSERT [dbo].[DIEMTS] ([MaSinhVien], [Diemmon1], [Diemmon2], [Diemmon3]) VALUES (N'TM02', CAST(6.7 AS Decimal(3, 1)), CAST(6.1 AS Decimal(3, 1)), CAST(4.7 AS Decimal(3, 1)))
INSERT [dbo].[DIEMTS] ([MaSinhVien], [Diemmon1], [Diemmon2], [Diemmon3]) VALUES (N'TM03', CAST(3.4 AS Decimal(3, 1)), CAST(1.8 AS Decimal(3, 1)), CAST(4.2 AS Decimal(3, 1)))
INSERT [dbo].[DIEMTS] ([MaSinhVien], [Diemmon1], [Diemmon2], [Diemmon3]) VALUES (N'TM04', CAST(7.9 AS Decimal(3, 1)), CAST(9.3 AS Decimal(3, 1)), CAST(9.9 AS Decimal(3, 1)))
INSERT [dbo].[DIEMTS] ([MaSinhVien], [Diemmon1], [Diemmon2], [Diemmon3]) VALUES (N'TM05', CAST(7.1 AS Decimal(3, 1)), CAST(6.8 AS Decimal(3, 1)), CAST(4.2 AS Decimal(3, 1)))
INSERT [dbo].[LOP] ([MaLop], [TenLop]) VALUES (N'K45HDDL', N'Lớp K45HDDL')
INSERT [dbo].[LOP] ([MaLop], [TenLop]) VALUES (N'K45QTKD', N'Lớp K45QTKD')
INSERT [dbo].[LOP] ([MaLop], [TenLop]) VALUES (N'K45TMDL', N'Lớp K45TMDL')
INSERT [dbo].[LOP] ([MaLop], [TenLop]) VALUES (N'K46HDDL', N'Lớp K46HDDL')
INSERT [dbo].[LOP] ([MaLop], [TenLop]) VALUES (N'K46QTKD', N'Lớp K46QTKD')
INSERT [dbo].[SINHVIEN] ([MaSinhVien], [MaLop], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'DL01', N'K45HDDL', N'Dương Minh', N'Hùng', CAST(N'1993-05-15' AS Date), 1, N'TP Huế')
INSERT [dbo].[SINHVIEN] ([MaSinhVien], [MaLop], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'DL02', N'K45HDDL', N'Lê Thịnh', N'Vượng', CAST(N'1992-08-25' AS Date), 1, N'Quảng Trị')
INSERT [dbo].[SINHVIEN] ([MaSinhVien], [MaLop], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'DL03', N'K45HDDL', N'Thị', N'Nỡ', CAST(N'1991-12-29' AS Date), 0, N'Qu?ng Ngãi')
INSERT [dbo].[SINHVIEN] ([MaSinhVien], [MaLop], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'DL04', N'K45HDDL', N'Văn Bá Thành', N'Nhân', CAST(N'1994-03-11' AS Date), 1, N'Thừa Thiên Huế')
INSERT [dbo].[SINHVIEN] ([MaSinhVien], [MaLop], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'DL05', N'K45HDDL', N'Dư Ái', N'Nghĩa', CAST(N'1994-08-05' AS Date), 0, N'Thành Phố Huế')
INSERT [dbo].[SINHVIEN] ([MaSinhVien], [MaLop], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'DL06', N'K45HDDL', N'Văn', N'Cao', CAST(N'1991-12-25' AS Date), 1, N'Huế')
INSERT [dbo].[SINHVIEN] ([MaSinhVien], [MaLop], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'DL07', N'K45HDDL', N'Lệnh Hồ', N'Xung ', CAST(N'1991-05-09' AS Date), 1, N'Quảng Trị')
INSERT [dbo].[SINHVIEN] ([MaSinhVien], [MaLop], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'KD01', N'K46QTKD', N'Nguyễn Thị', N'Huế', CAST(N'1993-08-05' AS Date), 0, N'Đà Nẵng')
INSERT [dbo].[SINHVIEN] ([MaSinhVien], [MaLop], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'KD02', N'K46QTKD', N'Lê Thị', N'Lý ', CAST(N'1992-09-21' AS Date), 0, N'TT Huế')
INSERT [dbo].[SINHVIEN] ([MaSinhVien], [MaLop], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'KD03', N'K46QTKD', N'Lê Thị Hồng', N'Nga', CAST(N'1991-07-24' AS Date), 0, N'Qu?ng Ngãi')
INSERT [dbo].[SINHVIEN] ([MaSinhVien], [MaLop], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'KD04', N'K46QTKD', N'Lương Nguyễn Nguyệt', N'Loan', CAST(N'1992-12-24' AS Date), 0, N'TT Huế')
INSERT [dbo].[SINHVIEN] ([MaSinhVien], [MaLop], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'KD05', N'K46QTKD', N'Nguyễn Dương', N'Thiện', CAST(N'1992-04-21' AS Date), 1, N'Đà Nẵng')
INSERT [dbo].[SINHVIEN] ([MaSinhVien], [MaLop], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'KD06', N'K46QTKD', N'Dương', N'Quá', CAST(N'1992-11-09' AS Date), 1, N'Đà Nẵng')
INSERT [dbo].[SINHVIEN] ([MaSinhVien], [MaLop], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'TM01', N'K45TMDL', N'Võ Văn', N'Hậu', CAST(N'1992-09-21' AS Date), 1, N'Quảng Bình')
INSERT [dbo].[SINHVIEN] ([MaSinhVien], [MaLop], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'TM02', N'K45TMDL', N'Võ Thị Thu', N'Hằng', CAST(N'1993-05-21' AS Date), 0, N'Hà Nội')
INSERT [dbo].[SINHVIEN] ([MaSinhVien], [MaLop], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'TM03', N'K45TMDL', N'Trần Thị Khánh', N'Hòa', CAST(N'1992-06-24' AS Date), 0, N'Qu?ng Ngãi')
INSERT [dbo].[SINHVIEN] ([MaSinhVien], [MaLop], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'TM04', N'K45TMDL', N'Đỗ Thị Ngọc', N'Huyền', CAST(N'1991-03-29' AS Date), 0, N'Hà Nội')
INSERT [dbo].[SINHVIEN] ([MaSinhVien], [MaLop], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'TM05', N'K45TMDL', N'Nguyễn Dư Ngọc', N'Ánh', CAST(N'1994-02-26' AS Date), 0, N'Hà Nội')
INSERT [dbo].[SINHVIEN] ([MaSinhVien], [MaLop], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'TM06', N'K45TMDL', N'Lê ', N'Bình', CAST(N'1993-11-15' AS Date), 1, N'Huế')
INSERT [dbo].[SINHVIEN] ([MaSinhVien], [MaLop], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'TM07', N'K45TMDL', N'Nguyễn', N'Tam', CAST(N'1991-06-25' AS Date), 1, N'Quảng Bình')
INSERT [dbo].[SINHVIEN] ([MaSinhVien], [MaLop], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'TM08', N'K45TMDL', N'Dư', N'Tuấn', CAST(N'1992-05-29' AS Date), 1, N'Đà Nẵng')
INSERT [dbo].[SINHVIEN_HO_LE] ([MaSinhVien], [MaLop], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'DL02', N'K45HDDL', N'Lê Thịnh', N'Vượng', CAST(N'1992-08-25' AS Date), 1, N'Quảng Trị')
INSERT [dbo].[SINHVIEN_HO_LE] ([MaSinhVien], [MaLop], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'KD02', N'K46QTKD', N'Lê Thị', N'Lý ', CAST(N'1992-09-21' AS Date), 0, N'TT Huế')
INSERT [dbo].[SINHVIEN_HO_LE] ([MaSinhVien], [MaLop], [HoDem], [Ten], [NgaySinh], [GioiTinh], [NoiSinh]) VALUES (N'TM06', N'K45TMDL', N'Lê ', N'Bình', CAST(N'1993-11-15' AS Date), 1, N'Huế')
ALTER TABLE [dbo].[DIEMTS]  WITH CHECK ADD  CONSTRAINT [FK_DIEMTS_SINHVIEN] FOREIGN KEY([MaSinhVien])
REFERENCES [dbo].[SINHVIEN] ([MaSinhVien])
GO
ALTER TABLE [dbo].[DIEMTS] CHECK CONSTRAINT [FK_DIEMTS_SINHVIEN]
GO
ALTER TABLE [dbo].[SINHVIEN]  WITH CHECK ADD  CONSTRAINT [FK_SINHVIEN_LOP] FOREIGN KEY([MaLop])
REFERENCES [dbo].[LOP] ([MaLop])
GO
ALTER TABLE [dbo].[SINHVIEN] CHECK CONSTRAINT [FK_SINHVIEN_LOP]
GO
