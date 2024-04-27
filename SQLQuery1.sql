USE QLNhaSach
GO
-- Proc_XemThongTinCaNhan
CREATE PROCEDURE Proc_XemThongTinCaNhan
AS
BEGIN
    DECLARE @TenTaiKhoan VARCHAR(50);
    SET @TenTaiKhoan = ORIGINAL_LOGIN()

    IF EXISTS (SELECT 1 FROM NhanVien WHERE TenTaiKhoan = @TenTaiKhoan)
    BEGIN
        SELECT MaNV, TenNV, GioiTinh, DiaChi, TenTaiKhoan, Cap, ChucVu
        FROM NhanVien
        WHERE TenTaiKhoan = @TenTaiKhoan;
    END
    ELSE
    BEGIN
        RAISERROR ('Tài khoản không tồn tại!', 16, 1);
    END
END;

GO
EXEC Proc_XemThongTinCaNhan
SELECT * FROM NhanVien WHERE TenTaiKhoan = ORIGINAL_LOGIN();
SELECT SESSION_USER;
SELECT ORIGINAL_LOGIN();
-- Proc_SuaThongTinCaNhan
GO
CREATE PROCEDURE Proc_SuaThongTinCaNhan
    @TenNV NVARCHAR(50),
    @GioiTinh NVARCHAR(10),
    @DiaChi NVARCHAR(255),
    @MatKhauMoi VARCHAR(50),
    @CapMoi INT,
    @ChucVu NVARCHAR(50) = '',
    @Anh IMAGE = NULL
AS
BEGIN
    DECLARE @TenTaiKhoan VARCHAR(50);
    SET @TenTaiKhoan = CURRENT_USER;

    IF EXISTS (SELECT 1 FROM NhanVien WHERE TenTaiKhoan = @TenTaiKhoan)
    BEGIN
        UPDATE NhanVien
        SET TenNV = @TenNV,
            GioiTinh = @GioiTinh,
            DiaChi = @DiaChi,
            MatKhau = @MatKhauMoi,
            Cap = @CapMoi,
            ChucVu = @ChucVu,
            Anh = @Anh
        WHERE TenTaiKhoan = @TenTaiKhoan;
    END
    ELSE
    BEGIN
        RAISERROR ('Tài khoản không tồn tại!', 16, 1);
    END
END;