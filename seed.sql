USE photography_mini;

-- ============================================================================
-- PHẦN 1: NẠP DỮ LIỆU MẪU (INSERT DATA)
-- ============================================================================

-- 1.1. Bảng photo_groups (5 bản ghi - tối thiểu đề yêu cầu: 5)
-- Ghi chú nghiệp vụ:
--   - Group 1, 2, 3: Có giao dịch trong Quý I/2025 và ngoài Quý I/2025
--   - Group 4: Không có giao dịch trong Quý I/2025 (chỉ có giao dịch tháng 06/2025)
--   - Group 5: Hoàn toàn chưa có giao dịch nào (minh họa nhóm 0 giao dịch, 0 chi phí)
INSERT INTO photo_groups (group_id, name) VALUES
(1, 'Nhóm Chân Dung Nghệ Thuật'),
(2, 'Nhóm Gia Đình & Kỷ Yếu'),
(3, 'Nhóm Sự Kiện & Hội Nghị'),
(4, 'Nhóm Phóng Sự Cưới'),
(5, 'Nhóm Kiến Trúc & Nội Thất');

-- 1.2. Bảng photographers (7 bản ghi - tối thiểu đề yêu cầu: 6)
-- Ghi chú nghiệp vụ:
--   - Photographer 1..5: Có lịch chụp trong năm 2025 (Photographer 2, 3, 4 cùng có 2 lịch Completed năm 2025 để kiểm tra tie-breaker ưu tiên photographer_id tăng dần ở Câu 5)
--   - Photographer 6 (Vũ Đức Minh): Chỉ có lịch chụp năm 2024, KHÔNG có giao dịch năm 2025
--   - Photographer 7 (Đặng Thảo Vy): Chưa từng có lịch chụp nào (0 giao dịch mọi thời điểm)
INSERT INTO photographers (photographer_id, full_name, email, specialty, group_id) VALUES
(1, 'Nguyễn Minh Tuấn', 'tuan.nm@studio.vn', 'Chân dung ngoại cảnh', 1),
(2, 'Trần Thu Hà', 'ha.tt@studio.vn', 'Chân dung Studio & Concept', 1),
(3, 'Lê Hoàng Nam', 'nam.lh@studio.vn', 'Gia đình & Trẻ em', 2),
(4, 'Phạm Quốc Bảo', 'bao.pq@studio.vn', 'Sự kiện doanh nghiệp', 3),
(5, 'Hoàng Mai Anh', 'anh.hm@studio.vn', 'Phóng sự cưới', 4),
(6, 'Vũ Đức Minh', 'minh.vd@studio.vn', 'Kỷ yếu học đường', 2),
(7, 'Đặng Thảo Vy', 'vy.dt@studio.vn', 'Nội thất cao cấp', 5);

-- 1.3. Bảng clients (10 bản ghi - tối thiểu đề yêu cầu: 10)
-- Ghi chú nghiệp vụ:
--   - Client 1 (Nguyễn Văn An): Khách VIP có 4 lịch chụp Completed trong năm 2025 (> 3)
--   - Client 2 (Trần Thị Bích): Có lịch chụp thanh toán thành 3 đợt (nhiều lần)
--   - Client 3 (Lê Minh Cường): Có lịch chụp trả 2 đợt nhưng vẫn còn nợ
--   - Client 4 (Phạm Hồng Đào): Có lịch chụp Completed & Pending nhưng CHƯA TỪNG thanh toán
--   - Client 5 (Hoàng Tuấn Kiệt): Có 2 lịch chụp Completed năm 2025, còn nợ 1 phần
--   - Client 6 (Vũ Thị Lan): Có 1 lịch Completed (cùng mức phí 3.500.000 với Client 4 để kiểm tra tie-breaker Câu 8) và 1 lịch Cancelled
--   - Client 7 (Đỗ Quang Huy): Có 1 lịch Completed năm 2024 (đã trả đủ năm 2024) và 1 lịch năm 2025
--   - Client 8 (Bùi Thanh Tâm): Chỉ có 1 lịch Pending (chưa có biên bản bàn giao, chưa thanh toán)
--   - Client 9 (Ngô Gia Bảo): Chỉ có 1 lịch Cancelled (để kiểm tra loại trừ Cancelled ở Câu 3)
--   - Client 10 (Đinh Mai Phương): Khách hàng mới đăng ký, chưa từng đặt lịch chụp nào
INSERT INTO clients (client_id, full_name, phone, email) VALUES
(1, 'Nguyễn Văn An', '0901000001', 'an.nv@gmail.com'),
(2, 'Trần Thị Bích', '0901000002', 'bich.tt@gmail.com'),
(3, 'Lê Minh Cường', '0901000003', 'cuong.lm@gmail.com'),
(4, 'Phạm Hồng Đào', '0901000004', 'dao.ph@gmail.com'),
(5, 'Hoàng Tuấn Kiệt', '0901000005', 'kiet.ht@gmail.com'),
(6, 'Vũ Thị Lan', '0901000006', 'lan.vt@gmail.com'),
(7, 'Đỗ Quang Huy', '0901000007', 'huy.dq@gmail.com'),
(8, 'Bùi Thanh Tâm', '0901000008', 'tam.bt@gmail.com'),
(9, 'Ngô Gia Bảo', '0901000009', 'bao.ng@gmail.com'),
(10, 'Đinh Mai Phương', '0901000010', 'phuong.dm@gmail.com');

