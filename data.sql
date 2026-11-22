--docker run --name baitapSQL -e POSTGRES_PASSWORD=1234 -d -p 5432:5432 postgres:18


select current_database();
create database baitapSQL;
select current_database(), current_schema();

-- 1. Bảng user
 CREATE TABLE "user" (
  user_id SERIAL PRIMARY KEY,
  full_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL
);

-- 2. Bảng restaurant
CREATE TABLE restaurant (
  res_id SERIAL PRIMARY KEY,
  res_name VARCHAR(255) NOT NULL,
  image VARCHAR(255),
  "desc" VARCHAR(255)
);

-- 3. Bảng food_type
CREATE TABLE food_type (
  type_id SERIAL PRIMARY KEY,
  type_name VARCHAR(255) NOT NULL
);

-- 4. Bảng food
CREATE TABLE food (
  food_id SERIAL PRIMARY KEY,
  food_name VARCHAR(255) NOT NULL,
  image VARCHAR(255),
  price REAL NOT NULL DEFAULT 0,
  "desc" VARCHAR(255),
  type_id INT,
  CONSTRAINT fk_food_type FOREIGN KEY (type_id) REFERENCES food_type(type_id)
);

-- 5. Bảng sub_food
CREATE TABLE sub_food (
  sub_id SERIAL PRIMARY KEY,
  sub_name VARCHAR(255) NOT NULL,
  sub_price REAL NOT NULL DEFAULT 0,
  food_id INT,
  CONSTRAINT fk_sub_food FOREIGN KEY (food_id) REFERENCES food(food_id)
);

-- 6. Bảng rate_res
CREATE TABLE rate_res (
  user_id INT NOT NULL,
  res_id INT NOT NULL,
  amount INT NOT NULL,
  date_rate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_rate_user FOREIGN KEY (user_id) REFERENCES "user"(user_id),
  CONSTRAINT fk_rate_res FOREIGN KEY (res_id) REFERENCES restaurant(res_id)
);

-- 7. Bảng like_res
CREATE TABLE like_res (
  user_id INT NOT NULL,
  res_id INT NOT NULL,
  date_like TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_like_user FOREIGN KEY (user_id) REFERENCES "user"(user_id),
  CONSTRAINT fk_like_res FOREIGN KEY (res_id) REFERENCES restaurant(res_id)
);

-- 8. Bảng order
CREATE TABLE "order" (
  user_id INT NOT NULL,
  food_id INT NOT NULL,
  amount INT NOT NULL DEFAULT 1,
  code VARCHAR(100),
  arr_sub_id VARCHAR(255),
  CONSTRAINT fk_order_user FOREIGN KEY (user_id) REFERENCES "user"(user_id),
  CONSTRAINT fk_order_food FOREIGN KEY (food_id) REFERENCES food(food_id)
);

-- Dữ liệu mẫu
INSERT INTO "user" (full_name, email, password) VALUES
('Nguyen Van A', 'a@example.com', '123456'),
('Tran Thi B', 'b@example.com', '123456'),
('Le Van C', 'c@example.com', '123456');

INSERT INTO restaurant (res_name, image, "desc") VALUES
('Quan Com Que', 'com.jpg', 'Com trua gia dinh'),
('Bun Rieu Co Ba', 'bunrieu.jpg', 'Bun rieu cua dong');

INSERT INTO food_type (type_name) VALUES
('Mon nuoc'),
('Mon com'),
('Do uong');

INSERT INTO food (food_name, image, price, "desc", type_id) VALUES
('Bun rieu dac biet', 'bun1.jpg', 45000, 'Co cha, huyet, dau hu', 1),
('Com suon bi cha', 'com1.jpg', 50000, 'Suon nuong than', 2),
('Tra da', 'trada.jpg', 5000, 'Tra xanh mat lanh', 3);

INSERT INTO sub_food (sub_name, sub_price, food_id) VALUES
('Them cha ca', 10000, 1),
('Them op la', 8000, 2);

INSERT INTO rate_res (user_id, res_id, amount, date_rate) VALUES
(1, 1, 5, '2026-11-20 10:00:00'),
(2, 2, 4, '2026-11-20 12:30:00');

