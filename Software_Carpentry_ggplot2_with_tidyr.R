rm(list = ls())

# Getting Started with ggplot2
getwd()
setwd("/Users/melissako/Desktop")
# change this to your own file directory!

library(tidyverse)

# Practice using the reactions in Zoom!
# Go to the Participants panel in Zoom and select the checkmark.
# We will proceed when we get a quorum of checkmarks.

# You can use the other reactions to indicate how the workshop is going.

# Getting Help in R
help(getwd)
?getwd

# Working with Data
# You can see built-in datasets in R:
data()

# Find out more about today's dataset:
?msleep # look up documentation if available
dim(msleep) # how many measurements, how many parameters
colnames(msleep) # what are the parameters
head(msleep) # preview the data


##### BREAKOUT ROOM ACTIVITY #####
# With your group in your breakout room, brainstorm questions you
# have about this data. Be ready to share ideas in Zoom chat when you return!
### What do you want to figure out from this data?
### What visualizations (graphs/plots) can help you answer these questions?

### Types of visualizations we might use:




# Basic Syntax of ggplot2
### Cheat Sheet: RStudio Help => Cheatsheets => Data visualization with ggplot2
### What are the main components of the ggplot function?
?ggplot




# my.plot <- ggplot(df, aes(x = xcol, y = ycol)) 
# To establish ggplot, pass in your data and mappings.
# df must be a dataframe that contains all info.
# aes establishes axes, other aesthetics.

my.plot <- ggplot(msleep, aes(x = brainwt, y = sleep_total))
print(my.plot)
### What do you notice about this output?




my.plot <- ggplot(msleep, aes(x = brainwt, y = sleep_rem)) + geom_point() # scatterplot
my.plot

# we may want to transform/scale certain variables before visualizing
msleep2 <- msleep %>% mutate(brainwt_log = log(brainwt))
ggplot(msleep2, aes(x = brainwt_log, y = sleep_rem)) + geom_point()

### What happens if we add a different geom?
my.plot <- ggplot(msleep2, aes(x = brainwt_log, y = sleep_rem)) + 
  geom_point() + geom_line() # line graph
print(my.plot)

ggplot(msleep2, aes(x = brainwt_log, y = sleep_rem)) + geom_line()


##### INDIVIDUAL ACTIVITY #####
# Starting with the above command, change the code to use different 
# variables for the x and/or y axis.
# Post a checkmark reaction in Zoom when you are done with this task.




### What else can we fill in for aes?
# fill, group, label, color, shape, linetype
ggplot(msleep2, aes(x = brainwt_log, y = sleep_rem, color = "darkblue")) + 
  geom_point()
### What has happened in this figure?
# Type in Zoom chat what you notice.





ggplot(msleep2, aes(x = brainwt_log, y = sleep_rem)) + 
  geom_point(color = "darkblue") # can fill in other colors here


##### BREAKOUT ROOM ACTIVITY #####
# With your group in your breakout room, complete the following:
### What is the difference between the first and second figures above?
### With your own choice of variables, generate a scatterplot.

ggplot(msleep2, aes(x = brainwt_log, y = sleep_rem)) +
  geom_point(shape = 15) 

ggplot(msleep2, aes(x = brainwt_log, y = sleep_rem, shape = vore)) + 
  geom_point()



##### BREAKOUT ROOM ACTIVITY #####
# With your group in your breakout room, complete the following:
### Pick one aesthetic for each person to work on changing.
### Starting with the scatterplot you generated for this dataset,
# individually try to change your chosen aesthetic either by
# manually setting the value, or using a parameter in the data.
#### Share your results with your group members!

# Try varying these kinds of aesthetics for this dataset!
# fill, group, label, color, shape, linetype


# One Dimensional Plot (One Variable)
## Discrete Variables
ggplot(msleep2, aes(vore)) + geom_bar() # bar plots
ggplot(msleep2, aes(conservation)) + geom_bar() # shows counts in group

## Continuous Variables
ggplot(msleep2, aes(x = awake)) + 
  geom_histogram(binwidth = 1)
# Try to change the binwidth and describe your results in Zoom chat.




ggplot(msleep2, aes(x = awake)) + 
  geom_density(kernel = "gaussian")

# Two Dimensional Plot (Two Variables)
## Discrete Variables
ggplot(msleep2, aes(x = vore, y = awake)) + 
  geom_bar(stat = "identity") 

##### BREAKOUT ROOM ACTIVITY #####
# With your group in your breakout room, discuss the following:
### What is this plot (generated above) actually showing?
### What might be a more useful plot?



ggplot(msleep2, aes(x = vore, y = awake)) + 
  geom_bar(stat = "summary", fun = "median")

