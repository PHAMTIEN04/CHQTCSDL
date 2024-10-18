--trigger sẽ được gọi khi có thao tác thay đổi thông tin bảng
--inserted: chứa những trường đã insert | update vào bảng
--deleted: chứa những trường bị xóa khỏi bảng

create trigger UTG_InsertSinhVien on sinhvien
for insert,update
as
begin
	print N'Thành công'
end

insert into SINHVIEN(MaSinhVien,MaLop,HoDem,Ten,NgaySinh,GioiTinh,NoiSinh)
values('DL09','K45HDDL','asda','asasd',null,1,null)
drop trigger UTG_insertSinhvien
exec sp_helptext UTG_InsertSinhVien
--ROLLBACK TRAN: Hủy bỏ thay đổi cập nhật của bảng
create trigger UTG_InsertSinhVien on sinhvien
for insert,update
as
begin
	Rollback tran
	print N'Không Thành công'
end

insert into SINHVIEN(MaSinhVien,MaLop,HoDem,Ten,NgaySinh,GioiTinh,NoiSinh)
values('DL010','K45HDDL','asda','asasd',null,1,null)

--xóa 1 sinh viên có giá trị ngày sinh bằng null ngược lại thì không xóa được sử dụng trigger
create trigger US_Delete on sinhvien
for delete
as
begin
	declare @count int = 0
	select @count= COUNT(*)
	from deleted
	where NgaySinh is null
	if(@count <= 0)
		begin
		print N'Ngày sinh khác null không xóa được'
		rollback tran
		end
	else
		begin
		print N'Ngày sinh bằng null đã xóa thành công'
		end
end
select * from sinhvien

delete from SINHVIEN where MaSinhVien = 'DL08'