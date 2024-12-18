select * from Registration
--1b
alter trigger trg_registration_update on Registration
for update
as
begin	
	declare @old int
	declare @new int
	select @old = ExamResult
	from deleted
	select @new = ExamResult
	from inserted 
	if(@old < 5 and @new >= 5)
	begin
		update Certificate
		set NumberOfPass = NumberOfPass + 1
		from inserted i inner join Certificate c
		on i.CertificateId = c.CertificateId
	end
	if(@old >= 5 and @new < 5)
	begin
		update Certificate
		set NumberOfPass = NumberOfPass - 1
		from inserted i inner join Certificate c
		on i.CertificateId = c.CertificateId
	end

end
select * from Registration
select * from Certificate

update Registration
set ExamResult = 5
where ExamineeId = 9

--2a
select * from examinee
alter proc proc_registration_Add(@ExamineeId int,
								  @CertificateId int,
								  @result nvarchar(255) output)
as
begin
	if exists(select 1 from Registration where ExamineeId = @ExamineeId and CertificateId = @CertificateId)
	begin
		set @result = N'Da Ton Tai'
		return
	end
	if not exists(select 1 from Examinee where ExamineeId = @ExamineeId)
	begin
		set @result = N'ExamineeID khong ton tai'
		return
	end 
	if not exists(select 1 from Certificate where CertificateId = @CertificateId)
	begin
		set @result = N'CertificateId khong ton tai'
		return
	end
	insert Registration(ExamineeId,CertificateId)
	values(@ExamineeId,@CertificateId)
	set @result = ''

end
select * from Examinee
select * from Registration
declare @resultt nvarchar(255)
exec proc_registration_Add @examineeid = 13,@certificateid= 1,@result= @resultt output
print @resultt

exec sp_helptext proc_registration_Add