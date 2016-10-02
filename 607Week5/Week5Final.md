607 Week5
================

Instructions
------------

Create a .CSV file (or optionally, a MySQL database!) that includes all of the information above. You are encouraged to use a “wide” structure similar to how the information appears above, so that you can practice tidying and transformations as described below.

``` r
url = "https://raw.githubusercontent.com/chrisestevez/DataAnalytics/master/607Week5/arrivalDelays.csv"
Rdata = getURL(url)
MyData = read.csv(text = Rdata,header = TRUE,stringsAsFactors = F,sep=",")

colnames(MyData)[which(names(MyData) == "X")] <- "Airline"
colnames(MyData)[which(names(MyData) == "X.1")] <- "Status"

MyData =MyData %>% drop_na()
MyData[2,1]= "ALASKA"
MyData[4,1]="AM WEST"

MyData
```

    ##   Airline  Status Los.Angeles Phoenix San.Diego San.Francisco Seattle
    ## 1  ALASKA on time         497     221       212           503    1841
    ## 2  ALASKA delayed          62      12        20           102     305
    ## 4 AM WEST on time         694    4840       383           320     201
    ## 5 AM WEST delayed         117     415        65           129      61

Data transformation
-------------------

``` r
FinalData = MyData %>% gather("Airport","Values",3:7) %>%
 spread("Status","Values")
FinalData
```

    ##    Airline       Airport delayed on time
    ## 1   ALASKA   Los.Angeles      62     497
    ## 2   ALASKA       Phoenix      12     221
    ## 3   ALASKA     San.Diego      20     212
    ## 4   ALASKA San.Francisco     102     503
    ## 5   ALASKA       Seattle     305    1841
    ## 6  AM WEST   Los.Angeles     117     694
    ## 7  AM WEST       Phoenix     415    4840
    ## 8  AM WEST     San.Diego      65     383
    ## 9  AM WEST San.Francisco     129     320
    ## 10 AM WEST       Seattle      61     201

Data Summary
------------

In order to effectively compare Alaska and AM West carriers, I analyzed their performance based on percentages in various categories.

``` r
FinalData= FinalData %>%
 group_by(Airline) %>% 
 summarise(ontimeTotal =sum(`on time`),delayedTotal =sum(delayed), TotalFlights =sum(`on time`+delayed),OnTimep = round( sum(`on time`) / sum(delayed +`on time`), digits=2),Delayp = round(sum(delayed) / sum(delayed +`on time`),digits=2) )
  

FinalData
```

    ## # A tibble: 2 × 6
    ##   Airline ontimeTotal delayedTotal TotalFlights OnTimep Delayp
    ##     <chr>       <int>        <int>        <int>   <dbl>  <dbl>
    ## 1  ALASKA        3274          501         3775    0.87   0.13
    ## 2 AM WEST        6438          787         7225    0.89   0.11

The summary indicates that AM West is is above Alaska airlines in on time flights by 2 percentage points. ![](Week5Final_files/figure-markdown_github/unnamed-chunk-3-1.png)

``` r
airportData = MyData %>% 
  gather("Airport","Values",3:7) %>%
 spread("Status","Values") %>% 
group_by(Airline,Airport) %>% 
 summarise(OnTimep = round( sum(`on time`) / sum(delayed +`on time`), digits=2),Delayp = round(sum(delayed) / sum(delayed +`on time`),digits=2) )
airportData
```

    ## Source: local data frame [10 x 4]
    ## Groups: Airline [?]
    ## 
    ##    Airline       Airport OnTimep Delayp
    ##      <chr>         <chr>   <dbl>  <dbl>
    ## 1   ALASKA   Los.Angeles    0.89   0.11
    ## 2   ALASKA       Phoenix    0.95   0.05
    ## 3   ALASKA     San.Diego    0.91   0.09
    ## 4   ALASKA San.Francisco    0.83   0.17
    ## 5   ALASKA       Seattle    0.86   0.14
    ## 6  AM WEST   Los.Angeles    0.86   0.14
    ## 7  AM WEST       Phoenix    0.92   0.08
    ## 8  AM WEST     San.Diego    0.85   0.15
    ## 9  AM WEST San.Francisco    0.71   0.29
    ## 10 AM WEST       Seattle    0.77   0.23

In the chart below we can effectively see that Alaska airline has a better on time performance than AM West across all airports. Therefore, contradicting the previous summary. ![](Week5Final_files/figure-markdown_github/unnamed-chunk-5-1.png) The chart illustrates a high volume of delays from AM West in San Francisco and Seattle

![](Week5Final_files/figure-markdown_github/unnamed-chunk-6-1.png)
