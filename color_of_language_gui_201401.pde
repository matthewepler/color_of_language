
Scrollbar h_bar;
Scrollbar s_bar;
Scrollbar b_bar;
Scrollbar red_bar;
Scrollbar green_bar;
Scrollbar blue_bar;

PFont f;

String[] lines = null;
String[] words = null;
String letters;
String temp_w;
color c;

int GUIwidth = 200;
int resolution = 72;
int docWidth = 8*resolution + GUIwidth;
int docHeight = 10*resolution;
//int lettersPerLine = 28;
int margin = docWidth/14;
int x = margin;
int y = margin;
int xspacing = docWidth/64;
float bheight = xspacing*1.5;
int yspacing = xspacing*2;
int endPoem;
int icounter, jcounter, kcounter;
String[] breaksArray;
int breaksCounter;
int xLimit = docWidth - margin - GUIwidth;
float h, s, b;
float user_h, user_s, user_b;
boolean firstLetter;
int keepLetterValue;
int letterCounter = 0;

// Controlled by user input
String filename = "iTooSing.txt";
float red;
float green;
float blue;
color userColor;
float hdivideBy = 0;
float sdivideBy = 0;
float bdivideBy = 0;
int totalBreaks = 2;
String breaksAt = "6, 13";

float Hue_Shift = 4;
float Brightness_Shift;
float Saturation_Shift;
float hueDiff, satDiff, briDiff;

void setup() {
  size(776, 720);
  
  red_bar = new Scrollbar(docWidth-GUIwidth+15, 110, 150, 10, 0, 255);
  green_bar = new Scrollbar(docWidth-GUIwidth+15, 160, 150, 10, 0, 255);
  blue_bar = new Scrollbar(docWidth-GUIwidth+15, 210, 150, 10, 0, 255);
  h_bar = new Scrollbar(docWidth-GUIwidth+15, 300, 150, 10, 0, 1.5);
  s_bar = new Scrollbar(docWidth-GUIwidth+15, 350, 150, 10, 0, 2);
  b_bar = new Scrollbar(docWidth-GUIwidth+15, 400, 150, 10, 0, 5);
  
  f = loadFont("Arial.vlw");  
  background(255);
  lines = loadStrings(filename);
  endPoem = lines.length;
  breaksArray = splitTokens(breaksAt, ", ");;
}

