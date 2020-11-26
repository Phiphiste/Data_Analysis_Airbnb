# Data_Analysis_Airbnb

Data Analytics project proposed by Ms. MHANNA from the class "Data Analytics" of ECE PARIS.

Authors: 
- Philippe Rambaud
- Jean Leroy

## Run the Shiny app

Go in the project directory.
Run the pre_process_data.R file.
It will create the data folder containing every listings of cites (.csv).
Now, you can run the app.
``` 
library(shiny) 
runApp('app.R') 
```

## Understand the Shiny App

- In Tab 1 (Analysis1 – Comparing cities), you can:
  - Select the cities he would like to compare among the list of cities.
  - Select a feature that he would like to compare.
  - Select the aggregation type/ plot type.

- In Tab 2 (Analysis 2 – Deep dive into a city), you can:
  - Select the city he would like to analyze.
  - Display the finer grained analysis.
  - Display a map(s)of listings in the selected city.
  
