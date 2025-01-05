---
title: Base R and Tidyverse syntax comparison for data wrangling
Comparisons: Base R vs. tidyverse (with data.table)
filters:
   - assets/foldableOutput.lua
date: today
author:
  - name: Emi Tanaka
    affiliations: 
      - name: Australian National University
        department: Biological Data Science Institute
        address: 46 Sullivan's Creek Road, R.N. Robertson Building, ACT 2600 Australia
    corresponding: true
    email: emi.tanaka@anu.edu.au
    orcid: 0000-0002-1455-259X
bibliography: references.bib
# shorttitle: Examining the interface design of tidyverse
engine: knitr
execute:
  echo: true
format: 
  html:
    number-sections: true
    toc: true
    keep-md: true
    toc-expanded: 3
editor:
  render-on-save: true
---






# Introduction



::: {.cell}

```{.r .cell-code}
library(tidyverse)
```

::: {.cell-output .cell-output-stderr}

```
── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
✔ dplyr     1.1.4     ✔ readr     2.1.5
✔ forcats   1.0.0     ✔ stringr   1.5.1
✔ ggplot2   3.5.1     ✔ tibble    3.2.1
✔ lubridate 1.9.3     ✔ tidyr     1.3.1
✔ purrr     1.0.2     
── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()
ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
```


:::
:::

::: {.cell}
<style type="text/css">
.details {
  font-size: 0.7em;
  padding: 5px;
}
.column {
  border: 1px solid grey;
  border-radius: 5px;
  margin-right: 5px;
  margin-top: 5px;
  width: calc(50% - 10px)!important;
}

.column p {
  padding: 5px;
}
</style>
:::



# Tabular data 



::: {.cell}

```{.r .cell-code}
library(palmerpenguins)
penguins_small <- penguins[seq(1, 300, 30), 
                           c("species", "sex", "bill_length_mm", "bill_depth_mm", "body_mass_g")] |> 
  rename(mass = body_mass_g)
tbl <- as_tibble(penguins_small)
df <- as.data.frame(penguins_small)
```
:::



::: column-margin



::: {.cell}

```{.r .cell-code}
library(data.table)
dt <- as.data.table(penguins_small)
```
:::





:::











## Selecting a single column as a vector

::: {.columns}

::: {.column}



::: {.cell}

```{.r .cell-code}
df$sex
```

::: {.cell-output .cell-output-stdout}

```
 [1] male   female female female female female female female female female
Levels: female male
```


:::

```{.r .cell-code}
df[["sex"]]
```

::: {.cell-output .cell-output-stdout}

```
 [1] male   female female female female female female female female female
Levels: female male
```


:::

```{.r .cell-code}
df[, "sex", drop = TRUE]
```

::: {.cell-output .cell-output-stdout}

```
 [1] male   female female female female female female female female female
Levels: female male
```


:::
:::



:::

::: {.column}



::: {.cell}

```{.r .cell-code}
pull(tbl, sex)
```

::: {.cell-output .cell-output-stdout}

```
 [1] male   female female female female female female female female female
Levels: female male
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
dt[, .(sex)]
```

::: {.cell-output .cell-output-stdout}

```
       sex
    <fctr>
 1:   male
 2: female
 3: female
 4: female
 5: female
 6: female
 7: female
 8: female
 9: female
10: female
```


:::
:::



:::



## Selecting columns

### By column name

::: {.columns}

::: {.column}



::: {.cell}

```{.r .cell-code}
subset(df, 
       select = c(sex, species))
```

::: {.cell-output .cell-output-stdout}

```
      sex species
1    male  Adelie
2  female  Adelie
3  female  Adelie
4  female  Adelie
5  female  Adelie
6  female  Adelie
7  female  Gentoo
8  female  Gentoo
9  female  Gentoo
10 female  Gentoo
```


:::

```{.r .cell-code}
subset(df, 
       select = c("sex", "species"))
```

::: {.cell-output .cell-output-stdout}

```
      sex species
1    male  Adelie
2  female  Adelie
3  female  Adelie
4  female  Adelie
5  female  Adelie
6  female  Adelie
7  female  Gentoo
8  female  Gentoo
9  female  Gentoo
10 female  Gentoo
```


:::

```{.r .cell-code}
df[c("sex", "species")]
```

::: {.cell-output .cell-output-stdout}

```
      sex species
1    male  Adelie
2  female  Adelie
3  female  Adelie
4  female  Adelie
5  female  Adelie
6  female  Adelie
7  female  Gentoo
8  female  Gentoo
9  female  Gentoo
10 female  Gentoo
```


:::

```{.r .cell-code}
df[, c("sex", "species")]
```

::: {.cell-output .cell-output-stdout}

```
      sex species
1    male  Adelie
2  female  Adelie
3  female  Adelie
4  female  Adelie
5  female  Adelie
6  female  Adelie
7  female  Gentoo
8  female  Gentoo
9  female  Gentoo
10 female  Gentoo
```


:::
:::



:::

::: {.column}



::: {.cell}

```{.r .cell-code}
select(tbl, sex, species)
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 2
   sex    species
   <fct>  <fct>  
 1 male   Adelie 
 2 female Adelie 
 3 female Adelie 
 4 female Adelie 
 5 female Adelie 
 6 female Adelie 
 7 female Gentoo 
 8 female Gentoo 
 9 female Gentoo 
10 female Gentoo 
```


:::

```{.r .cell-code}
select(tbl, c(sex, species))
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 2
   sex    species
   <fct>  <fct>  
 1 male   Adelie 
 2 female Adelie 
 3 female Adelie 
 4 female Adelie 
 5 female Adelie 
 6 female Adelie 
 7 female Gentoo 
 8 female Gentoo 
 9 female Gentoo 
10 female Gentoo 
```


:::

```{.r .cell-code}
select(tbl, c("sex", "species"))
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 2
   sex    species
   <fct>  <fct>  
 1 male   Adelie 
 2 female Adelie 
 3 female Adelie 
 4 female Adelie 
 5 female Adelie 
 6 female Adelie 
 7 female Gentoo 
 8 female Gentoo 
 9 female Gentoo 
10 female Gentoo 
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
dt[, .(sex, species)]
```

::: {.cell-output .cell-output-stdout}

```
       sex species
    <fctr>  <fctr>
 1:   male  Adelie
 2: female  Adelie
 3: female  Adelie
 4: female  Adelie
 5: female  Adelie
 6: female  Adelie
 7: female  Gentoo
 8: female  Gentoo
 9: female  Gentoo
10: female  Gentoo
```


:::
:::



:::

### By position 

::: {.columns}

::: {.column}



::: {.cell}

```{.r .cell-code}
subset(df, select = c(1, 2))
```

::: {.cell-output .cell-output-stdout}

```
   species    sex
1   Adelie   male
2   Adelie female
3   Adelie female
4   Adelie female
5   Adelie female
6   Adelie female
7   Gentoo female
8   Gentoo female
9   Gentoo female
10  Gentoo female
```


:::

```{.r .cell-code}
df[c(1, 2)]
```

::: {.cell-output .cell-output-stdout}

```
   species    sex
1   Adelie   male
2   Adelie female
3   Adelie female
4   Adelie female
5   Adelie female
6   Adelie female
7   Gentoo female
8   Gentoo female
9   Gentoo female
10  Gentoo female
```


:::

```{.r .cell-code}
df[, c(1, 2)]
```

::: {.cell-output .cell-output-stdout}

```
   species    sex
1   Adelie   male
2   Adelie female
3   Adelie female
4   Adelie female
5   Adelie female
6   Adelie female
7   Gentoo female
8   Gentoo female
9   Gentoo female
10  Gentoo female
```


:::
:::



:::

::: {.column}



::: {.cell}

```{.r .cell-code}
select(tbl, 1, 2)
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 2
   species sex   
   <fct>   <fct> 
 1 Adelie  male  
 2 Adelie  female
 3 Adelie  female
 4 Adelie  female
 5 Adelie  female
 6 Adelie  female
 7 Gentoo  female
 8 Gentoo  female
 9 Gentoo  female
10 Gentoo  female
```


:::

```{.r .cell-code}
select(tbl, c(1, 2))
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 2
   species sex   
   <fct>   <fct> 
 1 Adelie  male  
 2 Adelie  female
 3 Adelie  female
 4 Adelie  female
 5 Adelie  female
 6 Adelie  female
 7 Gentoo  female
 8 Gentoo  female
 9 Gentoo  female
10 Gentoo  female
```


:::
:::



:::

:::

::: {.column-margin}



::: {.cell}

```{.r .cell-code}
dt[, c(1, 2)]
```

::: {.cell-output .cell-output-stdout}

```
    species    sex
     <fctr> <fctr>
 1:  Adelie   male
 2:  Adelie female
 3:  Adelie female
 4:  Adelie female
 5:  Adelie female
 6:  Adelie female
 7:  Gentoo female
 8:  Gentoo female
 9:  Gentoo female
10:  Gentoo female
```


:::
:::



:::




### By booleans

::: {.columns}

::: {.column}



::: {.cell}

```{.r .cell-code}
subset(df, select = sapply(df, is.factor))
```

::: {.cell-output .cell-output-stdout}

```
   species    sex
1   Adelie   male
2   Adelie female
3   Adelie female
4   Adelie female
5   Adelie female
6   Adelie female
7   Gentoo female
8   Gentoo female
9   Gentoo female
10  Gentoo female
```


:::

```{.r .cell-code}
df[sapply(df, is.factor)]
```

::: {.cell-output .cell-output-stdout}

```
   species    sex
1   Adelie   male
2   Adelie female
3   Adelie female
4   Adelie female
5   Adelie female
6   Adelie female
7   Gentoo female
8   Gentoo female
9   Gentoo female
10  Gentoo female
```


:::

```{.r .cell-code}
df[, sapply(df, is.factor)]
```

::: {.cell-output .cell-output-stdout}

```
   species    sex
1   Adelie   male
2   Adelie female
3   Adelie female
4   Adelie female
5   Adelie female
6   Adelie female
7   Gentoo female
8   Gentoo female
9   Gentoo female
10  Gentoo female
```


:::
:::



:::

::: {.column}



::: {.cell}

```{.r .cell-code}
select(tbl, where(is.factor))
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 2
   species sex   
   <fct>   <fct> 
 1 Adelie  male  
 2 Adelie  female
 3 Adelie  female
 4 Adelie  female
 5 Adelie  female
 6 Adelie  female
 7 Gentoo  female
 8 Gentoo  female
 9 Gentoo  female
10 Gentoo  female
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
dt[, sapply(dt, is.factor), with = FALSE]
```

::: {.cell-output .cell-output-stdout}

```
    species    sex
     <fctr> <fctr>
 1:  Adelie   male
 2:  Adelie female
 3:  Adelie female
 4:  Adelie female
 5:  Adelie female
 6:  Adelie female
 7:  Gentoo female
 8:  Gentoo female
 9:  Gentoo female
10:  Gentoo female
```


:::
:::



:::

## Deleting one column

::: {.columns}

::: {.column}



::: {.cell}

```{.r .cell-code}
subset(df, select = -sex)
```

::: {.cell-output .cell-output-stdout}

```
   species bill_length_mm bill_depth_mm mass
1   Adelie           39.1          18.7 3750
2   Adelie           39.5          16.7 3250
3   Adelie           35.7          16.9 3150
4   Adelie           35.7          18.0 3550
5   Adelie           36.2          17.2 3150
6   Adelie           36.0          17.1 3700
7   Gentoo           48.2          14.3 4600
8   Gentoo           43.2          14.5 4450
9   Gentoo           47.5          14.0 4875
10  Gentoo           47.2          13.7 4925
```


:::
:::

::: {.cell isolate='true'}

```{.r .cell-code}
df$sex <- NULL
df
```

::: {.cell-output .cell-output-stdout}

```
   species bill_length_mm bill_depth_mm mass
1   Adelie           39.1          18.7 3750
2   Adelie           39.5          16.7 3250
3   Adelie           35.7          16.9 3150
4   Adelie           35.7          18.0 3550
5   Adelie           36.2          17.2 3150
6   Adelie           36.0          17.1 3700
7   Gentoo           48.2          14.3 4600
8   Gentoo           43.2          14.5 4450
9   Gentoo           47.5          14.0 4875
10  Gentoo           47.2          13.7 4925
```


:::
:::



:::

::: {.column}



::: {.cell}

```{.r .cell-code}
select(tbl, -sex)
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 4
   species bill_length_mm bill_depth_mm  mass
   <fct>            <dbl>         <dbl> <int>
 1 Adelie            39.1          18.7  3750
 2 Adelie            39.5          16.7  3250
 3 Adelie            35.7          16.9  3150
 4 Adelie            35.7          18    3550
 5 Adelie            36.2          17.2  3150
 6 Adelie            36            17.1  3700
 7 Gentoo            48.2          14.3  4600
 8 Gentoo            43.2          14.5  4450
 9 Gentoo            47.5          14    4875
10 Gentoo            47.2          13.7  4925
```


:::

```{.r .cell-code}
mutate(tbl, sex = NULL)
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 4
   species bill_length_mm bill_depth_mm  mass
   <fct>            <dbl>         <dbl> <int>
 1 Adelie            39.1          18.7  3750
 2 Adelie            39.5          16.7  3250
 3 Adelie            35.7          16.9  3150
 4 Adelie            35.7          18    3550
 5 Adelie            36.2          17.2  3150
 6 Adelie            36            17.1  3700
 7 Gentoo            48.2          14.3  4600
 8 Gentoo            43.2          14.5  4450
 9 Gentoo            47.5          14    4875
10 Gentoo            47.2          13.7  4925
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell isolate='true'}

```{.r .cell-code}
dt[, sex := NULL]
dt
```

::: {.cell-output .cell-output-stdout}

```
    species bill_length_mm bill_depth_mm  mass
     <fctr>          <num>         <num> <int>
 1:  Adelie           39.1          18.7  3750
 2:  Adelie           39.5          16.7  3250
 3:  Adelie           35.7          16.9  3150
 4:  Adelie           35.7          18.0  3550
 5:  Adelie           36.2          17.2  3150
 6:  Adelie           36.0          17.1  3700
 7:  Gentoo           48.2          14.3  4600
 8:  Gentoo           43.2          14.5  4450
 9:  Gentoo           47.5          14.0  4875
10:  Gentoo           47.2          13.7  4925
```


:::
:::



:::

## Deleting multiple column

::: {.columns}

::: {.column}



::: {.cell}

```{.r .cell-code}
subset(df, select = -c(sex, species))
```

::: {.cell-output .cell-output-stdout}

```
   bill_length_mm bill_depth_mm mass
1            39.1          18.7 3750
2            39.5          16.7 3250
3            35.7          16.9 3150
4            35.7          18.0 3550
5            36.2          17.2 3150
6            36.0          17.1 3700
7            48.2          14.3 4600
8            43.2          14.5 4450
9            47.5          14.0 4875
10           47.2          13.7 4925
```


:::
:::

::: {.cell isolate='true'}

```{.r .cell-code}
df[c("sex", "species")] <- NULL
df
```

::: {.cell-output .cell-output-stdout}

```
   bill_length_mm bill_depth_mm mass
1            39.1          18.7 3750
2            39.5          16.7 3250
3            35.7          16.9 3150
4            35.7          18.0 3550
5            36.2          17.2 3150
6            36.0          17.1 3700
7            48.2          14.3 4600
8            43.2          14.5 4450
9            47.5          14.0 4875
10           47.2          13.7 4925
```


:::
:::



:::

::: {.column}



::: {.cell}

```{.r .cell-code}
select(tbl, -c(sex, species))
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 3
   bill_length_mm bill_depth_mm  mass
            <dbl>         <dbl> <int>
 1           39.1          18.7  3750
 2           39.5          16.7  3250
 3           35.7          16.9  3150
 4           35.7          18    3550
 5           36.2          17.2  3150
 6           36            17.1  3700
 7           48.2          14.3  4600
 8           43.2          14.5  4450
 9           47.5          14    4875
10           47.2          13.7  4925
```


:::

```{.r .cell-code}
select(tbl, !c(sex, species))
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 3
   bill_length_mm bill_depth_mm  mass
            <dbl>         <dbl> <int>
 1           39.1          18.7  3750
 2           39.5          16.7  3250
 3           35.7          16.9  3150
 4           35.7          18    3550
 5           36.2          17.2  3150
 6           36            17.1  3700
 7           48.2          14.3  4600
 8           43.2          14.5  4450
 9           47.5          14    4875
10           47.2          13.7  4925
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
dt[, !c("sex", "species")]
```

::: {.cell-output .cell-output-stdout}

```
    bill_length_mm bill_depth_mm  mass
             <num>         <num> <int>
 1:           39.1          18.7  3750
 2:           39.5          16.7  3250
 3:           35.7          16.9  3150
 4:           35.7          18.0  3550
 5:           36.2          17.2  3150
 6:           36.0          17.1  3700
 7:           48.2          14.3  4600
 8:           43.2          14.5  4450
 9:           47.5          14.0  4875
