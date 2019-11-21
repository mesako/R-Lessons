rm(list = ls())

# Getting Started with ggplot2
getwd()
setwd("/Users/melissako/Desktop")

# install.packages("ggplot2")
library(ggplot2)
library(datasets)

# Getting Help in R
help(getwd)
?getwd

# Working with Data
# Choose one of the following built-in datasets in R:
data()
# Common datasets include iris, PlantGrowth, USArrests

# Find out more about your dataset:
dim(mtcars) # how many measurements, how many parameters
colnames(mtcars) # what are the parameters
head(mtcars) # preview the data
?mtcars # look up documentation if available

# With a neighbor, brainstorm questions you
# have about the data.
### What do you want to figure out from this data?
### What visualizations (graphs/plots) can help
### you answer these questions?


# Basic Syntax of ggplot2
### Cheat Sheet: bit.ly/2QC8M9l
### What are the main components of the ggplot function?
?ggplot

# my.plot <- ggplot(df, aes(x = xcol, y = ycol)) 
# To establish ggplot, pass in your data and mappings.
# df must be a dataframe that contains all info.
# aes establishes axes, other aesthetics.

my.plot <- ggplot(mtcars, aes(x = mpg, y = qsec))
print(my.plot)
### What do you notice about this output?

# Plot only shows up after adding geom layers.
# you add geom layers with the syntax + "a geomfunction"
ggplot(mtcars, aes(x = mpg, y = qsec)) + geom_point() # scatterplot
print(my.plot)
### What is wrong with my.plot?
# need to do my.plot <- my.plot + geom_point()

my.plot <- ggplot(mtcars, aes(x = mpg, y = qsec)) + geom_point()
print(my.plot)

### What happens if we add a different geom?
my.plot <- ggplot(mtcars, aes(x = mpg, y = qsec)) + 
  geom_point() + geom_line() # line graph
print(my.plot)
# just adds layers on top so you see both scatterplot
# and the line graph

# Compare with:
ggplot(mtcars, aes(x = mpg, y = qsec)) + geom_line()
# no dots!

### What else can we fill in for aes?
# fill, group, label, color, shape, linetype
ggplot(mtcars, aes(x = mpg, y = qsec, color = "darkblue")) + 
  geom_point()
### What happens?

# color scheme that shows up in the aes mapping that sets up
# the whole ggplot is for when you want to color by a
# specific parameter in the data

ggplot(mtcars, aes(x = mpg, y = qsec)) + 
  geom_point(color = "darkblue") # can fill in other colors here

ggplot(mtcars, aes(x = mpg, y = qsec, color = cyl)) + 
  geom_point()
# What is the difference here? Discuss with a neighbor.

# With your own dataset, try to generate a scatterplot.

ggplot(mtcars, aes(x = mpg, y = qsec)) +
  geom_point(shape = 15) # all points is one shape

ggplot(mtcars, aes(x = mpg, y = qsec, shape = cyl)) + 
  geom_point()
### What happens?
# Discuss with your neighbor, how could you deal 
# with this issue?

ggplot(mtcars, aes(x = mpg, y = qsec,
                   shape = as.factor(cyl))) + 
  geom_point() # turn cyl into a factor (discrete options)

# With your own dataset, generate a scatterplot. Try to change
# some of the aesthetics (linetype, color, fill, shape) either by
# manually setting the value, or using a parameter in the data.


# Plot Customization
## Labels
my.plot + ggtitle("Practice")
my.plot + xlab("new x axis")
my.plot + ylab("new y axis")

# These functionally do the same thing:
my.plot + ggtitle("hi") + xlab("yo") + ylab("hey")
my.plot + labs(title = "Practice", x = "new x axis",
               y = "new y axis")

## Legends
my.plot <- ggplot(mtcars, aes(x = mpg, y = qsec,
                              color = as.factor(cyl))) + 
  geom_point()
my.plot # where does the legend appear?

my.plot + theme(legend.position = "bottom")
## Guess other positions that are acceptable besides "bottom"!
# Work with a partner to test which position labels work.

my.plot + guides(color = "none") # no legend shown

my.plot <- ggplot(mtcars, aes(x = mpg, y = qsec,
                              color = as.factor(cyl))) + 
  geom_point()
my.plot
# What would you want to change about this plot? Discuss with a neighbor.

my.plot <- my.plot + labs(color = "Cylinder")
# changes how the legend for color is labeled
my.plot

# One Dimensional Plot (One Variable)
## Discrete Variables
ggplot(mtcars, aes(gear)) + geom_bar() # bar plots
ggplot(mtcars, aes(cyl)) + geom_bar() # shows counts in group
### What is the issue here? Discuss with a neighbor.

ggplot(mtcars, aes(as.factor(cyl))) + geom_bar()
# so that the x-axis does not show numbers not used

## Continuous Variables
ggplot(mtcars, aes(x = mpg)) + 
  geom_histogram(binwidth = 5)
# Work with a neighbor to see what happens when 
# you change binwidth.

# binwidth controls resolution of the grouping

ggplot(mtcars, aes(x = mpg)) + 
  geom_density(kernel = "gaussian")

# Two Dimensional Plot (Two Variables)
## Discrete Variables
ggplot(mtcars, aes(x = gear, y = mpg)) + 
  geom_bar(stat = "identity") # barplot not showing counts

### What is this plot actually showing?
### What might be a more useful plot? Discuss with a neighbor.

ggplot(mtcars, aes(x = gear, y = mpg)) + 
  geom_bar(stat = "summary", fun.y = "median")
# this uses median within each group, instead of sum

