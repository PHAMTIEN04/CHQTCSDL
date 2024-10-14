﻿--khác với stores procedure là function có giá trị trả về
select *
from sinhvien
create function func_find_name(@msv nvarchar(10))
returns nvarchar(60)
as
begin
	declare @name nvarchar(60)
	select @name = CONCAT(hodem,' ',Ten)
	from SINHVIEN
	where MaSinhVien = @msv
	return @name
end

select dbo.func_find_name(N'DL01')

--1
create function Fn_tong(@n int)
returns real 
as
begin
	return (@n*(@n+1))/2
end

select dbo.Fn_tong(7) 

--2
create function Fn_tong_nghich(@n int)
returns real 
as
begin
	declare @s real = 1
	declare @i int = 2
	while @i<=@n
		begin
			set @s = @s + 1.0*1/@i
			set @i = @i + 1
		end
	return @s
end

select dbo.Fn_tong_nghich(5)
drop function Fn_tong_nghich
--3
create function Fn_Demsv(@MaLop nvarchar(15))
returns int
as
begin
	
	return (select COUNT(MaLop)
	from SINHVIEN
	where MaLop =@MaLop)
end

select dbo.Fn_Demsv(N'K46QTKD')

--4
drop function Fn_Demsv
create function Fn_Demsv(@MaLop nvarchar(15),@GioiTinh bit)
returns int
as
begin
	
	return (select COUNT(MaLop)
	from SINHVIEN
	where MaLop =@MaLop and GioiTinh = @GioiTinh)
end
select dbo.Fn_Demsv(N'K46QTKD',1)

--5 
create function Fn_SV_NamSinh(@Namsinh int)
returns int
as
begin
	return (select Count(ngaysinh)
			from SINHVIEN
			where Year(ngaysinh) = @Namsinh)
end

select dbo.Fn_SV_NamSinh(11993)

--6
create function Fn_SV_HoLe(@HoSV nvarchar(45))
returns table
as
	return (select * 
			from SINHVIEN
			where HoDem like  @HoSV +' %' or HoDem = @HoSV)
select * from dbo.Fn_SV_HoLe(N'Lê')
drop function Fn_SV_HoLe

--7
create function Fn_SV_NhoTuoi(@MaLop nvarchar(15))
returns table
as
	
	return (select TOP 3*
	from sinhvien
	where malop = @MaLop
	order by ngaysinh desc)

select * from dbo.Fn_SV_NhoTuoi(N'K45HDDL')

--8
create function Fn_Diem_SV(@MaSV nvarchar(10))
returns table
as 
	return (select sv.*,dts.Diemmon1+dts.Diemmon2+dts.Diemmon3 as N'Tổng điểm 3 môn'
			from SINHVIEN sv left join DIEMTS dts
			on sv.MaSinhVien = dts.MaSinhVien
			where sv.MaSinhVien = @MaSV)

select * from dbo.Fn_Diem_SV(N'DL01')

--9
create function Fn_TongSV_Lop(@MaLop nvarchar(15))
returns table
as
	return (select l.MaLop,l.TenLop,COUNT(sv.MaSinhVien) as N'Tổng số sinh viên'
			from LOP l left join SINHVIEN sv
			on l.MaLop = sv.MaLop
			where l.MaLop = @MaLop
			group by l.MaLop,l.TenLop
	)

select * from dbo.Fn_TongSV_Lop(N'K45HDDL')
drop function Fn_TongSV_Lop
--10
create function Fn_TongSV_NamSinh(@MaLop nvarchar(15),@NamSinh int = 1992)
returns table
as
	return (select l.MaLop,l.TenLop,COUNT(sv.MaSinhVien) as N'Tổng số sinh viên'
			from LOP l left join SINHVIEN sv
			on l.MaLop = sv.MaLop
			where l.MaLop = @MaLop and YEAR(sv.NgaySinh) = @NamSinh 
			group by l.MaLop,l.TenLop
	)

select * from dbo.Fn_TongSV_NamSinh(N'K45HDDLád',default)
drop function Fn_TongSV_NamSinh

--11
create function Fn_TongSV_TenLop(@TenLop nvarchar(50))
returns @thongkesv table(
		malop nvarchar(15),
		tenlop nvarchar(50),
		tong int
)
as
begin
	if not exists (select 1 from LOP where TenLop = @TenLop)
		begin
				insert into @thongkesv
				select l.MaLop,l.TenLop,COUNT(sv.MaSinhVien) as N'Tổng số sinh viên'
				from LOP l left join SINHVIEN sv
				on l.MaLop = sv.MaLop
				group by l.MaLop,l.TenLop	
		end
	else
		begin
				insert into @thongkesv
				select l.MaLop,l.TenLop,COUNT(sv.MaSinhVien) as N'Tổng số sinh viên'
				from LOP l left join SINHVIEN sv
				on l.MaLop = sv.MaLop
				where l.TenLop = @TenLop
				group by l.MaLop,l.TenLop
		end
	return 
end
select *
from dbo.Fn_TongSV_TenLop(N'Lớp K45HDDL')
drop function Fn_TongSV_TenLop
--12

create function Fn_TongSV_Tinh(@NoiSinh nvarchar(250))
returns @thongkesv table(
	noisinh nvarchar(250),
	tong int
	)
as
begin
	if not exists (select 1 from SinhVien where NoiSinh = @NoiSinh)
		begin	
				insert into @thongkesv
				select noisinh,COUNT(MaSinhVien) as N'Tổng số sinh viên'
				from SINHVIEN 
				group by noisinh
		end
	else
		begin
				insert into @thongkesv
				select noisinh,COUNT(MaSinhVien) as N'Tổng số sinh viên'
				from SINHVIEN 
				where noisinh = @NoiSinh
				group by noisinh
		end

	return
	
end		
select *
from dbo.Fn_TongSV_Tinh(N'Huế')
drop function Fn_TongSV_Tinh
--13

create function Fn_TongSV_NamSinh(@NamSinh int)
returns @thongkesv table(
	namsinh int,
	tong int
	)
as
begin
	if not exists (select 1 from SinhVien where year(ngaysinh) = @NamSinh)
		begin	
				insert into @thongkesv
				select year(ngaysinh),COUNT(MaSinhVien) as N'Tổng số sinh viên'
				from SINHVIEN
				group by year(ngaysinh)
		end
	else
		begin
				insert into @thongkesv
				select year(ngaysinh),COUNT(MaSinhVien) as N'Tổng số sinh viên'
				from SINHVIEN 
				where year(ngaysinh) = @NamSinh
				group by year(ngaysinh)
		end
		return
end
select *
from dbo.Fn_TongSV_NamSinh(1991)
drop function Fn_TongSV_NamSinh
--14 xem nội dung hàm
exec sp_helptext Fn_TongSV_Lop
--15 xóa hàm
drop function Fn_TongSV_Tinh
--hàm không thể trả về một thông báo trực tiếp.
--UNION ALL là một toán tử trong SQL được sử dụng để kết hợp kết quả của hai hoặc nhiều truy vấn SELECT. 
--Nó trả về tất cả các hàng từ mỗi truy vấn mà không loại bỏ các bản sao, có nghĩa là nếu có các hàng giống nhau giữa các truy vấn, chúng sẽ được giữ lại trong kết quả.
--UNION ALL: Giữ tất cả các kết quả, bao gồm cả các kết quả trùng lặp.
--UNION: Chỉ giữ các kết quả duy nhất (loại bỏ các dòng trùng lặp).