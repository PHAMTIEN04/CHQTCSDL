--Tao tai khoan dang nhap
create Login tienpro
		with password = '123'
create Login tienpro1
		with password = '123'

--Tao tai khoan nguoi su dung
create user csdl8 for login tienpro
create user csdl9 for login tienpro1

--Cap quyen
grant select 
on Lop(MaLop)
to csdl8
with grant option
select * from Lop
-- chuyen tiep quyen: with grant option
grant select       
on Lop(TenLop)
to csdl9
--cap quyen thuc thi 
grant create view,create table
to csdl8

--thu hoi quyen 
revoke select
on Lop
from csdl8
cascade
--cascade : thu hoi quyen chuyen tiep

-- grant option for 
revoke grant option for select
on lop
from csdl8