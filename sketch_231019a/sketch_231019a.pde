void setup() {
  size(400, 400);
}

void draw() {
  frameRate(12);
  background(0);
  fill(random(255));
  noStroke();
  ellipse(random(400), random(400), random(40), random(40));
  stroke(255);
  line(random(400), random(400), random(400), random(400));
}
