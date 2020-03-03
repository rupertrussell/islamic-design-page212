// Design from page 212 of Islamic Geometric Designs by Eric Broug
// ISBN 978-0-500-51695-9
// Code by Rupert Russell
// 01 March 2020
// Thanks to: COLLISION DETECTION by Jeff Thompson  
// http://jeffreythompson.org/collision-detection/index.php
// Using Objects to reduce the code length


//to do  increase canvase size and tile design on a hexagonal grid X x Y times


int i = 0;
float scale = 900;
int designWeight = 9;

float[] saveIntersectionX;
float[] saveIntersectionY;

float[] saveCircleX;
float[] saveCircleY;

boolean displayGuideLines = false;
float[] xx, yy; // used to store working intersection test lines

// use the Lineline class to create multiple myLine objects
Lineline myLineline0;
Lineline myLineline1;
Lineline myLineline2;
Lineline myLineline3;
Lineline myLineline4;
Lineline myLineline5;
Lineline myLineline6;
Lineline myLineline7;
Lineline myLineline8;
Lineline myLineline9;
Lineline myLineline10;
Lineline myLineline11;
Lineline myLineline12;
Lineline myLineline13;
Lineline myLineline14;
Lineline myLineline15;
Lineline myLineline16;
Lineline myLineline17;
Lineline myLineline18;
Lineline myLineline19;
Lineline myLineline20;


// use the CalculatePoints class to create multiple myCircle objects
CalculatePoints myCircle1;
CalculatePoints myCircle2;
CalculatePoints myCircle3;
import processing.pdf.*;

void setup() {
  background(255);
  noFill();
  noLoop(); 
  size(900, 900); 
  smooth();
  noFill();
  rectMode(CENTER);
  ellipseMode(CENTER);
  noFill();
  beginRecord(PDF, "design_212_v009.pdf");

  saveIntersectionX = new float[100]; // store x Points for the intersections
  saveIntersectionY = new float[100]; // store y Points for the intersections

  saveCircleX = new float[100]; // store x Points for the circles
  saveCircleY = new float[100]; // store y Points for the circles

  xx = new float[100];
  yy = new float[100];
}

void draw() {
  background(255);

  translate(width/2, height/2);
  strokeWeight(1);
  step1(displayGuideLines);
  step2(displayGuideLines);
  step3(displayGuideLines);
  step4(displayGuideLines);

  // First 2 Design Lines
  step5a(true);
  step5b(true);

  // Guide Lines
  step6(displayGuideLines);

  // Final Design Lines
  step7(true);

  // showTestPoint();
  // numberCircles();
  // numberIntersections();

  strokeWeight(designWeight);
  save("design_212_v009.png");
  endRecord();
  // exit();
}

// Construct the Lineline object
class Lineline {
  int index;  // hold the index numbers for the intersection use to store points in array
  float x1;
  float y1;
  float x2;
  float y2;
  float x3;
  float y3;
  float x4;
  float y4;
  boolean displayLine;
  boolean displayInterection;
  char colour;
  float weight;
  float intersectionX;
  float intersectionY;

  // The Constructor is defined with arguments.
  Lineline(int tempIndex, float tempX1, float tempY1, float tempX2, float tempY2, float tempX3, float tempY3, float tempX4, float tempY4, boolean tempDisplayLine, boolean tempDisplayInterection, char tempColour, float tempWeight) {
    index =tempIndex;
    x1 = tempX1;
    y1 = tempY1;
    x2 = tempX2;
    y2 = tempY2;
    x3 = tempX3;
    y3 = tempY3;
    x4 = tempX4;
    y4 = tempY4;
    displayLine = tempDisplayLine;
    displayInterection = tempDisplayInterection;
    colour = tempColour;
    weight = tempWeight;
  }