10:           47.2          13.7  4925
```


:::
:::



:::

## Arrange columns

::: {.columns}

::: {.column}



::: {.cell}

```{.r .cell-code}
cols <- colnames(df)
new_order <- c("sex", setdiff(cols, "sex"))
```
:::

::: {.cell}

```{.r .cell-code}
subset(df, select = new_order)
```

::: {.cell-output .cell-output-stdout}

```
      sex species bill_length_mm bill_depth_mm mass
1    male  Adelie           39.1          18.7 3750
2  female  Adelie           39.5          16.7 3250
3  female  Adelie           35.7          16.9 3150
4  female  Adelie           35.7          18.0 3550
5  female  Adelie           36.2          17.2 3150
6  female  Adelie           36.0          17.1 3700
7  female  Gentoo           48.2          14.3 4600
8  female  Gentoo           43.2          14.5 4450
9  female  Gentoo           47.5          14.0 4875
10 female  Gentoo           47.2          13.7 4925
```


:::

```{.r .cell-code}
df[new_order]
```

::: {.cell-output .cell-output-stdout}

```
      sex species bill_length_mm bill_depth_mm mass
1    male  Adelie           39.1          18.7 3750
2  female  Adelie           39.5          16.7 3250
3  female  Adelie           35.7          16.9 3150
4  female  Adelie           35.7          18.0 3550
5  female  Adelie           36.2          17.2 3150
6  female  Adelie           36.0          17.1 3700
7  female  Gentoo           48.2          14.3 4600
8  female  Gentoo           43.2          14.5 4450
9  female  Gentoo           47.5          14.0 4875
10 female  Gentoo           47.2          13.7 4925
```


:::

```{.r .cell-code}
df[, new_order]
```

::: {.cell-output .cell-output-stdout}

```
      sex species bill_length_mm bill_depth_mm mass
1    male  Adelie           39.1          18.7 3750
2  female  Adelie           39.5          16.7 3250
3  female  Adelie           35.7          16.9 3150
4  female  Adelie           35.7          18.0 3550
5  female  Adelie           36.2          17.2 3150
6  female  Adelie           36.0          17.1 3700
7  female  Gentoo           48.2          14.3 4600
8  female  Gentoo           43.2          14.5 4450
9  female  Gentoo           47.5          14.0 4875
10 female  Gentoo           47.2          13.7 4925
```


:::
:::



:::

::: {.column}



::: {.cell}

```{.r .cell-code}
select(tbl, sex, everything())
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 5
   sex    species bill_length_mm bill_depth_mm  mass
   <fct>  <fct>            <dbl>         <dbl> <int>
 1 male   Adelie            39.1          18.7  3750
 2 female Adelie            39.5          16.7  3250
 3 female Adelie            35.7          16.9  3150
 4 female Adelie            35.7          18    3550
 5 female Adelie            36.2          17.2  3150
 6 female Adelie            36            17.1  3700
 7 female Gentoo            48.2          14.3  4600
 8 female Gentoo            43.2          14.5  4450
 9 female Gentoo            47.5          14    4875
10 female Gentoo            47.2          13.7  4925
```


:::

```{.r .cell-code}
relocate(tbl, sex, .before = species)
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 5
   sex    species bill_length_mm bill_depth_mm  mass
   <fct>  <fct>            <dbl>         <dbl> <int>
 1 male   Adelie            39.1          18.7  3750
 2 female Adelie            39.5          16.7  3250
 3 female Adelie            35.7          16.9  3150
 4 female Adelie            35.7          18    3550
 5 female Adelie            36.2          17.2  3150
 6 female Adelie            36            17.1  3700
 7 female Gentoo            48.2          14.3  4600
 8 female Gentoo            43.2          14.5  4450
 9 female Gentoo            47.5          14    4875
10 female Gentoo            47.2          13.7  4925
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
cols <- colnames(dt)
new_order <- c("sex", setdiff(cols, "sex"))
dt[, ..new_order]
```

::: {.cell-output .cell-output-stdout}

```
       sex species bill_length_mm bill_depth_mm  mass
    <fctr>  <fctr>          <num>         <num> <int>
 1:   male  Adelie           39.1          18.7  3750
 2: female  Adelie           39.5          16.7  3250
 3: female  Adelie           35.7          16.9  3150
 4: female  Adelie           35.7          18.0  3550
 5: female  Adelie           36.2          17.2  3150
 6: female  Adelie           36.0          17.1  3700
 7: female  Gentoo           48.2          14.3  4600
 8: female  Gentoo           43.2          14.5  4450
 9: female  Gentoo           47.5          14.0  4875
10: female  Gentoo           47.2          13.7  4925
```


:::
:::



:::

## Rename columns


### Rename one column

::: {.columns}

::: {.column}



::: {.cell isolate='true'}

```{.r .cell-code}
colnames(df)[3] <- "length"
df
```

::: {.cell-output .cell-output-stdout}

```
   species    sex length bill_depth_mm mass
1   Adelie   male   39.1          18.7 3750
2   Adelie female   39.5          16.7 3250
3   Adelie female   35.7          16.9 3150
4   Adelie female   35.7          18.0 3550
5   Adelie female   36.2          17.2 3150
6   Adelie female   36.0          17.1 3700
7   Gentoo female   48.2          14.3 4600
8   Gentoo female   43.2          14.5 4450
9   Gentoo female   47.5          14.0 4875
10  Gentoo female   47.2          13.7 4925
```


:::

```{.r .cell-code}
names(df)[3] <- "bill_length"
df
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length bill_depth_mm mass
1   Adelie   male        39.1          18.7 3750
2   Adelie female        39.5          16.7 3250
3   Adelie female        35.7          16.9 3150
4   Adelie female        35.7          18.0 3550
5   Adelie female        36.2          17.2 3150
6   Adelie female        36.0          17.1 3700
7   Gentoo female        48.2          14.3 4600
8   Gentoo female        43.2          14.5 4450
9   Gentoo female        47.5          14.0 4875
10  Gentoo female        47.2          13.7 4925
```


:::
:::



:::

::: {.column}



::: {.cell}

```{.r .cell-code}
rename(tbl, 
       length = bill_length_mm)
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 5
   species sex    length bill_depth_mm  mass
   <fct>   <fct>   <dbl>         <dbl> <int>
 1 Adelie  male     39.1          18.7  3750
 2 Adelie  female   39.5          16.7  3250
 3 Adelie  female   35.7          16.9  3150
 4 Adelie  female   35.7          18    3550
 5 Adelie  female   36.2          17.2  3150
 6 Adelie  female   36            17.1  3700
 7 Gentoo  female   48.2          14.3  4600
 8 Gentoo  female   43.2          14.5  4450
 9 Gentoo  female   47.5          14    4875
10 Gentoo  female   47.2          13.7  4925
```


:::

```{.r .cell-code}
# changes order at the same time though
select(tbl, 
       length = bill_length_mm,
       everything())
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 5
   length species sex    bill_depth_mm  mass
    <dbl> <fct>   <fct>          <dbl> <int>
 1   39.1 Adelie  male            18.7  3750
 2   39.5 Adelie  female          16.7  3250
 3   35.7 Adelie  female          16.9  3150
 4   35.7 Adelie  female          18    3550
 5   36.2 Adelie  female          17.2  3150
 6   36   Adelie  female          17.1  3700
 7   48.2 Gentoo  female          14.3  4600
 8   43.2 Gentoo  female          14.5  4450
 9   47.5 Gentoo  female          14    4875
10   47.2 Gentoo  female          13.7  4925
```


:::
:::

::: {.cell}

```{.r .cell-code}
nm_dict <- c("length" = "bill_length_mm")
rename(tbl, any_of(nm_dict))
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 5
   species sex    length bill_depth_mm  mass
   <fct>   <fct>   <dbl>         <dbl> <int>
 1 Adelie  male     39.1          18.7  3750
 2 Adelie  female   39.5          16.7  3250
 3 Adelie  female   35.7          16.9  3150
 4 Adelie  female   35.7          18    3550
 5 Adelie  female   36.2          17.2  3150
 6 Adelie  female   36            17.1  3700
 7 Gentoo  female   48.2          14.3  4600
 8 Gentoo  female   43.2          14.5  4450
 9 Gentoo  female   47.5          14    4875
10 Gentoo  female   47.2          13.7  4925
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell isolate='true'}

```{.r .cell-code}
setnames(dt, "bill_length_mm", "length")
dt
```

::: {.cell-output .cell-output-stdout}

```
    species    sex length bill_depth_mm  mass
     <fctr> <fctr>  <num>         <num> <int>
 1:  Adelie   male   39.1          18.7  3750
 2:  Adelie female   39.5          16.7  3250
 3:  Adelie female   35.7          16.9  3150
 4:  Adelie female   35.7          18.0  3550
 5:  Adelie female   36.2          17.2  3150
 6:  Adelie female   36.0          17.1  3700
 7:  Gentoo female   48.2          14.3  4600
 8:  Gentoo female   43.2          14.5  4450
 9:  Gentoo female   47.5          14.0  4875
10:  Gentoo female   47.2          13.7  4925
```


:::
:::



:::

### Rename multiple columns


::: {.columns}

::: {.column}



::: {.cell}

```{.r .cell-code}
cols <- colnames(df)
```
:::

::: {.cell isolate='true'}

```{.r .cell-code}
colnames(df) <- sub("_mm", "", cols)
df
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length bill_depth mass
1   Adelie   male        39.1       18.7 3750
2   Adelie female        39.5       16.7 3250
3   Adelie female        35.7       16.9 3150
4   Adelie female        35.7       18.0 3550
5   Adelie female        36.2       17.2 3150
6   Adelie female        36.0       17.1 3700
7   Gentoo female        48.2       14.3 4600
8   Gentoo female        43.2       14.5 4450
9   Gentoo female        47.5       14.0 4875
10  Gentoo female        47.2       13.7 4925
```


:::
:::

::: {.cell isolate='true'}

```{.r .cell-code}
names(df)[3:4] <- sub("_mm", "", cols[3:4])
df
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length bill_depth mass
1   Adelie   male        39.1       18.7 3750
2   Adelie female        39.5       16.7 3250
3   Adelie female        35.7       16.9 3150
4   Adelie female        35.7       18.0 3550
5   Adelie female        36.2       17.2 3150
6   Adelie female        36.0       17.1 3700
7   Gentoo female        48.2       14.3 4600
8   Gentoo female        43.2       14.5 4450
9   Gentoo female        47.5       14.0 4875
10  Gentoo female        47.2       13.7 4925
```


:::
:::



:::

::: {.column}



::: {.cell}

```{.r .cell-code}
rename_with(tbl, 
            ~str_remove(., "_mm"))
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 5
   species sex    bill_length bill_depth  mass
   <fct>   <fct>        <dbl>      <dbl> <int>
 1 Adelie  male          39.1       18.7  3750
 2 Adelie  female        39.5       16.7  3250
 3 Adelie  female        35.7       16.9  3150
 4 Adelie  female        35.7       18    3550
 5 Adelie  female        36.2       17.2  3150
 6 Adelie  female        36         17.1  3700
 7 Gentoo  female        48.2       14.3  4600
 8 Gentoo  female        43.2       14.5  4450
 9 Gentoo  female        47.5       14    4875
10 Gentoo  female        47.2       13.7  4925
```


:::

```{.r .cell-code}
rename_with(tbl, 
            ~str_remove(., "_mm"), 3:4)
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 5
   species sex    bill_length bill_depth  mass
   <fct>   <fct>        <dbl>      <dbl> <int>
 1 Adelie  male          39.1       18.7  3750
 2 Adelie  female        39.5       16.7  3250
 3 Adelie  female        35.7       16.9  3150
 4 Adelie  female        35.7       18    3550
 5 Adelie  female        36.2       17.2  3150
 6 Adelie  female        36         17.1  3700
 7 Gentoo  female        48.2       14.3  4600
 8 Gentoo  female        43.2       14.5  4450
 9 Gentoo  female        47.5       14    4875
10 Gentoo  female        47.2       13.7  4925
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell isolate='true'}

```{.r .cell-code}
cols <- colnames(dt)
```
:::

::: {.cell isolate='true'}

```{.r .cell-code}
setnames(dt, cols, sub("_mm", "", cols))
dt
```

::: {.cell-output .cell-output-stdout}

```
    species    sex bill_length bill_depth  mass
     <fctr> <fctr>       <num>      <num> <int>
 1:  Adelie   male        39.1       18.7  3750
 2:  Adelie female        39.5       16.7  3250
 3:  Adelie female        35.7       16.9  3150
 4:  Adelie female        35.7       18.0  3550
 5:  Adelie female        36.2       17.2  3150
 6:  Adelie female        36.0       17.1  3700
 7:  Gentoo female        48.2       14.3  4600
 8:  Gentoo female        43.2       14.5  4450
 9:  Gentoo female        47.5       14.0  4875
10:  Gentoo female        47.2       13.7  4925
```


:::
:::

::: {.cell isolate='true'}

```{.r .cell-code}
setnames(dt, cols[3:4], sub("_mm", "", cols[3:4]))
dt
```

::: {.cell-output .cell-output-stdout}

```
    species    sex bill_length bill_depth  mass
     <fctr> <fctr>       <num>      <num> <int>
 1:  Adelie   male        39.1       18.7  3750
 2:  Adelie female        39.5       16.7  3250
 3:  Adelie female        35.7       16.9  3150
 4:  Adelie female        35.7       18.0  3550
 5:  Adelie female        36.2       17.2  3150
 6:  Adelie female        36.0       17.1  3700
 7:  Gentoo female        48.2       14.3  4600
 8:  Gentoo female        43.2       14.5  4450
 9:  Gentoo female        47.5       14.0  4875
10:  Gentoo female        47.2       13.7  4925
```


:::
:::



:::


## Subset rows

### By position

::: {.columns}

::: {.column}



::: {.cell}

```{.r .cell-code}
df[1:2, ]
```

::: {.cell-output .cell-output-stdout}

```
  species    sex bill_length_mm bill_depth_mm mass
1  Adelie   male           39.1          18.7 3750
2  Adelie female           39.5          16.7 3250
```


:::

```{.r .cell-code}
df[-c(1:2), ]
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length_mm bill_depth_mm mass
3   Adelie female           35.7          16.9 3150
4   Adelie female           35.7          18.0 3550
5   Adelie female           36.2          17.2 3150
6   Adelie female           36.0          17.1 3700
7   Gentoo female           48.2          14.3 4600
8   Gentoo female           43.2          14.5 4450
9   Gentoo female           47.5          14.0 4875
10  Gentoo female           47.2          13.7 4925
```


:::
:::



:::

::: {.column}



::: {.cell}

```{.r .cell-code}
slice(tbl, 1:2)
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 2 × 5
  species sex    bill_length_mm bill_depth_mm  mass
  <fct>   <fct>           <dbl>         <dbl> <int>
1 Adelie  male             39.1          18.7  3750
2 Adelie  female           39.5          16.7  3250
```


:::

```{.r .cell-code}
slice(tbl, -c(1:2))
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 8 × 5
  species sex    bill_length_mm bill_depth_mm  mass
  <fct>   <fct>           <dbl>         <dbl> <int>
1 Adelie  female           35.7          16.9  3150
2 Adelie  female           35.7          18    3550
3 Adelie  female           36.2          17.2  3150
4 Adelie  female           36            17.1  3700
5 Gentoo  female           48.2          14.3  4600
6 Gentoo  female           43.2          14.5  4450
7 Gentoo  female           47.5          14    4875
8 Gentoo  female           47.2          13.7  4925
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
dt[1:2, ]
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length_mm bill_depth_mm  mass
    <fctr> <fctr>          <num>         <num> <int>
1:  Adelie   male           39.1          18.7  3750
2:  Adelie female           39.5          16.7  3250
```


:::
:::



:::

### By booleans 

::: {.columns}

::: {.column}



::: {.cell}

```{.r .cell-code}
df[!is.na(df$sex), ]
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length_mm bill_depth_mm mass
1   Adelie   male           39.1          18.7 3750
2   Adelie female           39.5          16.7 3250
3   Adelie female           35.7          16.9 3150
4   Adelie female           35.7          18.0 3550
5   Adelie female           36.2          17.2 3150
6   Adelie female           36.0          17.1 3700
7   Gentoo female           48.2          14.3 4600
8   Gentoo female           43.2          14.5 4450
9   Gentoo female           47.5          14.0 4875
10  Gentoo female           47.2          13.7 4925
```


:::

```{.r .cell-code}
subset(df, !is.na(sex))
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length_mm bill_depth_mm mass
1   Adelie   male           39.1          18.7 3750
2   Adelie female           39.5          16.7 3250
3   Adelie female           35.7          16.9 3150
4   Adelie female           35.7          18.0 3550
5   Adelie female           36.2          17.2 3150
6   Adelie female           36.0          17.1 3700
7   Gentoo female           48.2          14.3 4600
8   Gentoo female           43.2          14.5 4450
9   Gentoo female           47.5          14.0 4875
10  Gentoo female           47.2          13.7 4925
```


:::
:::



:::

::: {.column}



::: {.cell}

```{.r .cell-code}
filter(tbl, !is.na(sex))
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 5
   species sex    bill_length_mm bill_depth_mm  mass
   <fct>   <fct>           <dbl>         <dbl> <int>
 1 Adelie  male             39.1          18.7  3750
 2 Adelie  female           39.5          16.7  3250
 3 Adelie  female           35.7          16.9  3150
 4 Adelie  female           35.7          18    3550
 5 Adelie  female           36.2          17.2  3150
 6 Adelie  female           36            17.1  3700
 7 Gentoo  female           48.2          14.3  4600
 8 Gentoo  female           43.2          14.5  4450
 9 Gentoo  female           47.5          14    4875
