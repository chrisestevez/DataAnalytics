Regular Expressions
================

### Problem 3

``` r
library('stringr')


#Initial problem
raw.data <- "555-1239Moe Szyslak(636) 555-0113Burns, C. Montgomery555-6542Rev. Timothy Lovejoy555 8904Ned Flanders636-555-3226Simpson, Homer5543642Dr. Julius Hibbert"
name <- unlist(str_extract_all(raw.data, "[[:alpha:]., ]{2,}"))
name
```

    ## [1] "Moe Szyslak"          "Burns, C. Montgomery" "Rev. Timothy Lovejoy"
    ## [4] "Ned Flanders"         "Simpson, Homer"       "Dr. Julius Hibbert"

1a)Use the tools of this chapter to rearrange the vector so that all elements conform to the standard first\_name last\_name

``` r
change = str_replace(name,"Burns, C. Montgomery","Montgomery C. Burns")
str_replace(change,"Simpson, Homer", "Homer Simpson")
```

    ## [1] "Moe Szyslak"          "Montgomery C. Burns"  "Rev. Timothy Lovejoy"
    ## [4] "Ned Flanders"         "Homer Simpson"        "Dr. Julius Hibbert"

2b)Construct a logical vector indicating whether a character has a title(i.e.Rev. and Dr.)

``` r
str_detect(name,"Rev.|Dr.")
```

    ## [1] FALSE FALSE  TRUE FALSE FALSE  TRUE

``` r
name
```

    ## [1] "Moe Szyslak"          "Burns, C. Montgomery" "Rev. Timothy Lovejoy"
    ## [4] "Ned Flanders"         "Simpson, Homer"       "Dr. Julius Hibbert"

3c)Construct a logical vector indicating whether a character has a second name.

``` r
str_detect(name,"[A-Z][:punct:]")
```

    ## [1] FALSE  TRUE FALSE FALSE FALSE FALSE

``` r
name[2]
```

    ## [1] "Burns, C. Montgomery"

### Problem 4

Describe the types of strings that conform to the following regular expressions and construct an example that is matched by the regular expression.

1a) \[0-9\]+\\$

The regular expression will find digits before or after.

``` r
  example1 = c("1$"," 3# ","6/","606$")
  str_extract(example1,"[0-9]+\\$")
```

    ## [1] "1$"   NA     NA     "606$"

2b) \\b\[a-z\]{1,4}\\b

The regular expression will identify a 1 thru 4 lower case continuous pattern.

``` r
example2 = c("a", "ab", "abc", "abcd", "abcde", "abcdef")
str_extract(example2,"\\b[a-z]{1,4}\\b")
```

    ## [1] "a"    "ab"   "abc"  "abcd" NA     NA

3c) .\*?\\.txt$

The expression will find a pattern ending in TXT.

``` r
  example3 =c("test.txt", "file.xlx", "complete.txt")
  
  str_extract(example3,".*?\\.txt$")
```

    ## [1] "test.txt"     NA             "complete.txt"

``` r
  str_detect(example3,".*?\\.txt$")
```

    ## [1]  TRUE FALSE  TRUE

4d) \\d{2}/\\d{2}\\d{4}

The expression will capture date information formatted mm/dd/yyyy .

``` r
example4 =c("01/01/2016","08/12/2014","1/1/2015")
  
  str_extract(example4,"\\d{2}/\\d{2}/\\d{4}")
```

    ## [1] "01/01/2016" "08/12/2014" NA

5e) &lt;(.+?)&gt;.+?&lt;/\\1&gt;

The expression will identify well formatted HTML tags.

``` r
  example5 =c("<head>hello</head>","<body><p>some text</p></body>","<title>HTML Reference<title>")

str_extract(example5,"<(.+?)>.+?</\\1>")
```

    ## [1] "<head>hello</head>"            "<body><p>some text</p></body>"
    ## [3] NA

### Problem 9

The following code hides a secrete message. Crack it with R and regular expressions.

Below we find capitalize letters identify the message and the words are spaced by periods.

``` r
secretMessage = "clcopCow1zmstc0d87wnkig7OvdicpNuggvhryn92Gjuwczi8hqrfpRxs5Aj5dwpn0TanwoUwisdij7Lj8kpf03AT5Idr3coc0bt7yczjatOaootj55t3Nj3ne6c4Sfek.r1w1YwwojigOd6vrfUrbz2.2bkAnbhzgv4R9i05zEcrop.wAgnb.SqoU65fPa1otfb7wEm24k6t3sR9zqe5fy89n6Nd5t9kc4fE905gmc4Rgxo5nhDk!gr"

decoded= str_extract_all(secretMessage,"[[:upper:].]")

 print(decoded,quote = FALSE)
```

    ## [[1]]
    ##  [1] C O N G R A T U L A T I O N S . Y O U . A R E . A . S U P E R N E R D
