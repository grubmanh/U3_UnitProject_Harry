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
int rm1_code = 1234;
int rm2_code = 1234;
int forceCode = 0000;
String executionName = "";
int startTime;
Boolean oneTime = false;
String time = "00:00:00";
int hours = 1;
int minutes = 1;
int seconds = 10;
Boolean timerPaused = false;

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
  if (millis() % 10000 == 0);
  {
  timer();
  }
  println(millis());
  println(forceCode);
  if (forceCode != 0000)
  {
  consoleApp(forceCode);
  forceCode = 0000;
  }
  if (executionName != "")
  {
    int ts = millis();
    if (millis() > (ts + 6000))
    executionName = "";
  }
   //c.write(); // to write
  if (c.available() > 0)
  {
    input = c.readString();
    int i = input.indexOf('\n');
    println(i);
    if(i != -1)
    {
      input = input.substring(0, i);
      println(input);
    }
    data = int(split(input, '|'));
    if (data[0] == 0) // script from server
    {
      if (data[1] == 1) // server is available
      serverStatus = "CONNECTED";
      if (data[1] == 0) // server is unavailable
      serverStatus = "NO CONN.";
    }
    if (data[0] == 2) // script from room1
    {
      if (data[1] == 1) // room1 is available
      room1Status = "CONNECTED";
      if (data[1] == 0) // room1 is unavailable
      room1Status = "NO CONN.";
      if (data[2] == 1) // room is rooming
        rm1_code = data[3];
    }
    if (data[0] == 3) // script from room2
    {
      if (data[1] == 1) // room2 is available
      room2Status = "CONNECTED";
      if (data[1] == 0) // room2 is unavailable
      room2Status = "NO CONN.";
      if (data[2] == 1) // room is rooming
        rm2_code = data[3];
    }
  }
  if (oneTime == false && executionName != "")
  {
    startTime = millis();
    oneTime = true;
  }
  if ((millis() - startTime) > 1000)
  {
    executionName = "";
    oneTime = false;
  }
}

void masterLayout()
{
  textSize(15);
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
  line(0, height-170, width, height-170);
  line(3*width/8, height-170, 3*width/8, height);
  text("RM_1 CODE", 3*width/16, height-185);
  text("RM_2 CODE", 9*width/16, height-185);
  text("CONSOLE", 14*width/16, height-185);
  textAlign(CENTER, CENTER);
  text("SERV", 9*width/24, 10);
  text(serverStatus, 9*width/24, 60);
  text("MAST", 11*width/24, 10);
  text(masterStatus, 11*width/24, 60);
  text("RM_1", 13*width/24, 10);
  text(room1Status, 13*width/24, 60);
  text("RM_2", 15*width/24, 10);
  text(room2Status, 15*width/24, 60);
  text("TIME", 10*width/12, 10);
  image(exo, width/12, 0, 200, 100);
  text(console, 7*width/8, height-100);
  textSize(50);
  text(time, 10*width/12, 60);
  text(executionName, 7*width/8, height-100);
  textSize(100);
  text(rm1_code, 3*width/16, height-93);
  text(rm2_code, 9*width/16, height-93);
}
void keyPressed() // Adapted from Amnon.p5
{
  if (keyCode == RETURN || keyCode == ENTER)
  {
    forceCode = int(console);
    console = "";
  }
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
  else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT && console.length() < 5)
  {
    console = console + key;
  }
}

void consoleApp(int forceCode)
{
  println("ConsoleApp called");
  println("forceCode: " + forceCode);
  c.write("1|1|0|" + forceCode + "\n");
  switch(forceCode) 
  {
  case 0000:
    executionName = "NULL";
    break;
  case 8888:
    executionName = "Both Correct";
    break;
  case 8889:
    executionName = "RM_1 Correct";
    break;
  case 8890:
    executionName = "RM_2 Correct";
    break;
  case 9999: 
    executionName = "Reset All";
    break;
  case 1234: 
    executionName = "Start Game";
    timerPaused = false;
    break;
  case 4321:
    executionName = "Stop Game";
    break;
  case 3223:
    executionName = "Pause Game";
    timerPaused = true;
    break;
  case 5555:
    executionName = "Technical Difficulty";
    break;
  }
}

void timer()
{
  if (timerPaused == false)
  {
    if (minutes > 0 && seconds == 0)
    {
      minutes --;
      seconds += 59;
    }
    if (hours > 0 && minutes == 0 && seconds == 0)
    {
      hours --;
      minutes += 59;
      seconds += 59;
    }
    if (seconds > 0)
    {
      seconds --;
    }
    time = hours + ":" + minutes + ":" + seconds;
  }
}