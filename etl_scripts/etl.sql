-- Remove existing tables
DROP TABLE IF EXISTS brands CASCADE;
DROP TABLE IF EXISTS unformatted_receipts;
DROP TABLE IF EXISTS unformatted_receipts_items;
DROP TABLE IF EXISTS unformatted_users CASCADE;;
DROP TABLE IF EXISTS receipts CASCADE;
DROP TABLE IF EXISTS receipts_items CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- Create initial unformatted tables in Postgres database
-- Brands table
CREATE TABLE brands (
barcode VARCHAR(255) ,
category VARCHAR(255) ,
category_code VARCHAR(255) ,
name VARCHAR(255) ,
top_brand BOOLEAN ,
brand_code VARCHAR(255) ,
id VARCHAR(255) ,
cpg_id VARCHAR(255) ,
cpg_ref VARCHAR(255)
);

-- Receipts table
CREATE TABLE unformatted_receipts (
bonus_points_earned VARCHAR(500) ,
bonus_points_earned_reason VARCHAR(1000) ,
points_earned VARCHAR(500) ,
purchased_item_count VARCHAR(500) ,
rewards_receipt_item_list TEXT ,
rewards_receipt_status VARCHAR(500) ,
total_spent VARCHAR(500) ,
user_id VARCHAR(500) ,
id VARCHAR(500) ,
created_date VARCHAR(500) ,
date_scanned VARCHAR(500) ,
finished_date VARCHAR(500) ,
modify_date VARCHAR(500) ,
points_awarded_date VARCHAR(500) ,
purchase_date VARCHAR(500)
);

-- Receipts items table
CREATE TABLE unformatted_receipts_items (
id VARCHAR(255) ,
user_id VARCHAR(255) ,
barcode VARCHAR(255) ,
description VARCHAR(255) ,
final_price VARCHAR(255) ,
item_price VARCHAR(255) ,
needs_fetch_review VARCHAR(255) ,
partner_item_id VARCHAR(255) ,
prevent_target_gap_points VARCHAR(255) ,
quantity_purchased VARCHAR(255) ,
user_flagged_barcode VARCHAR(255) ,
user_flagged_new_item VARCHAR(255) ,
user_flagged_price VARCHAR(255) ,
user_flagged_quantity VARCHAR(255) ,
needs_fetch_review_reason VARCHAR(255) ,
points_not_awarded_reason VARCHAR(255) ,
points_payer_id VARCHAR(255) ,
rewards_group VARCHAR(255) ,
rewards_product_partner_id VARCHAR(255) ,
user_flagged_description VARCHAR(255) ,
original_meta_brite_barcode VARCHAR(255) ,
original_meta_brite_description VARCHAR(255) ,
brand_code VARCHAR(255) ,
competitor_rewards_group VARCHAR(255) ,
discounted_item_price VARCHAR(255) ,
original_receipt_item_text VARCHAR(255) ,
item_number VARCHAR(255) ,
original_meta_brite_quantity_purchased VARCHAR(255) ,
points_earned VARCHAR(255) ,
target_price VARCHAR(255) ,
competitive_product VARCHAR(255) ,
original_final_price VARCHAR(255) ,
original_meta_brite_item_price VARCHAR(255) ,
deleted VARCHAR(255) ,
price_after_coupon VARCHAR(255) ,
metabrite_campaign_id VARCHAR(255)
);

-- Users table
CREATE TABLE unformatted_users (
active VARCHAR(255) ,
role VARCHAR(255) ,
sign_up_source VARCHAR(255) ,
state VARCHAR(255) ,
id VARCHAR(255) ,
created_date VARCHAR(255) ,
last_login VARCHAR(255)
);

-- Load data into unformatted tables from csv files (executed in the database_load.ipynb notebook)

-- Create formatted tables from unformatted tables
-- Create formatted receipts table
CREATE TABLE receipts AS
(SELECT
id ,
user_id ,
CAST(NULLIF(bonus_points_earned , '') AS FLOAT) AS bonus_points_earned ,
bonus_points_earned_reason ,
CAST(NULLIF(points_earned , '') AS FLOAT) AS points_earned ,
CAST(NULLIF(purchased_item_count , '') AS FLOAT) AS purchased_item_count ,
rewards_receipt_item_list ,
rewards_receipt_status ,
CAST(NULLIF(total_spent , '') AS FLOAT) AS total_spent ,
TO_TIMESTAMP(created_date , 'YYYY-MM-DD HH24:MI:SS') AS created_date ,
TO_TIMESTAMP(date_scanned , 'YYYY-MM-DD HH24:MI:SS') AS date_scanned ,
TO_TIMESTAMP(finished_date , 'YYYY-MM-DD HH24:MI:SS') AS finished_date ,
TO_TIMESTAMP(modify_date , 'YYYY-MM-DD HH24:MI:SS') AS modify_date ,
TO_TIMESTAMP(points_awarded_date , 'YYYY-MM-DD HH24:MI:SS') AS points_awarded_date ,
TO_TIMESTAMP(purchase_date , 'YYYY-MM-DD HH24:MI:SS') AS purchase_date
FROM unformatted_receipts
WHERE id IS NOT NULL AND user_id IS NOT NULL);

