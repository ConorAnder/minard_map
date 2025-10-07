
void setup() {
  fullScreen();
  background(255, 255, 255);
  
  Table data = loadTable("minard_data.csv", "header");
  println(data.getRowCount() + " total rows in table");
  
  // There are three different blocks of information in the csv:
  // Cities ->
  float[] city_longs = getFloats(data, 20, "LONC");
  float[] city_lats = getFloats(data, 20, "LATC");
  String[] city_names = getStrings(data, 20, "CITY");
  
  // Temperature ->
  float[] temp_longs = getFloats(data, 9, "LONT");
  float[] temp = getFloats(data, 9, "TEMP");
  float[] temp_days = getFloats(data, 9, "DAYS");
  float[] temp_month = getFloats(data, 9, "MON");
  float[] temp_day = getFloats(data, 9, "DAY");
  
  // Survivors ->
  float[] surv_longs = getFloats(data, data.getRowCount(), "LONP");
  float[] surv_lats = getFloats(data, data.getRowCount(), "LATP");
  float[] surv_count = getFloats(data, data.getRowCount(), "SURV");
  String[] surv_dir = getStrings(data, data.getRowCount(), "DIR");
  float[] surv_div = getFloats(data, data.getRowCount(), "DIV");
  
  plotMapPoints(city_longs, city_lats);
  plotCityNames(city_names, city_longs, city_lats);
  plotTestPointsAdvance(surv_longs, surv_lats, surv_count, surv_dir);
  
}

float[] getFloats(Table data, int size, String column) {
  float[] f = new float[size];
  for(int i = 0; i < size; i++) {
    f[i] = data.getFloat(i, column);
  }
  return f;
}

String[] getStrings(Table data, int size, String column) {
  String[] cities = new String[size];
  for(int i = 0; i < size; i++) {
    cities[i] = data.getString(i, column);
  }
  return cities;
}

void plotMapPoints(float[] longs, float[] lats) {
  fill(0);
  noStroke();
  for (int i = 0; i < 20; i++) {
    float x = map(longs[i], min(longs), max(longs), 100, width - 100);
    float y = map(lats[i], min(lats), max(lats), height - 100, 100);
    //println(x + " " + y);
    ellipse(x, y, 6, 6);
  }
}

void plotCityNames(String[] names, float[] longs, float[] lats) {
  for(int i = 0; i < 20; i++) {
    float x = map(longs[i], min(longs), max(longs), 100, width - 100);
    float y = map(lats[i], min(lats), max(lats), height - 100, 100);
    
    fill(255, 0, 0);
    textSize(10);
    textAlign(CENTER);
    text(names[i], x, y - 10);
  }
}

void plotTestPointsAdvance(float[] longs, float[] lats, float[] count, String[] dir) {
  for(int i = 0; i < 48; i++) {
    if(dir[i].contains("A")) {
      float x = map(longs[i], min(longs), max(longs), 100, width - 100);
      float y = map(lats[i], min(lats), max(lats), height - 100, 100);
      float size = map(count[i], min(count), max(count), 6, 50);
      fill(0, 0, 255);
      noStroke();
      ellipse(x, y, size, size);
    }
  }
}
