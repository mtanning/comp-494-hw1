/**
 * This class represents
 */
class TableReader {

  Table table;
  String sortedBy;
  
  float getMin(String columnName) {
    if(sortedBy != columnName) {
      sortTable(columnName);
    }
    return table.getFloat(0, columnName);
  }
  
  float getMax(String columnName) {
    if(sortedBy != columnName) {
      sortTable(columnName);
    }
    return table.getFloat(table.lastRowIndex(), columnName);
  }
  
  String[] getColumnTitles() {
    return table.getColumnTitles();
  }
  
  int getColumnType(String column) {
    return table.getColumnType(column);
  }
  
  Iterable<TableRow> getRows() {
    return table.rows();
  }
  
  void sortTable(String columnName) {
    table.sort(columnName);
    sortedBy = columnName;
  }
  
  //loads a file and uses it to create a Table object. 
  void readTable(String filename) {
    table = loadTable(filename, "header");
    
    //set column types based on the types written in 2nd row of tsv file, then remove that row from the table
    for(int j = 0; j<table.getColumnCount(); j++) {
      table.setColumnType(table.getColumnTitle(j), table.getString(0,j));
    }
    table.removeRow(0);
  }
}