void draw() {
  fill(155);
  rect(docWidth - GUIwidth, 0, GUIwidth, height);
    textFont(f, 18);
    
        fill(255);
    text("Base Color", docWidth - GUIwidth+15, 20);
    fill(255);
    text("Red", docWidth - GUIwidth + 15, 105);
    red = red_bar.getPos();
    red_bar.update(mouseX, mouseY);
    red_bar.display();
    fill(255);
    text("Green", docWidth - GUIwidth + 15, 155);
    green = green_bar.getPos();
    green_bar.update(mouseX,mouseY);
    green_bar.display();
    fill(255);
    text("Blue", docWidth - GUIwidth + 15, 205);
    blue = blue_bar.getPos();
    blue_bar.update(mouseX,mouseY);
    blue_bar.display();
    
    calcUserColor(red, green, blue);
    fill(userColor);
    rect(docWidth - GUIwidth+15, 25, 50, 50);
    colorMode(HSB, 255);
  user_h = hue(userColor);
  user_s = saturation(userColor);
  user_b = brightness(userColor);
  
    fill(255);
    text("Hue", docWidth - GUIwidth + 15, 295);
    hdivideBy = h_bar.getPos();
    h_bar.update(mouseX, mouseY);
    h_bar.display();
    fill(255);
    text("Saturation", docWidth - GUIwidth + 15, 345);
    sdivideBy = s_bar.getPos();
    s_bar.update(mouseX,mouseY);
    s_bar.display();
    fill(255);
    text("Brightness", docWidth - GUIwidth + 15, 395);
    bdivideBy = b_bar.getPos();
    b_bar.update(mouseX,mouseY);
    b_bar.display();
    
       for (int i=0; i < endPoem; i++) {    
    if(i > 0 && i == int(breaksArray[breaksCounter])){
     fill(#FFFFFF);
     rect(x,y,xspacing, bheight);
     y = y+yspacing;
     breaksCounter++;
     i++;
     if(breaksCounter == totalBreaks){
      breaksCounter = 0; 
     }
    } 
    icounter = i;
    words = splitTokens(lines[i]);
    for (int j=0; j < words.length; j++) {
      jcounter = j;
      letters = words[j];
      float wordlength = letters.length()*xspacing;
      if(x + wordlength > xLimit){
        x = margin;
        y = y + yspacing;
      } 
      for (int k=0; k < letters.length(); k++) {
//        println("LETTER # " + letterCounter);
        letterCounter++;
//        println("word = " + letters);
//        println("letter = " + letters.charAt(k));
        kcounter = k;
        c = getColor(k);
        display(c);
        keepLetterValue = int(letters.charAt(k));
        
      }
      fill(255);
      rect(x, y, xspacing, bheight);
      x += xspacing;
    }
   x = margin;
    y = y + yspacing;
  } 
  icounter = 0;
  jcounter = 0;
  kcounter = 0;
  letterCounter = 0;
  println("draw complete");
  x = margin;
 y = margin; 
}

color getColor (int _k) {
//    println("icounter = " + icounter);
//    println("jcounter = " + jcounter);
//    println("kcounter = " + kcounter);
    if (icounter == 0 && jcounter == 0 && kcounter == 0 && letters.length() == 1) {
//    println("FIRST LETTER OF DOC && 1 LETTER WORD");
    firstLetter = true;
    // use the last letter in 1st line for Hue,
    String temp_w = words[words.length-1];
    h = int(temp_w.charAt(temp_w.length()-1));   
    // the first letter in Doc for Saturation,
    temp_w = words[0];
    s = int(temp_w.charAt(0));
    // and the first letter in the next word for Brightness. 
    temp_w = words[jcounter+1];
    b = int(temp_w.charAt(0));
  } 
  else if (icounter == 0 && jcounter == 0 && kcounter == 0 && letters.length() == 2) {
//    println("FIRST LETTER OF DOC && 2 LETTER WORD, 1ST LETTER");  
    firstLetter = true;
    // use the last letter in 1st line for Hue,
    String temp_w = words[words.length-1];
    h = int(temp_w.charAt(temp_w.length()-1));   
    // the first letter in Doc for Saturation,
    temp_w = words[0];
    s = int(temp_w.charAt(0));
    // and the next letter for Brightness. 
    b = int(temp_w.charAt(1));
  } 
  else if (icounter == 0 && jcounter == 0 && kcounter == 0 && letters.length() == 2) {
//    println("FIRST LETTER OF DOC && 2 LETTER WORD, 2ND LETTER"); 
    firstLetter = true; 
    // use the first word in Doc for Hue,
    h = int(letters.charAt(0));   
    // the current letter for Saturation,
    s = int(temp_w.charAt(1));
    // and the first letter in next word for Brightness. 
    temp_w = words[jcounter+1];
    b = int(temp_w.charAt(0));
  } 
  else if (icounter == 0 && jcounter == 0 && kcounter == 0) {
//    println("FIRST LETTER IN DOC");
    firstLetter = true;
    // use the last letter in 1st line for Hue,
    String temp_w = words[words.length-1];
    h = int(temp_w.charAt(temp_w.length()-1)); 
    // the first letter in Doc for Saturation,
    temp_w = words[0];
    s = int(temp_w.charAt(0));
    // and the second letter in Doc for Brightness. 
    b = int(temp_w.charAt(1));
    words = splitTokens(lines[0]);
  } else if (jcounter == 0 && kcounter == 0 && letters.length() == 1){
//    println("FIRST LETTER OF LINE && 1 LETTER IN LENGTH");
    // use last letter in line for hue
    letters = words[words.length-1];
    h = int(letters.charAt(letters.length()-1));
    letters = words[jcounter];
    // use current letter for saturation
    s = int(letters.charAt(_k));
    // use first letter of next word for brightness
    letters = words[jcounter+1];
    b = int(letters.charAt(0));
    letters = words[jcounter];
  } else if (jcounter == 0 && kcounter == 0 && letters.length() == 2){
//    println("FIRST LETTER OF LINE && 2 LETTERs IN LENGTH - 1ST LETTER");
    if(kcounter == 0){
    // use last letter in line for hue
    letters = words[words.length-1];
    h = int(letters.charAt(letters.length()-1));
    letters = words[jcounter];
    // use current letter for saturation
    s = int(letters.charAt(0));
    // use next letter for brightness
    b = int(letters.charAt(1));
    } else {
//    println("FIRST LETTER OF LINE && 1 LETTER IN LENGTH - 2ND LETTER");
    // use previous letter for hue
    h = int(letters.charAt(0));
    // use current letter for saturation
    s = int(letters.charAt(_k));
    // use first letter of next word for brightness
    letters = words[jcounter+1];
    b = int(letters.charAt(0));
    letters = words[jcounter];
    }
  } else if (jcounter == 0 && kcounter == 0){
//    println("FIRST LETTER OF EACH LINE");
    // use last letter in line for hue
    letters = words[words.length-1];
    h = int(letters.charAt(letters.length()-1));
    // use the current letter for saturation
    letters = words[jcounter];
    s = int(letters.charAt(_k));
    // use the next letter for brightness
    b = int(letters.charAt(_k+1));
  } else if (jcounter == words.length-1 && kcounter == letters.length()-1) {
//    println("LAST LETTER OF EACH LINE");
    // use the previous letter for hue
    h = int(letters.charAt(_k-1));
    // use the current letter for saturation
    s = int(letters.charAt(_k));
    // use the first letter of the same line for brightness
    letters = words[0];
    b = int(letters.charAt(0));
    letters = words[jcounter];
  } 
  else if (letters.length() == 1 && icounter == endPoem-1 && jcounter == words.length-1) {
//    println("LAST LETTER OF DOC && 1 LETTER");
    // use the last letter in the previous word for hue, 
    String temp_w = words[jcounter-1];
    h = int(temp_w.charAt(temp_w.length()-1));  
    // the last letter in Doc for Saturation,
    temp_w = words[jcounter];
    s = int(temp_w.charAt(0));
    // and the first letter in Doc for Brightness.
    words = splitTokens(lines[0]);
    temp_w = words[0];
    b = int(temp_w.charAt(0));
  } 
  else if (letters.length() == 2 && icounter == endPoem-1 && jcounter == words.length-1) {
//    println("LAST LETTER OF DOC && 2 LETTERS, 1ST LETTER");
    //    first letter
    if (kcounter == 0) {
      //    use the last letter in the previous word for hue, 
      String temp_w = words[jcounter-1];
      h = int(temp_w.charAt(temp_w.length()-1));  
      // the current letter for Saturation,
      s = int(letters.charAt(0));
      // and the next letter for Brightness.
      b = int(letters.charAt(1));
    } 
    else if (kcounter == 1) {
//      println("LAST LETTER OF DOC && 2 LETTERS, 2ND LETTER");
      //    use the previous letter for hue, 
      h = int(letters.charAt(0));  
      // the current letter for Saturation,
      s = int(letters.charAt(1));
      // and the first letter in Doc for Brightness.
      words = splitTokens(lines[0]);
      temp_w = words[0];
      b = int(temp_w.charAt(0));
    }
  } 
  else if (icounter == endPoem-1 && jcounter == words.length-1 && kcounter == letters.length()-1) {
//    println("LAST LETTER OF DOC");
    // use the next to last letter in Doc for Hue, 
    words = splitTokens(lines[endPoem]);
    String temp_w = words[words.length-1];
    h = int(temp_w.charAt(temp_w.length()-2));  
    // the last letter in Doc for Saturation,
    s = int(temp_w.charAt(temp_w.length()-1));
    // and the first letter in Doc for Brightness.
    words = splitTokens(lines[0]);
    temp_w = words[0];
    b = int(temp_w.charAt(0));
  } 
  else if (letters.length() == 1) {
//    println("ONE LETTER WORDS");
    // use the last letter of the previous word for Hue,
    temp_w = words[jcounter-1];
    h = int(temp_w.charAt(temp_w.length()-1));
    // the current letter for Saturation,
    s = int(letters.charAt(kcounter));
    // the first letter of the following word for Brightness.
    temp_w = words[jcounter+1];
    b = int(temp_w.charAt(0));
  } 
  else if (letters.length() == 2) { 
    if (kcounter == 0) {
//      println("TWO LETTER WORDS, 1ST LETTER");
      // h. Two letter words
      // use last letter of previous word for Hue,
      temp_w = words[jcounter-1];
      h = int(temp_w.charAt(temp_w.length()-1));
      // the current letter for Saturation,
      s = int(letters.charAt(0));
      // the next letter for Brightness.
      b = int(letters.charAt(1));
    } 
    else if (kcounter == 1) {
//      println("TWO LETTER WORDS, 2ND LETTER");
      // use next to last letter for Hue,
      h = int(letters.charAt(0));
      // the current letter for Saturation,
      s = int(letters.charAt(1));
      // the first letter of the *next Word for Brightness.
      temp_w = words[jcounter+1];
      b = int(temp_w.charAt(0));
    }
  } 
  else if (kcounter == 0) {
//    println("FIRST LETTER OF EACH WORD");
    // use last letter of previous word for Hue,
    temp_w = words[jcounter-1];
    h = int(letters.charAt(letters.length()-1));
    // the current letter for Saturation,
    letters = words[jcounter];
    s = int(letters.charAt(0));
    // the next letter for Brightness.
    b = int(letters.charAt(1));
  } 
  else if (kcounter == letters.length()-1) {
//    println("LAST LETTER OF EACH WORD");
    // use next to last letter for Hue,
    h = int(letters.charAt(kcounter-1));
    // the current letter for Saturation,
    s = int(letters.charAt(letters.length()-1));
    // the first letter of the next Word for Brightness.
    temp_w = words[jcounter+1];
    b = int(temp_w.charAt(0));
  } 
  else {
//    println("NORMAL LETTER");
    h = int(letters.charAt(_k-1));
    s = int(letters.charAt(_k));
    b = int(letters.charAt(_k+1));
  }
  
//  println("After IF's:");
//  println("h = " + h);
//  println("s = " + s);
//  println("b = " + b);
    
  h = int(map(h, 33, 126, 0, 255));
  s = int(map(s, 33, 126, 0, 255));
  b = int(map(b, 33, 126, 0, 255));
  //  println("User Color Info:");   
//  println("user_h : " + user_h);
//  println("user_s : " + user_s);
//  println("user_b : " + user_b);
//   println("After MAPs:");
//   println("h = " + h);
//   println("s = " + s);
//   println("b = " + b);
 
hueDiff = abs(user_h - h)/hdivideBy;
   satDiff = abs(user_s - s)/sdivideBy;    
   briDiff = abs(user_b - b)/bdivideBy;
if(int(letters.charAt(kcounter)) > keepLetterValue){
        h = user_h + hueDiff;
        s = user_s + satDiff;
        b = user_b + briDiff;
        } else{
         h = user_h - hueDiff;
         s = user_s - satDiff;
         b = user_b - briDiff; 
        }  
  

  

  
        
    return color(h, s, b);
}

void display (color _c) {
  noStroke();
  fill(_c);
  rect(x, y, xspacing, bheight);
  x += xspacing;
}

void keyPressed(){
 if(key == 's'){
   int s = second();
   int m = minute();
   int h = hour();
   int d = day();
   int mn = month();
   int yr = year();
  save(filename + "_" + mn + "." + d + "." + yr + "_" + h + "." + m + "." + s); 
  println("IMAGE SAVED!");
}
}
  
void mousePressed(){
  h_bar.press(mouseX,mouseY);
  s_bar.press(mouseX,mouseY);
  b_bar.press(mouseX,mouseY);
  red_bar.press(mouseX,mouseY);
  green_bar.press(mouseX,mouseY);
  blue_bar.press(mouseX,mouseY);
  
}

void mouseReleased() {
 h_bar.release(); 
 s_bar.release();
 b_bar.release();
 red_bar.release(); 
 green_bar.release();
 blue_bar.release();
}

void calcUserColor (float _red, float _green, float _blue) {
 colorMode(RGB);
  userColor = color(_red, _green, _blue);
}


/*         
 Problems, in order: 
 a. *first of doc & 1 letter, 
 b. *first of doc & 2 letter, 
 c. *first of doc,
 n. first letter of each line & 1 letter
 o. first letter of each line & 2 letters
 m. *first letter of each line
 d. *last of doc & 1 letter,
 e. *last of doc & 2 letters,
 f. *last of doc,
 g. *1 letter,
 h. *2 letters, 
 j. *first letter of word,
 k. *last letter of word,
 l. *normal letters.
 
 add: last letter in line, carriage return
 
 Can this be done with everything in "draw" in "setup"? Better performance?
 */
