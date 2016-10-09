Project 2
================

Instructions
============

Your task is to: (1) Choose any three of the “wide” datasets identified in the Week 6 Discussion items. (You may use your own dataset; please don’t use my Sample Post dataset, since that was used in your Week 6 assignment!) For each of the three chosen datasets:  Create a .CSV file (or optionally, a MySQL database!) that includes all of the information included in the dataset. You’re encouraged to use a “wide” structure similar to how the information appears in the discussion item, so that you can practice tidying and transformations as described below.  Read the information from your .CSV file into R, and use tidyr and dplyr as needed to tidy and transform your data. \[Most of your grade will be based on this step!\] Perform the analysis requested in the discussion item.  Your code should be in an R Markdown file, posted to rpubs.com, and should include narrative descriptions of your data cleanup work, analysis, and conclusions. (2) Please include in your homework submission, for each of the three chosen datasets: The URL to the .Rmd file in your GitHub repository, and  The URL for your rpubs.com web page.

Data Loading
============

``` r
url1="https://raw.githubusercontent.com/chrisestevez/DataAnalytics/master/Project2/201606-citibike-tripdata.csv"
url2="https://raw.githubusercontent.com/chrisestevez/DataAnalytics/master/Project2/Crosstab%20Query.csv"
url3="https://raw.githubusercontent.com/chrisestevez/DataAnalytics/master/Project2/LendingClubData.csv"
urlBike=getURL(url1)
urlCross=getURL(url2)
urlLend=getURL(url3)

CitiBike = read.csv(text =urlBike,header = TRUE,stringsAsFactors = F,sep=",")
CrossTab = read.csv(text=urlCross,header = TRUE,stringsAsFactors = F,sep=",")
LendingTree = read.csv(text=urlLend,header = TRUE,stringsAsFactors = F,sep=",")
```

Data Set 1
==========

Compare monthly citizenship for the given regions.
--------------------------------------------------

Regions 2, 3 and 5 had the greatest population by month. This is also supported in the total population by region.

``` r
str(CrossTab)
```

    ## 'data.frame':    9 obs. of  6 variables:
    ##  $ Month  : chr  "April" "May" "June" "July" ...
    ##  $ Region1: int  13 17 8 13 18 25 9 2 1
    ##  $ Region2: int  33 55 63 104 121 160 88 86 128
    ##  $ Region3: int  76 209 221 240 274 239 295 292 232
    ##  $ Region4: int  2 1 1 6 9 2 2 2 6
    ##  $ Region5: int  47 143 127 123 111 88 127 120 155

``` r
Crossdata =  gather(CrossTab,"Regions","Population",2:6)

ggplot(Crossdata, aes(Regions, Population,fill = Regions) ) +
  geom_bar(stat="identity", width = 0.5)+
  facet_grid(~ Month )+
 theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))+
      ggtitle("Population By Month")
```

<img src="Project2_files/figure-markdown_github/unnamed-chunk-1-1.png" style="display: block; margin: auto;" />

``` r
Crossdata = Crossdata %>%  group_by(Regions) %>% summarise(Total=sum(Population)) %>% arrange(desc(Total))

ggplot(Crossdata, aes(Regions, Total,fill = Regions) ) +
  geom_bar(stat="identity", width = 0.5)+
 theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))+
      ggtitle("Total Population By Region")
```

<img src="Project2_files/figure-markdown_github/unnamed-chunk-1-2.png" style="display: block; margin: auto;" />

Data set 2
==========

NYC Citibike data
-----------------

### Intructions

The data has some missing values that will have to be addressed. The data can be analyzed to create a profile of they typical Citibike users/subscriber. The year can be converted to an age and converted to a categorical variable. Start and stop times can be used to calculate the average time each bike is used.

After subsetting and analyzing the data the findings were the following:

1.  The majority of the users for citibike from the sample data are male 1/3 are female.
2.  The majority of the usage falls from from 22 - 40 years old.
3.  The majority of the time spent on a city bike ranges 2-20 minutes.

``` r
str(CitiBike)
```

    ## 'data.frame':    65499 obs. of  15 variables:
    ##  $ tripduration           : int  1470 229 344 1120 229 946 2351 773 1929 725 ...
    ##  $ starttime              : chr  "6/1/2016 00:00:18" "6/1/2016 00:00:20" "6/1/2016 00:00:21" "6/1/2016 00:00:28" ...
    ##  $ stoptime               : chr  "6/1/2016 00:24:48" "6/1/2016 00:04:09" "6/1/2016 00:06:06" "6/1/2016 00:19:09" ...
    ##  $ start.station.id       : int  380 3092 449 522 335 503 533 492 525 2002 ...
    ##  $ start.station.name     : chr  "W 4 St & 7 Ave S" "Berry St & N 8 St" "W 52 St & 9 Ave" "E 51 St & Lexington Ave" ...
    ##  $ start.station.latitude : num  40.7 40.7 40.8 40.8 40.7 ...
    ##  $ start.station.longitude: num  -74 -74 -74 -74 -74 ...
    ##  $ end.station.id         : int  3236 3103 469 401 285 495 386 483 306 3083 ...
    ##  $ end.station.name       : chr  "W 42 St & Dyer Ave" "N 11 St & Wythe Ave" "Broadway & W 53 St" "Allen St & Rivington St" ...
    ##  $ end.station.latitude   : num  40.8 40.7 40.8 40.7 40.7 ...
    ##  $ end.station.longitude  : num  -74 -74 -74 -74 -74 ...
    ##  $ bikeid                 : int  19859 16233 22397 16231 15400 25193 19538 17101 17802 21421 ...
    ##  $ usertype               : chr  "Subscriber" "Subscriber" "Subscriber" "Subscriber" ...
    ##  $ birth.year             : int  1972 1967 1989 1991 1989 1974 1986 1986 1968 1971 ...
    ##  $ gender                 : int  1 1 1 1 1 1 1 1 1 2 ...