10 Gentoo  female           47.2          13.7  4925
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
dt[!is.na(sex), ]
```

::: {.cell-output .cell-output-stdout}

```
    species    sex bill_length_mm bill_depth_mm  mass
     <fctr> <fctr>          <num>         <num> <int>
 1:  Adelie   male           39.1          18.7  3750
 2:  Adelie female           39.5          16.7  3250
 3:  Adelie female           35.7          16.9  3150
 4:  Adelie female           35.7          18.0  3550
 5:  Adelie female           36.2          17.2  3150
 6:  Adelie female           36.0          17.1  3700
 7:  Gentoo female           48.2          14.3  4600
 8:  Gentoo female           43.2          14.5  4450
 9:  Gentoo female           47.5          14.0  4875
10:  Gentoo female           47.2          13.7  4925
```


:::
:::



:::

## Arrange rows 

::: {.columns}

::: {.column}



::: {.cell}

```{.r .cell-code}
df[order(df$sex, df$bill_length_mm), ]
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length_mm bill_depth_mm mass
3   Adelie female           35.7          16.9 3150
4   Adelie female           35.7          18.0 3550
6   Adelie female           36.0          17.1 3700
5   Adelie female           36.2          17.2 3150
2   Adelie female           39.5          16.7 3250
8   Gentoo female           43.2          14.5 4450
10  Gentoo female           47.2          13.7 4925
9   Gentoo female           47.5          14.0 4875
7   Gentoo female           48.2          14.3 4600
1   Adelie   male           39.1          18.7 3750
```


:::
:::

::: {.cell}

```{.r .cell-code}
df[order(df$sex, 
         df$bill_length_mm,
         decreasing = TRUE), ]
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length_mm bill_depth_mm mass
1   Adelie   male           39.1          18.7 3750
7   Gentoo female           48.2          14.3 4600
9   Gentoo female           47.5          14.0 4875
10  Gentoo female           47.2          13.7 4925
8   Gentoo female           43.2          14.5 4450
2   Adelie female           39.5          16.7 3250
5   Adelie female           36.2          17.2 3150
6   Adelie female           36.0          17.1 3700
3   Adelie female           35.7          16.9 3150
4   Adelie female           35.7          18.0 3550
```


:::
:::




:::

::: {.column}



::: {.cell}

```{.r .cell-code}
arrange(tbl, sex, bill_length_mm)
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 5
   species sex    bill_length_mm bill_depth_mm  mass
   <fct>   <fct>           <dbl>         <dbl> <int>
 1 Adelie  female           35.7          16.9  3150
 2 Adelie  female           35.7          18    3550
 3 Adelie  female           36            17.1  3700
 4 Adelie  female           36.2          17.2  3150
 5 Adelie  female           39.5          16.7  3250
 6 Gentoo  female           43.2          14.5  4450
 7 Gentoo  female           47.2          13.7  4925
 8 Gentoo  female           47.5          14    4875
 9 Gentoo  female           48.2          14.3  4600
10 Adelie  male             39.1          18.7  3750
```


:::

```{.r .cell-code}
arrange(tbl, desc(sex), desc(bill_length_mm))
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 5
   species sex    bill_length_mm bill_depth_mm  mass
   <fct>   <fct>           <dbl>         <dbl> <int>
 1 Adelie  male             39.1          18.7  3750
 2 Gentoo  female           48.2          14.3  4600
 3 Gentoo  female           47.5          14    4875
 4 Gentoo  female           47.2          13.7  4925
 5 Gentoo  female           43.2          14.5  4450
 6 Adelie  female           39.5          16.7  3250
 7 Adelie  female           36.2          17.2  3150
 8 Adelie  female           36            17.1  3700
 9 Adelie  female           35.7          16.9  3150
10 Adelie  female           35.7          18    3550
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
dt[order(sex, bill_length_mm), ]
```

::: {.cell-output .cell-output-stdout}

```
    species    sex bill_length_mm bill_depth_mm  mass
     <fctr> <fctr>          <num>         <num> <int>
 1:  Adelie female           35.7          16.9  3150
 2:  Adelie female           35.7          18.0  3550
 3:  Adelie female           36.0          17.1  3700
 4:  Adelie female           36.2          17.2  3150
 5:  Adelie female           39.5          16.7  3250
 6:  Gentoo female           43.2          14.5  4450
 7:  Gentoo female           47.2          13.7  4925
 8:  Gentoo female           47.5          14.0  4875
 9:  Gentoo female           48.2          14.3  4600
10:  Adelie   male           39.1          18.7  3750
```


:::

```{.r .cell-code}
dt[order(sex, bill_length_mm, decreasing = TRUE), ]
```

::: {.cell-output .cell-output-stdout}

```
    species    sex bill_length_mm bill_depth_mm  mass
     <fctr> <fctr>          <num>         <num> <int>
 1:  Adelie   male           39.1          18.7  3750
 2:  Gentoo female           48.2          14.3  4600
 3:  Gentoo female           47.5          14.0  4875
 4:  Gentoo female           47.2          13.7  4925
 5:  Gentoo female           43.2          14.5  4450
 6:  Adelie female           39.5          16.7  3250
 7:  Adelie female           36.2          17.2  3150
 8:  Adelie female           36.0          17.1  3700
 9:  Adelie female           35.7          16.9  3150
10:  Adelie female           35.7          18.0  3550
```


:::
:::



:::

::: {.columns}

::: {.column}




::: {.cell}

```{.r .cell-code}
df[order(factor(df$sex, 
                levels = rev(levels(df$sex))), 
         df$bill_length_mm), ]
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length_mm bill_depth_mm mass
1   Adelie   male           39.1          18.7 3750
3   Adelie female           35.7          16.9 3150
4   Adelie female           35.7          18.0 3550
6   Adelie female           36.0          17.1 3700
5   Adelie female           36.2          17.2 3150
2   Adelie female           39.5          16.7 3250
8   Gentoo female           43.2          14.5 4450
10  Gentoo female           47.2          13.7 4925
9   Gentoo female           47.5          14.0 4875
7   Gentoo female           48.2          14.3 4600
```


:::
:::




:::

::: {.column}



::: {.cell}

```{.r .cell-code}
arrange(tbl, desc(sex), bill_length_mm)
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 5
   species sex    bill_length_mm bill_depth_mm  mass
   <fct>   <fct>           <dbl>         <dbl> <int>
 1 Adelie  male             39.1          18.7  3750
 2 Adelie  female           35.7          16.9  3150
 3 Adelie  female           35.7          18    3550
 4 Adelie  female           36            17.1  3700
 5 Adelie  female           36.2          17.2  3150
 6 Adelie  female           39.5          16.7  3250
 7 Gentoo  female           43.2          14.5  4450
 8 Gentoo  female           47.2          13.7  4925
 9 Gentoo  female           47.5          14    4875
10 Gentoo  female           48.2          14.3  4600
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
dt[order(factor(sex, 
                levels = rev(levels(sex))), 
         bill_length_mm), ]
```

::: {.cell-output .cell-output-stdout}

```
    species    sex bill_length_mm bill_depth_mm  mass
     <fctr> <fctr>          <num>         <num> <int>
 1:  Adelie   male           39.1          18.7  3750
 2:  Adelie female           35.7          16.9  3150
 3:  Adelie female           35.7          18.0  3550
 4:  Adelie female           36.0          17.1  3700
 5:  Adelie female           36.2          17.2  3150
 6:  Adelie female           39.5          16.7  3250
 7:  Gentoo female           43.2          14.5  4450
 8:  Gentoo female           47.2          13.7  4925
 9:  Gentoo female           47.5          14.0  4875
10:  Gentoo female           48.2          14.3  4600
```


:::
:::



:::

## Insert or update column 

::: {.columns}

::: {.column}




::: {.cell isolate='true'}

```{.r .cell-code}
transform(df, mpbl = mass / bill_length_mm)
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length_mm bill_depth_mm mass      mpbl
1   Adelie   male           39.1          18.7 3750  95.90793
2   Adelie female           39.5          16.7 3250  82.27848
3   Adelie female           35.7          16.9 3150  88.23529
4   Adelie female           35.7          18.0 3550  99.43978
5   Adelie female           36.2          17.2 3150  87.01657
6   Adelie female           36.0          17.1 3700 102.77778
7   Gentoo female           48.2          14.3 4600  95.43568
8   Gentoo female           43.2          14.5 4450 103.00926
9   Gentoo female           47.5          14.0 4875 102.63158
10  Gentoo female           47.2          13.7 4925 104.34322
```


:::

```{.r .cell-code}
df$mpbl <- df$mass / df$bill_length_mm
df
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length_mm bill_depth_mm mass      mpbl
1   Adelie   male           39.1          18.7 3750  95.90793
2   Adelie female           39.5          16.7 3250  82.27848
3   Adelie female           35.7          16.9 3150  88.23529
4   Adelie female           35.7          18.0 3550  99.43978
5   Adelie female           36.2          17.2 3150  87.01657
6   Adelie female           36.0          17.1 3700 102.77778
7   Gentoo female           48.2          14.3 4600  95.43568
8   Gentoo female           43.2          14.5 4450 103.00926
9   Gentoo female           47.5          14.0 4875 102.63158
10  Gentoo female           47.2          13.7 4925 104.34322
```


:::

```{.r .cell-code}
df[["mpbl"]] <- df$mass / df$bill_length_mm
df
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length_mm bill_depth_mm mass      mpbl
1   Adelie   male           39.1          18.7 3750  95.90793
2   Adelie female           39.5          16.7 3250  82.27848
3   Adelie female           35.7          16.9 3150  88.23529
4   Adelie female           35.7          18.0 3550  99.43978
5   Adelie female           36.2          17.2 3150  87.01657
6   Adelie female           36.0          17.1 3700 102.77778
7   Gentoo female           48.2          14.3 4600  95.43568
8   Gentoo female           43.2          14.5 4450 103.00926
9   Gentoo female           47.5          14.0 4875 102.63158
10  Gentoo female           47.2          13.7 4925 104.34322
```


:::
:::




:::

::: {.column}



::: {.cell}

```{.r .cell-code}
mutate(tbl, mpbl = mass / bill_length_mm)
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 6
   species sex    bill_length_mm bill_depth_mm  mass  mpbl
   <fct>   <fct>           <dbl>         <dbl> <int> <dbl>
 1 Adelie  male             39.1          18.7  3750  95.9
 2 Adelie  female           39.5          16.7  3250  82.3
 3 Adelie  female           35.7          16.9  3150  88.2
 4 Adelie  female           35.7          18    3550  99.4
 5 Adelie  female           36.2          17.2  3150  87.0
 6 Adelie  female           36            17.1  3700 103. 
 7 Gentoo  female           48.2          14.3  4600  95.4
 8 Gentoo  female           43.2          14.5  4450 103. 
 9 Gentoo  female           47.5          14    4875 103. 
10 Gentoo  female           47.2          13.7  4925 104. 
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
dt[, mpbl := mass / bill_length_mm]
dt
```

::: {.cell-output .cell-output-stdout}

```
    species    sex bill_length_mm bill_depth_mm  mass      mpbl
     <fctr> <fctr>          <num>         <num> <int>     <num>
 1:  Adelie   male           39.1          18.7  3750  95.90793
 2:  Adelie female           39.5          16.7  3250  82.27848
 3:  Adelie female           35.7          16.9  3150  88.23529
 4:  Adelie female           35.7          18.0  3550  99.43978
 5:  Adelie female           36.2          17.2  3150  87.01657
 6:  Adelie female           36.0          17.1  3700 102.77778
 7:  Gentoo female           48.2          14.3  4600  95.43568
 8:  Gentoo female           43.2          14.5  4450 103.00926
 9:  Gentoo female           47.5          14.0  4875 102.63158
10:  Gentoo female           47.2          13.7  4925 104.34322
```


:::
:::



:::

## Group operations 

::: {.columns}

::: {.column}




::: {.cell}

```{.r .cell-code}
aggregate(df, mass ~ sex + species, 
          \(x) c(avg = mean(x), 
                 sd = sd(x), 
                 n = length(x)))
```

::: {.cell-output .cell-output-stdout}

```
     sex species mass.avg  mass.sd   mass.n
1 female  Adelie 3360.000  250.998    5.000
2   male  Adelie 3750.000       NA    1.000
3 female  Gentoo 4712.500  225.924    4.000
```


:::

```{.r .cell-code}
aggregate(df$mass, 
          by = list(df$sex, df$species), 
          \(x) c(avg = mean(x), 
                 sd = sd(x), 
                 n = length(x)))
```

::: {.cell-output .cell-output-stdout}

```
  Group.1 Group.2    x.avg     x.sd      x.n
1  female  Adelie 3360.000  250.998    5.000
2    male  Adelie 3750.000       NA    1.000
3  female  Gentoo 4712.500  225.924    4.000
```


:::
:::



Below doesn't work where there are missing combinations.



::: {.cell}

```{.r .cell-code}
with(df, 
     tapply(
       mass, 
       list(sex = sex, species = species), 
       \(x) c(avg = mean(x), 
              sd = sd(x), 
              n = length(x))
       )) |>
  array2DF() 
```

::: {.cell-output .cell-output-stdout}

```
     sex   species                    Value
1 female    Adelie 3360.000, 250.998, 5.000
2   male    Adelie              3750, NA, 1
3 female Chinstrap                     NULL
4   male Chinstrap                     NULL
5 female    Gentoo 4712.500, 225.924, 4.000
6   male    Gentoo                     NULL
```


:::
:::




:::

::: {.column}



::: {.cell}

```{.r .cell-code}
summarise(tbl, 
          avg = mean(mass), 
          sd = sd(mass), 
          n = n(),
          .by = c(sex, species))
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 3 × 5
  sex    species   avg    sd     n
  <fct>  <fct>   <dbl> <dbl> <int>
1 male   Adelie  3750    NA      1
2 female Adelie  3360   251.     5
3 female Gentoo  4712.  226.     4
```


:::

```{.r .cell-code}
summarise(group_by(tbl, sex, species), 
          avg = mean(mass), 
          sd = sd(mass),
          n = n())
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 3 × 5
# Groups:   sex [2]
  sex    species   avg    sd     n
  <fct>  <fct>   <dbl> <dbl> <int>
1 female Adelie  3360   251.     5
2 female Gentoo  4712.  226.     4
3 male   Adelie  3750    NA      1
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
dt[, 
   .(avg = mean(mass), 
     sd = sd(mass),
     n = .N), 
   by = .(sex, species)]
```

::: {.cell-output .cell-output-stdout}

```
      sex species    avg      sd     n
   <fctr>  <fctr>  <num>   <num> <int>
1:   male  Adelie 3750.0      NA     1
2: female  Adelie 3360.0 250.998     5
3: female  Gentoo 4712.5 225.924     4
```


:::
:::



:::


## Row operations


::: {.columns}

::: {.column}




::: {.cell}

```{.r .cell-code}
apply(df[, sapply(df, is.numeric)], 1, max)  
```

::: {.cell-output .cell-output-stdout}

```
 [1] 3750 3250 3150 3550 3150 3700 4600 4450 4875 4925
```


:::
:::



:::

::: {.column}



::: {.cell}

```{.r .cell-code}
tbl |> 
  rowwise() |> 
  mutate(result = max(c_across(where(is.numeric)))) |> 
  pull(result)
```

::: {.cell-output .cell-output-stdout}

```
 [1] 3750 3250 3150 3550 3150 3700 4600 4450 4875 4925
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
dt[, apply(.SD, 1, max), .SDcol = sapply(dt, is.numeric)]
```

::: {.cell-output .cell-output-stdout}

```
 [1] 3750 3250 3150 3550 3150 3700 4600 4450 4875 4925
```


:::
:::



:::

## Column operations


::: {.columns}

::: {.column}




::: {.cell}

```{.r .cell-code}
apply(df[, sapply(df, is.numeric)], 2, max)  
```

::: {.cell-output .cell-output-stdout}

```
bill_length_mm  bill_depth_mm           mass 
          48.2           18.7         4925.0 
