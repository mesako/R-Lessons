rm(list = ls())

# Getting Started with ggplot2
getwd()
setwd("/Users/melissako/Desktop")
# change this to your own file directory!

# uncomment and run this command if you haven't already
# install.packages("ggplot2")
library(ggplot2)
library(datasets)

# Practice using the reactions in Zoom!
# Go to the Participants panel in Zoom and select the checkmark.
# We will proceed when we get a quorum of checkmarks.

# You can use the other reactions to indicate how the workshop is going.

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

# My choice of dataset: ???
# Share in Zoom chat which dataset you have chosen!

##### BREAKOUT ROOM ACTIVITY #####
# With your group in your breakout room, brainstorm questions you
# have about the data. Be ready to share ideas in Zoom chat when you return!
### What do you want to figure out from this data?
### What visualizations (graphs/plots) can help you answer these questions?


# Basic Syntax of ggplot2
### Cheat Sheet: bit.ly/3lLPTxp
### What are the main components of the ggplot function?
?ggplot




# my.plot <- ggplot(df, aes(x = xcol, y = ycol)) 
# To establish ggplot, pass in your data and mappings.
# df must be a dataframe that contains all info.
# aes establishes axes, other aesthetics.

my.plot <- ggplot(mtcars, aes(x = mpg, y = qsec))
print(my.plot)
### What do you notice about this output?




ggplot(mtcars, aes(x = mpg, y = qsec)) + geom_point() # scatterplot
print(my.plot)
### What is wrong with my.plot and how do we fix it?





### What happens if we add a different geom?
my.plot <- ggplot(mtcars, aes(x = mpg, y = qsec)) + 
  geom_point() + geom_line() # line graph
print(my.plot)




##### INDIVIDUAL ACTIVITY #####
# Starting with the above command, change the code to use different 
# variables for the x and/or y axis.
# Post a checkmark reaction in Zoom when you are done with this task.

# Compare with:
ggplot(mtcars, aes(x = mpg, y = qsec)) + geom_line()
# What is different with this plot?




### What else can we fill in for aes?
# fill, group, label, color, shape, linetype
ggplot(mtcars, aes(x = mpg, y = qsec, color = "darkblue")) + 
  geom_point()
### What has happened in this figure?
# Type in Zoom chat what you notice.
  




ggplot(mtcars, aes(x = mpg, y = qsec)) + 
  geom_point(color = "darkblue") # can fill in other colors here

ggplot(mtcars, aes(x = mpg, y = qsec, color = cyl)) + 
  geom_point()

##### BREAKOUT ROOM ACTIVITY #####
# With your group in your breakout room, complete the following:
### What is the difference between the first and second figures above?
### With your own dataset, work together to generate a scatterplot.

ggplot(mtcars, aes(x = mpg, y = qsec)) +
  geom_point(shape = 15) 

ggplot(mtcars, aes(x = mpg, y = qsec, shape = cyl)) + 
  geom_point()
### What has happened in this last command?
# Answer in Zoom chat, how could you deal with this issue?




##### BREAKOUT ROOM ACTIVITY #####
# With your group in your breakout room, complete the following:
### Pick one aesthetic for each person to work on changing.
### Starting with the scatterplot you generated for your own dataset,
  # individually try to change your chosen aesthetic either by
  # manually setting the value, or using a parameter in the data.
#### Share your results with your group members!


# Plot Customization
## Labels
my.plot + ggtitle("Practice")
my.plot + xlab("new x axis")
my.plot + ylab("new y axis")

# These functionally do the same thing:
my.plot + ggtitle("hi") + xlab("yo") + ylab("hey")
my.plot + labs(title = "Practice", x = "new x axis",
               y = "new y axis")

##### INDIVIDUAL ACTIVITY #####
# Change the labels (title or axes) on a prior plot that you made.
# Post a checkmark reaction in Zoom when you are done with this task.




## Legends
my.plot <- ggplot(mtcars, aes(x = mpg, y = qsec,
                              color = as.factor(cyl))) + 
  geom_point()
my.plot 

my.plot + theme(legend.position = "bottom")
## Guess other positions that are acceptable besides "bottom"!
# Share in Zoom chat which position labels work after you test it.




my.plot + guides(color = "none") # no legend shown

my.plot <- ggplot(mtcars, aes(x = mpg, y = qsec,
                              color = as.factor(cyl))) + 
  geom_point()