ggplot(mtcars, aes(x = gear, y = mpg)) + geom_bar(stat = "summary", fun.y = "median")
# What would you want to see in this plot?

## Error Bars
# ggplot(df, aes(x,y)) + geom_bar(blahblah) + geom_errorbar()
# you could do this, but then you need to have pre-calculated
# the mean value for each group and the SE in your data

# these give the same barplot
ggplot(mtcars, aes(x = gear, y = mpg)) + 
  geom_bar(stat = "summary", fun.y = "mean")
ggplot(mtcars, aes(x = gear, y = mpg)) + 
  stat_summary(geom = "bar", fun.y = mean, 
               position = "dodge")

# same as above where we used geom_bar, just different semantics

# stat_summary can be used with other geoms besides barplots
ggplot(mtcars, aes(x = gear, y = mpg)) + 
  stat_summary(geom = "point", fun.y = mean, position = "identity")
ggplot(mtcars, aes(x = gear, y = mpg)) + 
  stat_summary(geom = "line", fun.y = mean, position = "identity")

ggplot(mtcars, aes(x = gear, y = mpg)) + 
  stat_summary(geom = "bar", fun.y = mean, 
               position = "dodge") +
  stat_summary(geom = "errorbar", fun.data = mean_se, 
               position = "dodge", width = 0.2) 

# What does mean_se do?
?mean_se

### Boxplots
ggplot(mtcars, aes(x = gear, y = mpg, group = gear)) + 
  geom_boxplot()
ggplot(mtcars, aes(x = cyl, y = mpg, group = cyl)) + 
  geom_boxplot()

### Violin plots
ggplot(mtcars, aes(x = cyl, y = mpg, group = cyl)) + 
  geom_violin(scale = "area") # there are other scale options

# With your own dataset, try to generate any of the plots we learned
# about: histogram, bar plot, box plot, or violin plot.


## Continuous Variables
# add a trend line or fit line to show pattern/correlation
my.plot <- ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()
my.plot

my.plot + geom_smooth(method = "lm") # linear model

my.plot <- ggplot(mtcars, aes(x = mpg, y = qsec)) + geom_point()
my.plot

my.plot + geom_smooth(method = "lm")
my.plot + geom_smooth(method = "loess") # local polynomial regression

my.plot <- ggplot(mtcars, aes(x = qsec, y = wt)) + geom_point()
my.plot

my.plot + geom_smooth(method = "lm")
my.plot + geom_smooth(method = "loess")

### Which smoothing method would you use and why?
### Discuss with a neighbor.


### Why no heatmaps?

# the built-in heatmap function meets many needs while the
# ggplot2 equivalent (geom_tile) can be confusing
# I don't recommend ggplot2 for heatmaps

# Saving Your Figures
ggplot(mtcars, aes(x = cyl, y = mpg)) + geom_point() +
  geom_smooth(method = "lm")
ggsave("plot.png", width = 5, height = 5)

# this will save wherever your directory is currently
# check with getwd() and change with setwd(DIFFERENT FOLDER)
# you can also provide a file path in the new file name
# ggsave("/Users/melissako/Downloads/plot.png", width = 5, height = 5)

pdf("mtcars_lm.pdf") # creates the file
# png() also works if you want a different file format
ggplot(mtcars, aes(x = cyl, y = mpg)) + geom_point() +
  geom_smooth(method = "lm")
dev.off() # finishes editing the file

# With your own dataset, choose one graph and try to save
# a png and a pdf file onto your computer using
# both methods of saving.


# Special Extras
## Custom Colors
install.packages("RColorBrewer")
library(RColorBrewer) # useful for other color palettes
# scale_fill_manual(values = c()) # manually specific the colors
# scale_fill_brewer(palette = "Blues") # generate new color options
# scale_fill_gradientn() for gradients with high to low
### replace fill with color or size
my.plot <- ggplot(mtcars, aes(x = qsec, y = mpg,
                   color = as.factor(gear))) + geom_point()
my.plot

my.plot + scale_color_brewer(palette = "Set1")
my.plot + scale_color_brewer(palette = "Pastel1")

my.plot <- ggplot(mtcars, aes(x = qsec, y = mpg, color = wt)) + 
  geom_point()
my.plot

my.plot + scale_colour_gradient(low = "blue", high = "yellow")

my.plot <- ggplot(mtcars, aes(x = qsec, y = mpg,
                              color = as.factor(gear))) + 
  geom_point()
my.plot

my.plot +
  scale_colour_manual(values = c("magenta", "yellow", "cyan"))

## Themes
# use built-in themes to change graph aesthetics
my.plot
my.plot + theme_bw()
my.plot + theme_classic()
my.plot + theme_minimal()

## Facets
ggplot(mtcars, aes(x = mpg, y = qsec)) + 
  geom_point() + facet_grid(. ~ cyl)

ggplot(mtcars, aes(x = mpg, y = qsec)) + 
  geom_point() + facet_grid(cyl ~ .)
### How do these results differ? Discuss with a neighbor.

ggplot(mtcars, aes(x = mpg, y = qsec)) + 
  geom_point() + facet_grid(gear ~ cyl)
### What happens when you supply a formula (gear ~ cyl) with two variables
### to facet grid? Discuss with a neighbor.

ggplot(mtcars, aes(x = mpg, y = qsec)) + geom_point() + facet_grid(. ~ carb)
ggplot(mtcars, aes(x = mpg, y = qsec)) + geom_point() + facet_grid(carb ~ .)
ggplot(mtcars, aes(x = mpg, y = qsec)) + geom_point() + facet_wrap(~ carb)
### What are the differences between these three layouts?

# Repeat this with your own chosen dataset.