```


:::
:::



:::

::: {.column}



::: {.cell}

```{.r .cell-code}
summarise(tbl, 
          across(where(is.numeric), max))
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 1 × 3
  bill_length_mm bill_depth_mm  mass
           <dbl>         <dbl> <int>
1           48.2          18.7  4925
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
dt[, lapply(.SD, max), .SDcol = sapply(dt, is.numeric)]
```

::: {.cell-output .cell-output-stdout}

```
   bill_length_mm bill_depth_mm  mass     mpbl
            <num>         <num> <int>    <num>
1:           48.2          18.7  4925 104.3432
```


:::
:::



:::


## Update specific cells in a column with a single value


### By position

::: {.columns}

::: {.column}




::: {.cell isolate='true'}

```{.r .cell-code}
df[1:2, "mass"] <- 0
df
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length_mm bill_depth_mm mass
1   Adelie   male           39.1          18.7    0
2   Adelie female           39.5          16.7    0
3   Adelie female           35.7          16.9 3150
4   Adelie female           35.7          18.0 3550
5   Adelie female           36.2          17.2 3150
6   Adelie female           36.0          17.1 3700
7   Gentoo female           48.2          14.3 4600
8   Gentoo female           43.2          14.5 4450
9   Gentoo female           47.5          14.0 4875
10  Gentoo female           47.2          13.7 4925
```


:::
:::

::: {.cell isolate='true'}

```{.r .cell-code}
df$mass[1:2] <- 0
df
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length_mm bill_depth_mm mass
1   Adelie   male           39.1          18.7    0
2   Adelie female           39.5          16.7    0
3   Adelie female           35.7          16.9 3150
4   Adelie female           35.7          18.0 3550
5   Adelie female           36.2          17.2 3150
6   Adelie female           36.0          17.1 3700
7   Gentoo female           48.2          14.3 4600
8   Gentoo female           43.2          14.5 4450
9   Gentoo female           47.5          14.0 4875
10  Gentoo female           47.2          13.7 4925
```


:::
:::



:::

::: {.column}



::: {.cell}

```{.r .cell-code}
mutate(tbl, 
       mass = if_else(row_number() %in% 1:2, 
                      0, 
                      mass))
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 5
   species sex    bill_length_mm bill_depth_mm  mass
   <fct>   <fct>           <dbl>         <dbl> <dbl>
 1 Adelie  male             39.1          18.7     0
 2 Adelie  female           39.5          16.7     0
 3 Adelie  female           35.7          16.9  3150
 4 Adelie  female           35.7          18    3550
 5 Adelie  female           36.2          17.2  3150
 6 Adelie  female           36            17.1  3700
 7 Gentoo  female           48.2          14.3  4600
 8 Gentoo  female           43.2          14.5  4450
 9 Gentoo  female           47.5          14    4875
10 Gentoo  female           47.2          13.7  4925
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
dt[, mass := fifelse(.I %in% 1:2, 0, mass)][]
```

::: {.cell-output .cell-output-stdout}

```
    species    sex bill_length_mm bill_depth_mm  mass
     <fctr> <fctr>          <num>         <num> <num>
 1:  Adelie   male           39.1          18.7     0
 2:  Adelie female           39.5          16.7     0
 3:  Adelie female           35.7          16.9  3150
 4:  Adelie female           35.7          18.0  3550
 5:  Adelie female           36.2          17.2  3150
 6:  Adelie female           36.0          17.1  3700
 7:  Gentoo female           48.2          14.3  4600
 8:  Gentoo female           43.2          14.5  4450
 9:  Gentoo female           47.5          14.0  4875
10:  Gentoo female           47.2          13.7  4925
```


:::
:::



:::

### By boolean

::: {.columns}

::: {.column}




::: {.cell isolate='true'}

```{.r .cell-code}
df[df$sex == "female", "mass"] <- 0
df
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length_mm bill_depth_mm mass
1   Adelie   male           39.1          18.7 3750
2   Adelie female           39.5          16.7    0
3   Adelie female           35.7          16.9    0
4   Adelie female           35.7          18.0    0
5   Adelie female           36.2          17.2    0
6   Adelie female           36.0          17.1    0
7   Gentoo female           48.2          14.3    0
8   Gentoo female           43.2          14.5    0
9   Gentoo female           47.5          14.0    0
10  Gentoo female           47.2          13.7    0
```


:::
:::

::: {.cell isolate='true'}

```{.r .cell-code}
df$mass[df$sex == "female"] <- 0
df
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length_mm bill_depth_mm mass
1   Adelie   male           39.1          18.7 3750
2   Adelie female           39.5          16.7    0
3   Adelie female           35.7          16.9    0
4   Adelie female           35.7          18.0    0
5   Adelie female           36.2          17.2    0
6   Adelie female           36.0          17.1    0
7   Gentoo female           48.2          14.3    0
8   Gentoo female           43.2          14.5    0
9   Gentoo female           47.5          14.0    0
10  Gentoo female           47.2          13.7    0
```


:::
:::





:::

::: {.column}



::: {.cell}

```{.r .cell-code}
mutate(tbl, 
       mass = ifelse(sex == "female", 
                     0, 
                     mass))
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 5
   species sex    bill_length_mm bill_depth_mm  mass
   <fct>   <fct>           <dbl>         <dbl> <dbl>
 1 Adelie  male             39.1          18.7  3750
 2 Adelie  female           39.5          16.7     0
 3 Adelie  female           35.7          16.9     0
 4 Adelie  female           35.7          18       0
 5 Adelie  female           36.2          17.2     0
 6 Adelie  female           36            17.1     0
 7 Gentoo  female           48.2          14.3     0
 8 Gentoo  female           43.2          14.5     0
 9 Gentoo  female           47.5          14       0
10 Gentoo  female           47.2          13.7     0
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
dt[sex == "female", mass := 0][]
```

::: {.cell-output .cell-output-stdout}

```
    species    sex bill_length_mm bill_depth_mm  mass
     <fctr> <fctr>          <num>         <num> <int>
 1:  Adelie   male           39.1          18.7  3750
 2:  Adelie female           39.5          16.7     0
 3:  Adelie female           35.7          16.9     0
 4:  Adelie female           35.7          18.0     0
 5:  Adelie female           36.2          17.2     0
 6:  Adelie female           36.0          17.1     0
 7:  Gentoo female           48.2          14.3     0
 8:  Gentoo female           43.2          14.5     0
 9:  Gentoo female           47.5          14.0     0
10:  Gentoo female           47.2          13.7     0
```


:::
:::



:::


## Update specific cells in a column with a vector


### By position

::: {.columns}

::: {.column}




::: {.cell isolate='true'}

```{.r .cell-code}
df[1:2, "mass"] <- c(0, 1)
df
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length_mm bill_depth_mm mass
1   Adelie   male           39.1          18.7    0
2   Adelie female           39.5          16.7    1
3   Adelie female           35.7          16.9 3150
4   Adelie female           35.7          18.0 3550
5   Adelie female           36.2          17.2 3150
6   Adelie female           36.0          17.1 3700
7   Gentoo female           48.2          14.3 4600
8   Gentoo female           43.2          14.5 4450
9   Gentoo female           47.5          14.0 4875
10  Gentoo female           47.2          13.7 4925
```


:::
:::

::: {.cell isolate='true'}

```{.r .cell-code}
df$mass[1:2] <- c(0, 1)
df
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length_mm bill_depth_mm mass
1   Adelie   male           39.1          18.7    0
2   Adelie female           39.5          16.7    1
3   Adelie female           35.7          16.9 3150
4   Adelie female           35.7          18.0 3550
5   Adelie female           36.2          17.2 3150
6   Adelie female           36.0          17.1 3700
7   Gentoo female           48.2          14.3 4600
8   Gentoo female           43.2          14.5 4450
9   Gentoo female           47.5          14.0 4875
10  Gentoo female           47.2          13.7 4925
```


:::
:::



:::

::: {.column}



::: {.cell}

```{.r .cell-code}
mutate(tbl, 
       mass = ifelse(row_number() %in% 1:2, 
                     c(0, 1), 
                     mass))
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 5
   species sex    bill_length_mm bill_depth_mm  mass
   <fct>   <fct>           <dbl>         <dbl> <dbl>
 1 Adelie  male             39.1          18.7     0
 2 Adelie  female           39.5          16.7     1
 3 Adelie  female           35.7          16.9  3150
 4 Adelie  female           35.7          18    3550
 5 Adelie  female           36.2          17.2  3150
 6 Adelie  female           36            17.1  3700
 7 Gentoo  female           48.2          14.3  4600
 8 Gentoo  female           43.2          14.5  4450
 9 Gentoo  female           47.5          14    4875
10 Gentoo  female           47.2          13.7  4925
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
dt[1:2, mass := c(0, 1)][]
```

::: {.cell-output .cell-output-stdout}

```
    species    sex bill_length_mm bill_depth_mm  mass
     <fctr> <fctr>          <num>         <num> <int>
 1:  Adelie   male           39.1          18.7     0
 2:  Adelie female           39.5          16.7     1
 3:  Adelie female           35.7          16.9  3150
 4:  Adelie female           35.7          18.0  3550
 5:  Adelie female           36.2          17.2  3150
 6:  Adelie female           36.0          17.1  3700
 7:  Gentoo female           48.2          14.3  4600
 8:  Gentoo female           43.2          14.5  4450
 9:  Gentoo female           47.5          14.0  4875
10:  Gentoo female           47.2          13.7  4925
```


:::
:::



:::

### By boolean

::: {.columns}

::: {.column}




::: {.cell isolate='true'}

```{.r .cell-code}
within(df, 
       mass[sex == "female"] <- mass[sex == "female"] / 2)
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length_mm bill_depth_mm   mass
1   Adelie   male           39.1          18.7 3750.0
2   Adelie female           39.5          16.7 1625.0
3   Adelie female           35.7          16.9 1575.0
4   Adelie female           35.7          18.0 1775.0
5   Adelie female           36.2          17.2 1575.0
6   Adelie female           36.0          17.1 1850.0
7   Gentoo female           48.2          14.3 2300.0
8   Gentoo female           43.2          14.5 2225.0
9   Gentoo female           47.5          14.0 2437.5
10  Gentoo female           47.2          13.7 2462.5
```


:::
:::





:::

::: {.column}



::: {.cell}

```{.r .cell-code}
mutate(tbl, 
       mass = if_else(sex == "female",
                      mass / 2, 
                      mass))
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 5
   species sex    bill_length_mm bill_depth_mm  mass
   <fct>   <fct>           <dbl>         <dbl> <dbl>
 1 Adelie  male             39.1          18.7 3750 
 2 Adelie  female           39.5          16.7 1625 
 3 Adelie  female           35.7          16.9 1575 
 4 Adelie  female           35.7          18   1775 
 5 Adelie  female           36.2          17.2 1575 
 6 Adelie  female           36            17.1 1850 
 7 Gentoo  female           48.2          14.3 2300 
 8 Gentoo  female           43.2          14.5 2225 
 9 Gentoo  female           47.5          14   2438.
10 Gentoo  female           47.2          13.7 2462.
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
dt[sex == "female", mass := mass / 2][]
```

::: {.cell-output .cell-output-stderr}

```
Warning in `[.data.table`(dt, sex == "female", `:=`(mass, mass/2)): 2437.500000
(type 'double') at RHS position 8 out-of-range(NA) or truncated (precision
lost) when assigning to type 'integer' (column 5 named 'mass')
```


:::

::: {.cell-output .cell-output-stdout}

```
    species    sex bill_length_mm bill_depth_mm  mass
     <fctr> <fctr>          <num>         <num> <int>
 1:  Adelie   male           39.1          18.7  3750
 2:  Adelie female           39.5          16.7  1625
 3:  Adelie female           35.7          16.9  1575
 4:  Adelie female           35.7          18.0  1775
 5:  Adelie female           36.2          17.2  1575
 6:  Adelie female           36.0          17.1  1850
 7:  Gentoo female           48.2          14.3  2300
 8:  Gentoo female           43.2          14.5  2225
 9:  Gentoo female           47.5          14.0  2437
10:  Gentoo female           47.2          13.7  2462
```


:::
:::



:::


## Update specific cells in a column with multiple cases


::: {.columns}

::: {.column}




::: {.cell isolate='true'}

```{.r .cell-code}
df$size <- ifelse(df$sex == "female" & df$mass > 4000,
                  "large",
                  ifelse(df$sex == "male" & df$mass > 4100, 
                         "large", 
                         "small"))
df                
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length_mm bill_depth_mm mass  size
1   Adelie   male           39.1          18.7 3750 small
2   Adelie female           39.5          16.7 3250 small
3   Adelie female           35.7          16.9 3150 small
4   Adelie female           35.7          18.0 3550 small
5   Adelie female           36.2          17.2 3150 small
6   Adelie female           36.0          17.1 3700 small
7   Gentoo female           48.2          14.3 4600 large
8   Gentoo female           43.2          14.5 4450 large
9   Gentoo female           47.5          14.0 4875 large
10  Gentoo female           47.2          13.7 4925 large
```


:::
:::





:::

::: {.column}



::: {.cell}

```{.r .cell-code}
mutate(tbl, 
       size = case_when(sex == "female" & mass > 4000 ~ "large",
                        sex == "male" & mass > 4100 ~ "large",
                        .default = "small"))
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 10 × 6
   species sex    bill_length_mm bill_depth_mm  mass size 
   <fct>   <fct>           <dbl>         <dbl> <int> <chr>
 1 Adelie  male             39.1          18.7  3750 small
 2 Adelie  female           39.5          16.7  3250 small
 3 Adelie  female           35.7          16.9  3150 small
 4 Adelie  female           35.7          18    3550 small
 5 Adelie  female           36.2          17.2  3150 small
 6 Adelie  female           36            17.1  3700 small
 7 Gentoo  female           48.2          14.3  4600 large
 8 Gentoo  female           43.2          14.5  4450 large
 9 Gentoo  female           47.5          14    4875 large
10 Gentoo  female           47.2          13.7  4925 large
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
dt[, size := "small"]
dt[sex == "female" & mass > 4000, size := "large"]
dt[sex == "male" & mass > 4100, size := "large"][]
```

::: {.cell-output .cell-output-stdout}

```
    species    sex bill_length_mm bill_depth_mm  mass   size
     <fctr> <fctr>          <num>         <num> <int> <char>
 1:  Adelie   male           39.1          18.7  3750  small
 2:  Adelie female           39.5          16.7  3250  small
 3:  Adelie female           35.7          16.9  3150  small
 4:  Adelie female           35.7          18.0  3550  small
 5:  Adelie female           36.2          17.2  3150  small
 6:  Adelie female           36.0          17.1  3700  small
 7:  Gentoo female           48.2          14.3  4600  large
 8:  Gentoo female           43.2          14.5  4450  large
 9:  Gentoo female           47.5          14.0  4875  large
10:  Gentoo female           47.2          13.7  4925  large
```


:::
:::



:::



## Merge or join two tabular data



::: {.cell}

```{.r .cell-code}
df2 <- data.frame(sex = c("female", "male",  "female", "male"),
                  species = c("Adelie", "Adelie", "Chinstrap", "Chinstrap"),
                  name = c("A", "B", "C", "D"))
tbl2 <- as_tibble(df2)
```
:::



::: {.column-margin}



::: {.cell}

```{.r .cell-code}
dt2 <- as.data.table(df2)
```
:::




:::

### Left join 

::: {.columns}

::: {.column}




::: {.cell isolate='true'}

```{.r .cell-code}
merge(df, df2, by = c("species", "sex"),
      all.x = TRUE)        
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length_mm bill_depth_mm mass name
1   Adelie female           39.5          16.7 3250    A
2   Adelie female           35.7          16.9 3150    A
3   Adelie female           35.7          18.0 3550    A
4   Adelie female           36.2          17.2 3150    A
5   Adelie female           36.0          17.1 3700    A
6   Adelie   male           39.1          18.7 3750    B
7   Gentoo female           47.5          14.0 4875 <NA>
8   Gentoo female           47.2          13.7 4925 <NA>
9   Gentoo female           48.2          14.3 4600 <NA>
10  Gentoo female           43.2          14.5 4450 <NA>
```


:::
:::



:::

::: {.column}



::: {.cell}

```{.r .cell-code}
left_join(df, df2, join_by(species, sex))  
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length_mm bill_depth_mm mass name
1   Adelie   male           39.1          18.7 3750    B
2   Adelie female           39.5          16.7 3250    A
3   Adelie female           35.7          16.9 3150    A
4   Adelie female           35.7          18.0 3550    A
5   Adelie female           36.2          17.2 3150    A
6   Adelie female           36.0          17.1 3700    A
7   Gentoo female           48.2          14.3 4600 <NA>
8   Gentoo female           43.2          14.5 4450 <NA>
9   Gentoo female           47.5          14.0 4875 <NA>
10  Gentoo female           47.2          13.7 4925 <NA>
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
merge(dt, dt2, by = c("species", "sex"),
      all.x = TRUE) 
