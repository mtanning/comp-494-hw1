/**
 * This class represents 
 */
class Axis {
  static final color axisColor = 0;
  String name;
  float x;
  float minValue;
  float maxValue;
  float bottomValue;
  float topValue;
  boolean filtered;
  float filterMin;
  float filterMax;

  Axis(String name, float minValue, float maxValue) {
    this.name = name;
    this.minValue = minValue;
    this.maxValue = maxValue;
    this.bottomValue = minValue;
    this.topValue = maxValue;
  }
  
  //Filter axis by two 
  void filter(float y1, float y2) {
    if(y1>y2) {
      filterMin = max(mapYToValue(y1), minValue);
      filterMax = min(mapYToValue(y2), maxValue);
    } else {
      filterMin = max(mapYToValue(y2), minValue);
      filterMax = min(mapYToValue(y1), maxValue);
    }
    filtered = true;
  }
  
  //Inputs a y-coordinate, returns a float representing the value of that point on the axis
  float mapYToValue(float y) {
    return map(y, height-axesMarginBottom, axesMarginTop, bottomValue, topValue);
  }
  

  //Inputs a float, returns the y-coordinate where that value is located on the axis
  float mapValueToY(float value) {
    return map(value, bottomValue, topValue, height-axesMarginBottom, axesMarginTop);
  }
  
  
  
  void display() {
    float filterMinY = mapValueToY(filterMin);
    float filterMaxY = mapValueToY(filterMax);
    
    //Draw axis
    fill(0);
    stroke(axisColor);
    line(x, axesMarginTop, x, height-axesMarginBottom);
    
    if(filtered) {
      //Draw rectangle to represent filtered section of axis
      rectMode(CORNERS);
      fill(axisColor, 125);
      rect(x-5, filterMinY, x+5, filterMaxY);
      
      //Draw labels for filter min and max values
      fill(0);
      textAlign(CENTER, BOTTOM);
      text(filterMax, x, filterMaxY - 5);
      textAlign(CENTER, TOP);
      text(filterMin, x, filterMinY + 5);
    }
    
    //Draw axis title
    textAlign(CENTER, CENTER);
    textSize(14);
    text(name, x, 0.3*axesMarginTop);
    textSize(12);
    
    //Draw a label for maxValue at the top of the axis, or hide of the filter label intersects with it.
    if((!filtered) || (filterMaxY > axesMarginTop+10))
    {
      textAlign(CENTER, BOTTOM);
      text(nf(topValue), x, axesMarginTop-8);
    }
    
    //Draw a label for minValue at the bottom of the axis, or hide of the filter label intersects with it.
    if((!filtered) || (filterMinY < height-axesMarginBottom-10))
    {
      textAlign(CENTER, TOP);
      text(nf(bottomValue), x, height-axesMarginBottom+8);
    }
  }
}