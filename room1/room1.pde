import processing.net.*;

Client c;
String input;
int data[];
int startTime;
String stage = "initialize";
int stageNum = 0;
PImage exo;
String keypad = "989";
int identifier = 2;
int status = 1;
Boolean oneTime = false;

void setup()
{
  frameRate(5);
  size(1080, 600);
  c = new Client(this, "127.0.0.1", 12345);
  exo = loadImage("Exo_Logo.png");
}

void draw()
{
  background(0);
  if (stage == "initialize")
  {
    stageNum = 0;
    imageMode(CENTER);
    image(exo, width/2, height/2);
    c.write(identifier + "|" + status + "|" + stageNum + "\n");
    if (oneTime == false)
    {
      startTime = millis();
      oneTime = true;
    }
    if ((millis() - startTime) > 100)
    {
      stage = "rooming";    
    }
  }
  if (stage == "rooming")
  {
    stageNum = 1;
    fill(255);
    textSize(100);
    text(keypad, width/2, height/2);
    c.write(identifier + "|" + status + "|" + stageNum + "|" + int(keypad) + "\n");
  }
  // c.write(); // to write
  if (c.available() > 0)
  {
    input = c.readString();
    input = input.substring(0, input.indexOf("\n"));
    data = int(split(input, '|'));
    if (data[0] == 1)
    {
      //if (data[2] == 0001
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
    else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT && keypad.length() < 3)
    {
      int n = int(key);  // int('0') = 48 \\ Adapted from Quark
      n = n - 48;
      if(n >= 0 && n <= 9)
      keypad = keypad + key;
    }
  }
}