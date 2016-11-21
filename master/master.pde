import processing.net.*;

Client c;
String input;
int data[];

void setup()
{
  frameRate(5);
  c = new Client(this, "127.0.0.1", 12345);
  size(1280, 690);
  background(0);
}

void draw()
{
  masterLayout();
   //c.write(); // to write
  if (c.available() > 0)
  {
    input = c.readString();
    input = input.substring(0, input.indexOf("\n"));
    data = int(split(input, '|'));
    
  }
}

void masterLayout()
{
  stroke(255);
  line(0, 100, width, 100);
  line(0, height-200, width, height-200);
  line(4*width/12, 0, 4*width/12, 100);
  line(5*width/12, 0, 5*width/12, 100);
  line(6*width/12, 0, 6*width/12, 100);
  line(7*width/12, 0, 7*width/12, 100);
  line(8*width/12, 0, 8*width/12, 100);
  line(4*width/12, 20, width, 20);
  textAlign(CENTER, CENTER);
  text("SERV", 9*width/24, 10);
  text("MAST", 11*width/24, 10);
  text("RM_1", 13*width/24, 10);
  text("RM_2", 15*width/24, 10);
  text("TIME", 20*width/24, 10);
}