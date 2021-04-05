// Dependencies:

StringDict dictionary;
PImage[] kanji_1 = new PImage[24]; // let's try to keep it at 24 frames
PFont f;


boolean flag = true;

int borderStroke = 5;

int delay = 30;

int image_frame_count = 0;

String current_kagi = "両";
String current_value = "'on'-reading: リョウ - a measure word for vehicles";



void setup() {
  // FILE-PARSE
  
  f = createFont("MingLiu-ExtB.vlw",64,true);

  dictionary = new StringDict();
  
  String[] lines = loadStrings("vocab.txt");
  
  String kagi = ""; // Fun fact: since "key" is a keyword, we use kagi, which means "key" in Japanese
  String value = "";
  boolean found = false;
  
  for (int word = 0; word < lines.length; word++) {
    
    for (int letter = 0; letter < lines[word].length(); letter++) {
      
    if (lines[word].charAt(letter) != ':' && found == false) kagi += lines[word].charAt(letter);
    else if (lines[word].charAt(letter) != ':' && found == true) value += lines[word].charAt(letter);
    else if (lines[word].charAt(letter) == ':') found = true;
    
    }

    dictionary.set(kagi,value);

    found = false;
    
    kagi = "";
    value = "";
    
    // println(dictionary);
    
}
  
  
  
  
  
  size(1024, 800);
  smooth();
  stroke(0);
  background(255, 255, 255);
  
  // OPTIMIZE LOAD-IMAGE
  
  String frame_number;
  String gif_frame;
  
  for (int i = 0; i < 24; i++) {
    frame_number = "";
    if (i < 10) frame_number += "0";
    frame_number += Integer.toString(i);
    gif_frame = "frame_" + frame_number + "_kanji_1.gif";
    kanji_1[i] = loadImage(gif_frame);
  }
  
  frameRate(120);
  
  
  
}

void draw() {
  
  if (frameCount < 60){
    // We call this once
    fill(0);
    textSize(128);
    textFont(f,256); 
    text(current_kagi,200,300); // this is the "CHOSEN KANJI"
    textSize(24);
    text(current_value,200,355); // this is the "chosen value"
    
    // set SHADOW-TEXT
    
    fill(200);
    textSize(256);
    text(current_kagi,380,650); // this is the "CHOSEN KANJI"
    fill(0);
    textSize(16);
    
  }
  
  
  
  
  if (frameCount % 12 == 0) {
    image_frame_count++;
    image(kanji_1[image_frame_count%24], 550, 100);
  }
  
  fill(0);
  

  
  textSize(24);
  text("RANDOM",50,300);
  text("CLEAR",50,400);
  
  
  strokeWeight(5);
  rect(0, 0, width, borderStroke); // Top
  rect(width-borderStroke, 0, borderStroke, height); // Right
  rect(0, height-borderStroke, width, borderStroke); // Bottom
  rect(0, 0, borderStroke, height); // Left
  
  noFill();
  
  rect(200,400,600,370);
  
  
  
  // CANVAS LOGIC
  if(flag == true && mousePressed) {
    
    if ((mouseX>200) && (mouseY>400) && (mouseX<800) && (mouseY<770)){
      strokeWeight(10);
      line(mouseX, mouseY, pmouseX, pmouseY);
    }
  }
  
}




void mouseDragged() {
  flag = true;
}
void mouseReleased(){
  flag = false;
}

void mousePressed() {

  // HERE we can do some calls to other functions:
  
  // RANDOM KANJI:
  if ((mouseX>50) && (mouseY>276) && 
        (mouseX<160) && (mouseY<300) && flag == false){
          background(255, 255, 255);
      random_kanji();
      // manually erase original locations
      
      textSize(128);
      textFont(f,256); 
      text(current_kagi,200,300); // this is the "CHOSEN KANJI"
       
      textSize(24);
      text(current_value,200,355); // this is the "chosen value"
      
      fill(200);
      textSize(256);
      text(current_kagi,380,650); // this is the "CHOSEN KANJI"
      fill(0);
      textSize(16);
      
    }
  
  
  
  
  // CLEAR CANVAS:
  if ((mouseX>50) && (mouseY>376) && (mouseX<115) && (mouseY<400)){
      clear_canvas();
      fill(200);
      textSize(256);
      text(current_kagi,380,650); // this is the "CHOSEN KANJI"
      fill(0);
      textSize(16);
    }
  
  
}


void clear_canvas() {
  fill(255);
  strokeWeight(5);
  rect(200,400,600,370);
  
}

void random_kanji() {
  
  // println("RANDOM CALLED");
  String[] thekagis = dictionary.keyArray();
  int rand_index = int(random(dictionary.size()));
  
  // println("T KAGI:" + thekagis[rand_index]);
  
  current_kagi = "";
  current_kagi = thekagis[rand_index];
  current_value = dictionary.get(thekagis[rand_index]);
  
 
}