-- Create formatted receipts_items table with a unique key linking receipt items to receipts
CREATE TABLE receipts_items AS
WITH numbered_items AS (
SELECT 
, id as receipt_id ,
, ROW_NUMBER() OVER (PARTITION BY id ORDER BY item_number , description , final_price) as item_index ,
, barcode ,
, description ,
, CAST(NULLIF(final_price , '') AS FLOAT) AS final_price ,
, CAST(NULLIF(item_price , '') AS FLOAT) AS item_price ,
, needs_fetch_review ,
, partner_item_id ,
, prevent_target_gap_points ,
, CAST(NULLIF(quantity_purchased , '') AS FLOAT) AS quantity_purchased ,
, user_flagged_barcode ,
, user_flagged_new_item ,
, user_flagged_price ,
, CAST(NULLIF(user_flagged_quantity , '') AS FLOAT) AS user_flagged_quantity ,
, needs_fetch_review_reason ,
, points_not_awarded_reason ,
, points_payer_id ,
, rewards_group ,
, rewards_product_partner_id ,
, user_flagged_description ,
, original_meta_brite_barcode ,
, original_meta_brite_description ,
, brand_code ,
, competitor_rewards_group ,
, CAST(NULLIF(discounted_item_price , '') AS FLOAT) AS discounted_item_price ,
, original_receipt_item_text ,
, item_number ,
, CAST(NULLIF(original_meta_brite_quantity_purchased , '') AS FLOAT) AS original_meta_brite_quantity_purchased ,
, CAST(NULLIF(points_earned , '') AS FLOAT) AS points_earned ,
, CAST(NULLIF(target_price , '') AS FLOAT) AS target_price ,
, competitive_product ,
, CAST(NULLIF(original_final_price , '') AS FLOAT) AS original_final_price ,
, CAST(NULLIF(original_meta_brite_item_price , '') AS FLOAT) AS original_meta_brite_item_price ,
, deleted ,
, CAST(NULLIF(price_after_coupon , '') AS FLOAT) AS price_after_coupon ,
, metabrite_campaign_id
FROM unformatted_receipts_items 
WHERE id IS NOT NULL
)
SELECT
receipt_id ,'_' ,item_index as id ,
receipt_id ,
barcode ,
description ,
final_price ,
item_price ,
needs_fetch_review ,
partner_item_id ,
prevent_target_gap_points ,
quantity_purchased ,
user_flagged_barcode ,
user_flagged_new_item ,
user_flagged_price ,
user_flagged_quantity ,
needs_fetch_review_reason ,
points_not_awarded_reason ,
points_payer_id ,
rewards_group ,
rewards_product_partner_id ,
user_flagged_description ,
original_meta_brite_barcode ,
original_meta_brite_description ,
brand_code ,
competitor_rewards_group ,
discounted_item_price ,
original_receipt_item_text ,
item_number ,
original_meta_brite_quantity_purchased ,
points_earned ,
target_price ,
competitive_product ,
original_final_price ,
original_meta_brite_item_price ,
deleted ,
price_after_coupon ,
metabrite_campaign_id
FROM numbered_items;

-- Create formatted users table
CREATE TABLE users AS
(SELECT
id ,
active ,
role ,
sign_up_source ,
state ,
TO_TIMESTAMP(created_date , 'YYYY-MM-DD HH24:MI:SS') AS created_date ,
TO_TIMESTAMP(last_login , 'YYYY-MM-DD HH24:MI:SS') AS last_login
FROM (SELECT DISTINCT , FROM unformatted_users)
WHERE id IS NOT NULL);

-- Add user_ids to the user table that exist in the receipts table but not in the user table
INSERT INTO users (id)
SELECT DISTINCT user_id
FROM receipts
WHERE user_id IS NOT NULL AND user_id NOT IN (SELECT id FROM users);

-- Add primary keys
ALTER TABLE brands ADD PRIMARY KEY (id);
ALTER TABLE receipts ADD PRIMARY KEY (id);
ALTER TABLE receipts_items ADD PRIMARY KEY (id);
ALTER TABLE users ADD PRIMARY KEY (id);
-- Add foreign keys
ALTER TABLE receipts_items ADD CONSTRAINT fk_receipt_id FOREIGN KEY (receipt_id) REFERENCES receipts(id);
ALTER TABLE receipts ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users(id);
