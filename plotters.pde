void plotMapPoints(float[] longs, float[] lats, float[] all_longs, float[] all_lats) {
  fill(0);
  noStroke();
  for (int i = 0; i < 20; i++) {
    float x = map(longs[i], min(all_longs), max(all_longs), 100, width - 100);
    float y = map(lats[i], min(all_lats), max(all_lats), height - 100, 100);
    //println(x + " " + y);
    ellipse(x, y, 6, 6);
  }
}

void plotCityNames(String[] names, float[] longs, float[] lats, float[] all_longs, float[] all_lats) {
  for(int i = 0; i < 20; i++) {
    float x = map(longs[i], min(all_longs), max(all_longs), 100, width - 100);
    float y = map(lats[i], min(all_lats), max(all_lats), height - 100, 100);
    
    fill(255, 0, 0);
    textSize(10);
    textAlign(CENTER);
    text(names[i], x, y - 10);
  }
}

void plotMainAdvance(ArrayList<survCoord> coords, float[] surv_count, float[] all_longs, float[] all_lats) {
  stroke(0, 255, 0);
  noFill();
  for (int i = 0; i < coords.size() - 1; i++) {
    if (coords.get(i).direction.contains("A") && coords.get(i).division == 1) {
      int line_thickness = int(map(coords.get(i).count, min(surv_count), max(surv_count), 5, 100));
      strokeWeight(line_thickness);
      int x1 = int(map(coords.get(i).longitude, min(all_longs), max(all_longs), 100, width - 100));
      int y1 = int(map(coords.get(i).latitude, min(all_lats), max(all_lats), height - 100, 100));
      int x2 = int(map(coords.get(i+1).longitude, min(all_longs), max(all_longs), 100, width - 100));
      int y2 = int(map(coords.get(i+1).latitude, min(all_lats), max(all_lats), height - 100, 100));
      line(x1, y1, x2, y2);
    }
  }
}
