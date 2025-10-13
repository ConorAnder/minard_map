
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
  // plotTestPointsAdvance(surv_longs, surv_lats, surv_count, surv_dir);
  
  
  FloatList div_1_adv = new FloatList();
  IntList ints = new IntList();
  for (int it = 0; it < data.getRowCount(); it++) {
    if(surv_dir[it].contains("A") && surv_div[it] == 1.0) {
      div_1_adv.append(surv_count[it]);
      ints.append(it);
      print("Appending " + str(surv_count[it]) + "\n");
    }
  }
  div_1_adv.sort();
  for (int i = 0; i < div_1_adv.size(); i++) {
    print(div_1_adv.get(i));
    print(" ");
    print(ints.get(i));
    print("\n");
  }
}
