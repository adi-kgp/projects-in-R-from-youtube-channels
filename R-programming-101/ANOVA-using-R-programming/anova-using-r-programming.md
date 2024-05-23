Anova using R programming
================

``` r
# Explore
# Clean
# Manipulate
# Describe and Summarize
# Visualize
# Analyse
##### Analyze your data --- ANOVA 
```

``` r
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.2 ──
    ## ✔ ggplot2 3.5.1     ✔ purrr   1.0.2
    ## ✔ tibble  3.2.1     ✔ dplyr   1.1.4
    ## ✔ tidyr   1.3.1     ✔ stringr 1.5.1
    ## ✔ readr   2.1.5     ✔ forcats 1.0.0
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
library(patchwork)
library(gapminder)
library(forcats)
```

``` r
data()
```

``` r
head(gapminder)
```

    ## # A tibble: 6 × 6
    ##   country     continent  year lifeExp      pop gdpPercap
    ##   <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
    ## 1 Afghanistan Asia       1952    28.8  8425333      779.
    ## 2 Afghanistan Asia       1957    30.3  9240934      821.
    ## 3 Afghanistan Asia       1962    32.0 10267083      853.
    ## 4 Afghanistan Asia       1967    34.0 11537966      836.
    ## 5 Afghanistan Asia       1972    36.1 13079460      740.
    ## 6 Afghanistan Asia       1977    38.4 14880372      786.

``` r
# Create a data set to work with 
gapdata <- gapminder %>%
  filter(year == 2007 & 
           continent %in% c("Americas", "Europe", "Asia")) %>%
  select(continent, lifeExp)
```

``` r
gapdata
```

    ## # A tibble: 88 × 2
    ##    continent lifeExp
    ##    <fct>       <dbl>
    ##  1 Asia         43.8
    ##  2 Europe       76.4
    ##  3 Americas     75.3
    ##  4 Europe       79.8
    ##  5 Asia         75.6
    ##  6 Asia         64.1
    ##  7 Europe       79.4
    ##  8 Americas     65.6
    ##  9 Europe       74.9
    ## 10 Americas     72.4
    ## # ℹ 78 more rows

``` r
# Take a look at the distribution of means 
gapdata %>%
  group_by(continent) %>%
  summarise(Mean_life = mean(lifeExp)) %>%
  arrange(Mean_life)
```

    ## # A tibble: 3 × 2
    ##   continent Mean_life
    ##   <fct>         <dbl>
    ## 1 Asia           70.7
    ## 2 Americas       73.6
    ## 3 Europe         77.6

``` r
# Create ANOVA model
gapdata %>%
  aov(lifeExp ~ continent, data = .) %>%
  summary()
```

    ##             Df Sum Sq Mean Sq F value   Pr(>F)    
    ## continent    2  755.6   377.8   11.63 3.42e-05 ***
    ## Residuals   85 2760.3    32.5                     
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
aov_model <- gapdata %>%
  aov(lifeExp ~ continent, data = .)
```

``` r
# Is this significance being driven by a particular continent?
gapdata %>%
  aov(lifeExp ~ continent, data=.) %>%
  TukeyHSD() #%>%
```

    ##   Tukey multiple comparisons of means
    ##     95% family-wise confidence level
    ## 
    ## Fit: aov(formula = lifeExp ~ continent, data = .)
    ## 
    ## $continent
    ##                      diff        lwr        upr     p adj
    ## Asia-Americas   -2.879635 -6.4839802  0.7247099 0.1432634
    ## Europe-Americas  4.040480  0.3592746  7.7216854 0.0279460
    ## Europe-Asia      6.920115  3.4909215 10.3493088 0.0000189

``` r
# The difference between Asia and the Americas has an adjusted p value of 0.14 (not significant) and a 95% CI that overlaps 0
```
