--> Khai báo biến: Cú pháp>> DECLARE @<tên_biến> kiểu dữ liệu
--> Đặt giá trị cho biến: DECLARE @<tên_biến> kiểu dữ liệu = giá trị or set @<tên_biến> = giá trị or select @<tên_biến> = giá trị 

DECLARE @HOTEN nvarchar(20)
set @HOTEN = N'Phước Tiến'

print @HOTEN 

--> ví dụ tìm điểm lớn nhất
DECLARE @diem decimal(3,1)
select @diem = MAX(Diemmon1)
from DIEMTS
print CONCAT('MAX diemmon1: ',@diem)

-->Ví dụ về biến kiểu ngày tháng
DECLARE @date date
set @date = '2019-04-16';
DECLARE @Curent_date date = GETDATE()
DECLARE @Due_date  date = GETDATE()+2

select @date as 'Date',
		@Curent_date as 'Curent date',
		@Due_date as 'Due Date'

-->Ví dụ về biến kiểu table

DECLARE @tablenew table(
		malopn nvarchar(15),
		tenlopn nvarchar(20))

Insert into @tablenew(malopn,tenlopn)
select MaLop,TenLop
from LOP
where TongSoSinhVien != 0

select *
from @tablenew

-->Cấu trúc điều kiện
DECLARE @a int = 10,@b int = 20 
DECLARE @max int
if(@a > @b)
begin
	set @max = @a
end
else
begin
	set @max = @b
end
print concat('MAX : ',@max)

-->Cấu trúc lặp
DECLARE @i int = 0
DECLARE @n int = 10
DECLARE @s int = 0
while(@i <= @n)
begin 
	set @s = @s + @i
	set @i = @i + 1
end
print @s
-->• BREAK: Thoát khỏi vòng lặp WHILE
--> CONTINUE: Thực hiện lần lặp mới

--> Bắt lỗi
-- Sử dụng BEGIN TRY .. END TRY để bẫy lỗi.
-- Nếu lỗi xẩy ra trong khối này
-- nó sẽ nhẩy vào khối BEGIN CATCH .. END CATCH.
BEGIN TRY

Lệnh xử lý

END TRY
-- BEGIN CATCH .. END CATCH phải được đặt ngay
-- phía sau của khối BEGIN TRY .. END TRY.
BEGIN CATCH
Xử lý lỗi
END CATCH