-- 1.4. Bảng shoots (16 bản ghi - tối thiểu đề yêu cầu: 12)
-- Phân bổ thời gian & trạng thái:
--   - Tháng 01/2025: Shoot 1, 5, 6 (3 Completed)
--   - Tháng 02 & 03/2025 (còn lại của Quý I/2025): Shoot 2, 7, 16 (tháng 2) và Shoot 3, 8, 15 (tháng 3)
--   - Ngoài Quý I/2025 nhưng trong năm 2025: Shoot 4, 9, 10, 12 (Completed) và Shoot 13, 14 (Pending)
--   - Ngoài năm 2025 (năm 2024): Shoot 11 (Completed - của Photographer 6)
INSERT INTO shoots (shoot_id, client_id, photographer_id, shoot_date, status, location) VALUES
-- 4 lịch Completed trong năm 2025 của Client 1 (Nguyễn Văn An)
(1,  1, 1, '2025-01-10', 'Completed', 'Phố cổ Hà Nội'),
(2,  1, 1, '2025-02-08', 'Completed', 'Văn Miếu - Quốc Tử Giám'),
(3,  1, 3, '2025-03-05', 'Completed', 'Công viên Bách Thảo'),
(4,  1, 1, '2025-05-12', 'Completed', 'Hồ Tây - Hà Nội'),

-- Lịch Completed tháng 01/2025 của Client 2 (trả nhiều lần) và Client 3 (còn nợ)
(5,  2, 2, '2025-01-15', 'Completed', 'Studio Concept Cầu Giấy'),
(6,  3, 3, '2025-01-22', 'Completed', 'Khu đô thị Ecopark'),

-- Lịch Completed tháng 02/2025 của Client 4 (có giao dịch nhưng chưa thanh toán đồng nào)
(7,  4, 4, '2025-02-18', 'Completed', 'Trung tâm Hội nghị Quốc gia'),

-- Lịch Completed của Client 5 trong Quý I (tháng 03) và ngoài Quý I (tháng 06 - Nhóm 4)
(8,  5, 2, '2025-03-19', 'Completed', 'Phim trường Smiley Ville'),
(9,  5, 5, '2025-06-14', 'Completed', 'Khách sạn JW Marriott Hà Nội'),

-- Lịch Completed ngoài Quý I của Client 6 (do Photographer 4 phụ trách)
(10, 6, 4, '2025-07-20', 'Completed', 'Làng cổ Đường Lâm'),

-- Lịch Completed ngoài năm 2025 (năm 2024) của Client 7 do Photographer 6 phụ trách
(11, 7, 6, '2024-11-15', 'Completed', 'Trường THPT Chu Văn An'),

-- Lịch Completed tháng 09/2025 của Client 7
(12, 7, 1, '2025-09-05', 'Completed', 'Hoàng thành Thăng Long'),

-- Các lịch chụp Pending (chưa có biên bản bàn giao, chưa phát sinh thanh toán)
(13, 4, 4, '2025-08-10', 'Pending',   'Khách sạn Melia Hà Nội'),
(14, 8, 1, '2025-10-15', 'Pending',   'Vườn Quốc gia Ba Vì'),

-- Các lịch chụp Cancelled (đã hủy, không có biên bản bàn giao, không có thanh toán)
(15, 6, 3, '2025-03-28', 'Cancelled', 'Công viên Yên Sở'),
(16, 9, 2, '2025-02-25', 'Cancelled', 'Phố đi bộ Hồ Gươm');

