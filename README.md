
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tibbleprint

Print data frames as tibbles.

## Installation

Install with:

``` r
remotes::install_github("moodymudskipper/tibbleprint")
```

## When to use / not to use

*{tibbleprint}* overrides `base::print.data.frame()` and
`base::format.data.frame()`.

``` r
library(tibbleprint)
#> Registered S3 methods overwritten by 'tibbleprint':
#>   method            from
#>   format.data.frame base
#>   print.data.frame  base
```

It’s usually bad practice to override base methods. It’s unlikely to
have terrible consequences in this case though, and it’s nice to be able
to benefit from *{tibble}*’s pretty output on regular data frames.

In any case better use it on own projects, or remove from final
deliverable to avoid confusing collaborator or reader, or make your
local *R* authority grumpy.

It’s also probably a bad idea to place the library call in your
RProfile.

## How to use

After the package is attached, data frames will print like tibbles, and
printing of data frames will be affected by *{tibble}* and *{pillar}*’s
options.

The only two differences are that the header is different and row names
are displayed by default when they exist. Tibbles don’t have row names,
so this adjustment was necessary.

``` r
mtcars
#> # Description: df[,12] [32 x 11]
#>                    .   mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear
#>  *        <rownames> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1         Mazda RX4  21       6  160    110  3.9   2.62  16.5     0     1     4
#>  2     Mazda RX4 Wag  21       6  160    110  3.9   2.88  17.0     0     1     4
#>  3        Datsun 710  22.8     4  108     93  3.85  2.32  18.6     1     1     4
#>  4    Hornet 4 Drive  21.4     6  258    110  3.08  3.22  19.4     1     0     3
#>  5 Hornet Sportabout  18.7     8  360    175  3.15  3.44  17.0     0     0     3
#>  6           Valiant  18.1     6  225    105  2.76  3.46  20.2     1     0     3
#>  7        Duster 360  14.3     8  360    245  3.21  3.57  15.8     0     0     3
#>  8         Merc 240D  24.4     4  147.    62  3.69  3.19  20       1     0     4
#>  9          Merc 230  22.8     4  141.    95  3.92  3.15  22.9     1     0     4
#> 10          Merc 280  19.2     6  168.   123  3.92  3.44  18.3     1     0     4
#> # ... with 22 more rows, and 1 more variable: carb <dbl>

# the data didn't change
names(mtcars)
#>  [1] "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear"
#> [11] "carb"
```

We can hide row names:

``` r
print(mtcars, row.names = FALSE)
#> # Description: df[,11] [32 x 11]
#>      mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
#>  * <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1  21       6  160    110  3.9   2.62  16.5     0     1     4     4
#>  2  21       6  160    110  3.9   2.88  17.0     0     1     4     4
#>  3  22.8     4  108     93  3.85  2.32  18.6     1     1     4     1
#>  4  21.4     6  258    110  3.08  3.22  19.4     1     0     3     1
#>  5  18.7     8  360    175  3.15  3.44  17.0     0     0     3     2
#>  6  18.1     6  225    105  2.76  3.46  20.2     1     0     3     1
#>  7  14.3     8  360    245  3.21  3.57  15.8     0     0     3     4
#>  8  24.4     4  147.    62  3.69  3.19  20       1     0     4     2
#>  9  22.8     4  141.    95  3.92  3.15  22.9     1     0     4     2
#> 10  19.2     6  168.   123  3.92  3.44  18.3     1     0     4     4
#> # ... with 22 more rows
```

We can use any argument from `tibble:::print.tbl`:

``` r
print(mtcars, n = 2)
#> # Description: df[,12] [32 x 11]
#>               .   mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear
#> *    <rownames> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#> 1     Mazda RX4    21     6   160   110   3.9  2.62  16.5     0     1     4
#> 2 Mazda RX4 Wag    21     6   160   110   3.9  2.88  17.0     0     1     4
#> # ... with 30 more rows, and 1 more variable: carb <dbl>
```

The original base behavior is triggered by any of these conditions :

  - The `base` argument is set to `TRUE`.
  - The `base` argument is not set and option `"tibbleprint.base"` is
    set to `TRUE`.
  - Other arguments from `base::print.data.frame` (“digits”, “quote”,
    “right”, or “max”) are used.

<!-- end list -->

``` r
options(tibbleprint.base = TRUE)
mtcars
#>                      mpg cyl  disp  hp drat    wt  qsec vs am gear carb
#> Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
#> Mazda RX4 Wag       21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
#> Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
#> Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
#> Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
#> Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
#> Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
#> Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
#> Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
#> Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
#> Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
#> Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
#> Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
#> Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
#> Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
#> Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
#> Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
#> Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
#> Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
#> Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
#> Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
#> Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
#> AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
#> Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
#> Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
#> Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
#> Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
#> Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
#> Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
#> Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
#> Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
#> Volvo 142E          21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
options(tibbleprint.base = FALSE)
```

We made `n` work with base behavior for convenience.

``` r
# digits is an argument of base::data.frame (so triggers base printing)
# n isn't, yet this works
print(mtcars, digits = 0, n = 3)
#>               mpg cyl disp  hp drat wt qsec vs am gear carb
#> Mazda RX4      21   6  160 110    4  3   16  0  1    4    4
#> Mazda RX4 Wag  21   6  160 110    4  3   17  0  1    4    4
#> Datsun 710     23   4  108  93    4  2   19  1  1    4    1
#>  [ reached 'n' -- omitted 29 rows ]
```

Tibbles usually print nicer than data.frames, an occasional exception is
when you want to display small objects nested inside list columns, in
those cases using the `base` argument is useful.

``` r
test <- data.frame(id = 1:2)
test$list_col <- list(c(x=1, y=2), c(x=2, y = 4))

test
#> # Description: df[,2] [2 x 2]
#>      id list_col 
#>   <int> <list>   
#> 1     1 <dbl [2]>
#> 2     2 <dbl [2]>

print(test, base = TRUE)
#>   id list_col
#> 1  1     1, 2
#> 2  2     2, 4
```

## Aknowledgements

*{tibbleprint}* borrows a few essential lines of code from Kirill Müller
and Hadley Wickham’s *{tibble}* package, and the added value comes
essentially from their work.
