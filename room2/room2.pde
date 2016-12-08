/*    
 Harry Grubman's EXO Room Escape
 Room 2 Display & Keypad Code
 */
import processing.net.*;

Client c;
String input;
int data[];
int startTime;
String stage = "initialize";
int stageNum = 0;
PImage exo, portrait, clue, converter, maze, instructions;
String keypad = "CODE";
int identifier = 3;
int status = 1;
Boolean oneTime = false;

void setup()
{
  frameRate(5);
  fullScreen();
  c = new Client(this, "139.59.1.39", 12345);
  instructions = loadImage("Instruction_Screen.jpg");
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
  }
  if (stage == "instructions")
  {
    stageNum = 4;
    imageMode(CENTER);
    image(instructions, width/2, height/2, width, height);
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
    image(portrait, 2.5*width/12, 3.5*height/7, width/4, 5*height/7);
    image(maze, width/2, 2.5*height/7, width/4, 3*height/7);
    image(converter, 9.5*width/12, 3.5*height/7, width/4, 5*height/7); 
    if (keypad.length() > 3)
    {
      c.write(identifier + "|" + status + "|" + stageNum + "|" + int(keypad)  + "\n");
    }
    if (int(keypad) == 2847)
      stage = "correct";
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
  if (c.available() > 0)
  {
    input = c.readString();
    input = input.substring(0, input.indexOf("\n"));
    data = int(split(input, '|'));
    if (data[0] == 1)
    {
      switch(data[3])
      {
      case 1234:
        stage = "rooming";
        break;
      case 1111:
        stage = "instructions";
        break;
      case 8888:
        stage = "correct";
        break;
      case 8890:
        stage = "correct";
        break;
      case 3223:
        stage = "paused";
        break;
      case 4321:
        stage = "initialize";
        break;
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
      int n = int(key);  // Adapted from Quark
      n = n - 48;
      if (n >= 0 && n <= 9)
        keypad = keypad + key;
    }
  }
}

void exit()
{
  for (int n = 0; n < 2; n++)
    c.write(identifier + "|0|0\n"); // sends close connection code
}