// making eyes
// tutorial: https://happycoding.io/tutorials/processing/using-objects/eyes

PVector leftEye;
PVector rightEye;
PVector m;
int bgValue;

void setup(){
  bgValue = 128;
  background(bgValue);
  size(200, 100);
  leftEye = new PVector(width*.25, height*.5);
  rightEye = new PVector(width*.75, height*.5);
  m = new PVector(width*.50, height*.2);
}

void draw(){
  PVector mouseVector = new PVector(mouseX, mouseY);

  PVector leftPupil = leftEye.copy().add(mouseVector.copy().sub(leftEye).setMag(10));
  PVector rightPupil = rightEye.copy().add(mouseVector.copy().sub(rightEye).setMag(10));
  PVector mp = m.copy().add(mouseVector.copy().sub(m).setMag(4));

  fill(255);
  ellipse(leftEye.x, leftEye.y, 50, 50);
  ellipse(rightEye.x, rightEye.y, 50, 50);
  ellipse(m.x, m.y, 25, 25);

  fill(0);
  ellipse(leftPupil.x, leftPupil.y, 20, 20);
  ellipse(rightPupil.x, rightPupil.y, 20, 20);
  ellipse(mp.x, mp.y, 10, 10);
}

void mousePressed() {
  background(255);
}
