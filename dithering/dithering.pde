// Code based on The Coding Train exercise #90 - Floyd-Steinberg Dithering
// by Daniel Shiffman
// https://thecodingtrain.com/challenges/90-dithering

PImage img;

void setup() {
  size(1052, 562);
  img = loadImage("wall.png");
  image(img, 0, 0);
}


void draw() {
  img.loadPixels();
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      int i = x + y * img.width;
      color p = img.pixels[i];

      float r = red(p);
      float g = green(p);
      float b = blue(p);

      int nr = round(3 * r/255) * (255/3);
      int ng = round(3 * g/255) * (255/3);
      int nb = round(3 * b/255) * (255/3);

      img.pixels[i] = color(nr, ng, nb);
    }
  }
  img.updatePixels();
  image(img,526, 0);
}
