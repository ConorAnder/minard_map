void plotMapPoints(float[] longs, float[] lats, float[] all_longs, float[] all_lats) {
  fill(city_colour);
  noStroke();
  for (int i = 0; i < 20; i++) {
    float x = map(longs[i], min(all_longs), max(all_longs), left_border_map, right_border_map);
    float y = map(lats[i], min(all_lats), max(all_lats), bottom_border_map, top_border_map);
    //println(x + " " + y);
    ellipse(x, y, 6, 6);
  }
}

void plotCityNames(String[] names, float[] longs, float[] lats, float[] all_longs, float[] all_lats) {
  for(int i = 0; i < 20; i++) {
    float x = map(longs[i], min(all_longs), max(all_longs), left_border_map, right_border_map);
    float y = map(lats[i], min(all_lats), max(all_lats), bottom_border_map, top_border_map);

    // Outline of text
    textAlign(CENTER);
    textSize(12);
    fill(back_ground);
    for (int dx = -1; dx <= 1; dx++) {
      for (int dy = -1; dy <= 1; dy++) {
        if (dx != 0 || dy != 0) {
          text(names[i], x + dx, y + dy - 10);
        }
      }
    }

    // Inner text
    fill(city_colour);
    text(names[i], x, y - 10);
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
    int x1 = int(map(sub_array.get(i).longitude, min(all_longs), max(all_longs), left_border_map, right_border_map));
    int y1 = int(map(sub_array.get(i).latitude, min(all_lats), max(all_lats), bottom_border_map, top_border_map));
    int x2 = int(map(sub_array.get(i+1).longitude, min(all_longs), max(all_longs), left_border_map, right_border_map));
    int y2 = int(map(sub_array.get(i+1).latitude, min(all_lats), max(all_lats), bottom_border_map, top_border_map));
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
    int x1 = int(map(sub_array.get(i).longitude, min(all_longs), max(all_longs), left_border_map, right_border_map));
    int y1 = int(map(sub_array.get(i).latitude, min(all_lats), max(all_lats), bottom_border_map, top_border_map));
    int x2 = int(map(sub_array.get(i+1).longitude, min(all_longs), max(all_longs), left_border_map, right_border_map));
    int y2 = int(map(sub_array.get(i+1).latitude, min(all_lats), max(all_lats), bottom_border_map, top_border_map));
    print("Plotting point at " + str(x1) + ", " + str(y1) + " to " + str(x2) + ", " + str(y2) + " in division " + str(sub_array.get(i).division) + "\n");
    line(x1, y1, x2, y2);
  }

  sub_array.clear();
}

void plotAdvanceNums(ArrayList<survCoord> coords, float[] all_longs, float[] all_lats) {
  fill(city_colour);
  textAlign(CENTER);
  textSize(11);

  int[] indexes = {0, 4, 9, 10, 11, 12, 14, 15, 24, 27};
  int y_diff;
  for (int i : indexes) {
    if (i == 0 || i == 4) y_diff = 80;
    else y_diff = 50;
    float x = map(coords.get(i).longitude, min(all_longs), max(all_longs), left_border_map, right_border_map);
    float y = map(coords.get(i).latitude, min(all_lats), max(all_lats), bottom_border_map, top_border_map) - y_diff;
    pushMatrix();
    translate(x, y);
    rotate(-2 * HALF_PI / 3);
    text(NumberFormat.getInstance().format(int(coords.get(i).count)), 0, 0);
    popMatrix();
    print("Count for " + str(i) + " is " + str(coords.get(i).count));
  }
}

void plotRetreatNums(ArrayList<survCoord> coords, float[] all_longs, float[] all_lats) {
  fill(city_colour);
  textAlign(CENTER);
  textSize(11);

  int[] indexes = {18, 19, 25, 31, 34, 28, 38, 39, 42, 47};
  int y_diff = 0, x_diff = 0;
  for (int i : indexes) {
    if (i == 42) y_diff = -40;
    else if (i == 25) x_diff = 10;
    else if (i == 31 || i == 28) x_diff = -20;
    else {
      y_diff = 40;
      x_diff = 0;
    }

    float x = map(coords.get(i).longitude, min(all_longs), max(all_longs), left_border_map, right_border_map) + x_diff;
    float y = map(coords.get(i).latitude, min(all_lats), max(all_lats), bottom_border_map, top_border_map) + y_diff;
    pushMatrix();
    translate(x, y);
    rotate(-2 * HALF_PI / 3);
    text(NumberFormat.getInstance().format(int(coords.get(i).count)), 0, 0);
    popMatrix();
    print("Count for " + str(i) + " is " + str(coords.get(i).count));
  }
}

void plotTempLines(float[] temp_longs, float[] all_longs) {
  float left_x = getTempPos(temp_longs, all_longs).min();
  float right_x = right_border_map;
  stroke(city_colour);
  strokeWeight(2);

  textAlign(CENTER);
  textSize(15);
  int[] temps = {0, -13, -25, -38};
  int i = 0;

  text("°C", width - 100, 8.3 * height / 15);

  for (int y = 9 * height / 15; y < 13 * height / 15; y += height / 15) {
    text(str(temps[i]), width - 100, y);
    line(left_x, y, right_x, y);
    i++;
  }
}

