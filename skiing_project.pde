//  INSTRUCTIONS //
// ARROW KEYS "->" & "<-" TO MOVE//
// AVOID GREEN "TREES" //
// REACH THE RED "GOAL" //

Ski joe;
boolean gameOver;
boolean gameWon;

ArrayList<Tree> forest = new ArrayList<Tree>();
ArrayList<Goal> finish = new ArrayList<Goal>();

void setup() {
  size(500, 500);
  joe = new Ski();
  gameOver = false;
  gameWon = false;
}

void draw() {
  background(255);
  joe.display();
  joe.move();
  for (Tree f : forest) {
    f.display();
    f.move(); //using an array list the "forest" is created for the skier to dodge
    //below is the code for collision between joe and the trees
    if (joe.location.x <= f.location.x+10 && joe.location.x >= f.location.x-10 && joe.location.y <=  f.location.y+20 && joe.location.y >=  f.location.y-20) {
      gameOver = true;
      //println(gameOver);
    }
    if (gameOver == true) {
      textSize(60);
      fill(0);
      text("You Crashed", 65, height/2);
      stop(); //ends the game with a loss
    }
  }

  for (Goal g : finish) {
    g.display();
    g.move();
    if (joe.location.x <= g.location.x+30 && joe.location.x >= g.location.x-30 && joe.location.y <=  g.location.y+10 && joe.location.y >=  g.location.y-10) {
      gameWon = true;
      //println(gameOver);
    }
    if (gameWon == true) {
      textSize(60);
      fill(0);
      text("Well Done!", 85, height/2);
      stop(); //ends the game with a loss
    }
  }

  //the int can be changed to adjust how often trees spawn
  if ((int)random(50) == 1) {
    forest.add(new Tree(random(width)));
    //println("Tree");
  }
  //creates random trees

  if (frameCount >= 1800) { //after frame 1800 goals also begin to spawn
    if ((int)random(1000) == 1) { //rarer than trees only after 30 seconds
      finish.add(new Goal(random(width)));
    }
  }
  fill(0);
  textSize(20);
}

void keyPressed() {
  if (keyCode == LEFT) joe.haccel.x-=2; 
  if (keyCode == RIGHT) joe.haccel.x+=2;
  //USE LEFT AND RIGHT TO MOVE
  //By holding left or right the skier "turns" and accelerates
}

class Ski {
  color c;
  float d;
  PVector location, velocity, acceleration, haccel; //haccel =  horizontal acceleration

  Ski() { // Skier code is very similar to the thrust code that we did in class
    c = color(0, 0, 0);
    d = 10;
    location = new PVector(width/2, height/3); //sets skier position
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    haccel = new PVector(0, 0);
    //creates parameters for the skier and PVectors attached
  }
  void move() {
    acceleration.add(haccel.div(5));
    //this is how the skier gains acceleration
    velocity.add(acceleration);
    velocity.limit(3); //limits the max velocity of the skier
    location.add(velocity);
    if (location.x > width) location.x = 0;
    if (location.x < 0) location.x = width;
    //makes it so the player can move from either side of the screen
    acceleration.setMag(0);
  }
  void display() {
    fill(c);
    ellipse(location.x, location.y, d, d);
    //displays the skier
  }
}

class Tree {
  color c;
  PVector location, velocity;
  Tree(float x) {
    c = color(34, 139, 34);
    location = new PVector(0, height+20); //makes it so the trees spawn outside of the players vision
    velocity = new PVector(0, -3); //sets the velocity
    location.x = x;
  }
  void display() {
    fill(c);
    rectMode(CENTER);
    rect(location.x, location.y, 20, 40); 
    //tree visuals
  }
  void move() {
    location.add(velocity);
  }
}

class Goal {
  color c;
  PVector location, velocity;
  Goal(float x) {
    c = color(255, 0, 0);
    location = new PVector(0, height+10);
    velocity = new PVector(0, -3); //sets the velocity
    location.x = x;
  }
  void display() {
    fill(c);
    rectMode(CENTER);
    rect(location.x, location.y, 60, 20);
    fill(0);
    textSize(15);
    text("goal", location.x-15, location.y+5);
  }
  void move() {
    location.add(velocity);
  }
}
