USE [23T1020763]
GO
/****** Object:  Table [dbo].[Certificate]    Script Date: 1/8/2025 12:41:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Certificate](
	[CertificateId] [int] NOT NULL,
	[CertificateName] [nvarchar](100) NOT NULL,
	[NumberOfRegister] [int] NOT NULL,
	[NumberOfPass] [int] NOT NULL,
 CONSTRAINT [PK_Certificate] PRIMARY KEY CLUSTERED 
(
	[CertificateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Examinee]    Script Date: 1/8/2025 12:41:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Examinee](
	[ExamineeId] [int] NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[BirthDate] [date] NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Examinee] PRIMARY KEY CLUSTERED 
(
	[ExamineeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Registration]    Script Date: 1/8/2025 12:41:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Registration](
	[ExamineeId] [int] NOT NULL,
	[CertificateId] [int] NOT NULL,
	[RegisterTime] [date] NOT NULL,
	[ExamResult] [int] NOT NULL,
 CONSTRAINT [PK_Registration] PRIMARY KEY CLUSTERED 
(
	[ExamineeId] ASC,
	[CertificateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[Certificate] ([CertificateId], [CertificateName], [NumberOfRegister], [NumberOfPass]) VALUES (1, N'Tin Học', 0, 0)
INSERT [dbo].[Certificate] ([CertificateId], [CertificateName], [NumberOfRegister], [NumberOfPass]) VALUES (2, N'Ngoại Ngữ', 0, 0)
INSERT [dbo].[Examinee] ([ExamineeId], [FirstName], [LastName], [BirthDate], [Email], [Address]) VALUES (1, N'Phạm Phước', N'Tiến', CAST(N'1992-01-01' AS Date), N'phamtien@gmail.com', N'TP Huế')
INSERT [dbo].[Examinee] ([ExamineeId], [FirstName], [LastName], [BirthDate], [Email], [Address]) VALUES (2, N'Ngô Viết', N'Thắng', CAST(N'1993-01-01' AS Date), N'ngothang@gmail.com', N'Hà Nội')
INSERT [dbo].[Examinee] ([ExamineeId], [FirstName], [LastName], [BirthDate], [Email], [Address]) VALUES (3, N'Trần Việt', N'Lân', CAST(N'1992-02-02' AS Date), N'lan@gmail.com', N'Đà Nẵng')
INSERT [dbo].[Examinee] ([ExamineeId], [FirstName], [LastName], [BirthDate], [Email], [Address]) VALUES (4, N'Lê Thanh', N'Thuyết', CAST(N'1992-03-03' AS Date), N'thuyet@gmail.com', N'TP Huế')
INSERT [dbo].[Examinee] ([ExamineeId], [FirstName], [LastName], [BirthDate], [Email], [Address]) VALUES (5, N'Lê Thanh', N'Minh', CAST(N'1993-04-04' AS Date), N'minh@gmail.com', N'Quảng Nam')
INSERT [dbo].[Registration] ([ExamineeId], [CertificateId], [RegisterTime], [ExamResult]) VALUES (1, 1, CAST(N'2025-01-08' AS Date), 0)
ALTER TABLE [dbo].[Certificate] ADD  CONSTRAINT [DF_Certificate_NumberOfRegister]  DEFAULT ((0)) FOR [NumberOfRegister]
GO
ALTER TABLE [dbo].[Certificate] ADD  CONSTRAINT [DF_Certificate_NumberOfPass]  DEFAULT ((0)) FOR [NumberOfPass]
GO
ALTER TABLE [dbo].[Registration] ADD  CONSTRAINT [DF_Registration_RegisterTime]  DEFAULT (getdate()) FOR [RegisterTime]
GO
ALTER TABLE [dbo].[Registration] ADD  CONSTRAINT [DF_Registration_ExamResult]  DEFAULT ((0)) FOR [ExamResult]
GO
ALTER TABLE [dbo].[Registration]  WITH CHECK ADD  CONSTRAINT [FK_Registration_Certificate] FOREIGN KEY([CertificateId])
REFERENCES [dbo].[Certificate] ([CertificateId])
GO
ALTER TABLE [dbo].[Registration] CHECK CONSTRAINT [FK_Registration_Certificate]
GO
ALTER TABLE [dbo].[Registration]  WITH CHECK ADD  CONSTRAINT [FK_Registration_Examinee] FOREIGN KEY([ExamineeId])
REFERENCES [dbo].[Examinee] ([ExamineeId])
GO
ALTER TABLE [dbo].[Registration] CHECK CONSTRAINT [FK_Registration_Examinee]
GO
