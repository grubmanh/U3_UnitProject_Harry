import processing.net.*;

Client c;
String input;
int data[];
int startTime;
String stage = "initialize";
int stageNum = 0;
PImage exo, portrait, clue, converter, maze;
String keypad = "989";
int identifier = 3;
int status = 1;
Boolean oneTime = false;

void setup()
{
  frameRate(5);
  size(1080, 600);
  c = new Client(this, "127.0.0.1", 12345);
  exo = loadImage("Exo_Logo.png");
  portrait = loadImage("Couple_Portrait.jpg");
  clue = loadImage("Keypad_Clue.jpg");
  converter = loadImage("Number_Letter_Converter.jpg");
  maze = loadImage("Number_Maze.jpg");
  c.write(identifier + "|" + status + "|" + stageNum + "\n");
}

void draw()
{
  background(0);
  if (stage == "initialize")
  {
    stageNum = 0;
    imageMode(CENTER);
    image(exo, width/2, height/2);
    //if (oneTime == false)
    //{
    //  startTime = millis();
    //  oneTime = true;
    //}
    //if ((millis() - startTime) > 100)
    //{
    //  stage = "rooming";    
    //}
  }
  if (stage == "rooming")
  {
    stageNum = 1;
    fill(255);
    textSize(40);
    textAlign(CENTER, CENTER);
    text(keypad, width/2, height-100);
    imageMode(CENTER);
    image(clue, width/2, height-150, 150, 50);
    image(portrait, width/4, height/3, 200, 300);
    image(maze, width/2, height/3, 250, 250);
    image(converter, 3*width/4, height/3, 200, 300); 
    if (keypad.length() > 3)
    {
    c.write(identifier + "|" + status + "|" + stageNum + "|" + int(keypad)  + "\n");
    }
  }
  if (stage == "correct")
  {
    stageNum = 3;
    fill(255);
    textSize(100);
    textAlign(CENTER, CENTER);
    text("CORRECT", width/2, height/2);
  }
  if (stage == "paused")
  {
    stageNum = 3;
    fill(255);
    textSize(100);
    textAlign(CENTER, CENTER);
    text("PAUSED", width/2, height/2);
  }
  // c.write(); // to write
  if (c.available() > 0)
  {
    input = c.readString();
    input = input.substring(0, input.indexOf("\n"));
    data = int(split(input, '|'));
    println(input);
    if (data[0] == 1)
    {
      if (data[3] == 1234)
      {
        stage = "rooming";
      }
      if (data[3] == 8888 || data[3] == 8890)
      {
        stage = "correct";
      }
      if (data[3] == 3223)
      {
        stage = "paused";
      }
      if (data[3] == 4321)
      {
        stage = "initialize";
      }
    }
  }
}

void keyPressed() // Adapted from Amnon.p5
{
  if (stage == "rooming")
  {
    if (keyCode == BACKSPACE)
    {
      if (keypad.length() > 0)
      {
        keypad = keypad.substring(0, keypad.length()-1);
      }
    }
    else if (keyCode == DELETE)
    {
      keypad = "";
    }
    else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT && keypad.length() < 4)
    {
      int n = int(key);  // int('0') = 48 \\ Adapted from Quark
      n = n - 48;
      if(n >= 0 && n <= 9)
      keypad = keypad + key;
    }
  }
}

void exit()
{
  for (int n = 0; n < 2; n++)
  c.write(identifier + "|0|0\n");
}