##### INDIVIDUAL ACTIVITY #####
# Create a barplot for your own dataset.
# Post a checkmark reaction in Zoom when you are done with this task.
# What would you want to see in this plot?




## Error Bars
# ggplot(df, aes(x,y)) + geom_bar(blahblah) + geom_errorbar()
# you could do this, but then you need to have pre-calculated
# the mean value for each group and the SE in your data

feeding.data <- msleep2 %>% group_by(vore) %>% 
  summarize(mean_se(awake))
feeding.data

# What does mean_se do?
?mean_se
# y is the mean
# ymin is mean - one SE
# ymax is mean + one SE

ggplot(feeding.data, aes(x = vore, y = y)) + 
  geom_bar(stat = "identity")

ggplot(feeding.data, aes(x = vore, y = y)) + 
  geom_bar(stat = "identity") + 
  geom_errorbar(aes(ymin = ymin, ymax = ymax),
                width = 0.2)


##### INDIVIDUAL ACTIVITY #####
# Starting with the prior figure you generated, try to change the code
# in order to display an errorbar on your barplot.
# Post a checkmark reaction in Zoom when you are done with this task.



### Boxplots
ggplot(msleep2, aes(x = vore, y = awake, group = vore)) + 
  geom_boxplot()

### Violin plots
ggplot(msleep2, aes(x = vore, y = awake, group = vore)) + 
  geom_violin(scale = "area") # there are other scale options

##### BREAKOUT ROOM ACTIVITY #####
# With your group in your breakout room, discuss the following:
### Divvy up the different kinds of plots we just learned about:
# histogram, bar plot, box plot, or violin plot.
### Work on generating your assigned plot for this dataset.
#### Share your results with your group members!




## Continuous Variables
# add a trend line or fit line to show pattern/correlation
ggplot(msleep2, aes(x = brainwt, y = bodywt)) + 
  geom_point()

ggplot(msleep2, aes(x = brainwt_log, y = bodywt)) + 
  geom_point()

msleep3 <- msleep2 %>% mutate(bodywt_log = log(bodywt))

my.plot <- ggplot(msleep3, aes(x = brainwt_log, y = bodywt_log)) + 
  geom_point()
my.plot

my.plot + geom_smooth(method = "lm") # linear model

my.plot <- ggplot(msleep2, aes(x = brainwt_log, y = sleep_rem)) + 
  geom_point()
my.plot

my.plot + geom_smooth(method = "lm") # linear fit
my.plot + geom_smooth(method = "loess") # local polynomial regression

### How would you pick which smoothing method to use?
### Share your opinion in Zoom chat.




### Why no heatmaps?

# the built-in heatmap function meets many needs while the
# ggplot2 equivalent (geom_tile) can be confusing
# I don't recommend ggplot2 for heatmaps


# Plot Customization
## Labels
# These functionally do the same thing:
my.plot + ggtitle("hi") + xlab("yo") + ylab("hey")
my.plot + labs(title = "Practice", x = "new x axis",
               y = "new y axis")

##### INDIVIDUAL ACTIVITY #####
# Change the labels (title or axes) on a prior plot that you made.
# Post a checkmark reaction in Zoom when you are done with this task.




## Legends
my.plot <- ggplot(msleep2, aes(x = brainwt_log, 
                               y = sleep_rem, 
                               color = vore)) + 
  geom_point()
my.plot 

my.plot + theme(legend.position = "bottom")
## Guess other positions that are acceptable besides "bottom"!
# Share in Zoom chat which position labels work after you test it.




my.plot + guides(color = "none") # no legend shown

my.plot <- ggplot(msleep2, aes(x = brainwt_log, 
                               y = sleep_rem, 
                               color = vore)) + 
  geom_point()

my.plot + labs(color = "Feeding Behavior") # change legend label


# Saving Your Figures
ggplot(msleep3, aes(x = brainwt_log, y = bodywt_log)) + geom_point() +
  geom_smooth(method = "lm")
ggsave("plot.png", width = 5, height = 5)

# this will save wherever your directory is currently
# check with getwd() and change with setwd(DIFFERENT FOLDER)
# you can also provide a file path in the new file name
# ggsave("/Users/melissako/Downloads/plot.png", width = 5, height = 5)

pdf("msleep_body_brain_wt_lm.pdf") # creates the file
# png() also works if you want a different file format
ggplot(msleep3, aes(x = brainwt_log, y = bodywt_log)) + geom_point() +
  geom_smooth(method = "lm")
dev.off() # finishes editing the file

##### INDIVIDUAL ACTIVITY #####
# Choose one figure that you created for this data to save as
# a png and a pdf file onto your computer using both methods to save.
# Post a checkmark reaction in Zoom when you are done with this task.