INSERT INTO like_res (user_id, res_id, date_like) VALUES
(1, 1, '2026-11-20 09:45:00'),
(1, 2, '2026-11-20 12:00:00');

INSERT INTO "order" (user_id, food_id, amount, code, arr_sub_id) VALUES
(1, 1, 2, 'ORD001', '1'),
(2, 2, 1, 'ORD002', '2');

-- 1. Thêm nhiều user (10 người: có người hoạt động mạnh, có người không hoạt động)
INSERT INTO "user" (full_name, email, password) VALUES
('Nguyen Van An', 'an.nguyen@example.com', 'pass123'),
('Tran Thi Binh', 'binh.tran@example.com', 'pass123'),
('Le Minh Chau', 'chau.le@example.com', 'pass123'),
('Pham Quoc Dat', 'dat.pham@example.com', 'pass123'),
('Vo Thi Em', 'em.vo@example.com', 'pass123'),
('Do Hoang Giang', 'giang.do@example.com', 'pass123'),
('Bui Thanh Hai', 'hai.bui@example.com', 'pass123'),
('Dang Thu Khanh', 'khanh.dang@example.com', 'pass123'),
('Hoang Tuan Long', 'long.hoang@example.com', 'pass123'),
('Ngo My Linh', 'linh.ngo@example.com', 'pass123');

-- 2. Thêm nhiều nhà hàng (6 nhà hàng)
INSERT INTO restaurant (res_name, image, "desc") VALUES
('Quan Com Que Tra Cu', 'com_que.jpg', 'Com trua gia dinh mien Tay'),
('Bun Rieu Co Ba', 'bun_rieu.jpg', 'Bun rieu cua dong dam da'),
('Pho Bo Gia Truyen', 'pho_bo.jpg', 'Nuoc dung ninh xuong 12 gio'),
('Banh Xeo Mien Tay', 'banh_xeo.jpg', 'Gion rum, rau song tuoi'),
('Hu Tieu Nam Vang', 'hu_tieu.jpg', 'Hu tieu kho va nuoc'),
('Quan Nuong Than Hoa', 'nuong_than.jpg', 'Xien nuong va hai san');

-- 3. Thêm loại món ăn
INSERT INTO food_type (type_name) VALUES
('Mon nuoc'),
('Mon com'),
('Mon chien/nuong'),
('Do uong');

-- 4. Thêm nhiều món ăn (10 món)
INSERT INTO food (food_name, image, price, "desc", type_id) VALUES
('Bun rieu dac biet', 'bun1.jpg', 45000, 'Co cha, huyet, dau hu, cua', 1),
('Pho bo tai nam', 'pho1.jpg', 55000, 'Thit bo mem, hanh ngo', 1),
('Hu tieu thap cam', 'hutieu1.jpg', 50000, 'Tom, thit bam, trung cut', 1),
('Com suon bi cha', 'com1.jpg', 50000, 'Suon cot let nuong than', 2),
('Com ga xoi mo', 'com2.jpg', 48000, 'Da ga gion, com dẻo', 2),
('Banh xeo tom thit', 'banhxeo1.jpg', 35000, 'Banh vang gion, cha gio', 3),
('Ba roi nuong sa te', 'nuong1.jpg', 65000, 'Thit ba roi uop cay nhe', 3),
('Ca loc nuong trui', 'nuong2.jpg', 120000, 'Ca loc tuoi song', 3),
('Tra da chanh', 'trada1.jpg', 10000, 'Mat lanh giai khat', 4),
('Ca phe sua da', 'caphe1.jpg', 20000, 'Ca phe phin truyen thong', 4);

-- 5. Thêm món phụ (sub_food)
INSERT INTO sub_food (sub_name, sub_price, food_id) VALUES
('Them cha ca', 10000, 1),
('Them huyet', 5000, 1),
('Them trung tran', 7000, 2),
('Them op la', 8000, 4),
('Them rau song', 5000, 6),
('Them banh trang', 5000, 8);

