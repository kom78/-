int scene = 0; 
// 0 = 시작 화면, 1 = 게임 화면, 2 = 설정 화면, 3 = 엔딩 화면(인트로)

PImage mainmenu; //배경 이걸로 바꿈

float menuX = 0;
float menuY = 0;
float menuW = 260;
float menuH = 500;

// [엔딩 담당 변수]
float textAlpha = 0; 
float fadeSpeed = 3.0; 
boolean fadeComplete = false; 
PFont myFont; 

// =========================
// [설정 화면 추가 변수]
// =========================
float volume = 1.0; // 0.0 ~ 1.0, 1.0 = 100%

float sliderX = 55;
float sliderY = 195;
float sliderW = 150;
float knobSize = 18;

boolean volumeDragging = false;

String[] difficultyList = {"Ez", "Normal", "Sibar"};
int difficultyIndex = 1; // 기본값: 보통

void setup() {
  size(800, 500);
  mainmenu = loadImage("MainMenu.png"); 
  textAlign(CENTER, CENTER);
  smooth();
  
  // 한글 폰트 설정
  myFont = createFont("Malgun Gothic", 32); 
  textFont(myFont);
}

void draw() {
  background(10, 10, 25);

  if (scene == 0) {
    drawIntroScreen();
  } else if (scene == 1) {
    drawGameScreen();
  } else if (scene == 2) {
    drawSettingScreen();
  } else if (scene == 3) {
    drawEndingScreen();
  }
}



// --- 엔딩 화면 함수 (인트로) ---
void drawEndingScreen() {
  rectMode(CORNER); 
  fill(0, 200); 
  rect(0, 0, width, height);
  
  if (textAlpha < 255) textAlpha += fadeSpeed; 
  else {
    textAlpha = 255;
    fadeComplete = true;
  }
  
  textAlign(CENTER, CENTER);
  fill(0, textAlpha);
  textSize(62);
  text("GAME CLEAR!", width/2 + 3, height * 0.4 + 3);
  
  fill(255, textAlpha); 
  textSize(60); 
  text("GAME CLEAR!", width/2, height * 0.4);
  
  if (fadeComplete) {
    float btnX = width/2;
    float btnY = height * 0.75;
    float btnW = 200;
    float btnH = 60;
    
    rectMode(CENTER); 
    boolean hover = isMouseInside(btnX - btnW/2, btnY - btnH/2, btnW, btnH);
    if (hover) fill(80, 150, 255); 
    else fill(45, 70, 120); 
    
    stroke(160, 210, 255); 
    strokeWeight(2); 
    rect(btnX, btnY, btnW, btnH, 12); 
    
    noStroke();
    fill(255);
    textSize(22);
    text("시작 화면으로", btnX, btnY); 
  }
  
  rectMode(CORNER); 
  noStroke();
}

// --- 인트로 화면 (시작 화면) ---
void drawIntroScreen() {
  drawSpaceBackground();
  noStroke();
  fill(20, 25, 45, 230);
  rect(menuX, menuY, menuW, menuH);

  fill(150, 100, 255);
  textSize(34);
  text("The Project", menuW / 2, 90); 
  fill(150, 200, 255);
  textSize(16);
  text("Main Menu", menuW / 2, 130);

  drawButton("START", 40, 190, 180, 55);
  drawButton("SETTING", 40, 265, 180, 55);

  fill(60, 255, 0, 180);
  textSize(52);
  text("Introduce", 530-140, 210+180);
  fill(0, 200, 0, 180);
  textSize(13);
  text("This is a 2D shooting game where the player \n" + 
       "must defeat waves of incoming enemies to win. \n" + 
       "The core gameplay is moving around to avoid \n" + 
       "enemies while shooting them down.", 530-70, 270+180); 
}

// --- 설정 화면 ---
void drawSettingScreen() {
  background(15, 15, 35);

  noStroke();
  fill(20, 25, 45, 230);
  rect(menuX, menuY, menuW, menuH);

  fill(255);
  textSize(32);
  text("SETTING", menuW / 2, 90);

  fill(180, 220, 255);
  textSize(18);
  text("Volume : " + int(volume * 100) + "%", menuW / 2, 150);

  drawVolumeSlider();

  drawDifficultyButton(40, 245, 180, 55);

  drawButton("BACK", 40, 400, 180, 55);

  fill(255);
  textSize(36);
  text("Setting Screen", 530, 230);

  fill(180, 220, 255);
  textSize(18);
  text("Difficulty : " + difficultyList[difficultyIndex], 530, 280);
  text("Volume : " + int(volume * 100) + "%", 530, 315);
}

