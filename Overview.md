Below is an initial stab at content for the R section. Mitch and I will meet to discuss more, but let me know if you have any further feedback.

Monday:

- intro to R and Rstudio [Mitch]
	- console vs script
	- R and Rmd files
	- environment variables
	- packages
	- objects
		- class: integer, character, vector, data.frame, list (CO2)
		- where are they
		- Saving: rds, Rdata, Rhistory
	- don't: Rdata, attach/detach
	- errors and warnings
	- workflow strategy --> run chunks, check
		- not line by line
- pathname, working directories and projects [Daniel]
	- read_csv
	- write_csv

(data: Angela plant height)

Tuesday:

- intro to tidyverse [Daniel]
		- focus on data.frames (tibbles)
    - base vs tidyverse
    - why tidyverse
- loading and manipulating data [Daniel]
	- readr
	- dplyr
	- pipe
	- group_by
	- summarise
	- broom
- plotting with ggplot  [Mitch]
   - data structure (data frame, not vector)
   - geom_point, geom_boxplot
   - axis labelling, log transform axis
   - facet grid (Data: CO2 data plant growth CO2 )

Wednesday

- ggplot2 [Mitch]
  - geom_smooth <-> lm
  - geom_point, geom_abline, 
	- adding predicted data to ggplots
	- ggplotly (interactive)

- using and writing functions in R [Daniel]
	- names vs ordered arguments
	- default arguments
	- ...
- programming principles: DRY	 [Daniel]

Thursday:

- Intro to R packages - where, how [Mitch]
	- finding, installing, versions
	- vigenttes, tutorials, help
	- cran vs github
- Getting help: stackoverflow, MWEs [Mitch]
- Reproducible workflows [Daniel]
	- Projects, end to end
	- Rmd: notebooks vs knitr reports
	- version control (overview)
- Future: [Both]
	- style 
		- paradigms
		- Rstudio
		- ropensci / tidyverse
	- programming: when, how