  boolean displayIntersection() {
    // LINE/LINE 
    // Thanks to: COLLISION DETECTION by Jeff Thompson  
    // http://jeffreythompson.org/collision-detection/index.php
    // from http://jeffreythompson.org/collision-detection/line-line.php

    // calculate the distance to intersection point
    float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

    // if uA and uB are between 0-1, lines are colliding
    if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {

      // optionally, draw a circle where the lines meet
      intersectionX = x1 + (uA * (x2-x1));
      intersectionY = y1 + (uA * (y2-y1));
      noFill();

      switch(colour) {
      case 'r': 
        stroke(255, 0, 0);
        break;
      case 'g': 
        stroke(0, 255, 0);
        break;
      case 'b': 
        stroke(0, 0, 255);
        break;        
      case 'm': 
        stroke(255, 0, 255);
        break;    
      default:
        stroke(0, 0, 0); // black
        break;
      }

      if (displayLine) {
        strokeWeight(weight);
        line(x1, y1, x2, y2);
        line(x3, y3, x4, y4);
      }

      saveIntersectionX[index] = intersectionX;
      saveIntersectionY[index] = intersectionY;

      if (displayInterection) {
        circle(intersectionX, intersectionY, 10);
      }

      strokeWeight(designWeight);
      stroke(0, 0, 0);  // colour of final design uncomment to use 'case' to set individual design elements to different colours 

      return true ;
    }
    return false;
  }
}
//  end of constructor for Lineline class

// Start of Constructor for CalculatePoints defined with arguments
// calculate points around a circle and store n points around a circle
class CalculatePoints {
  int numPoints;
  float scale;
  float h;
  float k;
  int counterStart;
  boolean displayCrcles;

  // The Constructor is defined with arguments and sits inside the class 
  CalculatePoints(int tempCounterStart, int tempNumPoints, float tempScale, float tempH, float tempK, boolean tmpDisplayCrcles) {
    numPoints = tempNumPoints;
    scale = tempScale;
    h = tempH;
    k = tempK;
    counterStart = tempCounterStart;
    displayCrcles = tmpDisplayCrcles;

    int counter = counterStart;

    double step = radians(360/numPoints); 
    float r =  scale / 2 ;
    for (float theta=0; theta < 2 * PI; theta += step) {
      float x = h + r * cos(theta);
      float y = k - r * sin(theta); 

      // store the calculated coordinates
      saveCircleX[counter] = x;
      saveCircleY[counter] = y;
      if (displayCrcles) {
        circle(saveCircleX[counter], saveCircleY[counter], 10);  // draw small circles to show points
      }
      counter ++;
    }
  }
} // End of Constructor for CalculatePoints

void step1(boolean displayGuideLines) {
  // Guide Lines
  myCircle1 = new CalculatePoints(0, 12, scale, 0, 0, displayGuideLines);

  //Spokes
  if (displayGuideLines) {
    for (int i=0; i < 13; i ++) { 
      line(saveCircleX[0 + i], saveCircleY[0 + i], saveCircleX[6 + i], saveCircleY[6 + i]);
    }
  }

  // Circle Circle inside the square
  if (displayGuideLines) {
    circle(0, 0, scale);
  }
} // end step1

void step2(boolean displayGuideLines) {
  // inner Hexagon
  if (displayGuideLines) {
    line(saveCircleX[0], saveCircleY[0], saveCircleX[2], saveCircleY[2]); 
    line(saveCircleX[2], saveCircleY[2], saveCircleX[4], saveCircleY[4]); 
    line(saveCircleX[4], saveCircleY[4], saveCircleX[6], saveCircleY[6]); 
    line(saveCircleX[6], saveCircleY[6], saveCircleX[8], saveCircleY[8]); 
    line(saveCircleX[8], saveCircleY[8], saveCircleX[10], saveCircleY[10]);   
    line(saveCircleX[10], saveCircleY[10], saveCircleX[0], saveCircleY[0]);
  }
} // end step2

void step3(boolean displayGuideLines) {

  strokeWeight(1);
  // inner Star
  if (displayGuideLines) {
    line(saveCircleX[0], saveCircleY[0], saveCircleX[4], saveCircleY[4]);
    line(saveCircleX[4], saveCircleY[4], saveCircleX[8], saveCircleY[8]);
    line(saveCircleX[8], saveCircleY[8], saveCircleX[0], saveCircleY[0]);
    line(saveCircleX[2], saveCircleY[2], saveCircleX[6], saveCircleY[6]); 
    line(saveCircleX[6], saveCircleY[6], saveCircleX[10], saveCircleY[10]); 
    line(saveCircleX[10], saveCircleY[10], saveCircleX[2], saveCircleY[2]);
  }
}

