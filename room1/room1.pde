import processing.net.*;

Client c;
String input;
int data[];
float pulseOpacity;
String stage = "initialize";
PImage exo;

void setup()
{
  frameRate(5);
  fullScreen();
  c = new Client(this, "127.0.0.1", 12345);
  exo = loadImage("Exo_Logo.png");
  pulseOpacity = 0.0;
}

void draw()
{
  if (stage == "initialize")
  {
    imageMode(CENTER);
    image(exo, width/2, height/2);
  }
  // c.write(); // to write
  if (c.available() > 0)
  {
    input = c.readString();
    input = input.substring(0, input.indexOf("\n"));
    data = int(split(input, '|'));
  }
}