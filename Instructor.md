# Notes for instructors

Links to material

http://bit.ly/2020_bees_reg (download all)
http://bit.ly/2020_bees_reg_live
https://www.dropbox.com/sh/elgtkif3j43ccg4/AADuv6GmLfU1PvclahFvCsqda?dl=1


Gear to bring:

- cheatsheets
- stickynotes


# Writing exercises & solutions

We have organised different lessons into their own folder including 

- an Rstduio project file (Just double click to open and set wording directories) 
- relevant data in a folder called `data`
- An Rmd file with exercises and solutions.

The hope is that this structure will

- Reduce time and brain energy lost on navigating file structures
- Make projects and lessons portable, by removing any use of `setwd`
- Improve engagement with a particular lesson, by reducing clutter
- Help build good habits


## Style

* Use tidyverse tools for reading in data, e.g. `read_csv` rather than `read.csv`
* Use tidyverse tools for creating dataframes, eg. `tibble` rather than `data.frame`
* Use tools from `dplyr` and `tidyr` for data manipulation
* Use pipes to create clean workflows
* Use tidyverse style for naming variables, eg. `data_smoking` 
* Use ggplot for all plotting

## Exercise and Solutions file

Each lesson may have two Rmd files- an `Exercises` file and a `Solutions` file. The `Exercises` file should be the same `Solutions` but without some of the answers.

To reduce duplication, we only need write a single file (solutions) and then use this to auto-generate the associated exercises file by stripping out some of the answers. 

To achieve this, put solutions within in a chunk using the following format

```{r, eval=show_solutions}
...
your code here
...
```

Even though they don't need any code, text solutions should still use the above format, e.g.

```{r, eval=show_solutions}
"Each bat has the same probability of being selected (independence); guaranteed by random sampling of bats"
```

We can then easily strip out the solutions from the `solutions` file to generate the the `exercises` version to distribute to students using regular expressions, e.g.

```{r}
library(tidyverse)

file <- "lessons/30-stats_intro/solutions_stats_intro.Rmd"

readLines(file) %>% 
	str_c(collapse = "NNN") %>% 
	str_replace_all(", eval=show_solutions.+?(?=\`\`\`)", "}\n\n") %>%  
	str_replace_all("NNN", "\n") %>%  
	writeLines(gsub("solutions", "exercise", file))
```

Note here

- I'm using `NNNN` for new line when collapsing because this doesn't interfere with string replacement whereas `\n` does
- the regular expression searches for everything between  `, eval=show_solutions` and three backticks and replaces this with two blank lines

