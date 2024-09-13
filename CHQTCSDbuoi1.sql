select * from DIEMTS
select * from SINHVIEN
select * from LOP

-->cau1
select masinhvien,hodem,ten,ngaysinh,gioitinh
from SINHVIEN
where hodem like N'Lê %'
-->cau2
select masinhvien,hodem,ten,ngaysinh,gioitinh
from SINHVIEN
where hodem like N'%Thị %' or hodem like N'Thị%'
-->cau3
select masinhvien,hodem,ten,ngaysinh,gioitinh
from SINHVIEN
where hodem like N'% Văn'
-->cau4
select masinhvien,hodem+' '+ten as N'Họ và Tên',ngaysinh,gioitinh,s.malop,l.tenlop
from SINHVIEN as s,LOP as l
where l.malop = s.malop and (hodem like N'Dư %' or hodem = N'Dư' or  ten like 'V%')
-->cau5
select masinhvien,hodem+' '+ten as N'Họ và Tên',ngaysinh,gioitinh,noisinh
from SINHVIEN
where noisinh like N'%Huế%'
-->cau6
select masinhvien,hodem+' '+ten as N'Họ và Tên',ngaysinh,gioitinh,l.malop,l.tenlop
from SINHVIEN as s,LOP as l
where l.malop = s.malop and MONTH(ngaysinh) between 3 and 8 and YEAR(ngaysinh) = 1992
-->cau7
select masinhvien,hodem+' '+ten as N'Họ và Tên',ngaysinh,gioitinh,l.malop,l.tenlop
from SINHVIEN as s,LOP as l
where l.malop = s.malop and (gioitinh = 0 or MONTH(ngaysinh) between 5 and 11)
-->cau8
select masinhvien,hodem+' '+ten as N'Họ và Tên',ngaysinh,gioitinh,l.malop,l.tenlop
from SINHVIEN as s,LOP as l
where l.malop = s.malop and (hodem not like N'Lê %' and hodem not like N'Dư %' and hodem != N'Dư' and hodem not like N'Võ %' and hodem not like N'Nguyễn %' and hodem != N'Nguyễn')
-->cau9
select masinhvien,hodem+' '+ten as N'Họ và Tên',ngaysinh,gioitinh,l.malop,l.tenlop
from SINHVIEN as s,LOP as l
where l.malop = s.malop and hodem like N'Lê %' and( Ten = N'Nga' or Ten = N'Lý')
-->cau10
select masinhvien,hodem+' '+ten as N'Họ và Tên',ngaysinh,gioitinh,l.malop,l.tenlop
from SINHVIEN as s,LOP as l
where l.malop = s.malop and noisinh =''
-->cau11
select l.malop,l.tenlop,COUNT(MaSinhVien) as N'Tổng số sinh viên'
from SINHVIEN as s right join LOP as l
on l.malop = s.malop
group by l.MaLop, l.TenLop
-->cau12
select l.malop,l.tenlop,COUNT(MaSinhVien) as N'Tổng số sinh viên'
from SINHVIEN as s right join LOP as l
on l.malop = s.malop
group by l.MaLop, l.TenLop
having COUNT(MaSinhVien) = 0
-->cau13
SELECT l.MaLop, l.TenLop, COUNT(s.MaSinhVien) AS N'Tổng số sinh viên'
FROM SINHVIEN AS s
RIGHT JOIN LOP AS l ON l.MaLop = s.MaLop
GROUP BY l.MaLop, l.TenLop
HAVING COUNT(s.MaSinhVien) = (
    SELECT TOP 1 COUNT(sv.MaSinhVien)
    FROM SINHVIEN AS sv
    RIGHT JOIN LOP AS lp ON lp.MaLop = sv.MaLop
    GROUP BY lp.MaLop, lp.TenLop
    ORDER BY COUNT(sv.MaSinhVien) DESC
)


-->cau14
select TOP 5 noisinh,COUNT(NoiSinh) as N'Tổng số sinh viên'
from SINHVIEN 
group by NoiSinh
order by N'Tổng số sinh viên' desc
-->cau15
select TOP 5 s.MaSinhVien,s.hodem+' '+s.ten as N'Họ và Tên',s.NgaySinh,s.GioiTinh,s.MaLop,l.TenLop,(dts.Diemmon1 + dts.Diemmon2 + dts.Diemmon3)/3 as N'Điểm Trung Bình'
from LOP as l join SINHVIEN as s on l.MaLop = s.MaLop 
join DIEMTS as dts on s.MaSinhVien = dts.MaSinhVien
where GioiTinh = 0
order by N'Điểm Trung Bình' desc
-->16
select s.MaSinhVien,s.hodem+' '+s.ten as N'Họ và Tên',s.NgaySinh,s.GioiTinh,s.MaLop,l.TenLop,dts.Diemmon1
from LOP as l join SINHVIEN as s on l.MaLop = s.MaLop 
join DIEMTS as dts on s.MaSinhVien = dts.MaSinhVien
where dts.Diemmon1 = ( select TOP 1 diemmon1
						from DIEMTS
						order by diemmon1 desc
						)
-->17
select s.MaSinhVien,s.hodem+' '+s.ten as N'Họ và Tên',s.NgaySinh,s.GioiTinh,s.MaLop,l.TenLop,(dts.Diemmon1 + dts.Diemmon2 + dts.Diemmon3)/3 as N'Điểm Trung Bình'
from LOP as l join SINHVIEN as s on l.MaLop = s.MaLop 
join DIEMTS as dts on s.MaSinhVien = dts.MaSinhVien
where (dts.Diemmon1 + dts.Diemmon2 + dts.Diemmon3)/3 = (select TOP 1 (dts.Diemmon1 + dts.Diemmon2 + dts.Diemmon3)/3
														from DIEMTS as dts
														order by (dts.Diemmon1 + dts.Diemmon2 + dts.Diemmon3)/3 desc)

-->18
select masinhvien,hodem+' '+ten as N'Họ và Tên',ngaysinh,gioitinh,noisinh
from SINHVIEN
where noisinh = (select NoiSinh
				from SINHVIEN
				where MaSinhVien = 'DL03') 
-->and MaSinhVien != 'DL03'

-->19
select * 
from SINHVIEN_HO_LE
delete from SINHVIEN_HO_LE
-->20
insert into SINHVIEN_HO_LE
select masinhvien, malop,hodem ,ten, ngaysinh , gioitinh,noisinh
from SINHVIEN 
where hodem like 'Lê%' 
-->21
update SINHVIEN_HO_LE
set noisinh = N'Quảng Bình'
where masinhvien like '%03'
select * 
from SINHVIEN_HO_LE
-->22
delete SINHVIEN_HO_LE
where YEAR(NgaySinh) = 1991 and MONTH(NgaySinh) between 3 and 10 
select * 
from SINHVIEN_HO_LE
-->23
delete SINHVIEN_HO_LE
where YEAR(ngaysinh) = (
						select Year(ngaysinh)
						from SINHVIEN_HO_LE 
						where masinhvien = 'KD02')
select * 
from SINHVIEN_HO_LE
-->24
update LOP
set TongSoSinhVien =(select COUNT(MaSinhVien)
from SINHVIEN as s
where Lop.MaLop = s.malop)
select * 
from LOP

select *
from SINHVIEN
where HoDem not like (N'Lê')