```

::: {.cell-output .cell-output-stdout}

```
Key: <species, sex>
    species    sex bill_length_mm bill_depth_mm  mass   name
     <char> <char>          <num>         <num> <int> <char>
 1:  Adelie female           39.5          16.7  3250      A
 2:  Adelie female           35.7          16.9  3150      A
 3:  Adelie female           35.7          18.0  3550      A
 4:  Adelie female           36.2          17.2  3150      A
 5:  Adelie female           36.0          17.1  3700      A
 6:  Adelie   male           39.1          18.7  3750      B
 7:  Gentoo female           48.2          14.3  4600   <NA>
 8:  Gentoo female           43.2          14.5  4450   <NA>
 9:  Gentoo female           47.5          14.0  4875   <NA>
10:  Gentoo female           47.2          13.7  4925   <NA>
```


:::
:::



:::

### Right join 

::: {.columns}

::: {.column}




::: {.cell isolate='true'}

```{.r .cell-code}
merge(df, df2, by = c("species", "sex"),
      all.y = TRUE)              
```

::: {.cell-output .cell-output-stdout}

```
    species    sex bill_length_mm bill_depth_mm mass name
1    Adelie female           39.5          16.7 3250    A
2    Adelie female           35.7          16.9 3150    A
3    Adelie female           35.7          18.0 3550    A
4    Adelie female           36.2          17.2 3150    A
5    Adelie female           36.0          17.1 3700    A
6    Adelie   male           39.1          18.7 3750    B
7 Chinstrap female             NA            NA   NA    C
8 Chinstrap   male             NA            NA   NA    D
```


:::
:::



:::

::: {.column}



::: {.cell}

```{.r .cell-code}
right_join(df, df2, join_by(species, sex)) 
```

::: {.cell-output .cell-output-stdout}

```
    species    sex bill_length_mm bill_depth_mm mass name
1    Adelie   male           39.1          18.7 3750    B
2    Adelie female           39.5          16.7 3250    A
3    Adelie female           35.7          16.9 3150    A
4    Adelie female           35.7          18.0 3550    A
5    Adelie female           36.2          17.2 3150    A
6    Adelie female           36.0          17.1 3700    A
7 Chinstrap female             NA            NA   NA    C
8 Chinstrap   male             NA            NA   NA    D
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
merge(dt, dt2, by = c("species", "sex"),
      all.y = TRUE)
```

::: {.cell-output .cell-output-stdout}

```
Key: <species, sex>
     species    sex bill_length_mm bill_depth_mm  mass   name
      <char> <char>          <num>         <num> <int> <char>
1:    Adelie female           39.5          16.7  3250      A
2:    Adelie female           35.7          16.9  3150      A
3:    Adelie female           35.7          18.0  3550      A
4:    Adelie female           36.2          17.2  3150      A
5:    Adelie female           36.0          17.1  3700      A
6:    Adelie   male           39.1          18.7  3750      B
7: Chinstrap female             NA            NA    NA      C
8: Chinstrap   male             NA            NA    NA      D
```


:::
:::



:::


### Full join 

::: {.columns}

::: {.column}




::: {.cell isolate='true'}

```{.r .cell-code}
merge(df, df2, by = c("species", "sex"),
      all = TRUE)              
```

::: {.cell-output .cell-output-stdout}

```
     species    sex bill_length_mm bill_depth_mm mass name
1     Adelie female           39.5          16.7 3250    A
2     Adelie female           35.7          16.9 3150    A
3     Adelie female           35.7          18.0 3550    A
4     Adelie female           36.2          17.2 3150    A
5     Adelie female           36.0          17.1 3700    A
6     Adelie   male           39.1          18.7 3750    B
7  Chinstrap female             NA            NA   NA    C
8  Chinstrap   male             NA            NA   NA    D
9     Gentoo female           47.5          14.0 4875 <NA>
10    Gentoo female           47.2          13.7 4925 <NA>
11    Gentoo female           48.2          14.3 4600 <NA>
12    Gentoo female           43.2          14.5 4450 <NA>
```


:::
:::



:::

::: {.column}



::: {.cell}

```{.r .cell-code}
full_join(df, df2, join_by(species, sex)) 
```

::: {.cell-output .cell-output-stdout}

```
     species    sex bill_length_mm bill_depth_mm mass name
1     Adelie   male           39.1          18.7 3750    B
2     Adelie female           39.5          16.7 3250    A
3     Adelie female           35.7          16.9 3150    A
4     Adelie female           35.7          18.0 3550    A
5     Adelie female           36.2          17.2 3150    A
6     Adelie female           36.0          17.1 3700    A
7     Gentoo female           48.2          14.3 4600 <NA>
8     Gentoo female           43.2          14.5 4450 <NA>
9     Gentoo female           47.5          14.0 4875 <NA>
10    Gentoo female           47.2          13.7 4925 <NA>
11 Chinstrap female             NA            NA   NA    C
12 Chinstrap   male             NA            NA   NA    D
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
merge(dt, dt2, by = c("species", "sex"),
      all = TRUE)
```

::: {.cell-output .cell-output-stdout}

```
Key: <species, sex>
      species    sex bill_length_mm bill_depth_mm  mass   name
       <char> <char>          <num>         <num> <int> <char>
 1:    Adelie female           39.5          16.7  3250      A
 2:    Adelie female           35.7          16.9  3150      A
 3:    Adelie female           35.7          18.0  3550      A
 4:    Adelie female           36.2          17.2  3150      A
 5:    Adelie female           36.0          17.1  3700      A
 6:    Adelie   male           39.1          18.7  3750      B
 7: Chinstrap female             NA            NA    NA      C
 8: Chinstrap   male             NA            NA    NA      D
 9:    Gentoo female           48.2          14.3  4600   <NA>
10:    Gentoo female           43.2          14.5  4450   <NA>
11:    Gentoo female           47.5          14.0  4875   <NA>
12:    Gentoo female           47.2          13.7  4925   <NA>
```


:::
:::



:::


### Inner join 

::: {.columns}

::: {.column}




::: {.cell isolate='true'}

```{.r .cell-code}
merge(df, df2, by = c("species", "sex"))              
```

::: {.cell-output .cell-output-stdout}

```
  species    sex bill_length_mm bill_depth_mm mass name
1  Adelie female           39.5          16.7 3250    A
2  Adelie female           35.7          16.9 3150    A
3  Adelie female           35.7          18.0 3550    A
4  Adelie female           36.2          17.2 3150    A
5  Adelie female           36.0          17.1 3700    A
6  Adelie   male           39.1          18.7 3750    B
```


:::
:::



:::

::: {.column}



::: {.cell}

```{.r .cell-code}
inner_join(df, df2, join_by(species, sex)) 
```

::: {.cell-output .cell-output-stdout}

```
  species    sex bill_length_mm bill_depth_mm mass name
1  Adelie   male           39.1          18.7 3750    B
2  Adelie female           39.5          16.7 3250    A
3  Adelie female           35.7          16.9 3150    A
4  Adelie female           35.7          18.0 3550    A
5  Adelie female           36.2          17.2 3150    A
6  Adelie female           36.0          17.1 3700    A
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
merge(dt, dt2, by = c("species", "sex"))
```

::: {.cell-output .cell-output-stdout}

```
Key: <species, sex>
   species    sex bill_length_mm bill_depth_mm  mass   name
    <char> <char>          <num>         <num> <int> <char>
1:  Adelie female           39.5          16.7  3250      A
2:  Adelie female           35.7          16.9  3150      A
3:  Adelie female           35.7          18.0  3550      A
4:  Adelie female           36.2          17.2  3150      A
5:  Adelie female           36.0          17.1  3700      A
6:  Adelie   male           39.1          18.7  3750      B
```


:::
:::



:::

### Cross join 

::: {.columns}

::: {.column}




::: {.cell isolate='true'}

```{.r .cell-code}
merge(df, df2, by = NULL)              
```

::: {.cell-output .cell-output-stdout}

```
   species.x  sex.x bill_length_mm bill_depth_mm mass  sex.y species.y name
1     Adelie   male           39.1          18.7 3750 female    Adelie    A
2     Adelie female           39.5          16.7 3250 female    Adelie    A
3     Adelie female           35.7          16.9 3150 female    Adelie    A
4     Adelie female           35.7          18.0 3550 female    Adelie    A
5     Adelie female           36.2          17.2 3150 female    Adelie    A
6     Adelie female           36.0          17.1 3700 female    Adelie    A
7     Gentoo female           48.2          14.3 4600 female    Adelie    A
8     Gentoo female           43.2          14.5 4450 female    Adelie    A
9     Gentoo female           47.5          14.0 4875 female    Adelie    A
10    Gentoo female           47.2          13.7 4925 female    Adelie    A
11    Adelie   male           39.1          18.7 3750   male    Adelie    B
12    Adelie female           39.5          16.7 3250   male    Adelie    B
13    Adelie female           35.7          16.9 3150   male    Adelie    B
14    Adelie female           35.7          18.0 3550   male    Adelie    B
15    Adelie female           36.2          17.2 3150   male    Adelie    B
16    Adelie female           36.0          17.1 3700   male    Adelie    B
17    Gentoo female           48.2          14.3 4600   male    Adelie    B
18    Gentoo female           43.2          14.5 4450   male    Adelie    B
19    Gentoo female           47.5          14.0 4875   male    Adelie    B
20    Gentoo female           47.2          13.7 4925   male    Adelie    B
21    Adelie   male           39.1          18.7 3750 female Chinstrap    C
22    Adelie female           39.5          16.7 3250 female Chinstrap    C
23    Adelie female           35.7          16.9 3150 female Chinstrap    C
24    Adelie female           35.7          18.0 3550 female Chinstrap    C
25    Adelie female           36.2          17.2 3150 female Chinstrap    C
26    Adelie female           36.0          17.1 3700 female Chinstrap    C
27    Gentoo female           48.2          14.3 4600 female Chinstrap    C
28    Gentoo female           43.2          14.5 4450 female Chinstrap    C
29    Gentoo female           47.5          14.0 4875 female Chinstrap    C
30    Gentoo female           47.2          13.7 4925 female Chinstrap    C
31    Adelie   male           39.1          18.7 3750   male Chinstrap    D
32    Adelie female           39.5          16.7 3250   male Chinstrap    D
33    Adelie female           35.7          16.9 3150   male Chinstrap    D
34    Adelie female           35.7          18.0 3550   male Chinstrap    D
35    Adelie female           36.2          17.2 3150   male Chinstrap    D
36    Adelie female           36.0          17.1 3700   male Chinstrap    D
37    Gentoo female           48.2          14.3 4600   male Chinstrap    D
38    Gentoo female           43.2          14.5 4450   male Chinstrap    D
39    Gentoo female           47.5          14.0 4875   male Chinstrap    D
40    Gentoo female           47.2          13.7 4925   male Chinstrap    D
```


:::
:::



:::

::: {.column}



::: {.cell}

```{.r .cell-code}
cross_join(df, df2) 
```

::: {.cell-output .cell-output-stdout}

```
   species.x  sex.x bill_length_mm bill_depth_mm mass  sex.y species.y name
1     Adelie   male           39.1          18.7 3750 female    Adelie    A
2     Adelie   male           39.1          18.7 3750   male    Adelie    B
3     Adelie   male           39.1          18.7 3750 female Chinstrap    C
4     Adelie   male           39.1          18.7 3750   male Chinstrap    D
5     Adelie female           39.5          16.7 3250 female    Adelie    A
6     Adelie female           39.5          16.7 3250   male    Adelie    B
7     Adelie female           39.5          16.7 3250 female Chinstrap    C
8     Adelie female           39.5          16.7 3250   male Chinstrap    D
9     Adelie female           35.7          16.9 3150 female    Adelie    A
10    Adelie female           35.7          16.9 3150   male    Adelie    B
11    Adelie female           35.7          16.9 3150 female Chinstrap    C
12    Adelie female           35.7          16.9 3150   male Chinstrap    D
13    Adelie female           35.7          18.0 3550 female    Adelie    A
14    Adelie female           35.7          18.0 3550   male    Adelie    B
15    Adelie female           35.7          18.0 3550 female Chinstrap    C
16    Adelie female           35.7          18.0 3550   male Chinstrap    D
17    Adelie female           36.2          17.2 3150 female    Adelie    A
18    Adelie female           36.2          17.2 3150   male    Adelie    B
19    Adelie female           36.2          17.2 3150 female Chinstrap    C
20    Adelie female           36.2          17.2 3150   male Chinstrap    D
21    Adelie female           36.0          17.1 3700 female    Adelie    A
22    Adelie female           36.0          17.1 3700   male    Adelie    B
23    Adelie female           36.0          17.1 3700 female Chinstrap    C
24    Adelie female           36.0          17.1 3700   male Chinstrap    D
25    Gentoo female           48.2          14.3 4600 female    Adelie    A
26    Gentoo female           48.2          14.3 4600   male    Adelie    B
27    Gentoo female           48.2          14.3 4600 female Chinstrap    C
28    Gentoo female           48.2          14.3 4600   male Chinstrap    D
29    Gentoo female           43.2          14.5 4450 female    Adelie    A
30    Gentoo female           43.2          14.5 4450   male    Adelie    B
31    Gentoo female           43.2          14.5 4450 female Chinstrap    C
32    Gentoo female           43.2          14.5 4450   male Chinstrap    D
33    Gentoo female           47.5          14.0 4875 female    Adelie    A
34    Gentoo female           47.5          14.0 4875   male    Adelie    B
35    Gentoo female           47.5          14.0 4875 female Chinstrap    C
36    Gentoo female           47.5          14.0 4875   male Chinstrap    D
37    Gentoo female           47.2          13.7 4925 female    Adelie    A
38    Gentoo female           47.2          13.7 4925   male    Adelie    B
39    Gentoo female           47.2          13.7 4925 female Chinstrap    C
40    Gentoo female           47.2          13.7 4925   male Chinstrap    D
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
merge(dt, dt2, by = NULL)
```

::: {.cell-output .cell-output-stdout}

```
Key: <species, sex>
   species    sex bill_length_mm bill_depth_mm  mass   name
    <char> <char>          <num>         <num> <int> <char>
1:  Adelie female           39.5          16.7  3250      A
2:  Adelie female           35.7          16.9  3150      A
3:  Adelie female           35.7          18.0  3550      A
4:  Adelie female           36.2          17.2  3150      A
5:  Adelie female           36.0          17.1  3700      A
6:  Adelie   male           39.1          18.7  3750      B
```


:::
:::



:::


### Anti join 

::: {.columns}

::: {.column}




::: {.cell isolate='true'}

```{.r .cell-code}
df[!(df$sex %in% df2$sex & df$species %in% df2$species), ]        
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length_mm bill_depth_mm mass
7   Gentoo female           48.2          14.3 4600
8   Gentoo female           43.2          14.5 4450
9   Gentoo female           47.5          14.0 4875
10  Gentoo female           47.2          13.7 4925
```


:::
:::



:::

::: {.column}



::: {.cell}

```{.r .cell-code}
anti_join(df, df2, join_by(sex, species)) 
```

::: {.cell-output .cell-output-stdout}

```
  species    sex bill_length_mm bill_depth_mm mass
1  Gentoo female           48.2          14.3 4600
2  Gentoo female           43.2          14.5 4450
3  Gentoo female           47.5          14.0 4875
4  Gentoo female           47.2          13.7 4925
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell datatable='true'}

```{.r .cell-code}
setDT(dt)[!dt2, on = c("sex", "species")]
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length_mm bill_depth_mm  mass
    <fctr> <fctr>          <num>         <num> <int>
1:  Gentoo female           48.2          14.3  4600
2:  Gentoo female           43.2          14.5  4450
3:  Gentoo female           47.5          14.0  4875
4:  Gentoo female           47.2          13.7  4925
```


:::
:::



:::

### Bind columns

::: {.columns}

::: {.column}




::: {.cell}

```{.r .cell-code}
cbind(df[1:2], df[3:4])
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length_mm bill_depth_mm
1   Adelie   male           39.1          18.7
2   Adelie female           39.5          16.7
3   Adelie female           35.7          16.9
4   Adelie female           35.7          18.0
5   Adelie female           36.2          17.2
6   Adelie female           36.0          17.1
7   Gentoo female           48.2          14.3
8   Gentoo female           43.2          14.5
9   Gentoo female           47.5          14.0
10  Gentoo female           47.2          13.7
```


:::
:::




:::

::: {.column}



::: {.cell}

```{.r .cell-code}
bind_cols(df[1:2], df[3:4])
```

::: {.cell-output .cell-output-stdout}

```
   species    sex bill_length_mm bill_depth_mm
1   Adelie   male           39.1          18.7
2   Adelie female           39.5          16.7
3   Adelie female           35.7          16.9
4   Adelie female           35.7          18.0
5   Adelie female           36.2          17.2
6   Adelie female           36.0          17.1
7   Gentoo female           48.2          14.3
8   Gentoo female           43.2          14.5
9   Gentoo female           47.5          14.0
10  Gentoo female           47.2          13.7
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
setDT(c(dt[, 1:2], dt[, 3:4]))
```
:::



