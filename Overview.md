# BEES stats course 2018 - intro to R
Below is an overview of the content we intend to cover - most of it will be taught as "live coding" and there are associated exercises in the exercises page ([Exercises.md](https://github.com/nicercode/2018_BEES_regression/blob/master/Exercises.md))

## Monday:

crash-course to R and Rstudio [Mitch]

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

Project organisation -- Keeping things undercontrol [Daniel]

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

- intro to tidyverse [Daniel]
	- focus on data.frames (tibbles)
    - base vs tidyverse
    	- subsetting/indexing/logical operators
    - why tidyverse

The idea behind dplyr is that many of the common functions that you will need are descriptive verbs. The particularly useful ones that we will introduce you to today are:

mutate  – make new variables
select  and  filter   – subset columns and rows 
summarise  – summarise data
group_by  – grouping data
arrange  – order rows
rename    – rename variables

It uses elegant code with just the variable names rather than having to index variables by $. For example to create a log transformed variable in base R code, we would use:

- loading and manipulating data [Daniel]
	- readr
	- dplyr
	- filter & select
	- piping
	- group_by
	- summarise
	- ?broom
	
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

- using  functions in R [Daniel]
	- names vs ordered arguments
	- default arguments
	- ...
	- ? writing functions programming principles: DRY	 [Daniel]

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
