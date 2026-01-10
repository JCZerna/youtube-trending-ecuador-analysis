📊 YouTube Content Strategy Dashboard (Ecuador Market) 
📋 Project Overview  
The purpose of this Power BI dashboard is to give Ecuadorian content producers useful information. The program determines the "Golden Hour" for publishing and the ideal video duration to optimize audience interaction by examining engagement rates across various categories and times.

🛠️ Data Engineering Workflow (The "Under the Hood" Part) 
Note: This project uses a hybrid approach, combining capability BI's visualization capabilities with R's statistical capability.
    1) ETL with RStudio Wrangling: 
        ◦ The raw YouTube metadata was cleaned using R.
        ◦ To classify video lengths, the duration_range buckets were designed.
        ◦ Temporal data was formatted to enable hourly engagement mapping.
    2) Power BI visualization:
        ◦ The cleaned R-output was connected for the UI design and final modeling. 
          
💡 Key Strategic Insights 
    • The "Golden Hour": 9:00 PM was determined to be the peak strategy hour for overall engagement by custom DAX research.
    • The 10-20 Min Sweet Spot: Although many producers concentrate on short-form content, the data shows that when videos are between 10 and 20 minutes long, there is a notable increase in interaction (almost 15%) for comedic content.
    • Category Outliers: Regardless of the overall volume of videos, comedy and gaming routinely beat established categories in terms of engagement.

🛠️ Technical Features 
    • Dynamic KPIs: DAX metrics were used to determine "Peak Strategy Hour" and "Average Engagement %."
    • Advanced Interactivity: Provides a temporal heatmap to compare performance by hour and niche, as well as a multi-select category slicer.
    • Visual Optimization: High-performing outliers like Comedy were highlighted using a high-contrast category color scheme (Semantic Resonance).
    • Data Cleaning: To make trend analysis cleaner, raw YouTube metadata was converted into binned duration ranges.

🧪 Data Storytelling
The dashboard has a deliberate, gloomy theme:
    • Top Ribbon: High-level KPIs for quick "at-a-glance" decisions.
    • Heatmap: Shows trends of audience "availability" over the course of the day.
    • Performance Chart: To ascertain production strategy, a clustered column chart that compares the length of videos in five major areas. 
