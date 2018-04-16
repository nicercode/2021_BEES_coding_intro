# intro to R
Below is an overview of the content we intend to cover - most of it will be taught as "live coding" and there are associated exercises in the exercises page ([Exercises.md](https://github.com/nicercode/2018_BEES_regression/blob/master/Exercises.md))

## Intro:

#### crash-course to R and Rstudio 

- console vs script files (.R files)
- R and Rmd files
- objects:
	- variables (assignment, access)
	- functions (execution)
- object 'environments': global vs. function
- variables:
	- 'data' objects have 'classes' and 'structure':
		- structure: vector, matrix, array, list, data.frame ++ 
		- type: numeric, integer, character, logical, factor
	- saving: .rds, .Rdata, .Rhistory
	- aim to avoid .RData, attach() and detach() (more on namespaces on Thursday)
- errors and warnings
- workflow strategy --> run chunks, check (not line by line)
- packages: base-R vs. contributed (more on Thursday)

## Core of first class:

#### Intro to tidyverse 

- readr
- dplyr
- tidyr
- filter & select
- piping
- group_by
- summarise
- spread/gather

See slides how on the [Tidyverse](http://htmlpreview.github.io/?https://github.com/nicercode/2018_BEES_regression/blob/master/tidyverse.html)


References:

- [Cheat sheets from Rstudio](https://www.rstudio.com/resources/cheatsheets/)
- [Tidyverse reference materials](http://tidyr.tidyverse.org/)

Talks:

- [Hadley Wickham's "Data Science with R"](https://www.youtube.com/watch?v=K-ss_ag2k9E)
- [Emily Robinson's "Lesser known stars of the tidyverse"](https://www.rstudio.com/resources/videos/the-lesser-known-stars-of-the-tidyverse/)

Tutorials:

- [UNSW's environmental computing](http://environmentalcomputing.net/subsetting-data/)
- [Wickam's R for Data science](http://r4ds.had.co.nz/transform.html)
- [Stat 545 Into to dplyr](http://stat545.com/block009_dplyr-intro.html)
- [Data Camp's Into to tidyverse](http://varianceexplained.org/r/intro-tidyverse/)
- [Miles McBain's Into to tidyverse](https://github.com/MilesMcBain/tidycourse)

#### Plotting with ggplot 

- installing and loading the {ggplot2} package
- data structure (data.frames or tibbles)
	- typically you want *long* data when ggplotting (tidyr::gather)
- using the *reveg.csv* data as an example:
    - basic plot setup:
    	- data & aes()
    	- geom's (boxplot, point, line etc.)
    - basic colour, shape and other groupings:
    	- group
    	- colour
    	- fill
    	- shape/linetype
    - axis and plot labelling
    - theme (pronto overall layout)
    - facet grid/wrap
- scaling aesthetics (continuous, discrete, manual etc...)
- direct plotting vs. assigning to object
- ggsave()
- more customised themes
- opinion: incredibly powerful and efficient for visualising lots of information, BUT, really fine-scale aesthetics can be diminishing returns...
