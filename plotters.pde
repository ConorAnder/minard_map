void plotMapPoints(float[] longs, float[] lats, float[] all_longs, float[] all_lats) {
  fill(city_colour);
  noStroke();
  for (int i = 0; i < 20; i++) {
    float x = map(longs[i], min(all_longs), max(all_longs), left_border, right_border);
    float y = map(lats[i], min(all_lats), max(all_lats), bottom_border, top_border);
    //println(x + " " + y);
    ellipse(x, y, 6, 6);
  }
}

void plotCityNames(String[] names, float[] longs, float[] lats, float[] all_longs, float[] all_lats) {
  for(int i = 0; i < 20; i++) {
    float x = map(longs[i], min(all_longs), max(all_longs), left_border, right_border);
    float y = map(lats[i], min(all_lats), max(all_lats), bottom_border, top_border);
    
    fill(city_colour);
    textSize(10);
    textAlign(CENTER);
    text(names[i], x, y - 10);
  }
}

void plotMainAdvance(ArrayList<survCoord> coords, float[] surv_count, float[] all_longs, float[] all_lats) {
  stroke(advance);
  noFill();
  for (int i = 0; i < coords.size() - 1; i++) {
    if (coords.get(i).direction.contains("A") && coords.get(i).division == 1) {
      int line_thickness = int(map(coords.get(i).count, min(surv_count), max(surv_count), 5, 100));
      strokeWeight(line_thickness);
      int x1 = int(map(coords.get(i).longitude, min(all_longs), max(all_longs), left_border, right_border));
      int y1 = int(map(coords.get(i).latitude, min(all_lats), max(all_lats), bottom_border, top_border));
      int x2 = int(map(coords.get(i+1).longitude, min(all_longs), max(all_longs), left_border, right_border));
      int y2 = int(map(coords.get(i+1).latitude, min(all_lats), max(all_lats), bottom_border, top_border));
      line(x1, y1, x2 + 5, y2);
    }
  }
}

void plotAdvances(ArrayList<survCoord> coords, float[] surv_count, float[] all_longs, float[] all_lats, int div) {
  stroke(advance);
  noFill();
  ArrayList<survCoord> sub_array = new ArrayList<survCoord>();
  ArrayList<survCoord> sub_array_retreats = new ArrayList<survCoord>();

  for (survCoord data_point : coords) {
    if (int(data_point.division) == div && data_point.direction.contains("A")) {
      sub_array.add(data_point);
      print("Added data point in division " + str(data_point.division) + "\n");
    }
    if (int(data_point.division) == div && data_point.direction.contains("R")) {
      sub_array_retreats.add(data_point);
    }
  }
    
  // Add in first R value as A to connect lines seemlessly
  sub_array_retreats.sort((a, b) -> Float.compare(b.count, a.count));
  sub_array.add(sub_array_retreats.get(0));
    
  for (int i = 0; i < sub_array.size() - 1; i++) {
    print("Current data point direction is " + sub_array.get(i).direction + " and is in division " + str(sub_array.get(i).division) + "\n");
    int line_thickness = int(map(sub_array.get(i).count, min(surv_count), max(surv_count), 5, 100));
    strokeWeight(line_thickness);
    int x1 = int(map(sub_array.get(i).longitude, min(all_longs), max(all_longs), left_border, right_border));
    int y1 = int(map(sub_array.get(i).latitude, min(all_lats), max(all_lats), bottom_border, top_border));
    int x2 = int(map(sub_array.get(i+1).longitude, min(all_longs), max(all_longs), left_border, right_border));
    int y2 = int(map(sub_array.get(i+1).latitude, min(all_lats), max(all_lats), bottom_border, top_border));
    print("Plotting point at " + str(x1) + ", " + str(y1) + " to " + str(x2) + ", " + str(y2) + " in division " + str(sub_array.get(i).division) + "\n");
    line(x1, y1, x2, y2);
  }

  sub_array.clear();
  sub_array_retreats.clear();
}

void plotRetreats(ArrayList<survCoord> coords, float[] surv_count, float[] all_longs, float[] all_lats, int div) {
  stroke(retreat);
  noFill();
  ArrayList<survCoord> sub_array = new ArrayList<survCoord>();

  for (survCoord data_point : coords) {
    if (int(data_point.division) == div && data_point.direction.contains("R")) {
      sub_array.add(data_point);
      print("Added data point in division " + str(data_point.division) + "\n");
    }
  }
    
  for (int i = 0; i < sub_array.size() - 1; i++) {
    print("Current data point direction is " + sub_array.get(i).direction + " and is in division " + str(sub_array.get(i).division) + "\n");
    int line_thickness = int(map(sub_array.get(i).count, min(surv_count), max(surv_count), 5, 100));
    strokeWeight(line_thickness);
    int x1 = int(map(sub_array.get(i).longitude, min(all_longs), max(all_longs), left_border, right_border));
    int y1 = int(map(sub_array.get(i).latitude, min(all_lats), max(all_lats), bottom_border, top_border));
    int x2 = int(map(sub_array.get(i+1).longitude, min(all_longs), max(all_longs), left_border, right_border));
    int y2 = int(map(sub_array.get(i+1).latitude, min(all_lats), max(all_lats), bottom_border, top_border));
    print("Plotting point at " + str(x1) + ", " + str(y1) + " to " + str(x2) + ", " + str(y2) + " in division " + str(sub_array.get(i).division) + "\n");
    line(x1, y1, x2, y2);
  }

  sub_array.clear();
}