-- 1.5. Bảng deliveries (12 bản ghi - tối thiểu đề yêu cầu: 10)
-- Quy tắc:
--   - Đúng 12 lịch chụp Completed (shoot_id từ 1 đến 12) có đúng 12 biên bản bàn giao
--   - delivered_at luôn >= shoot_date
--   - photo_count > 0, fee >= 0
--   - Các lịch Pending (13, 14) và Cancelled (15, 16) tuyệt đối KHÔNG có trong deliveries
INSERT INTO deliveries (delivery_id, shoot_id, delivered_at, photo_count, album_link, fee) VALUES
(1,  1,  '2025-01-14', 120, 'https://photos.studio.vn/album/shoot-01', 3000000.00),
(2,  2,  '2025-02-12', 150, 'https://photos.studio.vn/album/shoot-02', 3500000.00),
(3,  3,  '2025-03-10', 180, 'https://photos.studio.vn/album/shoot-03', 4000000.00),
(4,  4,  '2025-05-16', 200, 'https://photos.studio.vn/album/shoot-04', 4500000.00),
(5,  5,  '2025-01-20', 250, 'https://photos.studio.vn/album/shoot-05', 5000000.00),
(6,  6,  '2025-01-26', 160, 'https://photos.studio.vn/album/shoot-06', 4000000.00),
(7,  7,  '2025-02-22', 140, 'https://photos.studio.vn/album/shoot-07', 3500000.00),
(8,  8,  '2025-03-24', 300, 'https://photos.studio.vn/album/shoot-08', 6000000.00),
(9,  9,  '2025-06-20', 220, 'https://photos.studio.vn/album/shoot-09', 4500000.00),
(10, 10, '2025-07-25', 130, 'https://photos.studio.vn/album/shoot-10', 3500000.00),
(11, 11, '2024-11-19', 110, 'https://photos.studio.vn/album/shoot-11', 2500000.00),
(12, 12, '2025-09-10', 145, 'https://photos.studio.vn/album/shoot-12', 3200000.00);

-- 1.6. Bảng payments (14 bản ghi - tối thiểu đề yêu cầu: 10)
-- Quy tắc:
--   - Chỉ thu tiền các shoot đã có biên bản bàn giao (xác nhận chi phí)
--   - Shoot 5 (fee = 5,000,000): Thanh toán 3 lần (1,5M + 2,0M + 1,5M = 5,0M -> Hết nợ)
--   - Shoot 6 (fee = 4,000,000): Thanh toán 2 lần (1,0M + 1,5M = 2,5M -> Còn nợ 1,5M)
--   - Shoot 7 (fee = 3,500,000, Client 4): Chưa có bản ghi thanh toán nào (Nợ 3,5M)
--   - Shoot 8 (fee = 6,000,000): Thanh toán 1 lần 4,0M -> Còn nợ 2,0M
--   - Shoot 12 (fee = 3,200,000): Thanh toán 1 lần 2,0M -> Còn nợ 1,2M
INSERT INTO payments (payment_id, shoot_id, amount, payment_date, method) VALUES
-- Client 1 thanh toán đủ cho 4 lịch chụp (Shoot 1, 2, 3, 4)
(1,  1,  3000000.00, '2025-01-15', 'BankTransfer'),
(2,  2,  3500000.00, '2025-02-13', 'Card'),
(3,  3,  4000000.00, '2025-03-11', 'BankTransfer'),
(4,  4,  4500000.00, '2025-05-17', 'Cash'),

-- Client 2 thanh toán 3 đợt cho Shoot 5 (tổng = 5,000,000 = fee)
(5,  5,  1500000.00, '2025-01-20', 'Cash'),
(6,  5,  2000000.00, '2025-01-25', 'BankTransfer'),
(7,  5,  1500000.00, '2025-02-01', 'Card'),

-- Client 3 thanh toán 2 đợt cho Shoot 6 (tổng = 2,500,000 < fee 4,000,000 -> còn nợ 1,500,000)
(8,  6,  1000000.00, '2025-01-27', 'Cash'),
(9,  6,  1500000.00, '2025-02-05', 'BankTransfer'),

-- Client 5 thanh toán 1 phần cho Shoot 8 (còn nợ 2,000,000) và trả đủ cho Shoot 9
(10, 8,  4000000.00, '2025-03-25', 'BankTransfer'),
(11, 9,  4500000.00, '2025-06-21', 'Card'),

-- Client 6 thanh toán đủ cho Shoot 10
(12, 10, 3500000.00, '2025-07-26', 'BankTransfer'),

-- Client 7 thanh toán đủ cho Shoot 11 (trong năm 2024) và thanh toán 1 phần cho Shoot 12 (năm 2025)
(13, 11, 2500000.00, '2024-11-20', 'Cash'),
(14, 12, 2000000.00, '2025-09-12', 'BankTransfer');


