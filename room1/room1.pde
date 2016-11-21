import processing.net.*;

Client c;
String input;
int data[];

void setup()
{
  frameRate(5);
  c = new Client(this, "127.0.0.1", 12345);
}

void draw()
{
  // c.write(); // to write
  if (c.available() > 0)
  {
    input = c.readString();
    input = input.substring(0, input.indexOf("\n"));
    data = int(split(input, ' '));
  }
}