--BEGIN TRANSACTION: Bắt đầu một giao tác
--SAVE TRANSACTION: Đánh dấu một vị trí trong giao tác (gọi kaf điểm đánh dấu)
--ROLLBACK TRANSACTION: Quay lui trở lại đầu giao tác hoặc một điểm đánh dấu trước đó trong giao tác
--COMMIT TRANSACTION: Đánh dấu điểm kết thúc một giao tác. Khi câu lệnh này thực thi cũng có nghĩa là giao tác đã thực hiện thành công
--ROLLBACK [WORK]: Quay lui trở lại đầu giao tác
--COMMIT [WORK]: Đánh dấu kết thúc giao tác

--Syntax: BEGIN TRANSACTION [Tên_giao_tác]

--ví dụ: giao tác kết thúc do lệnh ROLLBACK TRANSACTION và mọi thay đổi về
--mặt dữ liệu mà giao tác đã thực hiện (update) đều không có tác dụng.
Begin Transaction giaotac1
update Sinhvien set noisinh=N'Huế'
where masinhvien = N'DL01'
Rollback Transaction giaotac1
select * from sinhvien

--ví dụ: giao tác kết thúc bởi lệnh COMMIT và thực hiện thành công việc cập nhật
--dữ liệu trên bảng SINHVIEN.
Begin Transaction giaotac2
update Sinhvien set noisinh=N'TP Huế'
where masinhvien = N'DL01'
COMMIT Transaction giaotac2
select * from sinhvien

--ví dụ: Câu lệnh COMMIT TRANSACTION trong giao tác dưới đây kết thúc thành công một giao tác
Begin Transaction giaotac3
update Sinhvien set noisinh=N'TP Huế'
where masinhvien = N'DL02'
Save Transaction a
update Sinhvien set noisinh=N'TP Huế'
where masinhvien = N'DL03'
Rollback transaction a
COMMIT Transaction giaotac3
select * from sinhvien
--ví dụ: Câu lệnh COMMIT TRANSACTION gặp lỗi
Begin Transaction giaotac4
update Sinhvien set noisinh=N'TP Huế'
where masinhvien = N'DL02'
Save Transaction a
update Sinhvien set noisinh=N'TP Huế'
where masinhvien = N'DL03'
Rollback transaction giaotac4
COMMIT Transaction giaotac4
select * from SINHVIEN

--Giao tác lồng nhau
--Ví dụ định nghĩa bảng như sau
Create Table T(A int primary key,B int)
--Thủ tục sp_TransEx
Create Proc sp_TransEx(@a int,@b int)
as
Begin
	Begin Transaction T1
	if not exists(select * from T where A = @a)
		insert into T values(@a,@b)
	if not exists(select * from T where A = @a+1)
		insert into T values(@a+1,@b+1)
	Commit transaction T1
End

select * from T
Begin Transaction T3
exec sp_TransEx 40,33
save transaction a
exec sp_TransEx 30,40
Rollback transaction a
commit transaction T3


