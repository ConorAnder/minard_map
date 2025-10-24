import java.text.NumberFormat;

int left_border_map, right_border_map, top_border_map, bottom_border_map;
color back_ground = color(245, 240, 225);
color advance = color(196, 78, 82);
color retreat = color(76, 114, 176);
color city_colour = color(59, 59, 59);
color cold = color(140, 180, 210);
color warm = color(80, 60, 130);
PFont main_font;

void setup() {
  // Window size and borders
  size(1500, 750);
  background(back_ground);
  left_border_map = 150;
  right_border_map = width - 150;
  bottom_border_map = 3 * (height - 100) / 5;
  top_border_map = 100;

  // Insert data from csv into a table
  Table data = loadTable("minard_data.csv", "header");

  // Font
  main_font = createFont("Garamond", 30);
  
  // There are three different blocks of information in the csv:
  // Cities ->
  float[] city_longs = getFloats(data, 20, "LONC");
  float[] city_lats = getFloats(data, 20, "LATC");
  String[] city_names = getStrings(data, 20, "CITY");
  
  // Temperature ->
  float[] temp_longs = getFloats(data, 9, "LONT");
  float[] temp = getFloats(data, 9, "TEMP");
  String[] temp_month = getStrings(data, 9, "MON");
  float[] temp_day = getFloats(data, 9, "DAY");
  
  // Survivors ->
  float[] surv_longs = getFloats(data, data.getRowCount(), "LONP");
  float[] surv_lats = getFloats(data, data.getRowCount(), "LATP");
  float[] surv_count = getFloats(data, data.getRowCount(), "SURV");
  String[] surv_dir = getStrings(data, data.getRowCount(), "DIR");
  float[] surv_div = getFloats(data, data.getRowCount(), "DIV");
  
  // Need all coords to keep mapping consistent
  float[] all_longs = concat(concat(city_longs, surv_longs), temp_longs);
  float[] all_lats = concat(city_lats, surv_lats);
  
  // Sort all survivor data points by survivor count
  ArrayList<survCoord> coords = getCoords(surv_longs, surv_lats, surv_count, surv_dir, surv_div);
  coords.sort((a, b) -> Float.compare(b.count, a.count));

  // Plotting
  plotAdvances(coords, surv_count, all_longs, all_lats, 1);
  plotAdvances(coords, surv_count, all_longs, all_lats, 2);
  plotAdvances(coords, surv_count, all_longs, all_lats, 3);
  plotRetreats(coords, surv_count, all_longs, all_lats, 1);
  plotRetreats(coords, surv_count, all_longs, all_lats, 2);
  plotRetreats(coords, surv_count, all_longs, all_lats, 3);
  plotMapPoints(city_longs, city_lats, all_longs, all_lats);
  plotCityNames(city_names, city_longs, city_lats, all_longs, all_lats);
  plotAdvanceNums(coords, all_longs, all_lats);
  plotRetreatNums(coords, all_longs, all_lats);
  plotTempLines(temp_longs, all_longs);
  plotTempGrad(temp_longs, all_longs, temp, temp_day, temp_month);
  plotLegend();
  plotTitle();
  plotScale(all_longs);
  save("minard.png");
}
