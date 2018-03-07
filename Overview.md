# BEES stats course 2018 - intro to R
Below is an overview of the content we intend to cover - most of it will be taught as "live coding" and there are associated exercises in the exercises page ([Exercises.md](https://github.com/nicercode/2018_BEES_regression/blob/master/Exercises.md))

## Monday:

#### crash-course to R and Rstudio [Mitch]

- console vs script files (.R files)
- R and Rmd files
- objects:
	- variables (assignment, access)
	- functions (execution + more on Wednesday)
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

- **Things we skipped**:
	- saving objects
	- things to avoid (saving, attach/detach)

#### Project organisation -- Keeping things undercontrol [Daniel]

- Intro
  - Who am I: 2 things - plants, happy coder
	- Today, top tip for happy coding
	- structure for organising yourself
	- not only way you can do it, but unless have other good ideas, consider adopting it
- Path names
	- You have to know where things are
	- Where on your computer: getwd()
	- What's in the folder: dir() 
	- dir vs ls
	- **Challenge:**
- Projects
	- How do we organise materials?
	- What is a meaningful unit for project? (A chapter or analysis)
		- **Happy coder rule**: Projects are distinct & self contained
		- start with a folder for project
	- Key parts: What sort of files do we have to deal with?
		- README.md -- orients
		- data/
		- analysis.Rmd
		- R/
	- Pathnames: Relative vs absolute
		- **Happy coder rule**: use relative paths
			1. can move projects around and still use it
			2. collaboration
		- Exercise: try with absolute and relative 
			- dir() 
			- dir.create()
			- read_csv
			- write_csv
	- Rstudio project files
		- opening projects
		- **Happy coder rule**: use Rstduio's project files
		- **Rule: never use setwd**
		- [Hadley Wickham on opening Rstudio projects](https://youtu.be/boKFxBniUH0) 
	- **Challenge**
- **More Rules:**
	- consistent project structure
	- data is read-only (and precious)
	- everything in R is a function
	- output is disposable
	- top script is simple and readable
	- readme.md: introduction,
	- Rmd files: top or inst directory
- References
	- http://environmentalcomputing.net/basic-project-management/
	- http://nicercode.github.io/blog/2013-05-17-organising-my-project/
	- http://nicercode.github.io/blog/2013-04-05-projects/

## Tuesday:

#### Intro to tidyverse [Daniel]

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


## Wednesday:

#### Plotting with ggplot  [Mitch]

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

## Thursday:

#### Using functions in R [Daniel]

```
library(dplyr)
x <- tibble(x1 = c(1:7, NA), x2 = c(4:1, 2:5))
rowSums(x)
```
- function structure (rowSums)
	- name
	- body
	- arguments
- investigating structure of function f 
	- `args(f)`
	- `body(f)` or just `f`
	- return value
- ?help
- named vs ordered arguments
- default arguments
- ... 
```
mymean <- function(..., na.rm=TRUE) {
  mean(..., na.rm=na.rm)
}
```

#### packages in R [Daniel]

- finding, installing, versions
	- CRAN
- non-cran (github, r-forge etc.)
	- ways to install

### ggplot extended 

- adding predicted data to ggplots
- geom_abline, geom_ribbon, geom_errorbar
- geom_smooth (lm, loess, gam)
- string inputs e.g. aes_string()
- plotly (interactive)


#### Further topics (Show and tell)

- getting help: stackoverflow, MWEs [Mitch]
- Reproducible workflows [Daniel]
	- Projects, end to end
	- Rmd: notebooks vs knitr reports
- Style 
	- white space, tabs, naming
	- Rstudio indent  / reflow commands
- Continued learning: [Daniel + Mitch]
	- at UNSW
	- elsewhere
