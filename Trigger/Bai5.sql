--1
create trigger Trg_Diemts_Insert on dbo.SinhVien
for insert
as
begin
	declare @msv nvarchar(10)
	select @msv = masinhvien
	from inserted
	insert into DIEMTS(MaSinhVien,Diemmon1,Diemmon2,Diemmon3)
	values(@msv,0,0,0)
end

insert into SINHVIEN(MaSinhVien,MaLop,HoDem,Ten,NgaySinh,GioiTinh,NoiSinh)
values(N'DL09',N'K45HDDL',N'Pham Phuoc',N'Tien','1993-05-15',1,N'Hue')
insert into SINHVIEN(MaSinhVien,MaLop,HoDem,Ten,NgaySinh,GioiTinh,NoiSinh)
values(N'DL10',N'K45HDDL',N'Pham Phuoc',N'Tien','1993-05-15',1,N'Hue')
insert into SINHVIEN(MaSinhVien,MaLop,HoDem,Ten,NgaySinh,GioiTinh,NoiSinh)
values(N'DL11',N'K45HDDL',N'Pham Phuoc',N'Tien','1993-05-15',1,N'Hue')
select * from SINHVIEN
select * from DIEMTS
drop trigger dbo.Trg_Diemts_Insert
delete from SINHVIEN where MaSinhVien =N'DL09'
--2
create trigger Trg_Diemts_Update on dbo.DIEMTS
for update
as
begin
	SET NOCOUNT ON;
    UPDATE DIEMTS
    SET Diemmon1 = i.Diemmon1, 
        Diemmon2 = i.Diemmon2, 
        Diemmon3 = i.Diemmon3, 
        tongdiem = (i.Diemmon1 + i.Diemmon2 + i.Diemmon3) / 3.0
    FROM DIEMTS d
    INNER JOIN inserted i
        ON d.MaSinhVien = i.MaSinhVien
    WHERE d.Diemmon1 != i.Diemmon1
       OR d.Diemmon2 != i.Diemmon2
       OR d.Diemmon3 != i.Diemmon3;
end
drop trigger Trg_Diemts_Update
select * from DIEMTS
select * from SINHVIEN
update DIEMTS
set Diemmon1 =10,Diemmon2=3
where MaSinhVien = N'DL02'
--3
create trigger Trg_DiemTS_Delete on dbo.DIEMTS
for delete
as
begin
	declare @msv nvarchar(10)
	select @msv = masinhvien
	from deleted
	delete from SINHVIEN where MaSinhVien = @msv
end

delete from DIEMTS where MaSinhVien = 'DL01'
--4
exec sp_helptext trg_diemts_update
--5 
drop trigger trg_diemts_update
--6
alter table Lop
add TongSoSinhVien int null

update LOP
set TongSoSinhVien= (select Count(*)
					from SINHVIEN
					where Lop.MaLop = SINHVIEN.MaLop)

select * from LOP

--7
create trigger trg_SinhVien_Insert on dbo.SinhVien
for insert
as
begin
	
		update LOP
		set TongSoSinhVien= tongsosinhvien+(select Count(*)
							from inserted
							where Lop.MaLop = inserted.MaLop)

end
drop trigger trg_sinhvien_insert

insert into SINHVIEN(MaSinhVien,MaLop,HoDem,Ten,NgaySinh,GioiTinh,NoiSinh)
values('DL14','K45HDDL',N'Lê Văn',N'Luyện','2004-12-01',1,'Hue')

select * from LOP
select * from SINHVIEN

--8

create trigger trg_SinhVien_delete on dbo.SinhVien
for delete
as
begin
	
		update LOP
		set TongSoSinhVien= tongsosinhvien-(select Count(*)
							from deleted
							where Lop.MaLop = deleted.MaLop)

end

delete sinhvien
where Masinhvien = N'DL13'
select * from LOP
select * from SINHVIEN