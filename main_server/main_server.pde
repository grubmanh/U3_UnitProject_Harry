import processing.net.*;

Server main_server;
Client c;
String input;
int data[];

void setup()
{
  frameRate(5);  // Important to not overload server
  main_server = new Server(this, 12345); // Starts the server on a port
  // s.write(); // function for writing to the server
  //
}
void draw()
{
  c = main_server.available();
  if (c != null) 
  {
    input = c.readString();
    input = input.substring(0, input.indexOf("\n"));
    data = int(split(input, ' '));
}