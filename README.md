# Parallel Coordinates Visualization
###### Comp 494: HW1

Micah Tanning

## User's Manual
#####  Load file:
This program can load three different files: **cars-cleaned.tsv**, **cameras-cleaned.tsv**, and **nutrients-cleaned.tsv**. Each is available in the data folder.
<br>To switch between them, Press **1**, **2**, or **3**, respectively. By default when the program is run, cars-cleaned.tsv is loaded.
##### Reordering axes:
To reorder an axis, click on an axis title and drag it to the left or right.
##### Filtering axes:
To filter data on an axis, click on a point on the axis, then drag up or down. A box will appear and show the range of this filter. Any items with data on the axis outside this filter will no longer be displayed. You can create one filter on each of the available axes.

To clear the filter on any axis, click on the axis again.


## Design

While designing this Parallel Coordinates plot, my primary goal was to create a simple, readable, and intuitive sketch. My initial sketches and prototype had fairly standard features and not much more. I drew a line of vertical axes across the screen using thin black lines on a solid white background, and I labeled the titles and upper/lower bounds of each axis, as well as tick marks. Lastly I drew the connecting lines of each item across the axes.

For interactivity, I planned to implement only the two main required features - filtering and reordering, by using vertical and horizontal mouse dragging. I drew and explained these features in the attached sketches, and they work in the final implementation very closely to how I originally planned.

The final version ended up looking and functioning very similarly to the prototype. Once significant change I made was adding color to each line. I wanted to use a dark color, so that they would stand out against the white background. In order to differentiate each line, especially overlapping ones, I made each line slightly transparent, and the color of each one was also changed along a gradient, based on where the line was placed along a certain axis. Whichever axis was moved most recently is the one that is used to determine the color. This feature also helps the user to follow the paths of individual lines across the entire plot.

Another change I made was removing the tick marks and their labels along each axis. I included them in an early implementation, but they added a lot of clutter and and made it more difficult to view the lines behind them. I didn't think they were very important to keep, especially since you can already see values along each axis while filtering.

Given more time, I would have liked to add some more features, including inverting and hiding axes. I also would have liked to allow the user to highlight an item and see a more detailed view of its data with text, including its name, model, or any other important String attributes. I also considered adding axes for each String attribute, but chose not to include them because this data is not ordered.


## Sketches
original prototype:
![sketch1](sketch1.jpg?raw=true)

with filters:
![sketch2](sketch2.jpg?raw=true)

with reordered axes:
![sketch3](sketch3.jpg?raw=true)

#### Screenshots of final implementation

view on startup:
![screenshot1](screenshot1.png?raw=true)

filtered axes:
![screenshot2](screenshot2.png?raw=true)
