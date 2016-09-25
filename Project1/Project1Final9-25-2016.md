Project 1
================

In this project, you’re given a text file with chess tournament results where the information has some structure. Your job is to create an R Markdown file that generates a .CSV file (that could for example be imported into a SQL database) with the following information for all of the players: Player’s Name, Player’s State, Total Number of Points, Player’s Pre-Rating, and Average Pre Chess Rating of Opponents For the first player, the information would be: Gary Hua, ON, 6.0, 1794, 1605

``` r
library("bitops")
library("RCurl")
library('stringr')

# Load text file from Github repository
url = "https://raw.githubusercontent.com/chrisestevez/DataAnalytics/master/Project1/tournamentinfo.txt"
# empty data frame to hold extracted values
finalDataFrame = data.frame()
Rdata = getURL(url)
MyData = read.csv(text = Rdata,header = FALSE,stringsAsFactors = F)
#initiate a loop and retreive row information
for (i in 1:nrow(MyData)) {
  playerNum= str_extract(MyData[i,],"[[:digit:]]+")
  name = str_extract(MyData[i,],"(\\w+\\s\\w+\\s*\\w*\\s*\\w*)")
    State = str_extract(MyData[i+1,],"[[:alpha:]]+")
    NumPoints =str_extract(MyData[i,],"(\\d\\.\\d)")
   PreRating = str_sub(MyData[i+1,],23, 26)
    r1 =str_sub(MyData[i,], 51, 52)
    r2 = str_sub(MyData[i,], 57, 58)
    r3 = str_sub(MyData[i,], 63, 64)
    r4 = str_sub(MyData[i,], 69, 70)
    r5 = str_sub(MyData[i,], 75, 76)
    r6 = str_sub(MyData[i,], 81, 82)
    r7 = str_sub(MyData[i,], 87, 88)

    #variable will hold data and append to data frame
  capturenum = data.frame("PlayerNum"=playerNum ,"PlayerState"=State,"PlayerName"=name,"TotalNumPoints" =NumPoints, "PlayerPreRating"=PreRating, "AvgPrerate"=0.0,"game1"=r1,"game2"=r2,"game3"=r3,"game4"=r4,"game5"=r5,"game6"=r6,"game7"=r7,stringsAsFactors = F)  
    finalDataFrame =rbind(finalDataFrame,capturenum)
}
# Here is the result of the finalDataFrame.
head(finalDataFrame)
```

    ##   PlayerNum PlayerState                       PlayerName TotalNumPoints PlayerPreRating AvgPrerate game1 game2 game3 game4 game5 game6 game7
    ## 1      <NA>        Pair                             <NA>           <NA>                          0    --    --    --    --    --    --    --
    ## 2      <NA>         Num Player Name                                <NA>            (Pre          0    nd    nd    nd    nd    nd    nd    nd
    ## 3         1        <NA>                         USCF ID            <NA>            ----          0                                          
    ## 4      <NA>        GARY                             <NA>           <NA>                          0    --    --    --    --    --    --    --
    ## 5         1          ON GARY HUA                                    6.0            1794          0    39    21    18    14     7    12     4
    ## 6  15445895        <NA>                             <NA>           <NA>            ----          0

``` r
#remove Nas from data
datanoNas = data.frame()
datanoNas =finalDataFrame[!is.na(finalDataFrame$TotalNumPoints),] 

#Here is the current out put excluding Nas
head(datanoNas)
```

    ##    PlayerNum PlayerState                       PlayerName TotalNumPoints PlayerPreRating AvgPrerate game1 game2 game3 game4 game5 game6 game7
    ## 5          1          ON GARY HUA                                    6.0            1794          0    39    21    18    14     7    12     4
    ## 8          2          MI DAKSHESH DARURI                             6.0            1553          0    63    58     4    17    16    20     7
    ## 11         3          MI ADITYA BAJAJ                                6.0            1384          0     8    61    25    21    11    13    12
    ## 14         4          MI PATRICK H SCHILLING                         5.5            1716          0    23    28     2    26     5    19     1
    ## 17         5          MI HANSHI ZUO                                  5.5            1655          0    45    37    12    13     4    14    17
    ## 20         6          OH HANSEN SONG                                 5.0            1686          0    34    29    11    35    10    27    21

``` r
# Converted values to numeric in order to do calculations.
datanoNas$game1=as.numeric(as.character(datanoNas$game1))
datanoNas$game2=as.numeric(as.character(datanoNas$game2))
datanoNas$game3=as.numeric(as.character(datanoNas$game3))
datanoNas$game4=as.numeric(as.character(datanoNas$game4))
datanoNas$game5=as.numeric(as.character(datanoNas$game5))
datanoNas$game6=as.numeric(as.character(datanoNas$game6))
datanoNas$game7=as.numeric(as.character(datanoNas$game7))
datanoNas$PlayerPreRating=as.numeric(as.character(datanoNas$PlayerPreRating))


# initial implementation 
# using merge function  I was matching the opponents column to the players  pre rating.
#End goal was to sum the players rating and divide by non Nas
#Due to my inability to rename the column after matching to original data I abandon this method.
#please see below example
f1 =data.frame()
l1= data.frame(datanoNas$PlayerNum,datanoNas$PlayerPreRating)  
head(l1)
```

    ##   datanoNas.PlayerNum datanoNas.PlayerPreRating
    ## 1                   1                      1794
    ## 2                   2                      1553
    ## 3                   3                      1384
    ## 4                   4                      1716
    ## 5                   5                      1655
    ## 6                   6                      1686

