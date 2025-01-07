select * from Examinee
select * from Certificate
select * from Registration
--data
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
--cau1
--a
create trigger trg_Registration_Insert on Registration
for insert
as
begin
	update Certificate
	set NumberOfRegister = NumberOfRegister + (select count(*)
											   from inserted i
											   where Certificate.CertificateId = i.CertificateId)

end
delete from Registration
where ExamineeId = 1
insert into Registration(ExamineeId,CertificateId)
values(1,1)
--b
alter trigger trg_Registration_Update on registration
for update
as
begin
	declare @old int 
	declare @new int
	select @old = examresult from deleted
	select @new = examresult from inserted
	if @old < 5 and @new >= 5
	begin
		update Certificate
		set NumberOfPass = NumberOfPass +1
		from Certificate c inner join inserted i 
		on c.CertificateId = i.CertificateId
	end
	if @old >= 5 and @new < 5
	begin
		update Certificate
		set NumberOfPass = NumberOfPass - 1
		from Certificate c inner join inserted i 
		on c.CertificateId = i.CertificateId

	end



end
select * from Certificate
select * from Registration

update Registration
set ExamResult = 5
where ExamineeId = 1 and Certificateid = 1
--cau2
--a
alter proc proc_Registration_Add(@ExamineeId int,
								  @CertificateId int,
								  @Result nvarchar(255) output)
as
begin
	if not exists(select 1 from Examinee where ExamineeId = @ExamineeId)
	begin
		set @Result = N'Examinee khong ton tai'
		return
	end
	if not exists(select 1 from Certificate where CertificateId = @CertificateId)
	begin
		set @Result = N'Certificate khong ton tai'
		return
	end
	if exists(select 1 from Registration where ExamineeId = @ExamineeId and CertificateId = @CertificateId)
	begin
		set @Result = N'Registration da ton tai'
		return
	end
	set @Result = ''
	insert into Registration(ExamineeId,CertificateId)
	values(@ExamineeId,@CertificateId)

end
select * from Registration
declare @rs nvarchar(255)
exec proc_Registration_Add @examineeId=1,@certificateId=2,@Result=@rs output
select @rs as result
--b
create proc proc_SaveExamResult(@ExamineeId int,
								@CertificateId int,
								@ExamResult int,
								@Result nvarchar(255) output)
as
begin
	if not exists(select 1 from Registration where Examineeid = @ExamineeId and CertificateId = @CertificateId)
	begin
		set @Result = N'Registration khong ton tai'
		return

	end
	if not(@ExamResult between 0 and 10)
	begin
		set @Result = N'Khong nam trong khoang 0-10'
		return
	end
	set @Result =''
	update Registration
	set ExamResult=@ExamResult
	where ExamineeId = @ExamineeId and CertificateId=@CertificateId
end
select * from Registration
select * from Certificate
declare @rs nvarchar(255)
exec proc_SaveExamResult @examineeid=1,@certificateid=2,@examresult=5,@Result=@rs output
select @rs as result
--c
create proc proc_Examinee_Select9(@SearchValue nvarchar(255) = N'',
								  @Page int = 1,
								  @PageSize int = 20,
								  @RowCount int output,
								  @PageCount int output)
as
begin
	if @SearchValue = N''
	begin
		return
	end
	declare @from int
	set @from = (@Page - 1) * @PageSize
	select * 
	from Examinee
	where (FirstName+ ' '+ LastName) like '%' + @SearchValue + '%'
	order by ExamineeId asc
	offset @from rows
	fetch next @pagesize rows only
	set @RowCount = @@ROWCOUNT
	set @PageCount =@@ROWCOUNT / @PageSize

end
declare @r int
declare @p int
exec proc_Examinee_Select9 @searchvalue= N'T',@page=1,@pagesize=2,@RowCount=@r output,@PageCount=@p output
select @r as tongsodong
select @p as tongsotrang
select * from Examinee
--d
create proc proc_CountRegisteringByDate(@From date,
										@To date)
as
begin
	if @From > @To
	begin
		return
	end
	declare @tb table(ngay date,
					  sl int)
	declare @i date = @from
	while @i <= @To
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
exec proc_CountRegisteringByDate @from= '2025-01-07',@To='2025-01-09'
select * from Registration
--3
--a
create function func_CountPassed(@ExamineeId int)
returns int
as
begin
	declare @count int
	select @count= Count(*) 
	from Registration
	where ExamineeId = @ExamineeId and ExamResult >= 5
	return @count
end
select dbo.func_CountPassed(2) as sotinthidat

--b
create function fun_TotalByDate(@From date,@To date)
returns @tke table(ngay date,
				   sl int)
as
begin
	if @From > @To
	begin
		return
	end
	declare @i date = @From
	while @i<=@To
	begin
		declare @tt int
		select @tt = Count(*)
		from Registration
		where RegisterTime = @i
		insert into @tke(ngay,sl)
		values(@i,@tt)
		set @i = DATEADD(day,1,@i)

	end
	return
end
select *
from dbo.fun_TotalByDate('2025-01-07','2025-01-08')
select * 
from Registration

--cau4
create login normal_new11 with password = '123'
create user normal_user11 for login normal_new11

grant select
on certificate
to normal_user11
with grant option

grant execute
on dbo.proc_Registration_Add
to normal_user11
with grant option

grant execute
on dbo.proc_SaveExamResult
to normal_user11
with grant option

grant execute
on dbo.proc_Examinee_Select9
to normal_user11
with grant option

grant execute
on dbo.proc_CountRegisteringByDate
to normal_user11
with grant option

grant select
on dbo.func_CountPassed
to normal_user11
with grant option

grant select
on dbo.fun_TotalByDate
to normal_user11
with grant option
