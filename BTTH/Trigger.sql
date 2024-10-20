--D Trigger
--D1
create trigger bosung_nv on NhanVien
after insert
as
begin
	declare @manv nvarchar(10)
	select @manv = manhanvien 
	from inserted
	insert into THUNHAP_NV(MaNhanVien,HeSo,PhuCap)
	values(@manv,0.0,0)
end
-- Disable the foreign key constraint temporarily
alter table NHANVIEN nocheck constraint FK_THUNHAP_NV_NHANVIEN

insert into NHANVIEN(MaNhanVien,HoDem,Ten,NgaySinh,GioiTinh,DiaChi,MaPhong,MaPhanXuong)
values(N'22T1020763',N'Tiến',N'Pro','1997-11-17',1,N'TP Huế','NV','A1')
select *
from NHANVIEN
select * 
from THUNHAP_NV
drop trigger bosung_nv

--D2
create trigger Trg_Update_Phucap on THUNHAP_NV
for update
as
begin
	declare @mnv nvarchar(10)
	declare @hsl_cu decimal(3,2)
	declare @hsl_moi decimal(3,2)
	select @hsl_cu = HeSo
	from THUNHAP_NV
	select @hsl_moi = HeSo,@mnv = MaNhanVien
	from inserted 
	update THUNHAP_NV
	set PhuCap = Phucap +( ( @hsl_moi- @hsl_cu ) * 100000)
	where MaNhanVien = @mnv
end

update THUNHAP_NV
set HeSo = 5.0
where MaNhanVien = '1240210017'
select * from THUNHAP_NV
drop trigger Trg_Update_PhuCap



--D3
create trigger Trg_ThuNhap_Update_PhuCap on ThuNhap_NV
for update
as
begin
	declare @mnv nvarchar(10)
	declare @hsl_cu decimal(3,2)
	declare @hsl_moi decimal(3,2)
	select @hsl_cu = HeSo
	from THUNHAP_NV
	select @hsl_moi = HeSo,@mnv = MaNhanVien
	from inserted 
	update THUNHAP_NV
	set PhuCap = ( ( @hsl_moi- @hsl_cu ) * 100000)
	where HeSo = @hsl_moi
end 
select * from THUNHAP_NV
update THUNHAP_NV
set HeSo = 3.0
where MaNhanVien = '1240210017'
drop trigger Trg_ThuNhap_Update_PhuCap

--D4
create trigger Trg_xoa_nhanvien on nhanvien 
for delete
as
begin
	delete NHANVIEN
	where MaNhanVien in (select MaNhanVien from deleted)
end
delete NHANVIEN
where MaNhanVien = '1240210007'
delete THUNHAP_NV
where MaNhanVien = '1240210008'
drop trigger Trg_xoa_nhanvien
select * from NHANVIEN
select * from THUNHAP_NV

--D5
exec sp_helptext Trg_update_phucap

--D6
drop trigger Trg_update_phucap
