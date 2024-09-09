select * from DIEMTS
select * from SINHVIEN
select * from LOP

-->cau1
select masinhvien,hodem,ten,ngaysinh,gioitinh
from SINHVIEN
where hodem like 'Lê%'
-->cau2
select masinhvien,hodem,ten,ngaysinh,gioitinh
from SINHVIEN
where hodem like N'%Thị %'
-->cau3
select masinhvien,hodem,ten,ngaysinh,gioitinh
from SINHVIEN
where hodem like N'%Văn%'
-->cau4
select masinhvien,hodem+' '+ten as N'Họ và Tên',ngaysinh,gioitinh,s.malop,l.tenlop
from SINHVIEN as s,LOP as l
where l.malop = s.malop and (hodem like N'%Dư %' or hodem like N'Dư' or  ten like 'V%')
-->cau5
select masinhvien,hodem+ten as N'Họ và Tên',ngaysinh,gioitinh,noisinh
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
where l.malop = s.malop and hodem not like N'%Lê%' and hodem not like N'%Dư%' and hodem not like N'%Võ%' and hodem not like N'%Nguyễn%'
-->cau9
select masinhvien,hodem+' '+ten as N'Họ và Tên',ngaysinh,gioitinh,l.malop,l.tenlop
from SINHVIEN as s,LOP as l
where l.malop = s.malop and hodem like N'%Lê%' or hodem like N'%Nga%' or hodem like N'%Lý%'
-->cau10
select masinhvien,hodem+' '+ten as N'Họ và Tên',ngaysinh,gioitinh,l.malop,l.tenlop
from SINHVIEN as s,LOP as l
where l.malop = s.malop and noisinh =''
-->cau11
select masinhvien,hodem+' '+ten as N'Họ và Tên',l.malop,l.tenlop
from SINHVIEN as s,LOP as l
where l.malop = s.malop