:::

### Bind rows

::: {.columns}

::: {.column}




::: {.cell}

```{.r .cell-code}
df2[setdiff(names(df), names(df2))] <- NA
df[setdiff(names(df2), names(df))] <- NA
rbind(df, df2)
```

::: {.cell-output .cell-output-stdout}

```
     species    sex bill_length_mm bill_depth_mm mass name
1     Adelie   male           39.1          18.7 3750 <NA>
2     Adelie female           39.5          16.7 3250 <NA>
3     Adelie female           35.7          16.9 3150 <NA>
4     Adelie female           35.7          18.0 3550 <NA>
5     Adelie female           36.2          17.2 3150 <NA>
6     Adelie female           36.0          17.1 3700 <NA>
7     Gentoo female           48.2          14.3 4600 <NA>
8     Gentoo female           43.2          14.5 4450 <NA>
9     Gentoo female           47.5          14.0 4875 <NA>
10    Gentoo female           47.2          13.7 4925 <NA>
11    Adelie female             NA            NA   NA    A
12    Adelie   male             NA            NA   NA    B
13 Chinstrap female             NA            NA   NA    C
14 Chinstrap   male             NA            NA   NA    D
```


:::
:::




:::

::: {.column}



::: {.cell}

```{.r .cell-code}
bind_rows(tbl, tbl2)
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 14 × 6
   species   sex    bill_length_mm bill_depth_mm  mass name 
   <chr>     <chr>           <dbl>         <dbl> <int> <chr>
 1 Adelie    male             39.1          18.7  3750 <NA> 
 2 Adelie    female           39.5          16.7  3250 <NA> 
 3 Adelie    female           35.7          16.9  3150 <NA> 
 4 Adelie    female           35.7          18    3550 <NA> 
 5 Adelie    female           36.2          17.2  3150 <NA> 
 6 Adelie    female           36            17.1  3700 <NA> 
 7 Gentoo    female           48.2          14.3  4600 <NA> 
 8 Gentoo    female           43.2          14.5  4450 <NA> 
 9 Gentoo    female           47.5          14    4875 <NA> 
10 Gentoo    female           47.2          13.7  4925 <NA> 
11 Adelie    female           NA            NA      NA A    
12 Adelie    male             NA            NA      NA B    
13 Chinstrap female           NA            NA      NA C    
14 Chinstrap male             NA            NA      NA D    
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
rbindlist(list(dt, dt2), 
          fill = TRUE)
```

::: {.cell-output .cell-output-stdout}

```
      species    sex bill_length_mm bill_depth_mm  mass   name
       <fctr> <fctr>          <num>         <num> <int> <char>
 1:    Adelie   male           39.1          18.7  3750   <NA>
 2:    Adelie female           39.5          16.7  3250   <NA>
 3:    Adelie female           35.7          16.9  3150   <NA>
 4:    Adelie female           35.7          18.0  3550   <NA>
 5:    Adelie female           36.2          17.2  3150   <NA>
 6:    Adelie female           36.0          17.1  3700   <NA>
 7:    Gentoo female           48.2          14.3  4600   <NA>
 8:    Gentoo female           43.2          14.5  4450   <NA>
 9:    Gentoo female           47.5          14.0  4875   <NA>
10:    Gentoo female           47.2          13.7  4925   <NA>
11:    Adelie female             NA            NA    NA      A
12:    Adelie   male             NA            NA    NA      B
13: Chinstrap female             NA            NA    NA      C
14: Chinstrap   male             NA            NA    NA      D
```


:::
:::



:::

## Reshape data to longer format

::: {.columns}

::: {.column}




::: {.cell}

```{.r .cell-code}
reshape(df, 
        varying = grep("^bill", colnames(df)), 
        v.names = "bill", 
        direction = "long",
        timevar = "type",
        times = c("length", "depth"))
```

::: {.cell-output .cell-output-stdout}

```
          species    sex mass name   type bill id
1.length   Adelie   male 3750   NA length 39.1  1
2.length   Adelie female 3250   NA length 39.5  2
3.length   Adelie female 3150   NA length 35.7  3
4.length   Adelie female 3550   NA length 35.7  4
5.length   Adelie female 3150   NA length 36.2  5
6.length   Adelie female 3700   NA length 36.0  6
7.length   Gentoo female 4600   NA length 48.2  7
8.length   Gentoo female 4450   NA length 43.2  8
9.length   Gentoo female 4875   NA length 47.5  9
10.length  Gentoo female 4925   NA length 47.2 10
1.depth    Adelie   male 3750   NA  depth 18.7  1
2.depth    Adelie female 3250   NA  depth 16.7  2
3.depth    Adelie female 3150   NA  depth 16.9  3
4.depth    Adelie female 3550   NA  depth 18.0  4
5.depth    Adelie female 3150   NA  depth 17.2  5
6.depth    Adelie female 3700   NA  depth 17.1  6
7.depth    Gentoo female 4600   NA  depth 14.3  7
8.depth    Gentoo female 4450   NA  depth 14.5  8
9.depth    Gentoo female 4875   NA  depth 14.0  9
10.depth   Gentoo female 4925   NA  depth 13.7 10
```


:::
:::




:::

::: {.column}



::: {.cell}

```{.r .cell-code}
pivot_longer(tbl, cols = starts_with("bill"), names_to = "type", names_pattern = "bill_(.+)_mm")
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 20 × 5
   species sex     mass type   value
   <fct>   <fct>  <int> <chr>  <dbl>
 1 Adelie  male    3750 length  39.1
 2 Adelie  male    3750 depth   18.7
 3 Adelie  female  3250 length  39.5
 4 Adelie  female  3250 depth   16.7
 5 Adelie  female  3150 length  35.7
 6 Adelie  female  3150 depth   16.9
 7 Adelie  female  3550 length  35.7
 8 Adelie  female  3550 depth   18  
 9 Adelie  female  3150 length  36.2
10 Adelie  female  3150 depth   17.2
11 Adelie  female  3700 length  36  
12 Adelie  female  3700 depth   17.1
13 Gentoo  female  4600 length  48.2
14 Gentoo  female  4600 depth   14.3
15 Gentoo  female  4450 length  43.2
16 Gentoo  female  4450 depth   14.5
17 Gentoo  female  4875 length  47.5
18 Gentoo  female  4875 depth   14  
19 Gentoo  female  4925 length  47.2
20 Gentoo  female  4925 depth   13.7
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
melt(dt, 
     measure.vars = grep("^bill", colnames(dt)), 
     variable.name = "type",
     value.name = "bill")[
       , type := sub("^bill_", "", type)][
       , type := sub("_mm$", "", type)][]
```

::: {.cell-output .cell-output-stdout}

```
    species    sex  mass   type  bill
     <fctr> <fctr> <int> <char> <num>
 1:  Adelie   male  3750 length  39.1
 2:  Adelie female  3250 length  39.5
 3:  Adelie female  3150 length  35.7
 4:  Adelie female  3550 length  35.7
 5:  Adelie female  3150 length  36.2
 6:  Adelie female  3700 length  36.0
 7:  Gentoo female  4600 length  48.2
 8:  Gentoo female  4450 length  43.2
 9:  Gentoo female  4875 length  47.5
10:  Gentoo female  4925 length  47.2
11:  Adelie   male  3750  depth  18.7
12:  Adelie female  3250  depth  16.7
13:  Adelie female  3150  depth  16.9
14:  Adelie female  3550  depth  18.0
15:  Adelie female  3150  depth  17.2
16:  Adelie female  3700  depth  17.1
17:  Gentoo female  4600  depth  14.3
18:  Gentoo female  4450  depth  14.5
19:  Gentoo female  4875  depth  14.0
20:  Gentoo female  4925  depth  13.7
    species    sex  mass   type  bill
```


:::
:::



:::


## Reshape data to wider format

::: {.columns}

::: {.column}




::: {.cell}

```{.r .cell-code}
reshape(df[1:2, ],  
        idvar = "species",
        timevar = "sex",
        direction = "wide")
```

::: {.cell-output .cell-output-stdout}

```
  species bill_length_mm.male bill_depth_mm.male mass.male name.male
1  Adelie                39.1               18.7      3750        NA
  bill_length_mm.female bill_depth_mm.female mass.female name.female
1                  39.5                 16.7        3250          NA
```


:::
:::




:::

::: {.column}



::: {.cell}

```{.r .cell-code}
pivot_wider(tbl[1:2, ],
            names_from = sex, 
            values_from = -c(sex, species))
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 1 × 7
  species bill_length_mm_male bill_length_mm_female bill_depth_mm_male
  <fct>                 <dbl>                 <dbl>              <dbl>
1 Adelie                 39.1                  39.5               18.7
# ℹ 3 more variables: bill_depth_mm_female <dbl>, mass_male <int>,
#   mass_female <int>
```


:::
:::



:::

:::

::: {.column-margin}




::: {.cell}

```{.r .cell-code}
dcast(dt[1:2, ], 
      species ~ sex, 
      value.var = setdiff(colnames(dt), c("sex", "species")))
```

::: {.cell-output .cell-output-stdout}

```
Key: <species>
   species bill_length_mm_female bill_length_mm_male bill_depth_mm_female
    <fctr>                 <num>               <num>                <num>
1:  Adelie                  39.5                39.1                 16.7
   bill_depth_mm_male mass_female mass_male
                <num>       <int>     <int>
1:               18.7        3250      3750
```


:::
:::



:::


# Strings



::: {.cell}

```{.r .cell-code}
x <- c("Banana", " citrus ", "app le ")
```
:::




## Presence/absence of a pattern 

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
grepl("a", x)
```

::: {.cell-output .cell-output-stdout}

```
[1]  TRUE FALSE  TRUE
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
str_detect(x, "a")
```

::: {.cell-output .cell-output-stdout}

```
[1]  TRUE FALSE  TRUE
```


:::
:::


:::
:::



## Duplicate string 

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
strrep(x, 2)
```

::: {.cell-output .cell-output-stdout}

```
[1] "BananaBanana"     " citrus  citrus " "app le app le "  
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
str_dup(x, 2)
```

::: {.cell-output .cell-output-stdout}

```
[1] "BananaBanana"     " citrus  citrus " "app le app le "  
```


:::
:::


:::
:::

## Extract (first occurence only)

Warning 

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
regmatches(x, m = regexpr("an", x))
```

::: {.cell-output .cell-output-stdout}

```
[1] "an"
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
str_extract(x, "an")
```

::: {.cell-output .cell-output-stdout}

```
[1] "an" NA   NA  
```


:::
:::


:::
:::

## Extract (all occurences)

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
regmatches(x, m = gregexpr("an", x))
```

::: {.cell-output .cell-output-stdout}

```
[[1]]
[1] "an" "an"

[[2]]
character(0)

[[3]]
character(0)
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
str_extract_all(x, "an")
```

::: {.cell-output .cell-output-stdout}

```
[[1]]
[1] "an" "an"

[[2]]
character(0)

[[3]]
character(0)
```


:::
:::


:::
:::

## Length

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
nchar(x)
```

::: {.cell-output .cell-output-stdout}

```
[1] 6 8 7
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
str_length(x)
```

::: {.cell-output .cell-output-stdout}

```
[1] 6 8 7
```


:::
:::


:::
:::

## Locate (first occurence only)

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
regexpr("a", x)
```

::: {.cell-output .cell-output-stdout}

```
[1]  2 -1  1
attr(,"match.length")
[1]  1 -1  1
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
str_locate(x, "a")
```

::: {.cell-output .cell-output-stdout}

```
     start end
[1,]     2   2
[2,]    NA  NA
[3,]     1   1
```


:::
:::


:::
:::

## Locate (all occurences)

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
gregexpr("a", x)
```

::: {.cell-output .cell-output-stdout}

```
[[1]]
[1] 2 4 6
attr(,"match.length")
[1] 1 1 1
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE

[[2]]
[1] -1
attr(,"match.length")
[1] -1
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE

[[3]]
[1] 1
attr(,"match.length")
[1] 1
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
str_locate_all(x, "a")
```

::: {.cell-output .cell-output-stdout}

```
[[1]]
     start end
[1,]     2   2
[2,]     4   4
[3,]     6   6

[[2]]
     start end

[[3]]
     start end
[1,]     1   1
```


:::
:::


:::
:::

## Match 

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
regmatches(x, m = regexec("a", x))
```

::: {.cell-output .cell-output-stdout}

```
[[1]]
[1] "a"

[[2]]
character(0)

[[3]]
[1] "a"
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
str_match(x, "a")
```

::: {.cell-output .cell-output-stdout}

```
     [,1]
[1,] "a" 
[2,] NA  
[3,] "a" 
```


:::
:::


:::
:::

## Order 

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
order(x)
```

::: {.cell-output .cell-output-stdout}

```
[1] 2 3 1
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
str_order(x)
```

::: {.cell-output .cell-output-stdout}

```
[1] 2 3 1
```


:::
:::


:::
:::

## Replace (first occurence only)

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
sub("a", "e", x)
```

::: {.cell-output .cell-output-stdout}

```
[1] "Benana"   " citrus " "epp le " 
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
str_replace(x, "a", "e")
```

::: {.cell-output .cell-output-stdout}

```
[1] "Benana"   " citrus " "epp le " 
```


:::
:::


:::
:::

## Replace (all occurences)

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
gsub("a", "e", x)
```

::: {.cell-output .cell-output-stdout}

```
[1] "Benene"   " citrus " "epp le " 
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
str_replace_all(x, "a", "e")
```

::: {.cell-output .cell-output-stdout}

```
[1] "Benene"   " citrus " "epp le " 
```


:::
:::


:::
:::

## Sort

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
sort(x)
```

::: {.cell-output .cell-output-stdout}

```
[1] " citrus " "app le "  "Banana"  
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
str_sort(x)
```

::: {.cell-output .cell-output-stdout}

```
[1] " citrus " "app le "  "Banana"  
```


:::
:::


:::
:::

## Split 

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
strsplit(x, "a")
```

::: {.cell-output .cell-output-stdout}

```
[[1]]
[1] "B" "n" "n"

[[2]]
[1] " citrus "

[[3]]
[1] ""       "pp le "
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
str_split(x, "a")
```

::: {.cell-output .cell-output-stdout}

```
[[1]]
[1] "B" "n" "n" "" 

[[2]]
[1] " citrus "

[[3]]
[1] ""       "pp le "
```


:::
:::


:::
:::

## Subset string 

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
substr(x, 1, 2)
```

::: {.cell-output .cell-output-stdout}

```
[1] "Ba" " c" "ap"
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
str_sub(x, 1, 2)
```

::: {.cell-output .cell-output-stdout}

```
[1] "Ba" " c" "ap"
```


:::
:::


:::
:::

## Subset string vector

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
grep(x,"a", value = TRUE)
```

::: {.cell-output .cell-output-stderr}

```
Warning in grep(x, "a", value = TRUE): argument 'pattern' has length > 1 and
only the first element will be used
```


:::

::: {.cell-output .cell-output-stdout}

```
character(0)
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
str_subset(x, "a")
```

::: {.cell-output .cell-output-stdout}

```
[1] "Banana"  "app le "
```


:::
:::


:::
:::

## Transform to lower case 

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
tolower(x)
```

::: {.cell-output .cell-output-stdout}

```
[1] "banana"   " citrus " "app le " 
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
str_to_lower(x)
```

::: {.cell-output .cell-output-stdout}

```
[1] "banana"   " citrus " "app le " 
```


:::
:::


:::
:::

## Transform to upper case 

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
toupper(x)
```

::: {.cell-output .cell-output-stdout}

```
[1] "BANANA"   " CITRUS " "APP LE " 
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
str_to_upper(x)
```

::: {.cell-output .cell-output-stdout}

```
[1] "BANANA"   " CITRUS " "APP LE " 
```


:::
:::


:::
:::

## Transform to title case 

::: {.columns}
::: {.column}

None.

:::
::: {.column}


::: {.cell}

```{.r .cell-code}
str_to_title(x)
```

::: {.cell-output .cell-output-stdout}

```
[1] "Banana"   " Citrus " "App Le " 
```


:::
:::


:::
:::

## Trim white spaces

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
trimws(x)
```

::: {.cell-output .cell-output-stdout}

```
[1] "Banana" "citrus" "app le"
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
str_trim(x)
```

::: {.cell-output .cell-output-stdout}

```
[1] "Banana" "citrus" "app le"
```


:::
:::


:::
:::

## Which 

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
grep(x, "a")
```

::: {.cell-output .cell-output-stderr}

```
Warning in grep(x, "a"): argument 'pattern' has length > 1 and only the first
element will be used
```


:::

::: {.cell-output .cell-output-stdout}

```
integer(0)
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
str_which(x, "a")
```

::: {.cell-output .cell-output-stdout}

```
[1] 1 3
```


:::
:::


:::
:::

## Wrap

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
strwrap(x, 4)
```