-- 6. Thêm nhiều lượt like nhà hàng (để test Top 5 user like & Top 2 nhà hàng like)
INSERT INTO like_res (user_id, res_id, date_like) VALUES
(1, 1, '2026-11-15 08:10:00'),
(1, 2, '2026-11-15 09:20:00'),
(1, 3, '2026-11-16 10:00:00'),
(1, 4, '2026-11-16 11:30:00'),
(2, 1, '2026-11-15 12:00:00'),
(2, 2, '2026-11-17 14:15:00'),
(2, 5, '2026-11-18 16:40:00'),
(3, 1, '2026-11-15 18:00:00'),
(3, 2, '2026-11-18 19:10:00'),
(3, 3, '2026-11-19 07:45:00'),
(4, 1, '2026-11-16 08:30:00'),
(4, 3, '2026-11-19 12:20:00'),
(5, 1, '2026-11-17 09:00:00'),
(5, 2, '2026-11-20 17:05:00'),
(6, 4, '2026-11-18 11:11:00'),
(9, 6, '2026-11-21 20:00:00');

-- 7. Thêm nhiều lượt đánh giá nhà hàng (rate_res)
INSERT INTO rate_res (user_id, res_id, amount, date_rate) VALUES
(1, 1, 5, '2026-11-15 10:30:00'),
(2, 2, 4, '2026-11-17 15:00:00'),
(3, 1, 5, '2026-11-19 08:20:00'),
(4, 3, 4, '2026-11-19 13:00:00'),
(5, 2, 3, '2026-11-20 18:00:00'),
(6, 4, 5, '2026-11-21 12:15:00'),
(9, 6, 4, '2026-11-21 20:30:00');

-- 8. Thêm nhiều đơn đặt hàng ("order")
INSERT INTO "order" (user_id, food_id, amount, code, arr_sub_id) VALUES
(3, 1, 1, 'ORD101', '1'),
(3, 4, 2, 'ORD102', '4'),
(3, 9, 2, 'ORD103', NULL),
(3, 6, 1, 'ORD104', '5'),
(1, 2, 3, 'ORD105', '3'),
(1, 8, 2, 'ORD106', '6'),
(1, 10, 4, 'ORD107', NULL),
(2, 1, 2, 'ORD108', '1,2'),
(2, 5, 1, 'ORD109', NULL),
(5, 7, 2, 'ORD110', NULL),
(6, 3, 1, 'ORD111', NULL);


-- 1. Tìm 5 người đã like nhà hàng nhiều nhất
SELECT
  "user"."user_id",
  "user"."full_name",
  "user"."email",
  COUNT("like_res"."user_id") AS "Số lượt like"
FROM "like_res"
INNER JOIN "user" ON "like_res"."user_id" = "user"."user_id"
GROUP BY "user"."user_id", "user"."full_name", "user"."email"
ORDER BY "Số lượt like" DESC
LIMIT 5;
-- 2. Tìm 2 nhà hàng có lượt like nhiều nhất
SELECT
  "restaurant"."res_id",
  "restaurant"."res_name",
  "restaurant"."image",
  COUNT("like_res"."res_id") AS "Số lượt like"
FROM "like_res"
INNER JOIN "restaurant" ON "like_res"."res_id" = "restaurant"."res_id"
GROUP BY "restaurant"."res_id", "restaurant"."res_name", "restaurant"."image"
ORDER BY "Số lượt like" DESC
LIMIT 2;
-- 3. Tìm người đã đặt hàng nhiều nhất
SELECT
  "user"."user_id",
  "user"."full_name",
  "user"."email",
  COUNT("order"."user_id") AS "Số lần đặt",
  SUM("order"."amount") AS "Tổng số lượng"
FROM "order"
INNER JOIN "user" ON "order"."user_id" = "user"."user_id"
GROUP BY "user"."user_id", "user"."full_name", "user"."email"
ORDER BY "Số lần đặt" DESC, "Tổng số lượng" DESC
LIMIT 1;
-- 4. Tìm người dùng không hoạt động trong hệ thống (không đặt hàng, không like, không đánh giá nhà hàng)
SELECT
  "user"."user_id",
  "user"."full_name",
  "user"."email"
FROM "user"
LEFT JOIN "order" ON "order"."user_id" = "user"."user_id"
LEFT JOIN "like_res" ON "like_res"."user_id" = "user"."user_id"
LEFT JOIN "rate_res" ON "rate_res"."user_id" = "user"."user_id"
WHERE "order"."user_id" IS NULL
  AND "like_res"."user_id" IS NULL
  AND "rate_res"."user_id" IS NULL;
