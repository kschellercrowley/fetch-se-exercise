---
title: Fetch Rewards Database Schema
---
```mermaid
erDiagram;
    USERS {
        varchar id PK
        varchar active
        varchar role
        varchar sign_up_source
        varchar state
        timestamp created_date
        timestamp last_login
    };
    RECEIPTS {
        varchar id PK
        varchar user_id FK
        float bonus_points_earned
        varchar bonus_points_earned_reason
        float points_earned
        float purchased_item_count
        text rewards_receipt_item_list
        varchar rewards_receipt_status
        float total_spent
        timestamp created_date
        timestamp date_scanned
        timestamp finished_date
        timestamp modify_date
        timestamp points_awarded_date
        timestamp purchase_date
    };
    RECEIPTS_ITEMS {
        varchar id PK
        varchar receipt_id FK
        varchar brand_code FK
        varchar barcode
        varchar description
        float final_price
        float item_price
        varchar needs_fetch_review
        float quantity_purchased
        float points_earned
        float target_price
        varchar competitive_product
        float original_final_price
        varchar deleted
        float price_after_coupon
    };
    BRANDS {
        varchar id PK
        varchar brand_code
        varchar barcode
        varchar category
        varchar category_code
        varchar name
        boolean top_brand
        varchar cpg_id
        varchar cpg_ref
    };

    USERS ||--o{ RECEIPTS : has;
    RECEIPTS ||--o{ RECEIPTS_ITEMS : contains;
    BRANDS ||--o{ RECEIPTS_ITEMS : "appears in";
```



-- receipts table
    id,
    user_id VARCHAR,
    bonus_points_earned FLOAT,
    bonus_points_earned_reason VARCHAR,
    points_earned FLOAT,
    purchased_item_count FLOAT,
    rewards_receipt_item_list TEXT,
    rewards_receipt_status VARCHAR,
    total_spent FLOAT,
    created_date TIMESTAMP,
    date_scanned TIMESTAMP,
    finished_date TIMESTAMP,
    modify_date TIMESTAMP,
    points_awarded_date TIMESTAMP,
    purchase_date TIMESTAMP


-- receipts_items table
    id VARCHAR,
    receipt_id VARCHAR,
    barcode VARCHAR,
    description VARCHAR,
    final_price FLOAT,
    item_price FLOAT,
    needs_fetch_review VARCHAR,
    partner_item_id VARCHAR,
    prevent_target_gap_points VARCHAR,
    quantity_purchased FLOAT,
    user_flagged_barcode VARCHAR,
    user_flagged_new_item VARCHAR,
    user_flagged_price FLOAT,
    user_flagged_quantity FLOAT,
    needs_fetch_review_reason VARCHAR,
    points_not_awarded_reason VARCHAR,
    points_payer_id VARCHAR,
    rewards_group VARCHAR,
    rewards_product_partner_id VARCHAR,
    user_flagged_description VARCHAR,
    original_meta_brite_barcode VARCHAR,
    original_meta_brite_description VARCHAR,
    brand_code VARCHAR,
    competitor_rewards_group VARCHAR,
    discounted_item_price FLOAT,
    original_receipt_item_text VARCHAR,
    item_number VARCHAR,
    original_meta_brite_quantity_purchased FLOAT,
    points_earned FLOAT,
    target_price FLOAT,
    competitive_product VARCHAR,
    original_final_price FLOAT,
    original_meta_brite_item_price FLOAT,
    deleted VARCHAR,
    price_after_coupon FLOAT,
    metabrite_campaign_id VARCHAR

-- users table
    id VARCHAR,
    active VARCHAR,
    role VARCHAR,
    sign_up_source VARCHAR,
    state VARCHAR,
    id VARCHAR,
    created_date TIMESTAMP,
    last_login TIMESTAMP

-- brands table
    barcode VARCHAR,
    category VARCHAR,
    category_code VARCHAR,
    name VARCHAR,
    top_brand BOOLEAN,
    brand_code VARCHAR,
    id VARCHAR,
    cpg_id VARCHAR,
    cpg_ref VARCHAR

primary_keys_sql = """
ALTER TABLE brands ADD PRIMARY KEY (id);
ALTER TABLE receipts ADD PRIMARY KEY (id);
ALTER TABLE receipts_items ADD PRIMARY KEY (id);
ALTER TABLE users ADD PRIMARY KEY (id);
"""
foreign_keys_sql = """
ALTER TABLE receipts_items ADD CONSTRAINT fk_receipt_id FOREIGN KEY (receipt_id) REFERENCES receipts(id);
ALTER TABLE receipts ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE receipts_items ADD CONSTRAINT fk_brand_code FOREIGN KEY (brand_code) REFERENCES brand(brand_code);
"""