::: {.cell-output .cell-output-stdout}

```
[1] "Banana" "citrus" "app"    "le"    
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
str_wrap(x, 4)
```

::: {.cell-output .cell-output-stdout}

```
[1] "Banana"  "citrus"  "app\nle"
```


:::
:::


:::
:::

# Factors 



::: {.cell}

```{.r .cell-code}
set.seed(1)
f <- factor(c("A", "C", "A", "B", NA, "A", "C"))
x1 <- runif(length(f))
x2 <- runif(length(f))
f0 <- factor(rep(LETTERS[1:10], times = c(1, 3, 5, 16, 18, 20, 23, 27, 30, 31)))
f1 <- factor(c("C", "D", "D", "C", "E", "E"))
f2 <- factor(c("1", "101", "009", "009", "12", "12"))
```
:::




## Anonymise levels

::: {.columns}
::: {.column}


::: {.cell isolate='true'}

```{.r .cell-code}
new_lvls <- seq(nlevels(f))
levels(f) <- sample(new_lvls)
factor(f, new_lvls)
```

::: {.cell-output .cell-output-stdout}

```
[1] 1    3    1    2    <NA> 1    3   
Levels: 1 2 3
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
fct_anon(f)
```

::: {.cell-output .cell-output-stdout}

```
[1] 2    1    2    3    <NA> 2    1   
Levels: 1 2 3
```


:::
:::


:::
:::

## Concatenate

::: {.columns}
::: {.column}


::: {.cell isolate='true'}

```{.r .cell-code}
c(f1, f2)
```

::: {.cell-output .cell-output-stdout}

```
 [1] C   D   D   C   E   E   1   101 009 009 12  12 
Levels: C D E 009 1 101 12
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
fct_c(f1, f2)
```

::: {.cell-output .cell-output-stdout}

```
 [1] C   D   D   C   E   E   1   101 009 009 12  12 
Levels: C D E 009 1 101 12
```


:::
:::


:::
:::

## Collapse levels 

::: {.columns}
::: {.column}


::: {.cell isolate='true'}

```{.r .cell-code}
levels(f)[levels(f) %in% c("A", "B")] <- "a"
f
```

::: {.cell-output .cell-output-stdout}

```
[1] a    C    a    a    <NA> a    C   
Levels: a C
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
fct_collapse(f, a = c("A", "B"))
```

::: {.cell-output .cell-output-stdout}

```
[1] a    C    a    a    <NA> a    C   
Levels: a C
```


:::
:::


:::
:::

## Counting levels 

::: {.columns}
::: {.column}


::: {.cell isolate='true'}

```{.r .cell-code}
as.data.frame(table(f))
```

::: {.cell-output .cell-output-stdout}

```
  f Freq
1 A    3
2 B    1
3 C    2
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
fct_count(f)
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 4 × 2
  f         n
  <fct> <int>
1 A         3
2 B         1
3 C         2
4 <NA>      1
```


:::
:::


:::
:::

## Crossing levels 

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
factor(paste(f1, f2, sep = ":"))
```

::: {.cell-output .cell-output-stdout}

```
[1] C:1   D:101 D:009 C:009 E:12  E:12 
Levels: C:009 C:1 D:009 D:101 E:12
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
fct_cross(f1, f2)
```

::: {.cell-output .cell-output-stdout}

```
[1] C:1   D:101 D:009 C:009 E:12  E:12 
Levels: C:009 D:009 C:1 D:101 E:12
```


:::
:::


:::
:::

## Drop levels not in data

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
factor(f[-4])
```

::: {.cell-output .cell-output-stdout}

```
[1] A    C    A    <NA> A    C   
Levels: A C
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
fct_drop(f[-4])
```

::: {.cell-output .cell-output-stdout}

```
[1] A    C    A    <NA> A    C   
Levels: A C
```


:::
:::


:::
:::

## Add additional levels

::: {.columns}
::: {.column}


::: {.cell isolate='true'}

```{.r .cell-code}
levels(f) <- c(levels(f), c("D", "E"))
f
```

::: {.cell-output .cell-output-stdout}

```
[1] A    C    A    B    <NA> A    C   
Levels: A B C D E
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
fct_expand(f, c("D", "E"))
```

::: {.cell-output .cell-output-stdout}

```
[1] A    C    A    B    <NA> A    C   
Levels: A B C D E
```


:::
:::


:::
:::

## Reorder levels by frequency

::: {.columns}
::: {.column}


::: {.cell isolate='true'}

```{.r .cell-code}
factor(f, levels = rev(names(sort(table(f))))) 
```

::: {.cell-output .cell-output-stdout}

```
[1] A    C    A    B    <NA> A    C   
Levels: A C B
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
fct_infreq(f)
```

::: {.cell-output .cell-output-stdout}

```
[1] A    C    A    B    <NA> A    C   
Levels: A C B
```


:::
:::


:::
:::

## Reorder levels by order of appearance in data

::: {.columns}
::: {.column}


::: {.cell isolate='true'}

```{.r .cell-code}
factor(f, levels = unique(f)) 
```

::: {.cell-output .cell-output-stdout}

```
[1] A    C    A    B    <NA> A    C   
Levels: A C B
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
fct_inorder(f)
```

::: {.cell-output .cell-output-stdout}

```
[1] A    C    A    B    <NA> A    C   
Levels: A C B
```


:::
:::


:::
:::

## Reorder levels by numeric order

::: {.columns}
::: {.column}


::: {.cell isolate='true'}

```{.r .cell-code}
lvls <- levels(f2)
factor(f2, 
       levels = lvls[order(as.numeric(lvls))]) 
```

::: {.cell-output .cell-output-stdout}

```
[1] 1   101 009 009 12  12 
Levels: 1 009 12 101
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
fct_inseq(f2)
```

::: {.cell-output .cell-output-stdout}

```
[1] 1   101 009 009 12  12 
Levels: 1 009 12 101
```


:::
:::


:::
:::

## Lump levels

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
lvls <- levels(f0)
tt <- sort(table(f0))
lvls_order <- names(rev(tt))
```
:::

::: {.cell isolate='true'}

```{.r .cell-code}
levels(f0)[lvls %in% setdiff(lvls, lvls_order[1:2])] <- "Other"
f0
```

::: {.cell-output .cell-output-stdout}

```
  [1] Other Other Other Other Other Other Other Other Other Other Other Other
 [13] Other Other Other Other Other Other Other Other Other Other Other Other
 [25] Other Other Other Other Other Other Other Other Other Other Other Other
 [37] Other Other Other Other Other Other Other Other Other Other Other Other
 [49] Other Other Other Other Other Other Other Other Other Other Other Other
 [61] Other Other Other Other Other Other Other Other Other Other Other Other
 [73] Other Other Other Other Other Other Other Other Other Other Other Other
 [85] Other Other Other Other Other Other Other Other Other Other Other Other
 [97] Other Other Other Other Other Other Other Other Other Other Other Other
[109] Other Other Other Other Other I     I     I     I     I     I     I    
[121] I     I     I     I     I     I     I     I     I     I     I     I    
[133] I     I     I     I     I     I     I     I     I     I     I     J    
[145] J     J     J     J     J     J     J     J     J     J     J     J    
[157] J     J     J     J     J     J     J     J     J     J     J     J    
[169] J     J     J     J     J     J    
Levels: Other I J
```


:::
:::



:::
::: {.column}


::: {.cell}

```{.r .cell-code}
fct_lump_n(f, n = 2)
```

::: {.cell-output .cell-output-stdout}

```
[1] A     C     A     Other <NA>  A     C    
Levels: A C Other
```


:::
:::


:::
:::

::: {.columns}
::: {.column}


::: {.cell isolate='true'}

```{.r .cell-code}
n <- min(ceiling(0.2 * length(f0)), length(f0))
levels(f0)[lvls %in% setdiff(lvls, lvls_order[1:n])] <- "Other"
f0
```

::: {.cell-output .cell-output-stdout}

```
  [1] A B B B C C C C C D D D D D D D D D D D D D D D D E E E E E E E E E E E E
 [38] E E E E E E F F F F F F F F F F F F F F F F F F F F G G G G G G G G G G G
 [75] G G G G G G G G G G G G H H H H H H H H H H H H H H H H H H H H H H H H H
[112] H H I I I I I I I I I I I I I I I I I I I I I I I I I I I I I I J J J J J
[149] J J J J J J J J J J J J J J J J J J J J J J J J J J
Levels: A B C D E F G H I J
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
fct_lump_prop(f0, prop = 0.2)
```

::: {.cell-output .cell-output-stdout}

```
  [1] Other Other Other Other Other Other Other Other Other Other Other Other
 [13] Other Other Other Other Other Other Other Other Other Other Other Other
 [25] Other Other Other Other Other Other Other Other Other Other Other Other
 [37] Other Other Other Other Other Other Other Other Other Other Other Other
 [49] Other Other Other Other Other Other Other Other Other Other Other Other
 [61] Other Other Other Other Other Other Other Other Other Other Other Other
 [73] Other Other Other Other Other Other Other Other Other Other Other Other
 [85] Other Other Other Other Other Other Other Other Other Other Other Other
 [97] Other Other Other Other Other Other Other Other Other Other Other Other
[109] Other Other Other Other Other Other Other Other Other Other Other Other
[121] Other Other Other Other Other Other Other Other Other Other Other Other
[133] Other Other Other Other Other Other Other Other Other Other Other Other
[145] Other Other Other Other Other Other Other Other Other Other Other Other
[157] Other Other Other Other Other Other Other Other Other Other Other Other
[169] Other Other Other Other Other Other
Levels: Other
```


:::
:::


:::
:::

::: {.columns}
::: {.column}


::: {.cell isolate='true'}

```{.r .cell-code}
levels(f0)[lvls %in% names(tt[tt < 2])] <- "Other"
f0
```

::: {.cell-output .cell-output-stdout}

```
  [1] Other B     B     B     C     C     C     C     C     D     D     D    
 [13] D     D     D     D     D     D     D     D     D     D     D     D    
 [25] D     E     E     E     E     E     E     E     E     E     E     E    
 [37] E     E     E     E     E     E     E     F     F     F     F     F    
 [49] F     F     F     F     F     F     F     F     F     F     F     F    
 [61] F     F     F     G     G     G     G     G     G     G     G     G    
 [73] G     G     G     G     G     G     G     G     G     G     G     G    
 [85] G     G     H     H     H     H     H     H     H     H     H     H    
 [97] H     H     H     H     H     H     H     H     H     H     H     H    
[109] H     H     H     H     H     I     I     I     I     I     I     I    
[121] I     I     I     I     I     I     I     I     I     I     I     I    
[133] I     I     I     I     I     I     I     I     I     I     I     J    
[145] J     J     J     J     J     J     J     J     J     J     J     J    
[157] J     J     J     J     J     J     J     J     J     J     J     J    
[169] J     J     J     J     J     J    
Levels: Other B C D E F G H I J
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
fct_lump_min(f0, min = 2)
```

::: {.cell-output .cell-output-stdout}

```
  [1] Other B     B     B     C     C     C     C     C     D     D     D    
 [13] D     D     D     D     D     D     D     D     D     D     D     D    
 [25] D     E     E     E     E     E     E     E     E     E     E     E    
 [37] E     E     E     E     E     E     E     F     F     F     F     F    
 [49] F     F     F     F     F     F     F     F     F     F     F     F    
 [61] F     F     F     G     G     G     G     G     G     G     G     G    
 [73] G     G     G     G     G     G     G     G     G     G     G     G    
 [85] G     G     H     H     H     H     H     H     H     H     H     H    
 [97] H     H     H     H     H     H     H     H     H     H     H     H    
[109] H     H     H     H     H     I     I     I     I     I     I     I    
[121] I     I     I     I     I     I     I     I     I     I     I     I    
[133] I     I     I     I     I     I     I     I     I     I     I     J    
[145] J     J     J     J     J     J     J     J     J     J     J     J    
[157] J     J     J     J     J     J     J     J     J     J     J     J    
[169] J     J     J     J     J     J    
Levels: B C D E F G H I J Other
```


:::
:::


:::
:::

::: {.columns}
::: {.column}


::: {.cell isolate='true'}

```{.r .cell-code}
bottom_lvls <- seq(which.min(cumsum(tt)[-length(tt)] - tt[-1]))
levels(f0)[lvls %in% names(tt[bottom_lvls])] <- "Other"
f0
```

::: {.cell-output .cell-output-stdout}

```
  [1] Other Other Other Other Other Other Other Other Other D     D     D    
 [13] D     D     D     D     D     D     D     D     D     D     D     D    
 [25] D     E     E     E     E     E     E     E     E     E     E     E    
 [37] E     E     E     E     E     E     E     F     F     F     F     F    
 [49] F     F     F     F     F     F     F     F     F     F     F     F    
 [61] F     F     F     G     G     G     G     G     G     G     G     G    
 [73] G     G     G     G     G     G     G     G     G     G     G     G    
 [85] G     G     H     H     H     H     H     H     H     H     H     H    
 [97] H     H     H     H     H     H     H     H     H     H     H     H    
[109] H     H     H     H     H     I     I     I     I     I     I     I    
[121] I     I     I     I     I     I     I     I     I     I     I     I    
[133] I     I     I     I     I     I     I     I     I     I     I     J    
[145] J     J     J     J     J     J     J     J     J     J     J     J    
[157] J     J     J     J     J     J     J     J     J     J     J     J    
[169] J     J     J     J     J     J    
Levels: Other D E F G H I J
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
fct_lump_lowfreq(f0)
```

::: {.cell-output .cell-output-stdout}

```
  [1] Other Other Other Other Other Other Other Other Other D     D     D    
 [13] D     D     D     D     D     D     D     D     D     D     D     D    
 [25] D     E     E     E     E     E     E     E     E     E     E     E    
 [37] E     E     E     E     E     E     E     F     F     F     F     F    
 [49] F     F     F     F     F     F     F     F     F     F     F     F    
 [61] F     F     F     G     G     G     G     G     G     G     G     G    
 [73] G     G     G     G     G     G     G     G     G     G     G     G    
 [85] G     G     H     H     H     H     H     H     H     H     H     H    
 [97] H     H     H     H     H     H     H     H     H     H     H     H    
[109] H     H     H     H     H     I     I     I     I     I     I     I    
[121] I     I     I     I     I     I     I     I     I     I     I     I    
[133] I     I     I     I     I     I     I     I     I     I     I     J    
[145] J     J     J     J     J     J     J     J     J     J     J     J    
[157] J     J     J     J     J     J     J     J     J     J     J     J    
[169] J     J     J     J     J     J    
Levels: D E F G H I J Other
```


:::
:::


:::
:::


## Match levels

::: {.columns}
::: {.column}


::: {.cell isolate='true'}

```{.r .cell-code}
if("A" %in% levels(f)) {
  f %in% "A"
}
```

::: {.cell-output .cell-output-stdout}

```
[1]  TRUE FALSE  TRUE FALSE FALSE  TRUE FALSE
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
fct_match(f, "A")
```

::: {.cell-output .cell-output-stdout}

```
[1]  TRUE FALSE  TRUE FALSE FALSE  TRUE FALSE
```


:::
:::


:::
:::


## Recode levels

::: {.columns}
::: {.column}


::: {.cell isolate='true'}

```{.r .cell-code}
factor(sapply(f, \(x) {
  x <- as.character(x)
  switch(x, 
         A = "apple", 
         B = "banana",
         x)
  }))
```

::: {.cell-output .cell-output-stdout}

```
[1] apple  C      apple  banana <NA>   apple  C     
Levels: apple banana C
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
fct_recode(f, 
           apple = "A", 
           banana = "B")
```

::: {.cell-output .cell-output-stdout}

```
[1] apple  C      apple  banana <NA>   apple  C     
Levels: apple banana C
```


:::
:::


:::
:::

## Relabel levels

::: {.columns}
::: {.column}


::: {.cell isolate='true'}

```{.r .cell-code}
levels(f) <- paste0(levels(f), "1")
f
```

::: {.cell-output .cell-output-stdout}

```
[1] A1   C1   A1   B1   <NA> A1   C1  
Levels: A1 B1 C1
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
fct_relabel(f, ~str_c(., "1"))
```

::: {.cell-output .cell-output-stdout}

```
[1] A1   C1   A1   B1   <NA> A1   C1  
Levels: A1 B1 C1
```


:::
:::


:::
:::

## Relevel

::: {.columns}
::: {.column}


::: {.cell isolate='true'}

```{.r .cell-code}
relevel(f, ref = "B")
```

::: {.cell-output .cell-output-stdout}

```
[1] A    C    A    B    <NA> A    C   
Levels: B A C
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
fct_relevel(f, "B")
```

::: {.cell-output .cell-output-stdout}

```
[1] A    C    A    B    <NA> A    C   
Levels: B A C
```


:::
:::


:::
:::


## Reorder

::: {.columns}
::: {.column}


::: {.cell isolate='true'}

```{.r .cell-code}
reorder(f, x1, mean)
```

::: {.cell-output .cell-output-stdout}

```
[1] A    C    A    B    <NA> A    C   
attr(,"scores")
        A         B         C 
