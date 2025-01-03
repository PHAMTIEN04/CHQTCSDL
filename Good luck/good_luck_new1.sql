select * from Registration
select * from certificate
select * from Examinee
--1
--a
alter trigger trg_Registration_Insert on Registration
for insert
as
begin
	update Certificate
	set NumberOfRegister = NumberOfRegister + 1
	from Certificate c inner join inserted i
	on c.CertificateId = i.CertificateId

end

insert Registration(ExamineeId,CertificateId)
values(2,1)
--b
alter trigger trg_Registration_Update on Registration
for update
as
begin
	declare @old int
	declare @new int
	select @old = ExamResult
	from deleted
	select @new = ExamResult
	from inserted 
	if @old < 5 and @new >= 5
	begin
		update Certificate
		set NumberOfPass = NumberOfPass + 1
		from Certificate c inner join inserted i
		on c.CertificateId = i.CertificateId
	end
	if @old >= 5 and @new < 5
	begin
		update Certificate
		set NumberOfPass = NumberOfPass - 1
		from Certificate c inner join inserted i
		on c.CertificateId = i.CertificateId
		where c.NumberOfPass !=0
	end
end

update Registration
set ExamResult = 5
where ExamineeId = 2 and CertificateId =1
--2
--a
create proc proc_Registration_Add(@ExamineeId int,
								  @CertificateId int,
								  @Result nvarchar(255) output)
as
begin
	if exists(select 1 from Registration where ExamineeId = @ExamineeId and CertificateId = @CertificateId)
	begin
		set @Result = N'Hồ sơ đã tồn tại'
		return
	end
	if not exists(select 1 from Examinee where ExamineeId = @ExamineeId)
	begin
		set @Result = N'Không tồn tại ExamineeId'
		return
	end
	if not exists(select 1 from Certificate where CertificateId = @CertificateId)
	begin
		set @Result = N'Không tồn tại CertificateId'
	end
	insert Registration(ExamineeId,CertificateId)
	values(@ExamineeId,@CertificateId)
	set @Result = ''
end
declare @resultt nvarchar(255)
exec proc_Registration_Add @examineeId = 2,@CertificateId = 2,@Result=@Resultt output
print @resultt

--b
alter proc proc_SaveExamResult(@ExamineeId int,
								@CertificateId int,
								@ExamResult int,
								@Result nvarchar(255) output)
as
begin
	if not exists(select 1 from Registration where ExamineeId = @ExamineeId and CertificateId = @CertificateId)
	begin
		set @Result = N'Hồ sơ không tồn tại'
		return
	end
	if not(@ExamResult between 0 and 10)
	begin
		set @Result = N'Khong thuoc 0 - 10'
	end
	update Registration
	set ExamResult = @ExamResult
	where ExamineeId =@ExamineeId and CertificateId =@CertificateId
	set @Result = ''
end
declare @resultt nvarchar(255)
exec proc_SaveExamResult @examineeId = 1, @certificateId=2,@ExamResult=5,@Result=@Resultt output
print @resultt
select * from Registration
select * from certificate
select * from Examinee
--c
create proc proc_Examinee_Select(@searchvalue nvarchar(255) = N'',
								 @page int =1,
								 @pagesize int = 20,
								 @rowcount int output,
								 @pagecount int output)
as
begin
	declare @from int
	set @from = (@page-1)*@pagesize
	select *
	from Examinee
	where CONCAT(FirstName,' ',LastName) like '%'+@searchvalue+'%'
	order by ExamineeId asc
	offset @from rows
	fetch next @pagesize rows only
	set @rowcount = @@ROWCOUNT
	set @pagecount =(@rowcount/@pagesize)
end
declare @rowcountt nvarchar(255)
declare @pagecountt nvarchar(255)
exec proc_Examinee_Select @searchvalue='',@page=2,@pagesize = 3,@rowcount= @rowcountt output,@pagecount =@pagecountt output
print @rowcountt
print @pagecountt

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
	while @i <= @to
	begin
		declare @tt int
		select @tt = Count(*)
		from Registration
		where RegisterTime = @i
		insert @tb(ngay,sl)
		values(@i,@tt)
		set @i = DATEADD(day,1,@i)
	end
	select *
	from @tb
end

exec proc_CountRegisteringByDate @from = '2024-12-24',@to = '2024-12-26'
--3
--a
create function func_CountPassed(@ExamineeId int)
returns int
as
begin
	declare @tt int
	select @tt = count(*)
	from Registration
	where ExamineeId = @ExamineeId and ExamResult>=5
	return @tt
end
select dbo.func_CountPassed(1)
--b
create function func_TotalByDate(@from date,@to date)
returns @thongke table(ngay date,
						sl int)
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
		insert @thongke(ngay,sl)
		values(@i,@tt)
		set @i = DATEADD(day,1,@i)
	end
	return

end
select *
from func_TotalByDate('2024-12-24','2024-12-26')

--Cau 4
create login normal with password = '123456'
create user normal_user for login normal

grant select
on certificate
to normal_user
grant execute
on dbo.trg_Registration_Insert
to normal_user
grant execute
on dbo.trg_Registration_Update
to normal_user
grant execute
on dbo.proc_Registration_Add
to normal_user
grant execute
on dbo.proc_SaveExamResult
to normal_user
grant execute
on dbo.proc_CountRegisteringByDate
to normal_user
grant execute
on dbo.func_CountPassed
to normal_user
grant execute
on dbo.func_TotalByDate
to normal_user

