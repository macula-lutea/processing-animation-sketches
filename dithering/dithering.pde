// Code based on The Coding Train exercise #90 - Floyd-Steinberg Dithering
// by Daniel Shiffman
// https://thecodingtrain.com/challenges/90-dithering

PImage img;

void setup() {
  size(1052, 562);
  img = loadImage("wall.png");
  img.filter(GRAY);
  image(img, 0, 0);
}

int index(int x, int y, int w) {
  return x + y * w;
}

// Pseudocode from https://en.wikipedia.org/wiki/Floyd%E2%80%93Steinberg_dithering
//for each y from top to bottom do
//    for each x from left to right do
//        oldpixel := pixels[x][y]
//        newpixel := find_closest_palette_color(oldpixel)
//        pixels[x][y] := newpixel
//        quant_error := oldpixel - newpixel
//        pixels[x + 1][y    ] := pixels[x + 1][y    ] + quant_error × 7 / 16
//        pixels[x - 1][y + 1] := pixels[x - 1][y + 1] + quant_error × 3 / 16
//        pixels[x    ][y + 1] := pixels[x    ][y + 1] + quant_error × 5 / 16
//        pixels[x + 1][y + 1] := pixels[x + 1][y + 1] + quant_error × 1 / 16


void draw() {
  img.loadPixels();
  for (int y = 0; y < img.height-1; y++) {
    for (int x = 1; x < img.width-1; x++) {
      int i = index(x, y, img.width);
      color p = img.pixels[i];

      float red = red(p);
      float green = green(p);
      float blue = blue(p);

      int nR = round(1 * red/255) * (255/1);
      int nG = round(1 * green/255) * (255/1);
      int nB = round(1 * blue/255) * (255/1);
      img.pixels[i] = color(nR, nG, nB);

      float errR = red - nR;
      float errG = green - nG;
      float errB = blue - nB;

      int index = index(x+1, y, img.width);
      color c = img.pixels[index];
      float r = red(c);
      float g = green(c);
      float b = blue(c);
      r = r + errR * 7.0/16.0;
      g = g + errG * 7.0/16.0;
      b = b + errB * 7.0/16.0;
      img.pixels[index] = color(r, g, b);

      index = index(x-1, y+1, img.width);
      c = img.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 3.0/16.0;
      g = g + errG * 3.0/16.0;
      b = b + errB * 3.0/16.0;
      img.pixels[index] = color(r, g, b);

      index = index(x, y+1, img.width);
      c = img.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 5.0/16.0;
      g = g + errG * 5.0/16.0;
      b = b + errB * 5.0/16.0;
      img.pixels[index] = color(r, g, b);

      index = index(x+1, y+1, img.width);
      c = img.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 1.0/16.0;
      g = g + errG * 1.0/16.0;
      b = b + errB * 1.0/16.0;
      img.pixels[index] = color(r, g, b);
    }
  }
  img.updatePixels();
  image(img,526, 0);
}
