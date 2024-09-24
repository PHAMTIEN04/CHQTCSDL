create procedure v_sv(@mlop nvarchar(10))
	as
	begin
		select * 
		from SINHVIEN
		where MaLop = @mlop
	end

exec v_sv 'K45HDDL'
-- exec : thực thi thủ tục