/**
 * This class represents 
 */
class Item {
  color lineColor;
  TableRow row;
  String name;
  boolean visible = true;
  FloatDict attributes = new FloatDict();
  PShape line;
  
  Item(TableRow row) {
    this.row = row;
    for(int i=0; i<row.getColumnCount(); i++) {
      String attribute = row.getColumnTitle(i);
      Integer type = row.getColumnType(i);
      if(attribute.equals("name") && type.equals(Table.STRING)) {
        name = row.getString(i);
      } else if(type.equals(Table.FLOAT)) {
        float value = row.getFloat(i);
        attributes.set(attribute, value);
      }
    }
  }
  
  void setColor() {
    color colorMin   = #87b2ba;
    color colorMax   = #00344d;
    float attributeValue = attributes.get(selectedAxis.name);
    float interColorMapping = map(attributeValue, selectedAxis.minValue, selectedAxis.maxValue, 0, 1);
    lineColor = lerpColor(colorMin, colorMax, interColorMapping);
  }
  
  boolean isFiltered() {
    for(Axis axis : axes) {
      if(axis.filtered) {
        float attributeValue = attributes.get(axis.name);
        if((attributeValue > axis.filterMax) || (attributeValue < axis.filterMin)) {
          return true;
        }
      }
    }
    return false;
  }
  
  
  void display() {
    setColor();
    //draw a line segment between each axis
    for(int i=0; i<axes.size()-1; i++) {
      String attribute1 = axes.get(i).name;
      float value1 = attributes.get(attribute1);
      String attribute2 = axes.get(i+1).name;
      float value2 = attributes.get(attribute2);
      float x1 = axes.get(i).x;
      float x2 = axes.get(i+1).x;
      float y1 = axes.get(i).mapValueToY(value1);
      float y2 = axes.get(i+1).mapValueToY(value2);
      stroke(lineColor, 175);
      line(x1, y1, x2, y2);
    }   
  }
}