0.5789172 0.9082078 0.6583996 
Levels: A C B
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
fct_reorder(f, x1, mean)
```

::: {.cell-output .cell-output-stdout}

```
[1] A    C    A    B    <NA> A    C   
Levels: A C B
```


:::
:::


:::
:::


::: {.columns}
::: {.column}


::: {.cell isolate='true'}

```{.r .cell-code}
reorder(f, seq_along(f), 
        \(i) sum(x1[i] * x2[i]))
```

::: {.cell-output .cell-output-stdout}

```
[1] A    C    A    B    <NA> A    C   
attr(,"scores")
        A         B         C 
0.8280563 0.1870677 0.5969617 
Levels: B C A
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
fct_reorder2(f, x1, x2, 
             \(x, y) sum(x * y))
```

::: {.cell-output .cell-output-stdout}

```
[1] A    C    A    B    <NA> A    C   
Levels: A C B
```


:::
:::


:::
:::

## Unique

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
unique(f)
```

::: {.cell-output .cell-output-stdout}

```
[1] A    C    B    <NA>
Levels: A B C
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
fct_unique(f)
```

::: {.cell-output .cell-output-stdout}

```
[1] A    B    C    <NA>
Levels: A B C
```


:::
:::


:::
:::

## Reverse order of levels

::: {.columns}
::: {.column}


::: {.cell isolate='true'}

```{.r .cell-code}
factor(f, levels = rev(levels(f)))
```

::: {.cell-output .cell-output-stdout}

```
[1] A    C    A    B    <NA> A    C   
Levels: C B A
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
fct_rev(f)
```

::: {.cell-output .cell-output-stdout}

```
[1] A    C    A    B    <NA> A    C   
Levels: C B A
```


:::
:::


:::
:::


## Shift order of labels

::: {.columns}
::: {.column}


::: {.cell isolate='true'}

```{.r .cell-code}
factor(f, c(levels(f)[-1], levels(f)[1]))
```

::: {.cell-output .cell-output-stdout}

```
[1] A    C    A    B    <NA> A    C   
Levels: B C A
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
fct_shift(f)
```

::: {.cell-output .cell-output-stdout}

```
[1] A    C    A    B    <NA> A    C   
Levels: B C A
```


:::
:::


:::
:::



## Shuffle order of labels

::: {.columns}
::: {.column}


::: {.cell isolate='true'}

```{.r .cell-code}
factor(f, sample(levels(f)))
```

::: {.cell-output .cell-output-stdout}

```
[1] A    C    A    B    <NA> A    C   
Levels: A C B
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
fct_shuffle(f)
```

::: {.cell-output .cell-output-stdout}

```
[1] A    C    A    B    <NA> A    C   
Levels: A C B
```


:::
:::


:::
:::

## Unify labels across list

::: {.columns}
::: {.column}


::: {.cell isolate='true'}

```{.r .cell-code}
lapply(list(f1, f2), 
       \(x) factor(x, c(levels(f1), levels(f2))))
```

::: {.cell-output .cell-output-stdout}

```
[[1]]
[1] C D D C E E
Levels: C D E 009 1 101 12

[[2]]
[1] 1   101 009 009 12  12 
Levels: C D E 009 1 101 12
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
fct_unify(list(f1, f2))
```

::: {.cell-output .cell-output-stdout}

```
[[1]]
[1] C D D C E E
Levels: C D E 009 1 101 12

[[2]]
[1] 1   101 009 009 12  12 
Levels: C D E 009 1 101 12
```


:::
:::


:::
:::


# Date and time 

## Get today's date 

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
Sys.Date()
```

::: {.cell-output .cell-output-stdout}

```
[1] "2025-01-05"
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
today()
```

::: {.cell-output .cell-output-stdout}

```
[1] "2025-01-05"
```


:::
:::


:::
:::

## Get current date and time 

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
Sys.time()
```

::: {.cell-output .cell-output-stdout}

```
[1] "2025-01-05 17:03:56 AEDT"
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
now()
```

::: {.cell-output .cell-output-stdout}

```
[1] "2025-01-05 17:03:56 AEDT"
```


:::
:::


:::
:::

## Change input to date 

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
as.Date("2025-01-01")
```

::: {.cell-output .cell-output-stdout}

```
[1] "2025-01-01"
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
as_date("2025-01-01")
```

::: {.cell-output .cell-output-stdout}

```
[1] "2025-01-01"
```


:::
:::


:::
:::


::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
as.Date("2025 Jan 1", format = "%Y %b %d")
```

::: {.cell-output .cell-output-stdout}

```
[1] "2025-01-01"
```


:::

```{.r .cell-code}
as.Date("1/3/2025", format = "%m/%d/%Y")
```

::: {.cell-output .cell-output-stdout}

```
[1] "2025-01-03"
```


:::

```{.r .cell-code}
as.Date("1-3-2025", format = "%d-%m-%Y")
```

::: {.cell-output .cell-output-stdout}

```
[1] "2025-03-01"
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
ymd("2025 Jan 1")
```

::: {.cell-output .cell-output-stdout}

```
[1] "2025-01-01"
```


:::

```{.r .cell-code}
mdy("1/3/2025")
```

::: {.cell-output .cell-output-stdout}

```
[1] "2025-01-03"
```


:::

```{.r .cell-code}
dmy("1-3-2025")
```

::: {.cell-output .cell-output-stdout}

```
[1] "2025-03-01"
```


:::
:::


:::
:::


## Change input to date and time

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
as.POSIXct("2025-01-01 05:00:00", tz = "UTC")
```

::: {.cell-output .cell-output-stdout}

```
[1] "2025-01-01 05:00:00 UTC"
```


:::

```{.r .cell-code}
as.POSIXlt("2025-01-01 05:00:00", tz = "UTC")
```

::: {.cell-output .cell-output-stdout}

```
[1] "2025-01-01 05:00:00 UTC"
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
as_datetime("2025-01-01 05:00:00")
```

::: {.cell-output .cell-output-stdout}

```
[1] "2025-01-01 05:00:00 UTC"
```


:::
:::


:::
:::


## Extract year, month, day, hour, minutes or seconds



::: {.cell}

```{.r .cell-code}
d <- as.POSIXct("2025/01/03 01:20:40")
```
:::




::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
as.numeric(format(d, "%Y"))
```

::: {.cell-output .cell-output-stdout}

```
[1] 2025
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
year(d)
```

::: {.cell-output .cell-output-stdout}

```
[1] 2025
```


:::
:::


:::
:::


::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
as.numeric(format(d, "%m"))
```

::: {.cell-output .cell-output-stdout}

```
[1] 1
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
month(d)
```

::: {.cell-output .cell-output-stdout}

```
[1] 1
```


:::
:::


:::
:::

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
as.numeric(format(d, "%d"))
```

::: {.cell-output .cell-output-stdout}

```
[1] 3
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
day(d)
```

::: {.cell-output .cell-output-stdout}

```
[1] 3
```


:::
:::


:::
:::

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
as.numeric(format(d, "%H"))
```

::: {.cell-output .cell-output-stdout}

```
[1] 1
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
hour(d)
```

::: {.cell-output .cell-output-stdout}

```
[1] 1
```


:::
:::


:::
:::

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
as.numeric(format(d, "%M"))
```

::: {.cell-output .cell-output-stdout}

```
[1] 20
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
minutes(d)
```

::: {.cell-output .cell-output-stdout}

```
[1] "1735827640M 0S"
```


:::
:::


:::
:::

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
as.numeric(format(d, "%S"))
```

::: {.cell-output .cell-output-stdout}

```
[1] 40
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
seconds(d)
```

::: {.cell-output .cell-output-stdout}

```
[1] "1735827640S"
```


:::
:::


:::
:::

# Functional programming



::: {.cell}

```{.r .cell-code}
x <- list(1:3, 2:5, 3:-1)
y <- list("a", "b", "c")
z <- list(1, 2, 3)
```
:::




## Iterate over a list

### Return as list 

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
lapply(x, sum)
```

::: {.cell-output .cell-output-stdout}

```
[[1]]
[1] 6

[[2]]
[1] 14

[[3]]
[1] 5
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
map(x, sum)
```

::: {.cell-output .cell-output-stdout}

```
[[1]]
[1] 6

[[2]]
[1] 14

[[3]]
[1] 5
```


:::
:::


:::
:::

### Return as vector

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
vapply(x, length, integer(1))
```

::: {.cell-output .cell-output-stdout}

```
[1] 3 4 5
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
map_int(x, length)
```

::: {.cell-output .cell-output-stdout}

```
[1] 3 4 5
```


:::
:::


:::
:::


::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
vapply(x, sum, double(1))
```

::: {.cell-output .cell-output-stdout}

```
[1]  6 14  5
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
map_dbl(x, sum)
```

::: {.cell-output .cell-output-stdout}

```
[1]  6 14  5
```


:::
:::


:::
:::

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
vapply(x, is.numeric, logical(1))
```

::: {.cell-output .cell-output-stdout}

```
[1] TRUE TRUE TRUE
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
map_lgl(x, is.numeric)
```

::: {.cell-output .cell-output-stdout}

```
[1] TRUE TRUE TRUE
```


:::
:::


:::
:::

::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
vapply(x, \(x) letters[length(x)], character(1))
```

::: {.cell-output .cell-output-stdout}

```
[1] "c" "d" "e"
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
map_chr(x, ~letters[length(.x)])
```

::: {.cell-output .cell-output-stdout}

```
[1] "c" "d" "e"
```


:::
:::


:::
:::


## Iterate over two lists



::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
lapply(seq_along(x), 
       \(i) paste0(y[[i]], sum(x[[i]])))
```

::: {.cell-output .cell-output-stdout}

```
[[1]]
[1] "a6"

[[2]]
[1] "b14"

[[3]]
[1] "c5"
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
map2(x, y, ~paste0(.y, sum(.x)))
```

::: {.cell-output .cell-output-stdout}

```
[[1]]
[1] "a6"

[[2]]
[1] "b14"

[[3]]
[1] "c5"
```


:::
:::


:::
:::


## Iterate over two or more lists



::: {.columns}
::: {.column}


::: {.cell}

```{.r .cell-code}
lapply(seq_along(x), 
       \(i) paste0(sum(x[[i]]), y[[i]], z[[i]]))
```

::: {.cell-output .cell-output-stdout}

```
[[1]]
[1] "6a1"

[[2]]
[1] "14b2"

[[3]]
[1] "5c3"
```


:::
:::


:::
::: {.column}


::: {.cell}

```{.r .cell-code}
pmap(list(x, y, z), 
     ~paste0(sum(..1), ..2, ..3))
```

::: {.cell-output .cell-output-stdout}

```
[[1]]
[1] "6a1"

[[2]]
[1] "14b2"

[[3]]
[1] "5c3"
```


:::
:::


:::
:::

# Computational details 



::: {.cell}

```{.r .cell-code}
sessioninfo::session_info(include_base = TRUE)
```
:::



<pre>


─ Session info ───────────────────────────────────────────────────────────────
 setting  value
 version  R version 4.3.3 (2024-02-29)
 os       macOS 15.1.1
 system   aarch64, darwin20
 ui       X11
 language (EN)
 collate  en_US.UTF-8
 ctype    en_US.UTF-8
 tz       Australia/Sydney
 date     2025-01-05
 pandoc   3.2 @ /Applications/RStudio.app/Contents/Resources/app/quarto/bin/tools/aarch64/ (via rmarkdown)

─ Packages ───────────────────────────────────────────────────────────────────
 ! package        * version date (UTC) lib source
   base           * 4.3.3   2024-03-01 [?] local
   cachem           1.1.0   2024-05-16 [1] CRAN (R 4.3.3)
   cli              3.6.3   2024-06-21 [1] CRAN (R 4.3.3)
   colorspace       2.1-1   2024-07-26 [1] CRAN (R 4.3.3)
 P compiler         4.3.3   2024-03-01 [1] local
   conflicted       1.2.0   2023-02-01 [1] CRAN (R 4.3.0)
   data.table     * 1.16.4  2024-12-06 [1] CRAN (R 4.3.3)
 P datasets       * 4.3.3   2024-03-01 [1] local
   digest           0.6.37  2024-08-19 [1] CRAN (R 4.3.3)
   dplyr          * 1.1.4   2023-11-17 [1] CRAN (R 4.3.1)
   evaluate         1.0.1   2024-10-10 [1] CRAN (R 4.3.3)
   fansi            1.0.6   2023-12-08 [1] CRAN (R 4.3.1)
   fastmap          1.2.0   2024-05-15 [1] CRAN (R 4.3.3)
   forcats        * 1.0.0   2023-01-29 [1] CRAN (R 4.3.0)
   generics         0.1.3   2022-07-05 [1] CRAN (R 4.3.0)
   ggplot2        * 3.5.1   2024-04-23 [1] CRAN (R 4.3.1)
   glue             1.8.0   2024-09-30 [1] CRAN (R 4.3.3)
 P graphics       * 4.3.3   2024-03-01 [1] local
 P grDevices      * 4.3.3   2024-03-01 [1] local
 P grid             4.3.3   2024-03-01 [1] local
   gtable           0.3.6   2024-10-25 [1] CRAN (R 4.3.3)
   here             1.0.1   2020-12-13 [1] CRAN (R 4.3.0)
   hms              1.1.3   2023-03-21 [1] CRAN (R 4.3.0)
   htmltools        0.5.8.1 2024-04-04 [1] CRAN (R 4.3.1)
   htmlwidgets      1.6.4   2023-12-06 [1] CRAN (R 4.3.1)
   jsonlite         1.8.9   2024-09-20 [1] CRAN (R 4.3.3)
   knitr            1.49    2024-11-08 [1] CRAN (R 4.3.3)
   lifecycle        1.0.4   2023-11-07 [1] CRAN (R 4.3.1)
   lubridate      * 1.9.3   2023-09-27 [1] CRAN (R 4.3.1)
   magrittr         2.0.3   2022-03-30 [1] CRAN (R 4.3.0)
   memoise          2.0.1   2021-11-26 [1] CRAN (R 4.3.0)
 P methods        * 4.3.3   2024-03-01 [1] local
   munsell          0.5.1   2024-04-01 [1] CRAN (R 4.3.1)
   palmerpenguins * 0.1.1   2022-08-15 [1] CRAN (R 4.3.0)
   pillar           1.9.0   2023-03-22 [1] CRAN (R 4.3.0)
   pkgconfig        2.0.3   2019-09-22 [1] CRAN (R 4.3.0)
   purrr          * 1.0.2   2023-08-10 [1] CRAN (R 4.3.0)
   R6               2.5.1   2021-08-19 [1] CRAN (R 4.3.0)
   readr          * 2.1.5   2024-01-10 [1] CRAN (R 4.3.1)
   rlang            1.1.4   2024-06-04 [1] CRAN (R 4.3.3)
   rmarkdown        2.29    2024-11-04 [1] CRAN (R 4.3.3)
   rprojroot        2.0.4   2023-11-05 [1] CRAN (R 4.3.1)
   rstudioapi       0.17.1  2024-10-22 [1] CRAN (R 4.3.3)
   scales           1.3.0   2023-11-28 [1] CRAN (R 4.3.1)
   sessioninfo      1.2.2   2021-12-06 [1] CRAN (R 4.3.0)
 P stats          * 4.3.3   2024-03-01 [1] local
   stringi          1.8.4   2024-05-06 [1] CRAN (R 4.3.1)
   stringr        * 1.5.1   2023-11-14 [1] CRAN (R 4.3.1)
   tibble         * 3.2.1   2023-03-20 [1] CRAN (R 4.3.0)
   tidyr          * 1.3.1   2024-01-24 [1] CRAN (R 4.3.1)
   tidyselect       1.2.1   2024-03-11 [1] CRAN (R 4.3.1)
   tidyverse      * 2.0.0   2023-02-22 [1] CRAN (R 4.3.0)
   timechange       0.3.0   2024-01-18 [1] CRAN (R 4.3.1)
 P tools            4.3.3   2024-03-01 [1] local
   tzdb             0.4.0   2023-05-12 [1] CRAN (R 4.3.0)
   utf8             1.2.4   2023-10-22 [1] CRAN (R 4.3.1)
 P utils          * 4.3.3   2024-03-01 [1] local
   vctrs            0.6.5   2023-12-01 [1] CRAN (R 4.3.1)
   withr            3.0.2   2024-10-28 [1] CRAN (R 4.3.3)
   xfun             0.49    2024-10-31 [1] CRAN (R 4.3.3)
   yaml             2.3.10  2024-07-26 [1] CRAN (R 4.3.3)

 [1] /Library/Frameworks/R.framework/Versions/4.3-arm64/Resources/library

 P ── Loaded and on-disk path mismatch.

──────────────────────────────────────────────────────────────────────────────


</pre>


