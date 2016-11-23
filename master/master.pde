import processing.net.*;
PImage exo;

Client c;
String input;
String console = "con";
int data[];
String serverStatus = "NO CONN.";
String masterStatus = "NO CONN.";
String room1Status = "NO CONN.";
String room2Status = "NO CONN.";
//char 

void setup()
{
  frameRate(5);
  c = new Client(this, "127.0.0.1", 12345);
  exo = loadImage("Exo_Logo.png");
  masterStatus = "CONNECTED";
  size(1280, 690);
  background(0);
}

void draw()
{
  background(0);
  masterLayout();
   //c.write(); // to write
  if (c.available() > 0)
  {
    input = c.readString();
    input = input.substring(0, input.indexOf("\n"));
    data = int(split(input, '|'));
    if (data[0] == 0) // script from server
    {
      if (data[1] == 1) // server is available
      serverStatus = "CONNECTED";
    }
    if (data[0] == 2) // script from room1
    {
      if (data[1] == 1) // room1 is available
      serverStatus = "CONNECTED";
    }
    if (data[0] == 3) // script from room1
    {
      if (data[1] == 1) // room1 is available
      serverStatus = "CONNECTED";
    }
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
  line(3*width/4, height-200, 3*width/4, height);
  textAlign(CENTER, CENTER);
  text("SERV", 9*width/24, 10);
  text(serverStatus, 9*width/24, 60);
  text("MAST", 11*width/24, 10);
  text(masterStatus, 11*width/24, 60);
  text("RM_1", 13*width/24, 10);
  text(room1Status, 13*width/24, 60);
  text("RM_2", 15*width/24, 10);
  text(room2Status, 15*width/24, 60);
  text("TIME", 20*width/24, 10);
  image(exo, width/12, 0, 200, 100);
  text(console, 3*width/4, height-100);
}

void keyPressed() // Adapted from Amnon.p5
{
  if (keyCode == BACKSPACE)
  {
    if (console.length() > 0)
    {
      console = console.substring(0, console.length()-1);
    }
  }
  else if (keyCode == DELETE)
  {
    console = "";
  }
  else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT && console.length() < 7)
  {
    console = console + key;
  }
}