void step4(boolean displayGuideLines) {
  // Circle within the Hexagon

  strokeWeight(1);
  if (displayGuideLines) {
    circle(0, 0, saveCircleY[2] * 2);
  }
} // end step4


void step5a(boolean displayDesign) {
  // locate intersection point for top of line 

  if (displayDesign) {
    strokeWeight(designWeight);
    stroke(255, 0, 0); // red design lines
    myCircle2 = new CalculatePoints(13, 12, saveCircleY[2] * 2, 0, 0, displayGuideLines);
    // Outer Hexagon Design Lines
    line(saveCircleX[18], saveCircleY[18], saveCircleX[20], saveCircleY[20]); 
    line(saveCircleX[20], saveCircleY[20], saveCircleX[22], saveCircleY[22]); 
    line(saveCircleX[22], saveCircleY[22], saveCircleX[24], saveCircleY[24]); 
    line(saveCircleX[24], saveCircleY[24], saveCircleX[14], saveCircleY[14]); 
    line(saveCircleX[14], saveCircleY[14], saveCircleX[16], saveCircleY[16]);   
    line(saveCircleX[16], saveCircleY[16], saveCircleX[18], saveCircleY[18]);
  }
}// end step5a

void step5b(boolean displayDesign) {
  // calculate the radius of the inner circle
  float x1, y1, x2, y2, x3, y3, x4, y4;

  x1 = saveCircleX[3];
  y1 = saveCircleY[3];

  x2 = saveCircleX[9];
  y2 = saveCircleY[9];

  x3 = saveCircleX[0];
  y3 = saveCircleY[0];

  x4 = saveCircleX[4];
  y4 = saveCircleY[4];

  myLineline1 = new Lineline(1, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline1.displayIntersection();

  if (displayDesign) {
    strokeWeight(1);
    stroke(255, 0, 0); // red design lines
    myCircle2 = new CalculatePoints(25, 12, saveIntersectionY[1] * 2, 0, 0, displayGuideLines);
    strokeWeight(designWeight);
    // Inner Hexagon Design Lines
    line(saveCircleX[30], saveCircleY[30], saveCircleX[32], saveCircleY[32]); 
    line(saveCircleX[32], saveCircleY[32], saveCircleX[34], saveCircleY[34]); 
    line(saveCircleX[34], saveCircleY[34], saveCircleX[36], saveCircleY[36]); 
    line(saveCircleX[36], saveCircleY[36], saveCircleX[26], saveCircleY[26]); 
    line(saveCircleX[26], saveCircleY[26], saveCircleX[28], saveCircleY[28]);   
    line(saveCircleX[28], saveCircleY[28], saveCircleX[30], saveCircleY[30]);
  }
} // end step5b


void step6(boolean displayGuideLines) {
  strokeWeight(1);
  float x1, y1, x2, y2, x3, y3, x4, y4;

  x1 = saveCircleX[2];
  y1 = saveCircleY[2];

  x2 = saveCircleX[6];
  y2 = saveCircleY[6];

  x3 = saveCircleX[24];
  y3 = saveCircleY[24];

  x4 = saveCircleX[14];
  y4 = saveCircleY[14];

  myLineline2 = new Lineline(2, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline2.displayIntersection();

  x1 = saveCircleX[0];
  y1 = saveCircleY[0];

  x2 = saveCircleX[4];
  y2 = saveCircleY[4];

  x3 = saveCircleX[18];
  y3 = saveCircleY[18];

  x4 = saveCircleX[20];
  y4 = saveCircleY[20];

  myLineline3 = new Lineline(3, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline3.displayIntersection();


  x1 = saveCircleX[6];
  y1 = saveCircleY[6];

  x2 = saveCircleX[10];
  y2 = saveCircleY[10];

  x3 = saveCircleX[24];
  y3 = saveCircleY[24];

  x4 = saveCircleX[14];
  y4 = saveCircleY[14];

  myLineline4 = new Lineline(4, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline4.displayIntersection();

  x1 = saveCircleX[0];
  y1 = saveCircleY[0];

  x2 = saveCircleX[8];
  y2 = saveCircleY[8];

  x3 = saveCircleX[18];
  y3 = saveCircleY[18];

  x4 = saveCircleX[20];
  y4 = saveCircleY[20];

  myLineline5 = new Lineline(5, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline5.displayIntersection();

  x1 = saveCircleX[4];
  y1 = saveCircleY[4];

  x2 = saveCircleX[8];
  y2 = saveCircleY[8];

  x3 = saveCircleX[24];
  y3 = saveCircleY[24];

  x4 = saveCircleX[22];
  y4 = saveCircleY[22];

  myLineline6 = new Lineline(6, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline6.displayIntersection();

  x1 = saveCircleX[4];
  y1 = saveCircleY[4];

  x2 = saveCircleX[8];
  y2 = saveCircleY[8];

  x3 = saveCircleX[14];
  y3 = saveCircleY[14];

  x4 = saveCircleX[16];
  y4 = saveCircleY[16];

  myLineline7 = new Lineline(7, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline7.displayIntersection();

  x1 = saveCircleX[4];
  y1 = saveCircleY[4];

  x2 = saveCircleX[0];
  y2 = saveCircleY[0];

  x3 = saveCircleX[24];
  y3 = saveCircleY[24];

  x4 = saveCircleX[22];
  y4 = saveCircleY[22];

  myLineline8 = new Lineline(8, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline8.displayIntersection();

  x1 = saveCircleX[0];
  y1 = saveCircleY[0];

  x2 = saveCircleX[8];
  y2 = saveCircleY[8];

  x3 = saveCircleX[14];
  y3 = saveCircleY[14];

  x4 = saveCircleX[16];
  y4 = saveCircleY[16];

  myLineline9 = new Lineline(9, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline9.displayIntersection();

  x1 = saveCircleX[2];
  y1 = saveCircleY[2];

  x2 = saveCircleX[6];
  y2 = saveCircleY[6];

  x3 = saveCircleX[20];
  y3 = saveCircleY[20];

  x4 = saveCircleX[22];
  y4 = saveCircleY[22];

  myLineline10 = new Lineline(10, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline10.displayIntersection();

  x1 = saveCircleX[6];
  y1 = saveCircleY[6];

  x2 = saveCircleX[10];
  y2 = saveCircleY[10];

  x3 = saveCircleX[18];
  y3 = saveCircleY[18];

  x4 = saveCircleX[16];
  y4 = saveCircleY[16];

  myLineline11 = new Lineline(11, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline11.displayIntersection();

  x1 = saveCircleX[2];
  y1 = saveCircleY[2];

  x2 = saveCircleX[10];
  y2 = saveCircleY[10];

  x3 = saveCircleX[20];
  y3 = saveCircleY[20];

  x4 = saveCircleX[22];
  y4 = saveCircleY[22];

  myLineline12 = new Lineline(12, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline12.displayIntersection();

  x1 = saveCircleX[2];
  y1 = saveCircleY[2];

  x2 = saveCircleX[10];
  y2 = saveCircleY[10];

  x3 = saveCircleX[18];
  y3 = saveCircleY[18];

  x4 = saveCircleX[16];
  y4 = saveCircleY[16];

  myLineline13 = new Lineline(13, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline13.displayIntersection();
  strokeWeight(1);
  if (displayGuideLines) {
    // Horizontal parallel lines
    line(saveIntersectionX[2], saveIntersectionY[2], saveIntersectionX[3], saveIntersectionY[3]); // top parallel 
    line(saveIntersectionX[4], saveIntersectionY[4], saveIntersectionX[5], saveIntersectionY[5]); // top parallel 

    line(saveIntersectionX[6], saveIntersectionY[6], saveIntersectionX[11], saveIntersectionY[11]); // top parallel 
    line(saveIntersectionX[8], saveIntersectionY[8], saveIntersectionX[13], saveIntersectionY[13]); // top parallel 

    line(saveIntersectionX[10], saveIntersectionY[10], saveIntersectionX[7], saveIntersectionY[7]); // top parallel 
    line(saveIntersectionX[12], saveIntersectionY[12], saveIntersectionX[9], saveIntersectionY[9]); // top parallel
  }
} // end step6


void step7(boolean displayDesign) {
  // calculate the radius of the inner circle
  float x1, y1, x2, y2, x3, y3, x4, y4;

  x1 = saveCircleX[4];
  y1 = saveCircleY[4];

  x2 = saveCircleX[10];
  y2 = saveCircleY[10];

  x3 = saveIntersectionX[2];
  y3 = saveIntersectionY[2];

  x4 = saveIntersectionX[3];
  y4 = saveIntersectionY[3];

  myLineline14 = new Lineline(14, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline14.displayIntersection();

  if (displayDesign) {
    strokeWeight(designWeight);
    stroke(255, 0, 0); // red

    line( saveIntersectionX[10], saveIntersectionY[10], saveIntersectionX[14], saveIntersectionY[14]); 
    line(-saveIntersectionX[10], saveIntersectionY[10], -saveIntersectionX[14], saveIntersectionY[14]); 
    line( saveIntersectionX[10], -saveIntersectionY[10], saveIntersectionX[14], -saveIntersectionY[14]); 
    line( -saveIntersectionX[10], -saveIntersectionY[10], -saveIntersectionX[14], -saveIntersectionY[14]); 

    line( saveIntersectionX[14], saveIntersectionY[14], saveIntersectionX[2], saveIntersectionY[2]); 
    line(-saveIntersectionX[14], saveIntersectionY[14], -saveIntersectionX[2], saveIntersectionY[2]); 
    line( saveIntersectionX[14], -saveIntersectionY[14], saveIntersectionX[2], -saveIntersectionY[2]); 
    line( -saveIntersectionX[14], -saveIntersectionY[14], -saveIntersectionX[2], -saveIntersectionY[2]);


    x1 = saveCircleX[25];
    y1 = saveCircleY[25];

    x2 = saveCircleX[31];
    y2 = saveCircleY[31];

    x3 = saveIntersectionX[6];
    y3 = saveIntersectionY[6];

    x4 = saveIntersectionX[11];
    y4 = saveIntersectionY[11];

    myLineline15 = new Lineline(15, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
    myLineline15.displayIntersection();
    stroke(255, 0, 0); // red design lines
    line( saveIntersectionX[6], saveIntersectionY[6], saveIntersectionX[15], saveIntersectionY[15]); 
    line(-saveIntersectionX[6], saveIntersectionY[6], -saveIntersectionX[15], saveIntersectionY[15]); 
    line( saveIntersectionX[6], -saveIntersectionY[6], saveIntersectionX[15], -saveIntersectionY[15]); 
    line( -saveIntersectionX[6], -saveIntersectionY[6], -saveIntersectionX[15], -saveIntersectionY[15]); 

    line( saveIntersectionX[15], saveIntersectionY[15], saveIntersectionX[7], saveIntersectionY[7]); 
    line(-saveIntersectionX[15], saveIntersectionY[15], -saveIntersectionX[7], saveIntersectionY[7]); 
    line( saveIntersectionX[15], -saveIntersectionY[15], saveIntersectionX[7], -saveIntersectionY[7]); 
    line( -saveIntersectionX[15], -saveIntersectionY[15], -saveIntersectionX[7], -saveIntersectionY[7]);
  }
} // end step7


void numberCircles() {
  textSize(32);
  fill(0);
  for (int i = 0; i < 37; i = i+1) {
    text(i, saveCircleX[i], saveCircleY[i]);
  }
  noFill();
}



void numberIntersections() {
  textSize(32);
  fill(255, 0, 0);
  for (int i = 0; i < 16; i = i+1) {
    text(i, saveIntersectionX[i], saveIntersectionY[i]);
  }
  noFill();
}



void showTestPoint() {

  println("i = " + i);
  circle(saveIntersectionX[i], saveIntersectionY[i], 25);
  noFill();
}


void mousePressed() {
  showTestPoint();
    if (mouseButton == LEFT) {
    i = i + 1;
  }
}