``` r
Citi=CitiBike %>%  drop_na() %>% 
  select(tripduration,start.station.id,end.station.id,usertype,birth.year,gender)%>% 
mutate(TripTimeMinutes=round(tripduration/60, digits=0),Age= 2016 - birth.year)
Citi$gender =  c('1'="Male",'2'="Female")[ as.character(Citi$gender)]
ggplot(Citi, aes(gender, fill = gender) ) +
  geom_bar( width = 0.5)+
      ggtitle("Usage By Gender")
```

<img src="Project2_files/figure-markdown_github/unnamed-chunk-2-1.png" style="display: block; margin: auto;" />

``` r
#https://www.r-bloggers.com/how-to-make-a-histogram-with-ggplot2/
ggplot(data=Citi, aes(Age)) + 
  geom_histogram(breaks=seq(18,80, by =2), col="red",aes(fill=..count..)) +
     scale_fill_gradient("Count", low = "green", high = "red") +
      ggtitle("Age Histogram")             
```

<img src="Project2_files/figure-markdown_github/unnamed-chunk-2-2.png" style="display: block; margin: auto;" />

``` r
ggplot(data=Citi, aes(TripTimeMinutes)) + 
  geom_histogram(breaks=seq(1,75, by =1), col="red",aes(fill=..count..)) +
     scale_fill_gradient("Count", low = "green", high = "red")+
      ggtitle("Trip time Histogram")  
```

<img src="Project2_files/figure-markdown_github/unnamed-chunk-2-3.png" style="display: block; margin: auto;" />

Data set 3
==========

Lending Club Data
=================

<https://www.lendingclub.com/info/download-data.action> Just follow the link, we can download the data for the loans that were rejected and loans that is issued (Most current is 2016Q2). We can analyses the relationship among amount requested loan amount, debt to income ratio and employment length. Or we can compare income with interest rates and the rating of loans etc.

Due to the size of the data set being 50MB I removed some columns to reduce the size. My analysis focused on loans made by grade. A loan with grade A is a lower interest loan and consider less risky. The majority of the loans distributed were A,B, and C.

``` r
str(LendingTree)
```

    ## 'data.frame':    97854 obs. of  14 variables:
    ##  $ loan_amnt     : int  18000 9800 28000 20000 4900 19625 30000 21000 9000 20000 ...
    ##  $ funded_amnt   : int  18000 9800 28000 20000 4900 19625 30000 21000 9000 20000 ...
    ##  $ term          : chr  " 60 months" " 36 months" " 60 months" " 36 months" ...
    ##  $ int_rate      : chr  "13.49%" "14.49%" "15.59%" "16.99%" ...
    ##  $ installment   : num  414 337 675 713 160 ...
    ##  $ grade         : chr  "C" "C" "C" "D" ...
    ##  $ sub_grade     : chr  "C2" "C4" "C5" "D1" ...
    ##  $ emp_title     : chr  "Supervisor" "Restaurant manager " "Account Representative" "Transition Manager" ...
    ##  $ emp_length    : chr  "10+ years" "10+ years" "10+ years" "2 years" ...
    ##  $ home_ownership: chr  "MORTGAGE" "MORTGAGE" "MORTGAGE" "MORTGAGE" ...
    ##  $ annual_inc    : num  70000 48000 86000 71000 120000 45000 323000 80000 52500 130000 ...
    ##  $ purpose       : chr  "credit_card" "credit_card" "debt_consolidation" "credit_card" ...
    ##  $ title         : chr  "Credit card refinancing" "Credit card refinancing" "Debt consolidation" "Credit card refinancing" ...
    ##  $ addr_state    : chr  "VA" "OH" "AZ" "MI" ...

``` r
LendData = LendingTree %>% 
  select(loan_amnt,grade,addr_state) %>% 
  group_by(addr_state,grade) %>% 
  summarise(TotalLoanAMT=sum(loan_amnt),TotalLoans= n())


  ggplot(LendData, aes(grade, TotalLoanAMT,fill = grade) ) +
  geom_bar(stat="identity", width = 0.5)+
      ggtitle("Total Loan disbursement AMT By Grade")
```

<img src="Project2_files/figure-markdown_github/unnamed-chunk-3-1.png" style="display: block; margin: auto;" />

``` r
    ggplot(LendData, aes(grade, TotalLoans,fill = grade) ) +
  geom_bar(stat="identity", width = 0.5)+
       ggtitle("Total Loan disbursement By Grade")
```

<img src="Project2_files/figure-markdown_github/unnamed-chunk-3-2.png" style="display: block; margin: auto;" />