my.plot
# What would you want to change about this plot?
# Share your ideas in Zoom chat.




my.plot <- my.plot + labs(color = "Cylinder")
my.plot

# One Dimensional Plot (One Variable)
## Discrete Variables
ggplot(mtcars, aes(gear)) + geom_bar() # bar plots
ggplot(mtcars, aes(cyl)) + geom_bar() # shows counts in group
### What is the issue here?




ggplot(mtcars, aes(as.factor(cyl))) + geom_bar()

## Continuous Variables
ggplot(mtcars, aes(x = mpg)) + 
  geom_histogram(binwidth = 5)
# Try to change the binwidth and describe your results in Zoom chat.




ggplot(mtcars, aes(x = mpg)) + 
  geom_density(kernel = "gaussian")

# Two Dimensional Plot (Two Variables)
## Discrete Variables
ggplot(mtcars, aes(x = gear, y = mpg)) + 
  geom_bar(stat = "identity") 

##### BREAKOUT ROOM ACTIVITY #####
# With your group in your breakout room, discuss the following:
### What is this plot (generated above) actually showing?
### What might be a more useful plot?




ggplot(mtcars, aes(x = gear, y = mpg)) + 
  geom_bar(stat = "summary", fun = "median")

ggplot(mtcars, aes(x = gear, y = mpg)) + geom_bar(stat = "summary", fun = "median")
# What would you want to see in this plot?




##### INDIVIDUAL ACTIVITY #####
# Create a barplot for your own dataset.
# Post a checkmark reaction in Zoom when you are done with this task.

## Error Bars
# ggplot(df, aes(x,y)) + geom_bar(blahblah) + geom_errorbar()
# you could do this, but then you need to have pre-calculated
# the mean value for each group and the SE in your data

# these give the same barplot
ggplot(mtcars, aes(x = gear, y = mpg)) + 
  geom_bar(stat = "summary", fun = "mean")
ggplot(mtcars, aes(x = gear, y = mpg)) + 
  stat_summary(geom = "bar", fun = mean, 
               position = "dodge")

# same as above where we used geom_bar, just different semantics

# stat_summary can be used with other geoms besides barplots
ggplot(mtcars, aes(x = gear, y = mpg)) + 
  stat_summary(geom = "point", fun = mean, position = "identity")
ggplot(mtcars, aes(x = gear, y = mpg)) + 
  stat_summary(geom = "line", fun = mean, position = "identity")

ggplot(mtcars, aes(x = gear, y = mpg)) + 
  stat_summary(geom = "bar", fun = mean, 
               position = "dodge") +
  stat_summary(geom = "errorbar", fun.data = mean_se, 
               position = "dodge", width = 0.2) 

##### INDIVIDUAL ACTIVITY #####
# Starting with the prior figure you generated, try to change the code
# in order to display an errorbar on your barplot.
# Post a checkmark reaction in Zoom when you are done with this task.


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

##### BREAKOUT ROOM ACTIVITY #####
# With your group in your breakout room, discuss the following:
### Divvy up the different kinds of plots we just learned about:
  # histogram, bar plot, box plot, or violin plot.
### Work on generating your assigned plot for your chosen dataset.
#### Share your results with your group members!




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
### Share your opinion in Zoom chat.




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

##### INDIVIDUAL ACTIVITY #####
# With your own dataset, choose one graph and try to save
# a png and a pdf file onto your computer using both methods to save.
# Post a checkmark reaction in Zoom when you are done with this task.


# Special Extras
## Custom Colors
# install.packages("RColorBrewer")
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
### How do these results differ?




ggplot(mtcars, aes(x = mpg, y = qsec)) + 
  geom_point() + facet_grid(gear ~ cyl)
### What happens when you supply a formula (gear ~ cyl) with two variables
### to facet grid?




ggplot(mtcars, aes(x = mpg, y = qsec)) + geom_point() + facet_grid(. ~ carb)
ggplot(mtcars, aes(x = mpg, y = qsec)) + geom_point() + facet_grid(carb ~ .)
ggplot(mtcars, aes(x = mpg, y = qsec)) + geom_point() + facet_wrap(~ carb)
### What are the differences between these three layouts?





##### BREAKOUT ROOM ACTIVITY #####
# With your group in your breakout room, complete the following:
### Work together to change one of your prior figures to use custom colors.
### Work together to change one of your prior figures to use a different theme.
### Work together to get one of the faceting methods to work on your dataset.