// --- 게임 화면 ---
void drawGameScreen() {
  background(20, 40, 30);

  fill(255);
  textSize(40);
  text("GAME START!", width / 2, height / 2);

  textSize(18);
  text("Connect the nextPage", width / 2, height / 2 + 50); 
}

void drawSpaceBackground() {
  image(mainmenu, 0, 0, 2383/2, 1322/2);
}

// =========================
// [볼륨 슬라이더 그리기]
// =========================
void drawVolumeSlider() {
  float knobX = sliderX + sliderW * volume;

  strokeWeight(8);
  stroke(60, 80, 120);
  line(sliderX, sliderY, sliderX + sliderW, sliderY);

  stroke(80, 150, 255);
  line(sliderX, sliderY, knobX, sliderY);

  noStroke();

  boolean hover = dist(mouseX, mouseY, knobX, sliderY) < knobSize;

  if (hover || volumeDragging) {
    fill(180, 220, 255);
  } else {
    fill(255);
  }

  ellipse(knobX, sliderY, knobSize, knobSize);

  fill(180, 220, 255);
  textSize(12);
  text("drag", menuW / 2, sliderY + 30);
}

// =========================
// [난이도 버튼 그리기]
// =========================
void drawDifficultyButton(float x, float y, float w, float h) {
  boolean hover = isMouseInside(x, y, w, h);

  if (hover) fill(80, 150, 255);
  else fill(45, 70, 120);

  stroke(160, 210, 255);
  strokeWeight(2);
  rect(x, y, w, h, 12);

  noStroke();
  fill(255);
  textSize(20);
  text("난이도 : " + difficultyList[difficultyIndex], x + w / 2, y + h / 2);
}

// =========================
// [마우스 위치로 볼륨 갱신]
// =========================
void updateVolumeByMouse() {
  volume = constrain((mouseX - sliderX) / sliderW, 0, 1);
}

void drawButton(String label, float x, float y, float w, float h) {
  boolean hover = isMouseInside(x, y, w, h);

  if (hover) fill(80, 150, 255);
  else fill(45, 70, 120);

  stroke(160, 210, 255);
  strokeWeight(2);
  rect(x, y, w, h, 12);

  noStroke();
  fill(255);
  textSize(22);
  text(label, x + w / 2, y + h / 2);
}

boolean isMouseInside(float x, float y, float w, float h) {
  return mouseX >= x && mouseX <= x + w &&
         mouseY >= y && mouseY <= y + h;
}

void mousePressed() {
  if (scene == 0) {
    if (isMouseInside(40, 190, 180, 55)) scene = 1;
    if (isMouseInside(40, 265, 180, 55)) scene = 2;
  } 
  
  else if (scene == 1) {
    // 게임 본체 영역
  } 
  
  else if (scene == 2) {
    // 볼륨 슬라이더 클릭
    if (isMouseInside(sliderX - 10, sliderY - 20, sliderW + 20, 40)) {
      volumeDragging = true;
      updateVolumeByMouse();
    }

    // 난이도 버튼 클릭
    if (isMouseInside(40, 245, 180, 55)) {
      difficultyIndex++;

      if (difficultyIndex >= difficultyList.length) {
        difficultyIndex = 0;
      }
    }

    // 뒤로가기 버튼
    if (isMouseInside(40, 400, 180, 55)) {
      scene = 0;
    }
  } 
  
  else if (scene == 3) {
    if (fadeComplete && isMouseInside(width/2 - 100, height*0.75 - 30, 200, 60)) {
      scene = 0;
      textAlpha = 0;
      fadeComplete = false;
    }
  }
}

void mouseDragged() {
  if (volumeDragging) {
    updateVolumeByMouse();
  }
}

void mouseReleased() {
  volumeDragging = false;
}
