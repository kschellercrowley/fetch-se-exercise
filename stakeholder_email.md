## Instructions
Construct an email or slack message that is understandable to a product or business leader who isn’t familiar with your day to day work. This part of the exercise should show off how you communicate and reason about data with others. Commit your answers to the git repository along with the rest of your exercise.

## Questions
* What questions do you have about the data?
* How did you discover the data quality issues?
* What do you need to know to resolve the data quality issues?
* What other information would you need to help you optimize the data assets you're trying to create?
* What performance and scaling concerns do you anticipate in production and how do you plan to address them?

## Email 
### Fetch Data Follow-Up
Hi team,

Hope everyone had a great weekend!

I just wrapped up an initial analysis of the new Fetch data, and want to pass along my findings as well as discuss next steps. 

To quickly summarize, below are the files that were sent to me by the Fetch engineering team:  
* brands.json
* receipts.json
* users.json

It took a bit of effort to unpack and map all of the various data together, but we now have a clear vision of the impact this data can have on our business.  

**Having direct access to this customer transaction data will be a game changer during our planning sessions, allowing us to lead with data-driven decision-making!**

In order to help get this across the finish line and into production, I have a couple of asks from you all.

First some questions about the data that we need clarity on:  
1. How often will new data be sent to us for ingestion? 
    * I need to determine the expected data latency and etl costs.
2. What is the correct connection/key to use when joining together the various items in the receipts to the brands?
    * Is this `brand_code`?
        * If so, there are a lot of missing data that needs to be addressed before pushing this process to production.
3. A deeper explanation on the various IDs in the receipts table would be helpful:
    * `partner_item_id`, `points_payer_id`, `rewards_product_partner_id`, `metabrite_campaign_id`
4. How should the `cpg_id` field in the `brands` table be referenced?
    * Is there an additional cpg reference table that can be provided?

There are also some data quality issues that were uncovered during the initial analysis:  
1. Fill-rate concerns
    * Several fields in each of the tables have less than a 100% fill rate.
    * Will this become an issue down the road? I would like to create a plan with you all on how to handle NULL or blank values. 
    * `brands` table
        * `category`: 86.7%
        * `categoryCode`: 44.3%
        * `topBrand`: 47.5%
        * `brandCode`: 79.9%
    * `receipts` table
        * `bonusPointsEarned`: 48.6%
        * `bonusPointsEarnedReason`: 48.6%
        * `pointsEarned`: 54.4%
        * `purchasedItemCount`: 56.7%
        * `rewardsReceiptItemList`: 60.6%
        * `totalSpent`: 61.1%
        * `purchaseDate`: 59.9%
    * `users` table
        * `signUpSource`: 90.3%
        * `state`: 88.6%
        * `lastLogin`: 87.4%
2. No clear brand id link to `receipts` or `receipts_items` tables
    * Without a clean and reliable link between the `brands` and `receipts` tables, attribution efforts and deeper analysis will prove to be very challenging, if not impossible. 
        * Let's ensure we have a clear path connecting the two so we can reliably report out on all of our brand partners. 
        * For this initial analysis, a lot of manual cleaning was required to create an initial link, but it is not scalable. 

I am feeling optimistic and excited about the potential that this Fetch data will have on our business! As long as we can get ahead of the above hurdles, this will be a tremendous asset to us all.   

Look out for a meeting invite for early next week to review all of this. 
Please take the time to review ahead of time!

Thanks all and please let me know if you have any questions in the meantime. 

Best,  
Kevin