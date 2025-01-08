--cau2

alter trigger Trigger_HuongDan_Insert on HuongDan
for insert
as
begin
	declare @magv int
	declare @tengv nvarchar(50)
	declare @sodetai int
	select @magv =i.MaGV,@tengv =gv.TenGV,@sodetai = 0
	from inserted i inner join GiangVien gv
	on i.MaGV = gv.MaGV
	if not exists(select 1 from sodetai where magv = @magv)
	begin
		insert into sodetai(magv,TenGV,sodetai)
		values(@magv,@tengv,@sodetai)
	end
	update sodetai
	set sodetai = sodetai + 1
	from sodetai s inner join inserted i
	on s.magv = i.MaGV
	

end

insert into HuongDan(MaDT,MaGV,NgayBatDau,NgayKetThuc,KetQua)
values('DT05',11,'1992-01-01','1992-02-02',10.00)
select * from sodetai
select * from HuongDan

--cau3
--a
create proc proc_capnhat_giangvien(@MaGV int,
								   @TenGV nvarchar(50),
								   @GioiTinh bit,
								   @DiaChi nvarchar(100),
								   @Luong decimal(5,2),
								   @KetQua nvarchar(255) output)
as
begin
	if not exists (select 1 from GiangVien where MaGV = @MaGV)
	begin
		set @KetQua = N'Giang Vien khong ton tai'
		return

	end
	set @KetQua = ''
	update GiangVien
	set TenGV=@TenGV,GioiTinh=@GioiTinh,DiaChi=@DiaChi,Luong=@Luong
	where MaGV = @MaGV

end
declare @kq nvarchar(255)
exec proc_capnhat_giangvien @magv=17,@TenGV=N'Tiến đẹp trai',@gioitinh=1,@diachi=N'Huế',@luong=100.00,@ketqua=@kq output
select @kq as ketqua
								   

select * from GiangVien

--b
create proc proc_danhsach_detai(@TenGV nvarchar(50),
								@ngay date)
as
begin
	select dt.MaDT,dt.TenDT,dt.KinhPhi,dt.NoiThucTap,gv.MaGV,gv.TenGV,hd.NgayBatDau,hd.NgayKetThuc,hd.KetQua
	from GiangVien gv left join HuongDan hd
	on gv.MaGV = hd.MaGV inner join DeTai dt 
	on hd.MaDT = dt.MaDT
	where TenGV =@TenGV and NgayBatDau < @ngay

end

exec proc_danhsach_detai @TenGV=N'Nguyễn Sơn',@ngay='2030-01-01'
select * from GiangVien

--c
create proc proc_thongkedetai(@thang int,
							  @nam int,
							  @loai bit,
							  @sodong int output,
							  @kinhphimax int output)
as
begin
	if @loai = 1
	begin
		select *
		from HuongDan
		where MONTH(ngayketthuc) = @thang and Year(NgayKetThuc) = @nam a

	end

end
select * from HuongDan

--d
alter proc proc_tke(@nam int,
					 @tongkinhphi int output)
as
begin
	declare @tb table (thang int,
					   tongkinhphi int)
	declare @i int = 1
	while @i <= 12
	begin
		declare @tt int
		select @tt = isnull(Sum(dt.KinhPhi),0)
		from HuongDan hd inner join DeTai dt 
		on hd.MaDT = dt.MaDT
		where Month(hd.NgayBatDau) = @i and Year(hd.ngaybatdau)= @nam
		insert into @tb (thang,tongkinhphi)
		values(@i,@tt)
		set @i = @i+1
	end
	select *
	from @tb
	select @tongkinhphi=sum(tongkinhphi) from @tb

end
declare @tkp int
exec proc_tke @nam=2022,@tongkinhphi=@tkp output
select @tkp as tongkinhphi
select * from HuongDan
select * from sodetai
--cau 4
--a
create function tke_detai(@maGV int,
						  @thang int,
						  @nam int)
returns int
as
begin
	declare @count int
	select @count = Count(*)
	from HuongDan
	where MaGV=@maGV and (MONTH(ngaybatdau)=@thang and YEAR(Ngaybatdau)=@nam)
	return @count
end

select dbo.tke_detai(11,1,2022) as sodetai

--b
create function tke_moinam(@from int,
						   @to int)
returns @tke table(nam int,
				   sl int)
as
begin
	if @from > @to
	begin
		return
	end
	declare @i int = @from
	while @i <= @to
	begin
		declare @tt int
		select @tt = COUNT(*)
		from HuongDan
		where year(NgayBatDau) = @i

		insert into @tke (nam,sl)
		values(@i,@tt)
		set @i = @i +1

	end
	return
end

select *
from dbo.tke_moinam(2020,2022)

--5
create login masv_tensv_lop with password ='masv'
create user user_masv for login masv_tensv_lop

grant select
on detai
to user_masv
with grant option

grant update
on detai
to user_masv
with grant option

grant execute
on dbo.proc_capnhat_giangvien
to user_masv
with grant option

grant execute
on dbo.proc_danhsach_detai
to user_masv
with grant option

grant execute
on dbo.proc_thongkedetai
to user_masv
with grant option

grant execute
on dbo.proc_tke
to user_masv
with grant option

grant select
on dbo.tke_detai
to user_masv
with grant option

grant select
on dbo.tke_moinam
to user_masv
with grant option