-- ============================================================================
-- PHẦN 2: MINH HỌA CÁC CÂU LỆNH INSERT VI PHẠM RÀNG BUỘC (ĐỂ TRONG CHÚ THÍCH)
-- ============================================================================
/*
-- 1. Vi phạm UNIQUE(shoot_id) trong bảng deliveries (1 lịch chụp có 2 biên bản bàn giao):
INSERT INTO deliveries (delivery_id, shoot_id, delivered_at, photo_count, album_link, fee)
VALUES (99, 1, '2025-01-16', 50, 'https://photos.studio.vn/album/dup', 1000000.00);

-- 2. Vi phạm CHECK(photo_count > 0) trong bảng deliveries:
INSERT INTO deliveries (delivery_id, shoot_id, delivered_at, photo_count, album_link, fee)
VALUES (100, 13, '2025-08-12', 0, 'https://photos.studio.vn/album/zero', 2000000.00);

-- 3. Vi phạm CHECK(amount > 0) trong bảng payments:
INSERT INTO payments (payment_id, shoot_id, amount, payment_date, method)
VALUES (101, 1, -500000.00, '2025-01-20', 'Cash');

-- 4. Vi phạm FOREIGN KEY (client_id không tồn tại):
INSERT INTO shoots (shoot_id, client_id, photographer_id, shoot_date, status, location)
VALUES (102, 999, 1, '2025-11-01', 'Pending', 'Hà Nội');
*/


-- ============================================================================
-- PHẦN 3: CÁC TRUY VẤN KIỂM TRA TÍNH TOÀN VẸN DỮ LIỆU & NGHIỆP VỤ
-- (Kết quả mong đợi cho các truy vấn tìm lỗi 3.1 -> 3.5: 0 dòng trả về)
-- ============================================================================

-- 3.1. Kiểm tra lịch chụp Completed nhưng CHƯA CÓ biên bản bàn giao (Kỳ vọng: 0 dòng)
SELECT s.shoot_id, s.status, d.delivery_id
FROM shoots s
LEFT JOIN deliveries d ON s.shoot_id = d.shoot_id
WHERE s.status = 'Completed' AND d.delivery_id IS NULL;

-- 3.2. Kiểm tra lịch chụp Pending hoặc Cancelled nhưng LẠI CÓ biên bản bàn giao (Kỳ vọng: 0 dòng)
SELECT s.shoot_id, s.status, d.delivery_id
FROM shoots s
INNER JOIN deliveries d ON s.shoot_id = d.shoot_id
WHERE s.status IN ('Pending', 'Cancelled');

-- 3.3. Kiểm tra ngày bàn giao (delivered_at) bị trước ngày chụp (shoot_date) (Kỳ vọng: 0 dòng)
SELECT d.delivery_id, d.shoot_id, s.shoot_date, d.delivered_at
FROM deliveries d
INNER JOIN shoots s ON d.shoot_id = s.shoot_id
WHERE d.delivered_at < s.shoot_date;

-- 3.4. Kiểm tra thanh toán phát sinh khi CHƯA CÓ chi phí được xác nhận trong deliveries (Kỳ vọng: 0 dòng)
SELECT p.payment_id, p.shoot_id, p.amount, p.payment_date
FROM payments p
LEFT JOIN deliveries d ON p.shoot_id = d.shoot_id
WHERE d.delivery_id IS NULL;

-- 3.5. Kiểm tra tổng tiền đã thu của một lịch chụp vượt quá chi phí đã xác nhận (fee) (Kỳ vọng: 0 dòng)
SELECT
    d.shoot_id,
    d.fee AS confirmed_fee,
    SUM(p.amount) AS total_paid
FROM deliveries d
INNER JOIN payments p ON d.shoot_id = p.shoot_id
GROUP BY d.shoot_id, d.fee
HAVING SUM(p.amount) > d.fee;

-- 3.6. Kiểm tra tổng hợp số lượng bản ghi của 6 bảng so với mức tối thiểu của đề bài
SELECT 'photo_groups (Min: 5)' AS table_check, COUNT(*) AS actual_count FROM photo_groups
UNION ALL
SELECT 'photographers (Min: 6)', COUNT(*) FROM photographers
UNION ALL
SELECT 'clients (Min: 10)', COUNT(*) FROM clients
UNION ALL
SELECT 'shoots (Min: 12)', COUNT(*) FROM shoots
UNION ALL
SELECT 'deliveries (Min: 10)', COUNT(*) FROM deliveries
UNION ALL
SELECT 'payments (Min: 10)', COUNT(*) FROM payments;
