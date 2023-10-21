// Code based on The Coding Train exercise #90 - Floyd-Steinberg Dithering
// by Daniel Shiffman
// https://thecodingtrain.com/challenges/90-dithering
// Images used are my own

PImage img;

void setup() {
  size(1052, 562);
  img = loadImage("wall.png");
  //img.filter(GRAY);
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

 void dither(int index, float errR, float errG, float errB, float distributionAmount) {
      color c = img.pixels[index];
      float r = red(c);
      float g = green(c);
      float b = blue(c);
      r = r + errR * distributionAmount;
      g = g + errG * distributionAmount;
      b = b + errB * distributionAmount;
      img.pixels[index] = color(r, g, b);
 }

void draw() {
  img.loadPixels();
  for (int y = 0; y < img.height-1; y++) {
    for (int x = 1; x < img.width-1; x++) {
      int i = index(x, y, img.width);
      color p = img.pixels[i];

      float red = red(p);
      float green = green(p);
      float blue = blue(p);

      int factor = 8;
      int nR = round(factor * red/255) * (255/factor);
      int nG = round(factor * green/255) * (255/factor);
      int nB = round(factor * blue/255) * (255/factor);
      img.pixels[i] = color(nR, nG, nB);

      float errR = red - nR;
      float errG = green - nG;
      float errB = blue - nB;

      dither(index(x+1, y, img.width), errR, errG, errB, 7.0/16.0);
      dither(index(x-1, y+1, img.width), errR, errG, errB, 3.0/16.0);
      dither(index(x, y+1, img.width), errR, errG, errB, 5.0/16.0);
      dither(index(x+1, y+1, img.width), errR, errG, errB, 1.0/16.0);
    }
  }

  img.updatePixels();
  image(img,526, 0);
}
