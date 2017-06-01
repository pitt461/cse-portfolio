/*
Grace Kariuki and Tevin Stanley
5/28/17
This is an arcade old-style shooting game. Move the mouse to aim and click to shoot. 
This program includes "Ultimate" by Denzel Curry, "Mad World" by Gary Jules, and "My Love" by Justin Timberlake.
*/

import processing.sound.*;// imports sound into code
PImage cactus;// image of cacti
PImage cactus2;// image of cacti
PImage shrub1;// image of shrub
PImage crossheirs;// image for cursor
PImage tumbleweed;// image of tumbleweed
PFont font;// importing font
boolean win = true;// win condition
boolean shots[] = {true, true, true, true};// bullets array
int time = 0;// variable for time set to zero
int shotsFired = 0;// variable that keeps track of number of shots that are fired
boolean startScreen = true;// start screen condition
float xValue[] = new float[61];// array for x values with 61 spaces
float yValue[] = new float[61];// array for y values with 61 spaces
int sadSong = 0;// variable used to control losing music
int winSong = 0;// variable used to control winning music
int score = 0;// variable used to add to score
SoundFile miss;// gunshot sound without reloading
SoundFile hit;// gunshot sound with reloading
SoundFile banger;// "My Love" by Justin Timberlake
SoundFile sad;// "Mad World" by Gary Jules
SoundFile winner;// "Ultimate" by Denzel Curry


// setup has image variables, font and for loop for the rectangle
void setup() {
  size(2000, 1800);
  miss = new SoundFile(this, "gun sound miss.mp3");
  hit = new SoundFile(this, "gun shot relead.mp3");
  banger = new SoundFile(this, "my love.mp3");
  sad = new SoundFile(this, "mad world.mp3");
  winner = new SoundFile(this, "ultimate.mp3");
  cactus = loadImage("cactus.png");// setting variable for image input of cacti
  cactus2 = loadImage("cactus2.png");
  shrub1 = loadImage("shrub.png");
  crossheirs = loadImage("crossheirs.png");
  font = loadFont("Algerian-48.vlw");
  tumbleweed = loadImage("tumbleweed.png");
  for(int i = 0; i<xValue.length; i++) {
    xValue[i] = random(80, 1620);
    yValue[i] = random(200, 1620);
  } 
  banger.cue(3);
  banger.play();
}

// Contains methods and if statements for winning and losing
void draw() {
  if(((time / 36) > 30) && (win==true)) {
    time--;
    fill(0);
    for(int i = 0; i < 4; i++) {
      shots[i] = true;
    }
    textSize(80);
    winSong ++;
    fill(random(255), random(255), random(255));
    text(" You win, congrats!", 1000, 1000);
    text("PRESS 'r' to restart", 1000, 1200);
    banger.stop();
    if(winSong == 1) {
      winner.cue(16);
      winner.play();
    }
  }else if(win == false) {
    loseScreen();
  }else {
    game();
    cursor();
  }
}


// makes button go into game when mousePressed and contains if statements for shots
void game() {
  if(startScreen == true) {
    startScreen();
    shotsFired = 0;
  }else {
    background();
    cursor(); 
    timer();
    if(mousePressed && (((time + 36) / 36) % 4 != 0)) {
      shots[shotsFired] = false;
      miss.play();
    }
    if(((time + 36) / 36) % 2 == 0) {
      rootbeer(xValue[(time / 36) ], yValue[(time / 36)]);
      if(mousePressed && (mouseX >= xValue[time / 36]) 
      && (mouseX <= xValue[time / 36] + 50) 
      && (mouseY >= yValue[time / 36]) 
      && (mouseY <= yValue[time / 36] +80)) {
        score+=50;
        hit.play();
        for(int i = 0; i < 4; i++) {
          shots[i] = true;
        }
        shotsFired = 0;
      }else if(mousePressed) {
        shots[shotsFired] = false;
        miss.play();
      }
    }
  }
}

