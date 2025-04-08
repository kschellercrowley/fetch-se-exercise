# ETL Process Documentation

## Process Steps

### 1. Data Extraction (`data_transform.ipynb`)
- Raw data is loaded from three JSON files:
  - `brands.json`
  - `receipts.json`
  - `users.json`
- Data is initially converted to Pandas DataFrames

### 2. Data Transformation (`data_transform.ipynb`)
- Column names are converted from camelCase to snake_case
- Data quality checks are performed:
  - Fill rates are calculated for each column
  - Data types are validated
  - Missing values are handled
- Transformed data is saved to cleaned CSV files:
  - `brands_cleaned.csv`
  - `receipts_cleaned.csv`
  - `receipts_items_cleaned.csv`
  - `users_cleaned.csv`

### 3. Data Loading (`database_load.ipynb`)
1. **Database Connection**
   - Uses PostgreSQL database
   - Connection details managed through environment variables
   
2. **Initial Table Creation**
   - Drops existing tables if present
   - Creates unformatted tables:
     - `brands` (no further formatting required for this table, so will remain the same)
     - `unformatted_receipts`
     - `unformatted_receipts_items`
     - `unformatted_users`

3. **Data Import**
   - Loads cleaned CSV files into unformatted tables
   - Handles data type conversions (e.g., boolean for top_brand)

4. **Data Formatting**
   - Creates formatted tables:
     - Converts text to appropriate numeric
     - Creates timestamps
     - Handles NULL values

5. **Database Schema Setup**
   - Primary Keys:
     - `brands.id`
     - `receipts.id`
     - `receipts_items.id`
     - `users.id`
   - Foreign Key relationships:
     - `receipts_items.receipt_id` → `receipts.id`
     - `receipts.user_id` → `users.id`

## Data Quality Considerations
- Missing values are handled with NULL or placeholder
- Link between receipts and receipts_items is maintained through the creation of a id field unique to each receipt item
- User IDs from receipts are added to users table if missing

## Technical Details
- **Programming Languages**: Python, SQL
- **Main Libraries**: pandas, psycopg2, SQLAlchemy
- **Database**: PostgreSQL
- **File Formats**: JSON (input), CSV (intermediate), SQL (database)