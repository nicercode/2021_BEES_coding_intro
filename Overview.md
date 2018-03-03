# BEES stats course 2018 - intro to R
Below is an overview of the content we intend to cover - most of it will be taught as "live coding" and there are associated exercises in the exercises page (Exercises.md)

## Monday:

- crash-course to R and Rstudio [Mitch]
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

- project organisation [Daniel]
	- pathname, working directories and projects 
	- read_csv
	- write_csv

(data: Angela plant height)

## Tuesday:

- intro to tidyverse [Daniel]
	- focus on data.frames (tibbles)
    - base vs tidyverse
    	- subsetting/indexing/logical operators
    - why tidyverse

- loading and manipulating data [Daniel]
	- readr
	- dplyr
	- filter & select
	- piping
	- group_by
	- summarise
	- broom

- plotting with ggplot  [Mitch]
   - data structure (data.frames or tibbles)
   - basic plot setup (grammar)
   - geom_point, geom_boxplot
   - axis labelling, log transform axis
   - facet grid/wrap (Data: CO2 data plant growth CO2)

## Wednesday:

- plotting with ggplot [Mitch]
  - geom_abline, geom_ribbon 
  - geom_smooth (lm, loess, gam)
  - adding predicted data to ggplots
  - plotly (interactive)

- using and writing functions in R [Daniel]
	- names vs ordered arguments
	- default arguments
	- ...

- programming principles: DRY	 [Daniel]

## Thursday:

- intro to R packages [Mitch]
	- finding, installing, versions
	- namespaces (conflicts mainly)
	- vigenttes, tutorials, help
	- cran vs non-cran (github, r-forge etc.)

- getting help: stackoverflow, MWEs [Mitch]

- reproducible workflows [Daniel]
	- Projects, end to end
	- Rmd: notebooks vs knitr reports
	- version control (overview)

- continued learning: [Daniel + Mitch]
	- style 
		- paradigms
		- Rstudio
		- ropensci / tidyverse
	- programming: when, how
