---
title: Fetch Rewards Database Schema
---
```mermaid
erDiagram
    USERS {
        varchar id PK
        varchar active
        varchar role
        varchar sign_up_source
        varchar state
        timestamp created_date
        timestamp last_login
    }
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
    }
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
    }
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
    }

    USERS ||--o{ RECEIPTS : has
    RECEIPTS ||--o{ RECEIPTS_ITEMS : contains
    BRANDS ||--o{ RECEIPTS_ITEMS : "appears in"
```



| receipts |
|:-------------:|
| id (PK) |
| user_id (FK)|
| bonus_points_earned |
| bonus_points_earned_reason |
| points_earned |
| purchased_item_count |
| rewards_receipt_item_list |
| rewards_receipt_status |
| total_spent |
| created_date |
| date_scanned |
| finished_date |
| modify_date |
| points_awarded_date |
| purchase_date |


| receipts_items |
|:-------------:|
| id (PK) |
| receipt_id  (FK)|
| barcode |
| description |
| final_price |
| item_price |
| needs_fetch_review |
| partner_item_id |
| prevent_target_gap_points |
| quantity_purchased |
| user_flagged_barcode |
| user_flagged_new_item |
| user_flagged_price |
| user_flagged_quantity |
| needs_fetch_review_reason |
| points_not_awarded_reason |
| points_payer_id |
| rewards_group |
| rewards_product_partner_id |
| user_flagged_description |
| original_meta_brite_barcode |
| original_meta_brite_description |
| brand_code  (FK)|
| competitor_rewards_group |
| discounted_item_price |
| original_receipt_item_text |
| item_number |
| original_meta_brite_quantity_purchased |
| points_earned |
| target_price |
| competitive_product |
| original_final_price |
| original_meta_brite_item_price |
| deleted |
| price_after_coupon |
| metabrite_campaign_id |

| users |
|:----:|
| id (PK) |
| active |
| role |
| sign_up_source |
| state |
| id |
| created_date |
| last_login |

| brands |
|:--------:|
| id (PK) |
| barcode |
| category |
| category_code |
| name |
| top_brand |
| brand_code |
| cpg_id |
| cpg_ref |