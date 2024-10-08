--1
create procedure p_date
as 
begin
	declare @d_date date
	set @d_date = GETDATE()
	print @d_date	
end

exec p_date
--2
create procedure hcn_dt_cv (@chieudai int, @chieurong int)
as
begin
	
	print concat(N'Diện tích hình chữ nhật là: ',@chieudai * @chieurong)
	print concat(N'Chu vi hình chữ nhật là: ',2*(@chieudai + @chieurong))
end

exec hcn_dt_cv @chieudai = 10, @chieurong = 2
drop procedure hcn_dt_cv

--3
create procedure in_ds_sv_ml(@mlop nvarchar(15))
as
begin
	select MaSinhVien,CONCAT(hodem,' ',ten) as N'Họ Tên',NgaySinh,GioiTinh,MaLop
	from SINHVIEN
	where malop = @mlop
end
drop procedure in_ds_sv_ml
exec in_ds_sv_ml @mlop = N'K45HDDL'

--4
create procedure in_ds_sv_tl(@tlop nvarchar(50))
as
begin
	select s.MaSinhVien,CONCAT(s.hodem,' ',s.ten)  as N'Họ Tên',s.NgaySinh,l.MaLop,l.TenLop
	from Lop l join SINHVIEN s on l.MaLop = s.MaLop
	where l.TenLop = @tlop
end
drop procedure in_ds_sv_tl
exec in_ds_sv_tl @tlop = N'Lớp K45HDDL'

--5
create procedure in_ds_sv_gt_ns (@gt bit = 0,@ns nvarchar(250) = N'TT Huế')
as
begin
	select MaSinhVien,CONCAT(hodem,' ',ten)  as N'Họ Tên',
			case gioitinh
				when 1 then N'Nam'
				when 0 then N'Nữ'
			end as N'Gioitinh',
			NoiSinh
	from SINHVIEN
	where GioiTinh = @gt and NoiSinh = @ns	

end

exec in_ds_sv_gt_ns @gt = '0' , @ns = ''

--6
create procedure in_date_x_y(@x int,@y int)
as
begin
	if(@x > @y)
		begin
			print N'Dữ liệu không hợp lệ'
		end
	else
		begin
			select *
			from SINHVIEN
			where MONTH(NgaySinh) between @x and @y
		end
end

exec in_date_x_y @x =1, @y= 8

--7
create procedure in_ds_ns(@ns nvarchar(250))
as
begin
	select MaSinhVien,CONCAT(hodem,' ',ten)  as N'Họ Tên',NgaySinh,NoiSinh
	from SINHVIEN 
	where NoiSinh = @ns
end

exec in_ds_ns @ns = N'Hà Nội'

--8
create procedure in_ds_ns_c(@ns nvarchar(250))
as
begin
	select MaSinhVien,CONCAT(hodem,' ',ten)  as N'Họ Tên',NgaySinh,NoiSinh
	from SINHVIEN 
	where NoiSinh like '%'+@ns+'%'
end
drop procedure in_ds_ns_c
exec in_ds_ns_c @ns = N'H'

--9
create procedure in_diem(@msv nvarchar(10))
as
begin
	select s.MaSinhVien,CONCAT(s.hodem,' ',ten)  as N'Họ Tên',s.NgaySinh,dts.Diemmon1,dts.Diemmon2,dts.Diemmon3,dts.Diemmon1 + dts.Diemmon2 + dts.Diemmon3 as N'Tổng điểm'
	from SINHVIEN s join DIEMTS dts on s.MaSinhVien = dts.MaSinhVien
	where s.MaSinhVien = @msv
end
drop procedure in_diem
exec in_diem @msv = 'DL01'

--10
create procedure in_tsv(@tlop nvarchar(50))
as
begin
	if (not exists(SELECT 1 FROM LOP WHERE TenLop = @tlop))
		begin
			print concat(N'Tên lớp: ',@tlop,N' không tồn tại')
		end
	else
		begin
			select l.MaLop,l.TenLop,COUNT(sv.MaLop) as N'Tổng số sinh viên'
			from LOP l left join SINHVIEN sv 
			on l.MaLop = sv.MaLop
			group by l.MaLop,l.TenLop
			having l.TenLop = @tlop
		end
end
drop procedure in_tsv
exec in_tsv @tlop = N'L'
exec in_tsv @tlop = N'Lớp K45HDDL'
--11
create procedure in_tsv_n(@tlop nvarchar(50))
as
begin
	if (not exists(SELECT 1 FROM LOP WHERE TenLop = @tlop))
		begin
			select l.MaLop,l.TenLop,COUNT(sv.MaLop) as N'Tổng số sinh viên'
			from LOP l left join SINHVIEN sv 
			on l.MaLop = sv.MaLop
			group by l.MaLop,l.TenLop
		end
	else
		begin
			select l.MaLop,l.TenLop,COUNT(sv.MaLop) as N'Tổng số sinh viên'
			from LOP l left join SINHVIEN sv 
			on l.MaLop = sv.MaLop
			group by l.MaLop,l.TenLop
			having l.TenLop = @tlop
		end
