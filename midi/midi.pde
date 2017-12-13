import javax.sound.midi.*;
import java.io.*;
Table table;

Sequencer playMidi;
File selection;

long finalTick; // the last midi tick clock event (the end of the piece)
 
void setup(){
  size(1200, 600);
  background(0);
  noStroke();
  fill(255);
  table = loadTable("data/BWV784.csv");
  try
  {
    println("trying midi");
    File selection = new File(dataPath("BWV784.MID"));
    playMidi = MidiSystem.getSequencer();
    playMidi.open();
    Sequence fileSequence = MidiSystem.getSequence(selection);
    playMidi.setSequence(fileSequence);
    playMidi.start();
    println("midi started");
  }catch(Exception e) { println("FILE NOT FOUND!!"); }
  
  for(TableRow row : table.rows()){
    int tick = row.getInt(1);
    if(tick > finalTick) finalTick = tick;
  }
}


void draw(){
  background(0);
  println(playMidi.getTickPosition());
  long currentTick = playMidi.getTickPosition();
  for(TableRow row : table.rows()){
    String type = row.getString(2);
    if(type.equals("Note_on_c")){
      int tick = row.getInt(1);
      int pitch = row.getInt(4);
      float x = tick/70585.0;
      float xPixel = width * x * 10;
      float xoff = float(mouseX) * (10-1);
      //float brightness = 1/sqrt(tick-currentTick);
      float brightness = 15;
      // dTime is negative for notes past, positive=incoming
      long dTime = tick - currentTick;
      if(dTime < 0 && dTime > -100){
        brightness = 255;
      } else if(dTime < 0 && dTime > -1000){
        float fade = (dTime+100.0) / -(1000.0-100.0);
        brightness = 15 + 240 - fade*240;
      }
      
      fill(brightness);
      //if( currentTick > tick ){
      //  fill( brightness, 120);
      //} else{ fill(brightness, 255); }
      
      xoff = width*(10-0.5) * currentTick / float(int(finalTick));
      xoff -= width*(0.25);
      
      ellipse(xPixel - xoff, height*0.5-(pitch-60)*6, 20, 20);
    }
  }  
}