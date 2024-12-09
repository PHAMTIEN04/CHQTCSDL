USE [22T1020763]
GO
/****** Object:  UserDefinedFunction [dbo].[func_CountPassed]    Script Date: 12/12/2024 12:20:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[func_CountPassed](@examineeId int)
returns int
as
begin
declare @sl int
select @sl = COUNT(*)
from Registration
where ExamResult >= 5 and ExamineeId = @examineeId
return @sl
end

GO
/****** Object:  UserDefinedFunction [dbo].[func_totalbydate]    Script Date: 12/12/2024 12:20:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[func_totalbydate](@from date,@to date)
returns @thongke table(ngay date,sl int)
as
begin
if @from > @to
begin
return
end
declare @i date = @from
while @i <= @to
begin
declare @tt int
select @tt = Count(*)
from Registration
where RegisterTime = @i
insert into @thongke(ngay,sl)
values(@i,@tt)
set @i = DATEADD(day,1,@i)
end
return
end

GO
/****** Object:  Table [dbo].[Certificate]    Script Date: 12/12/2024 12:20:30 AM ******/
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
/****** Object:  Table [dbo].[Examinee]    Script Date: 12/12/2024 12:20:30 AM ******/
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
/****** Object:  Table [dbo].[Registration]    Script Date: 12/12/2024 12:20:30 AM ******/
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
INSERT [dbo].[Certificate] ([CertificateId], [CertificateName], [NumberOfRegister], [NumberOfPass]) VALUES (1, N'Tin Học', 5, 4)
INSERT [dbo].[Certificate] ([CertificateId], [CertificateName], [NumberOfRegister], [NumberOfPass]) VALUES (2, N'Ngoại Ngữ', 5, 2)
INSERT [dbo].[Examinee] ([ExamineeId], [FirstName], [LastName], [BirthDate], [Email], [Address]) VALUES (1, N'Phạm Phước', N'Tiến', CAST(N'1993-03-05' AS Date), N'phamtien@gmail.com', N'Huế')
INSERT [dbo].[Examinee] ([ExamineeId], [FirstName], [LastName], [BirthDate], [Email], [Address]) VALUES (2, N'Trần Việt', N'Lân', CAST(N'1994-04-06' AS Date), N'tranlan@gmail.com', N'Huế')
INSERT [dbo].[Examinee] ([ExamineeId], [FirstName], [LastName], [BirthDate], [Email], [Address]) VALUES (3, N'Lê Thanh', N'Thuyết', CAST(N'1995-01-05' AS Date), N'lethuyet@gmail.com', N'Hà Nội')
INSERT [dbo].[Examinee] ([ExamineeId], [FirstName], [LastName], [BirthDate], [Email], [Address]) VALUES (4, N'Nguyễn Hữu', N'Thiện', CAST(N'1992-02-11' AS Date), N'nguyenthien@gmail.com', N'Quảng Bình')
INSERT [dbo].[Examinee] ([ExamineeId], [FirstName], [LastName], [BirthDate], [Email], [Address]) VALUES (5, N'Hồng', N'Phương', CAST(N'1993-03-12' AS Date), N'hongphuong@gmail.com', N'Đà Nẵng')
INSERT [dbo].[Registration] ([ExamineeId], [CertificateId], [RegisterTime], [ExamResult]) VALUES (1, 1, CAST(N'2004-01-05' AS Date), 9)
INSERT [dbo].[Registration] ([ExamineeId], [CertificateId], [RegisterTime], [ExamResult]) VALUES (2, 1, CAST(N'2004-02-03' AS Date), 6)
INSERT [dbo].[Registration] ([ExamineeId], [CertificateId], [RegisterTime], [ExamResult]) VALUES (3, 2, CAST(N'2005-01-02' AS Date), 7)
INSERT [dbo].[Registration] ([ExamineeId], [CertificateId], [RegisterTime], [ExamResult]) VALUES (4, 2, CAST(N'2006-01-02' AS Date), 3)
INSERT [dbo].[Registration] ([ExamineeId], [CertificateId], [RegisterTime], [ExamResult]) VALUES (5, 1, CAST(N'2005-02-03' AS Date), 7)
INSERT [dbo].[Registration] ([ExamineeId], [CertificateId], [RegisterTime], [ExamResult]) VALUES (6, 2, CAST(N'2005-02-03' AS Date), 7)
INSERT [dbo].[Registration] ([ExamineeId], [CertificateId], [RegisterTime], [ExamResult]) VALUES (7, 1, CAST(N'2005-02-03' AS Date), 2)
INSERT [dbo].[Registration] ([ExamineeId], [CertificateId], [RegisterTime], [ExamResult]) VALUES (8, 1, CAST(N'2024-12-09' AS Date), 0)
INSERT [dbo].[Registration] ([ExamineeId], [CertificateId], [RegisterTime], [ExamResult]) VALUES (9, 2, CAST(N'2024-12-09' AS Date), 0)
INSERT [dbo].[Registration] ([ExamineeId], [CertificateId], [RegisterTime], [ExamResult]) VALUES (10, 2, CAST(N'2024-12-09' AS Date), 0)
/****** Object:  StoredProcedure [dbo].[proc_CountRegisteringByDate]    Script Date: 12/12/2024 12:20:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[proc_CountRegisteringByDate](@from date,
 @to date)
as
begin
if @from > @to
begin
return
end
declare @tb table(ngay date,
 sl int)
declare @i date = @from
while @i <= @to
begin
declare @tt int
select @tt = Count(*)
from Registration
where RegisterTime = @i
insert into @tb(ngay,sl)
values(@i,@tt)
set @i = DATEADD(day,1,@i)
end
select *
from @tb
end

GO
/****** Object:  StoredProcedure [dbo].[proc_Examinee_Select]    Script Date: 12/12/2024 12:20:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_Examinee_Select](	@SearchValue nvarchar(255) = N'',
									@Page int = 1,
									@PageSize int = 20,
									@RowCount int output,
									@PageCount int output)

as
begin
	if @SearchValue = ''
	begin
		return
	end
	declare @from int 
	set @from = (@page-1)*@PageSize

	select *
	from examinee
	where firstname +' ' +lastname like '%'+@SearchValue+'%'
	order by examineeID asc
	offset @from rows
	fetch next @pagesize rows only
	set @RowCount = @@ROWCOUNT
	set @PageCount = (@ROWCOUNT / @PageSize)
end
GO
/****** Object:  StoredProcedure [dbo].[proc_Registration_Add]    Script Date: 12/12/2024 12:20:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[proc_Registration_Add](@ExamineeId int,
 @CertificateId int,
 @Result nvarchar(255) output)
as
begin
if exists(select 1 from Registration where ExamineeId = @ExamineeId)
begin
set @Result = N'ExamineeId đã tồn tại!!!!'
return
end
if not exists(select 1 from Certificate where CertificateId = @CertificateId)
begin
set @Result = N'CertificateId không tồn tại!!!'
return
end
insert into Registration(ExamineeId,CertificateId,RegisterTime,ExamResult)
values(@ExamineeId,@CertificateId,GETDATE(),0)
set @Result = ''
end

GO
/****** Object:  StoredProcedure [dbo].[proc_SaveExamResult]    Script Date: 12/12/2024 12:20:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[proc_SaveExamResult](@ExamineeId int,
 @CertificateId int,
@ExamResult int,
@Result nvarchar(255) output)
as
begin
if not exists(select 1 from Registration where ExamineeId = @ExamineeId)
begin
set @Result = N'ExamineeId không tồn tại!!!!'
return
end
if not exists(select 1 from Certificate where CertificateId = @CertificateId)
begin
set @Result = N'CertificateId không tồn tại!!!'
return
end
if not(@ExamResult between 0 and 10)
begin
set @Result = N'Điểm thi không thuộc trong khoảng 0 - 10'
return
end
set @Result = ''
update Registration
set ExamResult = @ExamResult
where ExamineeId = @ExamineeId
end

GO