##### INDIVIDUAL ACTIVITY #####
# Apply ggplot2 to a new dataset!
# Pick ONE of the following new datasets to explore:
# iris, infert, midwest, diamonds

# Practice:
# identifying a research question => 
# processing and visualizing the data =>
# interpreting findings to answer your research question!





##### EXTRA CONTENT #####

## Custom Colors
# install.packages("RColorBrewer")
library(RColorBrewer) # useful for other color palettes
# scale_fill_manual(values = c()) # manually specific the colors
# scale_fill_brewer(palette = "Blues") # generate new color options
# scale_fill_gradientn() for gradients with high to low
### replace fill with color or size
my.plot <- ggplot(msleep3, aes(x = brainwt_log, 
                               y = sleep_rem, 
                               color = vore)) + 
  geom_point()
my.plot

my.plot + scale_color_brewer(palette = "Set1")
my.plot + scale_colour_manual(values = c("magenta", "yellow", 
                                         "cyan", "green"))

my.plot <- ggplot(msleep3, aes(x = brainwt_log, 
                               y = sleep_rem, 
                               color = sleep_total)) + 
  geom_point()
my.plot

my.plot + scale_colour_gradient(low = "blue", high = "yellow")

## Themes
# use built-in themes to change graph aesthetics
my.plot
my.plot + theme_bw()
my.plot + theme_classic()
my.plot + theme_minimal()

## Facets
ggplot(msleep3, aes(x = brainwt_log, 
                    y = sleep_rem)) + 
  geom_point() + facet_grid(. ~ vore)

ggplot(msleep3, aes(x = brainwt_log, 
                    y = sleep_rem)) + 
  geom_point() + facet_grid(vore ~ .)
### How do these results differ?




ggplot(msleep3, aes(x = brainwt_log, 
                    y = sleep_rem)) + 
  geom_point() + facet_grid(vore ~ conservation)
### What happens when you supply a formula 
### (vore ~ conservation) with two variables
### to facet grid?




my.plot <- ggplot(msleep3, aes(x = brainwt_log, 
                              y = sleep_rem)) + geom_point()
my.plot + facet_grid(. ~ conservation)
my.plot + facet_grid(conservation ~ .)
my.plot + facet_wrap(~ conservation)
### What are the differences between these three layouts?


##### CHALLENGE ACTIVITY #####
# Make the ugliest ggplot2!
### Code from Emily Riederer (https://github.com/emilyriederer)

### sample data for plot
my.data <- data.frame(x = rep(1:10,3), 
                      y = rep(1:10,3), 
                      z = sort(rep(letters[1:2], 15)),
                      w = rep(letters[3:4], 15))

### how to use many theme options in ggplot2
# Adapt this code to make the ugliest ggplot2 you can!
# Try changing the options called for color, placement, text, and more!
ggplot(data = points, 
       mapping = aes(x = x, y = y, col = factor(x))) + 
  geom_point(size = 3) + 
  facet_grid(w ~ z, switch = "y") +
  theme(
    plot.background = element_rect(fill = "grey"),
    plot.title = element_text(size = 15, hjust = 0),
    plot.subtitle = element_text(size = 10, hjust = 0, color = "black", face = "italic"),
    plot.caption = element_text(size = 5, face = "bold", angle = 0),
    
    panel.background = element_rect(fill = "white", colour = "grey", size = 1),
    panel.border = element_rect(fill = NA, color = "black", size = 1),
    panel.grid.major.x = element_line(color = "black", linetype = 1),
    panel.grid.minor.x = element_line(color = "grey", linetype = 1),
    panel.grid.major.y = element_line(color = "black", linetype = 1),
    panel.grid.minor.y = element_blank(),
    
    axis.title.x = element_text(color = "black"),
    axis.title.y = element_text(family = "sans", face = "bold", size = 10, hjust = 0),
    axis.text = element_text(face = "bold", size = 5),
    axis.text.x.bottom = element_text(angle = 0), # note that axis.text options from above are inherited
    
    strip.background = element_rect(fill = "grey"),
    strip.text.y = element_text(color = "black"),
    strip.placement = "outside",
    
    legend.background = element_rect(fill = "white"), # generally will want to match w plot background
    legend.key = element_rect(fill = "grey"),
    legend.direction = "vertical",
    legend.position = "right",
    legend.justification = "left",
    legend.title = element_text(family = "sans", color = "black"),
    legend.text = element_text(family = "sans", face = "bold", color = "black")
  ) +
  labs(title = "test title",
       subtitle = "test subtitle",
       x = "my x axis",
       y = "my y axis",
       caption = "this is a caption",
       col = "Renamed Legend") 
