

PFont font;
TableReader tablereader;
ArrayList<Item> items;
ArrayList<Axis> axes;

float axesMarginLeft;
float axesMarginRight;
float axesMarginTop;
float axesMarginBottom;

Axis selectedAxis;
Axis filteredAxis;
boolean mouseFiltering;
boolean mouseReordering;
float filterStart;
float filterEnd;

String filename;

import java.util.Collections;

void setup() {
  size(1600, 900, P2D); //<>//
  pixelDensity(displayDensity());
  font = createFont("Arial", 12);
  textFont(font); //<>//
  
  tablereader = new TableReader();
  
  loadFile("cars-cleaned.tsv"); //<>//
}

void loadFile(String path) {
  filename = path;
  tablereader.readTable(path);
  setupAxes();
  setupItems();
}

void keyPressed() {
  switch(key) {
  case '1': 
    loadFile("cars-cleaned.tsv");
    break;
  case '2':
    loadFile("cameras-cleaned.tsv");
    break;
  case '3':
    loadFile("nutrients-cleaned.tsv");
    break;
  }

}

//loads items from tablereader
void setupItems() {
  tablereader.sortTable(selectedAxis.name);
  items = new ArrayList<Item>();
  for(TableRow row : tablereader.getRows()) {
      Item item = new Item(row);
      items.add(item);
    }
}

void setupAxes() {
  axesMarginLeft = 0.05*width;
  axesMarginRight = 0.05*width;
  axesMarginTop = 0.07*height;
  axesMarginBottom = 0.05*height;
  axes = new ArrayList<Axis>();
  for(String column : tablereader.getColumnTitles()) {
    Integer type = tablereader.getColumnType(column);
    if(type.equals(Table.FLOAT)) {
      String attribute = column;
      float min = tablereader.getMin(column);
      float max = tablereader.getMax(column);
      Axis axis = new Axis(attribute, min, max);
      axes.add(axis);
    }
  }
  arrangeAxes();
  selectedAxis = axes.get(0);
}
  
//arrange axes horizontally
void arrangeAxes() {
  for(int i=0; i < axes.size(); i++) {
    float x = map(i,0,axes.size()-1,axesMarginLeft,width-axesMarginRight);
    axes.get(i).x = x;
  }
}

//Swaps the positions of two axes in the axes ArrayList. Then calls arrangeAxes() to refresh x-positions 
void swapAxes(Axis axis1, Axis axis2) {
  int i1 = axes.indexOf(axis1);
  int i2 = axes.indexOf(axis2);
  Collections.swap(axes, i1, i2);
  arrangeAxes();
}

void mousePressed() {
  //after pressing mouse, determine if mouse is over an axis, or over an axis title. This will determine
  //whether dragging the mouse will be used to filter the values of the axis, or if dragging will reposition
  //and reorder the axes
  
  filteredAxis = null;
  for(Axis axis : axes) {
    
    //Check if mouse is on an axis. 
    if( dist(mouseX,mouseY,axis.x,mouseY)<=20 &&
    mouseY >= axesMarginTop-10 &&
    mouseY <= height-axesMarginBottom+10)
    {
      //if axis was already filtered, clear the filter. Otherwise, begin filtering
      if(axis.filtered == true) { 
        axis.filtered = false;    
      } else {                   
        filteredAxis = axis;
        filterStart = mouseY;
        mouseFiltering = true;
      }
      break;
    } 
    
    else
    
    //If mouse is not on the axis, check if it is near an axis title. 
    if( mouseY < axesMarginTop-20 &&
    mouseX > axis.x-textWidth(axis.name)/2 && 
    mouseX < axis.x+textWidth(axis.name)/2)
    {
      selectedAxis = axis;
      mouseReordering = true;
      tablereader.sortTable(selectedAxis.name);
      setupItems();
      break;
    }
  }
}

void mouseReleased() {
    mouseFiltering = false;
    mouseReordering = false;
    arrangeAxes();
}


void mouseDragged() { 
  //This updates the position of an axis while its title is being dragged horizontally. If an
  //axis is dragged past one of its neighbor axes, the two axes will swap positions.
  if(mouseReordering) {
    selectedAxis.x = mouseX;
    Axis previousAxis;
    Axis nextAxis;
    int selectedAxisIndex = axes.indexOf(selectedAxis);
    
    //determine which axis (if any) is to the left of the one being reordered
    if(selectedAxisIndex != 0) {
      previousAxis = axes.get(selectedAxisIndex-1);
    } else {
      previousAxis = null;
    }
    
    //determine which axis (if any) is to the right of the one being reordered
    if(selectedAxisIndex != axes.size()-1) {
      nextAxis = axes.get(selectedAxisIndex+1);
    } else {
      nextAxis = null;
    }
    
    //if axis is dragged past another axis, swap them.
    if((previousAxis != null) && (mouseX < previousAxis.x )) {
      swapAxes(selectedAxis, previousAxis);
    } else if ((nextAxis != null) && (mouseX > nextAxis.x)) {
      swapAxes(selectedAxis, nextAxis);
    }
  }
 
  
  //Update the bounds of the filter
  else if(mouseFiltering) {
    filterEnd = mouseY;
    if(dist(mouseX,filterStart,mouseX,filterEnd) > 2) {
      filteredAxis.filter(filterStart, filterEnd);
    } else {
      filteredAxis.filtered = false;
    }
  }
}
  
void draw() { //<>//
  background(255);
  
  //draw items
  for(Item item: items) {
    if(!item.isFiltered()) {
      item.display();
    }
  }
   //<>//
  //draw axes
  for(Axis axis : axes) {
    axis.display();
  }
  
  //draw title of source file
  textAlign(LEFT, BOTTOM);
  text(filename, 2, height-2);
}