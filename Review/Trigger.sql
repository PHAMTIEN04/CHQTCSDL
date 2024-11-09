--D Trigger
--D1
create trigger BoSung_NV on dbo.NhanVien
for insert
as
begin
	declare @mnv nvarchar(15)
	select @mnv = Manhanvien
	from inserted
	insert into THUNHAP_NV(MaNhanVien,HeSo,PhuCap)
	values(@mnv,0,0)
end


insert into NHANVIEN(MaNhanVien,HoDem,Ten,NgaySinh,GioiTinh,DiaChi,MaPhong,MaPhanXuong)
values(N'11D4021164',N'Tiến',N'Pro','1997-11-17',1,N'TP Huế','NV','A1')
select *
from NHANVIEN
select * 
from THUNHAP_NV
drop trigger bosung_nv

--D2
create trigger Trg_Update_PhuCap on dbo.ThuNhap_NV
for update
as
begin
	if update(heso)
		begin
			update THUNHAP_NV 
			set THUNHAP_NV.PhuCap = THUNHAP_NV.PhuCap + ((i.HeSo - d.HeSo) * 100000)
			from inserted i inner join deleted d on i.MaNhanVien = d.MaNhanVien
			where THUNHAP_NV.MaNhanVien = i.MaNhanVien
		end
end

update THUNHAP_NV
set HeSo = 4
where MaNhanVien = N'11D4021165'
select * 
from THUNHAP_NV
drop trigger Trg_Update_PhuCap

--D3
create trigger Trg_ThuNhap_Update_PhuCap on dbo.ThuNhap_NV
for update
as
begin
	if update(phucap)
		begin
			update THUNHAP_NV 
			set THUNHAP_NV.PhuCap = THUNHAP_NV.PhuCap + (i.PhuCap - d.PhuCap) 
			from inserted i inner join deleted d on i.MaNhanVien = d.MaNhanVien
			where THUNHAP_NV.MaNhanVien != i.MaNhanVien and THUNHAP_NV.HeSo = i.HeSo
		end

end

update THUNHAP_NV
set PhuCap = 3000000
where MaNhanVien = N'11D4021169'
select * 
from THUNHAP_NV
--D4
create trigger Trg_Delete_ThuNhap on dbo.ThuNhap_NV
for delete
as
begin
	declare @mnv nvarchar(15)
	select @mnv = manhanvien
	from deleted
	delete NHANVIEN
	where MaNhanVien = @mnv

end

delete THUNHAP_NV
where MaNhanVien = N'14T1020764'

select * from NHANVIEN
select * from THUNHAP_NV

--D5
exec sp_helptext trg_delete_thunhap
--D6
drop trigger trg_delete_thunhap
--D7
alter table Phong
add TongSoNhanVien int Null
select * from Phong
update PHONG
set tongsonhanvien = (select Count(*)
						from NHANVIEN
						where PHONG.MaPhong = NHANVIEN.MaPhong
						)
--D8
alter trigger trg_NhanVien_Insert on dbo.NhanVien
for insert
as
begin
	declare @mnv nvarchar(15)
	select @mnv = manhanvien
	from inserted
	if exists(select 1 from NHANVIEN where MaNhanVien = @mnv)
		begin
		return
		end
	update PHONG
	set tongsonhanvien = tongsonhanvien+ (select Count(*)
						from inserted
						where PHONG.MaPhong = inserted.MaPhong
						)


end


insert into NHANVIEN(MaNhanVien,HoDem,Ten,NgaySinh,GioiTinh,DiaChi,MaPhong,MaPhanXuong)
values(N'11D4021163',N'Trần',N'Tiến','2000-01-01',0,N'Huế',N'NV',N'A1')
drop trigger trg_NhanVien_Insert

select * from NHANVIEN
select * from PHONG

--D9
alter trigger trg_NhanVien_Delete on dbo.NhanVien
for delete
as
begin
	update PHONG
	set tongsonhanvien = tongsonhanvien- (select Count(*)
						from deleted
						where PHONG.MaPhong = deleted.MaPhong
						)
end

delete NHANVIEN 
where manhanvien = N'11D4021163'