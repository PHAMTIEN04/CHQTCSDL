select * from Registration
select * from Examinee
select * from Certificate

--Câu 1
--a
alter trigger trg_Registration_Insert on Registration
for insert
as
begin
	update Certificate
	set NumberOfRegister = (select count(*)
							from Registration
							where CertificateId = Certificate.CertificateId)
										         
end

insert Registration(ExamineeId,CertificateId)
values(1,2)

--b
create trigger trg_Registration_Update on Registration
for update
as
begin
	update Certificate
	set NumberOfPass = (select count(*)
							from Registration
							where CertificateId = Certificate.CertificateId and ExamResult >= 5)

end

update Registration
set ExamResult = 5
where ExamineeId = 1 and CertificateId =2

--Câu 2
--a
alter proc proc_Registration_Add(@ExamineeId int,
								  @CertificateId int,
								  @Result nvarchar(255) output)
as
begin
	if exists(select 1 from Registration where ExamineeId = @ExamineeId and CertificateId = @CertificateId)
	begin
		set @Result = N'Da ton tai ho so'
		return
	end
	if not exists(select 1 from Examinee where ExamineeId = @ExamineeId)
	begin
		set @Result = N'Khong ton tai ExamineeId'
		return
	end
	if not exists(select 1 from Certificate where CertificateId = @CertificateId)
	begin
		set @Result = N'Khong ton tai CertificateId'
		return
	end
	insert Registration(examineeId,certificateId)
	values(@examineeId,@certificateId)
	set @Result = ''
end
declare @resultt nvarchar(255)
exec proc_Registration_Add @examineeid = 2,@certificateid = 1,@result= @resultt output
print @resultt 

--b
create proc proc_SaveExamResult(@ExamineeId int,
								@CertificateId int,
								@ExamResult int,
								@Result nvarchar(255) output)
as
begin
	if not exists(select 1 from Registration where ExamineeId = @ExamineeId and CertificateId = @CertificateId)
	begin
		set @Result = N'Khong ton tai ho so'
		return
	end
	if not(@ExamResult between 0 and 10)
	begin
		set @Result = N'Diem thi khong nam trong 0 - 10'
		return
	end
	update Registration
	set ExamResult = @ExamResult
	where ExamineeId = @ExamineeId and CertificateId = @CertificateId
end
declare @resultt nvarchar(255) 
exec proc_SaveExamResult @examineeId= 1,@CertificateId= 1,@Examresult= 5,@Result= @resultt output
print @resultt

--c
create proc proc_Examinee_Select(@SearchValue nvarchar(255) = N'',
								 @Page int = 1,
								 @PageSize int = 20,
								 @RowCount int output,
								 @PageCount int output)
as 
begin
	declare @from int
	set @from = (@Page-1)*@PageSize

	select *
	from Examinee
	where Concat(firstname,' ',lastname) like '%' + @SearchValue + '%'
	order by ExamineeId
	offset @from rows
	fetch next @pagesize rows only
	set @RowCount = @@ROWCOUNT
	set @PageCount = (@@ROWCOUNT/@PageSize)
end
declare @rowcountt int
declare @pagecountt int
exec proc_Examinee_Select @searchvalue= N'',@page=2,@pagesize=2,@RowCount=@rowcountt output,@PageCount=@rowcountt output
print @rowcountt
print @pagecountt

--d
create proc proc_CountRegisteringByDate(@from date,
										@to date)
as
begin
	if @from > @to
	begin
		return
	end
	declare @tb table(ngay date,
					  soluong int)
	declare @i date = @from
	while @i <= @to
	begin
		declare @tt int
		select @tt = COUNT(*)
		from Registration
		where RegisterTime = @i

		insert @tb(ngay,soluong) values(@i,@tt)
		set @i = DATEADD(day,1,@i)
	end
	select *
	from @tb

end

exec proc_CountRegisteringByDate @from = '2024-12-19',@to = '2024-12-23'

--cau 3
--a
create function func_CountPassed(@examineeid int)
returns int 
as
begin
	declare @td int
	select @td = count(*)
	from Registration
	where ExamineeId = @examineeid and ExamResult >=5
	return @td

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
	declare @i date =@from
	while @i <= @to
	begin
		declare @tt int
		select @tt = count(*)
		from Registration
		where RegisterTime = @i
		insert @thongke(ngay,sl) values(@i,@tt)
		set @i = DATEADD(day,1,@i)
	end
	return

end

select *
from func_TotalByDate('2024-12-19','2024-12-23')