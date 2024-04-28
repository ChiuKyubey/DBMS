-- Quản lý nhân viên 
USE QLNhaSach
GO
CREATE PROCEDURE XemThongTinNhanVien
AS
BEGIN
    SELECT 
        MaNV,
        TenNV,
        GioiTinh,
        DiaChi,
        Cap,
        ChucVu,
        Anh
    FROM 
        NhanVien;
END;
GO
--View_CaLam
--WITH SortedCaLam AS (
--    SELECT MaNV, Ca, Thu,
--           CASE 
--               WHEN Thu = 'Monday' THEN 1
--               WHEN Thu = 'Tuesday' THEN 2
--               WHEN Thu = 'Wednesday' THEN 3
--               WHEN Thu = 'Thursday' THEN 4
--               WHEN Thu = 'Friday' THEN 5
--               WHEN Thu = 'Saturday' THEN 6
--               WHEN Thu = 'Sunday' THEN 7
--           END AS ThuOrder
--    FROM CaLamViec
--)
--SELECT MaNV, Ca, Thu
--FROM SortedCaLam
--ORDER BY ThuOrder;

--Proc_ThemCaLam
GO
CREATE PROCEDURE Proc_ThemCaLam
    @MaNV INT,
    @Ca VARCHAR(50),
    @Thu VARCHAR(50)
AS
BEGIN
    INSERT INTO CaLamViec (MaNV, Ca, Thu)
    VALUES (@MaNV, @Ca, @Thu);
END;

--Proc_XoaCaLam
GO
CREATE PROCEDURE Proc_XoaCaLam
    @MaNV INT
AS
BEGIN
    DELETE FROM CaLamViec WHERE MaNV = @MaNV;
END;
--Proc_SuaCaLam
GO
CREATE PROCEDURE Proc_SuaCaLam
    @MaNV INT,
    @Ca VARCHAR(50),
    @Thu VARCHAR(50)
AS
BEGIN
    UPDATE CaLamViec
    SET Ca = @Ca, Thu = @Thu
    WHERE MaNV = @MaNV;
END;
--TG_KiemTraSoLuong (3 ca, moi ca co ThuNgan: 2 nguoi, QuanLyKho: 2 nguoi)
GO
CREATE FUNCTION TG_KiemTraSoLuong (@Ca VARCHAR(50))
RETURNS INT
AS
BEGIN
    DECLARE @SoLuong INT;
    SET @SoLuong = (SELECT COUNT(*) FROM CaLamViec WHERE Ca = @Ca);
    RETURN @SoLuong;
END;
--Func_TimKiemNhanVien