// background design for game and if statements for fills for shot counter
void background() {
  background(#E8C97A);
  image(cactus, 100, 100, 100, 100);
  image(cactus, 1200, 1200, 400, 400);
  image(cactus2, 500, 600, 200, 200);
  image(shrub1, 1500, 200, 150, 150);
  rotate(PI*(time)/80);
  image(tumbleweed, -200 + time, 1500, 150, 100);
  rotate(-PI*(time)/80);
  for(int i = 0; i < 1000; i++) {
    stroke(#6C5C31);
    strokeWeight(1.25);
    rect(random(2000), random(2000), 3, 3);
    strokeWeight(0);
  }
  textSize(50);
  fill(#F73A05);
  text("Time: " + (time / 36), 1750, 100);
  text("SCORE " + score, 200, 100);
  textFont(font, 80);
  textAlign(CENTER, CENTER);
  text("OLD WEST", 1000, 100);
  strokeWeight(5);
  stroke(#6A5C5A);
  for(int j = 1; j < 4; j++){
    if(shots[j] == true) {
      fill(#21AD43);
    }else {
      fill(#D3361E);
    }
    ellipse(1600 + (100 * j), 200, 50, 50);
  }
}

void cursor() {
  if(mousePressed) {
    int x = mouseX;
    int y = mouseY;
    fill(255);
    ellipse(x, y, 20, 20);
  }
  noCursor();
  image(crossheirs, mouseX - 50, mouseY - 50, 100, 100);
}

void timer() {
  time++;
}

// checks to see if all bullets have been used
void mouseClicked() {
  if(shotsFired < 3) {
    shotsFired++;
  }
  if((shots[1]==false) && shots[2]==false && shots[3] == false) {
    win = false;
  }
}

// start screen design and mousePressed function to go into game
void startScreen() {
  background(0);
  fill(#4235E3);
  rect(800, 945, 400, 110);
  fill(255);
  textSize(50);
  textAlign(CENTER, CENTER);
  text("START GAME", width / 2, 1000);
  if((mousePressed == true) && (800 < mouseX) && 
  (mouseX < 1200) && (mouseY < 1055) && (mouseY > 945)) {
    startScreen = false;
  }
  textSize(100);
  textFont(font, 80);
  text("Welcome to the OLD WEST", 1000, 500);
  textSize(50);
  text("Use your mouse to aim and click to shoot the rootbeer", 1000, 1200);
  text("You have 3 shots. If you miss all 3, you lose.", 1000, 1300);
  text("Shots refill if you hit, make it to 30 seconds to win", 1000, 1400);
}

// rootbeer rectangle by passing variables
void rootbeer(float x, float y) {
  fill(#5F4501);
  strokeWeight(1);
  rect(x, y, 50, 80);
  fill(255);
  textSize(17);
  text("Root", x + 25, y + 30); 
  text("Beer", x + 25, y + 50);
}

// lose screen design with score and instructions to restart
void loseScreen() {
  for(int i = 0; i < 2000; i++) {
    stroke(0, 20, map(i, 0, 2000, 255, 0));
    line(0, i, 2000, i);
  }
  textSize(100);
  textAlign(CENTER, CENTER);
  text("HA! YOU THOUGHT! LOL YOU LOSE >:)", 1000, 800);
  text("Score: " + score, 1000, 950);
  textSize(50);
  text("Press 'r' to restart game", 1000, 1100);
  sadSong++;
  if(sadSong == 1) {
    sad.play();
  }
  banger.stop();
}

// 'r' restarts game and 'w' is a cheat code that adds a lot to score
void keyPressed() {
  if(key == 'r') {
    time = 0;
    score = 0;
    win = true;
    winner.stop();
    banger.stop();
    banger.cue(3);
    banger.play();
    sad.stop();
    shotsFired = 1;
    winSong = 0;
    sadSong = 0;
    for(int i = 0; i < 4; i++) {
      shots[i] = true;
    }
  }
  if(key == 'w') {
    score += 1999999999;
  }
}