end
drop procedure in_tsv_n
exec in_tsv_n @tlop = N'L'
exec in_tsv_n @tlop = N'Lớp K45HDDL'

--12
create procedure bosung_sv(@msv nvarchar(10), @mlop nvarchar(15),@hd nvarchar(45),@t nvarchar(15),@ns date,@gt bit,@noisinh nvarchar(250))
as
begin
	begin try
		insert into SINHVIEN(MaSinhVien,MaLop,HoDem,Ten,NgaySinh,GioiTinh,NoiSinh) 
		values(@msv,@mlop,@hd,@t,@ns,@gt,@noisinh)
		print N'Thêm dữ liệu mới thành công vào bảng SINHVIEN'
	end try
	begin catch
		print N'Dữ liệu thêm vào không hợp lệ'
	end catch
end
drop procedure bosung_sv
exec bosung_sv @msv =N'DL08',@mlop =N'K45HDDL' ,@hd =N'Phạm Phước' , @t =N'Tiến' , @ns = '2004-11-17', @gt = 1 , @noisinh= N'Huế'
select *
from SINHVIEN
where MaSinhVien = N'DL08'

--13
CREATE PROCEDURE ss_diem(@msv1 NVARCHAR(10), @msv2 NVARCHAR(10))
AS
BEGIN
    DECLARE @diem_sv1 DECIMAL(3,1)
    DECLARE @diem_sv2 DECIMAL(3,1)
    DECLARE @msv_higher NVARCHAR(10)

    SELECT 
        @diem_sv1 = MAX(CASE WHEN sv.MaSinhVien = @msv1 THEN dts.Diemmon1 ELSE NULL END),
        @diem_sv2 = MAX(CASE WHEN sv.MaSinhVien = @msv2 THEN dts.Diemmon1 ELSE NULL END)
    FROM SINHVIEN sv
    JOIN DIEMTS dts ON sv.MaSinhVien = dts.MaSinhVien

    SET @msv_higher = CASE WHEN @diem_sv1 > @diem_sv2 THEN @msv1 ELSE @msv2 END

    SELECT sv.MaSinhVien, CONCAT(sv.hodem, ' ', sv.ten) AS N'Họ Tên', sv.NgaySinh, dts.Diemmon1
    FROM SINHVIEN sv
    JOIN DIEMTS dts ON sv.MaSinhVien = dts.MaSinhVien
    WHERE sv.MaSinhVien = @msv_higher
END

drop procedure ss_diem
exec ss_diem @msv1 = N'DL03' , @msv2 = N'DL02'

--14 
CREATE PROCEDURE ss_tongdiem(@msv1 NVARCHAR(10), @msv2 NVARCHAR(10))
AS
BEGIN
    DECLARE @tdiem_sv1 DECIMAL(3,1)
    DECLARE @tdiem_sv2 DECIMAL(3,1)
    DECLARE @msv_higher NVARCHAR(10)

    SELECT 
        @tdiem_sv1 = MAX(CASE WHEN sv.MaSinhVien = @msv1 THEN dts.Diemmon1+dts.Diemmon2+dts.Diemmon3 ELSE NULL END),
        @tdiem_sv2 = MAX(CASE WHEN sv.MaSinhVien = @msv2 THEN dts.Diemmon1+dts.Diemmon2+dts.Diemmon3 ELSE NULL END)
    FROM SINHVIEN sv
    JOIN DIEMTS dts ON sv.MaSinhVien = dts.MaSinhVien

    SET @msv_higher = CASE WHEN @tdiem_sv1 > @tdiem_sv2 THEN @msv1 ELSE @msv2 END

    SELECT sv.MaSinhVien, CONCAT(sv.hodem, ' ', sv.ten) AS N'Họ Tên', sv.NgaySinh, dts.Diemmon1,dts.Diemmon2,dts.Diemmon3,dts.Diemmon1 + dts.Diemmon2 + dts.Diemmon3 as N'Tổng điểm'
    FROM SINHVIEN sv
    JOIN DIEMTS dts ON sv.MaSinhVien = dts.MaSinhVien
    WHERE sv.MaSinhVien = @msv_higher
END
drop procedure ss_tongdiem
exec ss_tongdiem @msv1 = N'DL01' , @msv2 = N'DL02'

