/*    Harry Grubman's EXO Room Escape
      Server Send and Receive Code
*/    
import processing.net.*;

Server main_server;
Client c;
String input;
int data[];

void setup()
{
  frameRate(5);  // Important to not overload server
  main_server = new Server(this, 12345); // Starts the server on a port
  //
}
void draw()
{
  c = main_server.available();
  if (c != null) 
  {
    input = c.readString();
    int i = input.indexOf('\n');
    if(i != -1)
    {
      input = input.substring(0, i);
      main_server.write(input + '\n'); // echos reception to other nodes
    }
    data = int(split(input, '|'));
    println(input);
  }
  main_server.write("0|1|0\n"); // running code for server
}

void exit()
{
  for (int n = 0; n < 2; n++)
  main_server.write("0|0|0\n");
}