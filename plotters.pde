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