``` r
f1=merge(datanoNas,l1,by.x = "game1",by.y = "datanoNas.PlayerNum",all.x = TRUE)
head(f1)
```

    ##   game1 PlayerNum PlayerState                       PlayerName TotalNumPoints PlayerPreRating AvgPrerate game2 game3 game4 game5 game6 game7 datanoNas.PlayerPreRating
    ## 1     1        39          MI JOEL R HENDON                               3.0            1436          0    54    40    16    44    21    24                      1794
    ## 2     2        63          MI THOMAS JOSEPH HOSMER                        1.0            1175          0    48    49    43    45    NA    NA                      1553
    ## 3     3         8          MI EZEKIEL HOUGHTON                            5.0            1641          0    32    14     9    47    28    19                      1384
    ## 4     4        23          ON ALAN BUI                                    4.0            1363          0    43    20    58    17    37    46                      1716
    ## 5     5        45          MI DEREK YAN                                   3.0            1242          0    51    60    56    63    55    58                      1655
    ## 6     6        34          MI MICHAEL JEFFERY THOMAS                      3.5            1399          0    60    37    29    25    11    52                      1686

``` r
#colnames(f1$datanoNas.PlayerPreRating) ="Round1"
l2= data.frame(datanoNas$PlayerNum,datanoNas$PlayerPreRating)
head(l2)
```

    ##   datanoNas.PlayerNum datanoNas.PlayerPreRating
    ## 1                   1                      1794
    ## 2                   2                      1553
    ## 3                   3                      1384
    ## 4                   4                      1716
    ## 5                   5                      1655
    ## 6                   6                      1686

``` r
f1=merge(datanoNas,l2,by.x = "game2",by.y = "datanoNas.PlayerNum",all.x = TRUE)
head(f1)
```

    ##   game2 PlayerNum PlayerState                       PlayerName TotalNumPoints PlayerPreRating AvgPrerate game1 game3 game4 game5 game6 game7 datanoNas.PlayerPreRating
    ## 1     1        21          ON DINH DANG BUI                               4.0            1563          0    43    47     3    40    39     6                      1794
    ## 2     2        58          MI VIRAJ MOHILE                                2.0             917          0    31    41    23    49    NA    45                      1553
    ## 3     3        61          ON JEZZEL FARKAS                               1.5             955          0    32    54    47    42    30    37                      1384
    ## 4     4        28          MI             SOFIA ADINA STANESCU            3.5            1507          0    24    22    19    20     8    36                      1716
    ## 5     5        37          MI AMIYATOSH PWNANANDAM                        3.5             980          0    NA    34    27    NA    23    61                      1655
    ## 6     6        29          MI CHIEDOZIE OKORIE                            3.5            1602          0    50    38    34    52    48    NA                      1686

``` r
 # borrowed code from below person in order to calculate opponents pregame average.
#http://rpubs.com/brucehao/208280

#I nitialize loop
for (rowNum in 1:nrow(datanoNas)) {
  #empty variable to hold opponents pregame average
  favgpreRate = NULL  
    for (colNum in 1:7) {
      #included nested loop to iterate thru each column
    colName = paste("game", colNum,sep = "") 
    oppRowOriginal = datanoNas[rowNum, colName]
    favgpreRate = c(favgpreRate,datanoNas[oppRowOriginal, "PlayerPreRating"])
  }
  datanoNas[rowNum, "AvgPrerate"] = round(mean(favgpreRate, na.rm = TRUE), 0) 
  
}
#Output with pre game values
head(datanoNas)
```

    ##    PlayerNum PlayerState                       PlayerName TotalNumPoints PlayerPreRating AvgPrerate game1 game2 game3 game4 game5 game6 game7
    ## 5          1          ON GARY HUA                                    6.0            1794       1605    39    21    18    14     7    12     4
    ## 8          2          MI DAKSHESH DARURI                             6.0            1553       1469    63    58     4    17    16    20     7
    ## 11         3          MI ADITYA BAJAJ                                6.0            1384       1564     8    61    25    21    11    13    12
    ## 14         4          MI PATRICK H SCHILLING                         5.5            1716       1574    23    28     2    26     5    19     1
    ## 17         5          MI HANSHI ZUO                                  5.5            1655       1501    45    37    12    13     4    14    17
    ## 20         6          OH HANSEN SONG                                 5.0            1686       1519    34    29    11    35    10    27    21

``` r
# here I generate CSV file to local default directory.
#http://stackoverflow.com/questions/16630085/write-csv-or-table-variables-to-file

write.csv(datanoNas[,c("PlayerName","PlayerState","TotalNumPoints", "PlayerPreRating","AvgPrerate")], file="Project1outfile.csv",row.names=FALSE)
```