void plotTempGrad(float[] temp_longs, float[] all_longs, float[] temp, float[] temp_day, String[] temp_month) {
  ArrayList<PVector> data_points = new ArrayList<PVector>();
  textSize(11);

  for (int i = 0; i < temp.length; i++) {
    float x_pos = map(temp_longs[i], min(all_longs), max(all_longs), left_border_map, right_border_map);
    float y_pos = map(temp[i], 0, -30, 9 * height / 15, 12 * height / 15);
    data_points.add(new PVector(x_pos, y_pos));
    if (!temp_month[i].equals("")) {
      text(temp_month[i] + " " + str(int(temp_day[i])), x_pos, y_pos + 40);
    }
  }

  int subdivisions = 100;
  strokeWeight(20);
  for (int i = 0; i < data_points.size() - 1; i++) {
    for (int j = 0; j < subdivisions; j++) {
      // Interpolations
      float segment = j / float(subdivisions);
      float x = lerp(data_points.get(i).x, data_points.get(i + 1).x, segment);
      float y = lerp(data_points.get(i).y, data_points.get(i + 1).y, segment);
      float temperature = lerp(temp[i], temp[i + 1], segment);
      float mapped_temp = map(temperature, 0, -30, 0, 1);

      stroke(lerpColor(cold, warm, mapped_temp));
      line(x, y, x+1, y+1);
      // line(data_points.get(i).x, data_points.get(i).y, data_points.get(i + 1).x, data_points.get(i + 1).y);
    }
  }

  // Insert vertical lines to connect to map
  stroke(city_colour);
  strokeWeight(1);
  ellipse(data_points.get(0).x, data_points.get(0).y, 2, 2);
  line(data_points.get(0).x, data_points.get(0).y, data_points.get(0).x, data_points.get(0).y - 0.4666 * height);

  ellipse(data_points.get(1).x, data_points.get(1).y, 2, 2);
  line(data_points.get(1).x, data_points.get(1).y, data_points.get(1).x, data_points.get(1).y - 0.34 * height);
  ellipse(data_points.get(1).x, data_points.get(1).y - 0.34 * height, 2, 2);

  ellipse(data_points.get(2).x, data_points.get(2).y, 2, 2);
  line(data_points.get(2).x, data_points.get(2).y, data_points.get(2).x, data_points.get(2).y - 0.32 * height);
  ellipse(data_points.get(2).x, data_points.get(2).y - 0.32 * height, 2, 2);

  ellipse(data_points.get(3).x, data_points.get(3).y, 2, 2);
  line(data_points.get(3).x, data_points.get(3).y, data_points.get(3).x, data_points.get(3).y - 0.364 * height);
  ellipse(data_points.get(3).x, data_points.get(3).y - 0.364 * height, 2, 2);

  ellipse(data_points.get(4).x, data_points.get(4).y, 2, 2);
  line(data_points.get(4).x, data_points.get(4).y, data_points.get(4).x, data_points.get(4).y - 0.2666 * height);

  ellipse(data_points.get(5).x, data_points.get(5).y, 2, 2);
  line(data_points.get(5).x, data_points.get(5).y, data_points.get(5).x, data_points.get(5).y - 0.296 * height);

  ellipse(data_points.get(6).x, data_points.get(6).y, 2, 2);
  line(data_points.get(6).x, data_points.get(6).y, data_points.get(6).x, data_points.get(6).y - 0.356 * height);
  ellipse(data_points.get(6).x, data_points.get(6).y - 0.356 * height, 2, 2);

  ellipse(data_points.get(7).x, data_points.get(7).y, 2, 2);
  line(data_points.get(7).x, data_points.get(7).y, data_points.get(7).x, data_points.get(7).y - 0.3666 * height);
  ellipse(data_points.get(7).x, data_points.get(7).y - 0.3666 * height, 2, 2);

  ellipse(data_points.get(8).x, data_points.get(8).y, 2, 2);
  line(data_points.get(8).x, data_points.get(8).y, data_points.get(8).x, data_points.get(8).y - 0.3625 * height);
  ellipse(data_points.get(8).x, data_points.get(8).y - 0.3625 * height, 2, 2);
}

void plotLegend() {
  String[] keys = {"Advance", "Retreat", "Cold", "Freezing"};
  color[] colours = {advance, retreat, cold, warm};
  textAlign(LEFT);
  textFont(main_font, 15);
  strokeWeight(15);

  int i = 0;
  for (int y = 9 * height / 15; y < 13 * height / 15; y += height / 15) {
    text(keys[i], width / 18, y);
    stroke(colours[i]);
    line(2 * width / 18, y - 5, 2 * width / 18 + 20, y - 5);
    i++;
  }
}

void plotTitle() {
  textAlign(CENTER);
  textFont(main_font);
  text("Survivors of Napoleon's Campaign in Russia - 1812/1813", width / 2 + 90, height - 75);
}

void plotScale(float[] all_longs) {
  int scaling_indicator = 100;
  float scale_width_long = scaling_indicator * 0.009;
  float x_diff = map(min(all_longs) + scale_width_long, min(all_longs), max(all_longs), left_border_map, right_border_map) - map(min(all_longs), min(all_longs), max(all_longs), left_border_map, right_border_map);

  float x1 = 309 * width / 480;
  float y = height / 2 - 50;
  float x = x1;
  stroke(city_colour);
  strokeWeight(2);
  for (int i = 0; i < 3; i++) {
    // Horizontal
    line(x, y, x + x_diff, y);

    // Vertical
    line(x, y, x, y - 5);
    line(x + x_diff, y, x + x_diff, y - 5);

    x += x_diff;
  }

  textAlign(CENTER);
  textSize(11);
  text("100km", x1 + (3 * x_diff / 2), y + 15);
}