--15
CREATE PROCEDURE ss_tongdiem_n(@msv1 NVARCHAR(10), @msv2 NVARCHAR(10))
AS
BEGIN
    DECLARE @tdiem_sv1 DECIMAL(3,1)
    DECLARE @tdiem_sv2 DECIMAL(3,1)
    DECLARE @msv_higher NVARCHAR(10)

    SELECT 
        @tdiem_sv1 = MAX(CASE WHEN sv.MaSinhVien = @msv1 THEN dts.Diemmon1+dts.Diemmon2+dts.Diemmon3 ELSE NULL END),
        @tdiem_sv2 = MAX(CASE WHEN sv.MaSinhVien = @msv2 THEN dts.Diemmon1+dts.Diemmon2+dts.Diemmon3 ELSE NULL END)
    FROM SINHVIEN sv
    JOIN DIEMTS dts ON sv.MaSinhVien = dts.MaSinhVien
	if(@tdiem_sv1 = @tdiem_sv2)
		begin
		    SELECT sv.MaSinhVien, CONCAT(sv.hodem, ' ', sv.ten) AS N'Họ Tên', sv.NgaySinh, dts.Diemmon1,dts.Diemmon2,dts.Diemmon3,dts.Diemmon1 + dts.Diemmon2 + dts.Diemmon3 as N'Tổng điểm'
			FROM SINHVIEN sv
			JOIN DIEMTS dts ON sv.MaSinhVien = dts.MaSinhVien
			WHERE sv.MaSinhVien = @msv1 or sv.MaSinhVien = @msv2
		end
	else
		begin
			SET @msv_higher = CASE WHEN @tdiem_sv1 > @tdiem_sv2 THEN @msv1 ELSE @msv2 END

			SELECT sv.MaSinhVien, CONCAT(sv.hodem, ' ', sv.ten) AS N'Họ Tên', sv.NgaySinh, dts.Diemmon1,dts.Diemmon2,dts.Diemmon3,dts.Diemmon1 + dts.Diemmon2 + dts.Diemmon3 as N'Tổng điểm'
			FROM SINHVIEN sv
			JOIN DIEMTS dts ON sv.MaSinhVien = dts.MaSinhVien
			WHERE sv.MaSinhVien = @msv_higher
		end
END
exec ss_tongdiem_n @msv1 = N'DL01' , @msv2 = N'DL06'
drop procedure ss_tongdiem_n

--16
create proc proc_TK_SV_ThangSinh(@TuThang int,@DenThang int)
as
	begin
		if (@TuThang > @DenThang or @TuThang < 1 or @TuThang > 12 or @DenThang < 1 or @DenThang > 12)
			begin
			return;
			end
		declare @t table(
			thang int,
			tong int
			)
		declare @i int
		
		set @i=@TuThang
		while @i <= @DenThang
			begin
				declare @tt int 
				select @tt = Count(*)
				from sinhvien as s
				where MONTH(ngaysinh) = @i
				insert into @t(thang,tong) values(@i,@tt)
				set @i = @i + 1
			end
		select *
		from @t

		
	end

exec proc_TK_SV_ThangSinh @TuThang = 3,@DenThang = 12
drop proc proc_TK_SV_ThangSinh
--17
create proc proc_TK_SV_ThangSinh_Lop(@malop nvarchar(15),@TuThang int,@DenThang int)
as
	begin
		if (@TuThang > @DenThang or @TuThang < 1 or @TuThang > 12 or @DenThang < 1 or @DenThang > 12)
			begin
			return;
			end
		declare @t table(
			thang int,
			tong int
			)
		declare @i int
		
		set @i=@TuThang
		while @i <= @DenThang
			begin
				declare @tt int 
				select @tt = Count(*)
				from sinhvien as s
				where MONTH(ngaysinh) = @i and MaLop = @malop
				insert into @t(thang,tong) values(@i,@tt)
				set @i = @i + 1
			end
		select *
		from @t

		
	end
exec proc_TK_SV_ThangSinh_Lop @malop =N'K45HDDLL' ,@TuThang = 5,@DenThang = 12
drop proc proc_TK_SV_ThangSinh_Lop
--18
CREATE PROC proc_TK_SV_NgaySinh_Lop
    @malop nvarchar(15),
    @TuNgay date,
    @DenNgay date
AS
BEGIN
    IF (@TuNgay > @DenNgay)
    BEGIN
        RETURN;
    END

    DECLARE @t TABLE (
        ngay date,
        tong int
    );

    DECLARE @currentDate date;
    SET @currentDate = @TuNgay;

    WHILE @currentDate <= @DenNgay
    BEGIN
        DECLARE @tt int;
        SELECT @tt = COUNT(*)
        FROM sinhvien
        WHERE ngaysinh = @currentDate AND MaLop = @malop;
        INSERT INTO @t(ngay, tong) VALUES (@currentDate, @tt);

        -- Tăng ngày hiện tại lên 1 ngày
        SET @currentDate = DATEADD(DAY, 1, @currentDate);
    END
    SELECT *
    FROM @t;
END

exec proc_TK_SV_NgaySinh_Lop @malop =N'K45HDDL' ,@TuNgay = '1994-03-10',@DenNgay = '1994-03-15'
drop proc proc_TK_SV_NgaySinh_Lop




--Sự khác biệt giữa COUNT(*) và các biến thể khác của COUNT:
--COUNT(*): Đếm tất cả các hàng, bất kể các cột có chứa giá trị NULL hay không.

--COUNT(column_name): Chỉ đếm những hàng mà cột column_name không có giá trị NULL.