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

ArrayList getTempColour(float[] temps) {
  color cold = color(0, 150, 255);     // Light icy blue
  color freezing = color(100, 0, 150); // Deep purple
  ArrayList<Integer> colours = new ArrayList<Integer>();
  for (float temp : temps) {
    float norm = map(temp, min(temps), max(temps), 0, 1);
    colours.add(lerpColor(cold, freezing, norm));
  }
  return colours;
}

ArrayList<survCoord> getCoords(float[] longs, float[] lats, float[] counts, String[] dirs, float[] divs) {
  ArrayList<survCoord> coords = new ArrayList<survCoord>();
  for (int i = 0; i < longs.length; i++) {
    coords.add(new survCoord(longs[i], lats[i], counts[i], dirs[i], divs[i]));
  }
  return coords;
}
