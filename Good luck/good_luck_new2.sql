select * from Examinee
select * From Certificate
select * from Registration
--Cau1
--a
create trigger trg_Registration_Insert on Registration
for insert
as
begin
	update Certificate
	set NumberOfRegister = NumberOfRegister + 1
	from Certificate c inner join inserted i
	on c.CertificateId = i.CertificateId
end

insert into Registration(ExamineeId,CertificateId)
values(1,2)

--b
alter trigger trg_Registration_Update on Registration
for update
as
begin
	declare @new int
	declare @old int
	select @new = ExamResult
	from inserted
	select @old = ExamResult
	from deleted
	if(@old < 5 and @new >= 5)
	begin
		update Certificate
		set NumberOfPass = NumberOfPass + 1
		from Certificate c inner join inserted i
		on c.CertificateId = i.CertificateId
	end
	if(@old >= 5 and @new < 5)
	begin
		update Certificate
		set NumberOfPass = NumberOfPass - 1
		from Certificate c inner join inserted i
		on c.CertificateId = i.CertificateId
	end
end
update Registration
set ExamResult = 5
where ExamineeId = 1 and CertificateId = 2

--cau2
--a
create proc proc_Registration_Add(@ExamineeId int,
								  @CertificateId int,
								  @Result nvarchar(255) output)
as
begin
	if not exists(select 1 from Examinee where ExamineeId = @ExamineeId)
	begin
		set @Result = N'Ho so khong ton tai'
		return

	end
	if not exists(select 1 from Certificate where CertificateId = @CertificateId)
	begin
		set @Result = N'Chung chi khong ton tai'
		return
	end
	if exists( select 1 from Registration where ExamineeId = @ExamineeId and Certificateid = @CertificateId)
	begin
		set @Result= N'Ho so du thi da ton tai'
		return

	end
	set @Result = ''
	insert into Registration(ExamineeId,CertificateId)
	values(@ExamineeId,@CertificateId)

end
declare @rs nvarchar(255)
exec proc_Registration_Add @examineeId= 2,@certificateId=2,@Result=@rs output
print @rs

--b
create proc proc_SaveExamResult(@ExamineeId int,
								@CertificateId int,
								@ExamResult int,
								@Result nvarchar(255) output)
as
begin
	if not exists(select 1 from Registration where ExamineeId = @ExamineeId and CertificateId = @CertificateId)
	begin
		set @Result = N'Ho so khong ton tai'
		return
	end
	if not(@ExamResult between 0 and 10)
	begin
		set @Result = N'Khong nam trong khoang 0-10'
		return
	end
	set @Result = ''
	update Registration
	set ExamResult = @ExamResult
	where ExamineeId = @ExamineeId and CertificateId = @CertificateId
end
declare @rs nvarchar(255)
exec proc_SaveExamResult @examineeId=1,@certificateId=1,@examresult=22,@result=@rs output
print @rs

--c
create proc proc_Examinee_Select(@SearchValue nvarchar(255) = N'',
								 @Page int = 1,
								 @PageSize int =20,
								 @RowCount int output,
								 @PageCount int output)
as
begin
	if @SearchValue = N''
	begin
		return
	end
	declare @from int 
	set @from = (@page-1)*@PageSize
	select *
	from Examinee
	where (FirstName + ' ' + LastName) like '%' + @SearchValue + '%'
	order by ExamineeId
	offset @from rows
	fetch next @pagesize rows only
	set @RowCount = @@ROWCOUNT
	set @PageCount = (@RowCount/@PageSize)
end
declare @rc int
declare @pc int
exec proc_Examinee_Select @searchvalue = N'T',@page=2,@pagesize=2,@rowcount=@rc output,@pagecount= @pc output
print @rc
print @pc
select * from Examinee

--d
create proc proc_CountRegisteringByDate(@From date,
										@To date)
as
begin
	if @from > @To
	begin
		return
	end
	declare @tb table(ngay date,
					  sl int)
	declare @i date = @from
	while @i<=@To
	begin
		declare @tt int
		select @tt = COUNT(*)
		from Registration
		where RegisterTime = @i
		insert into @tb(ngay,sl)
		values(@i,@tt)
		set @i = DATEADD(day,1,@i)

	end
	select *
	from @tb
end
exec proc_CountRegisteringByDate @from = '2025-01-06',@to='2025-02-06'

--cau3
--a
create function func_CountPassed(@examineeId int)
returns int
as
begin
	declare @count int
	select @count = COUNT(*)
	from Registration
	where ExamineeId = @examineeId and ExamResult >= 5
	return @count

end
select dbo.func_CountPassed(1)
--b
create function func_TotalByDate(@from date,
								 @To date)
returns @thongke table(ngay date,
					   sl int)
as
begin
	declare @i date = @from
	while @i <= @to
	begin
		declare @tt int
		select @tt = count(*)
		from Registration
		where RegisterTime = @i
		insert into @thongke(ngay,sl)
		values(@i,@tt)
		set @i = DATEADD(day,1,@i)


	end
	return

end

select *
from dbo.func_TotalByDate('2025-01-05','2025-01-06')

--4
create login normal_new with password = '1234'
create user normal_user_new for login normal_new

grant select
on certificate
to normal_user_new
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

revoke select
on certificate
from normal_user