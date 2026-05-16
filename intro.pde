int scene = 0;
// 0 = 시작 화면
// 1 = 게임 화면
// 2 = 설정 화면

//이거 연결할려면 수정 조금 필요하니까
//주석있는거 읽어줘

float menuX = 0;
float menuY = 0;
float menuW = 260;
float menuH = 500;

void setup() {
  size(800, 500);
  textAlign(CENTER, CENTER);
  smooth();
}

void draw() {
  background(10, 10, 25);

  if (scene == 0) {
    drawIntroScreen();
  } else if (scene == 1) {
    drawGameScreen();
  } else if (scene == 2) {
    drawSettingScreen();
  }
}

void drawIntroScreen() {
  drawSpaceBackground();

  // 왼쪽 메뉴 패널
  noStroke();
  fill(20, 25, 45, 230);
  rect(menuX, menuY, menuW, menuH);

  // 메뉴 제목
  fill(255);
  textSize(34);
  text("MY GAME", menuW / 2, 90); //게임 이름좀 원하는 걸로 수정 ㄱㄱ

  fill(150, 200, 255);
  textSize(16);
  text("Main Menu", menuW / 2, 130);

  // 버튼
  drawButton("START", 40, 190, 180, 55);
  drawButton("SETTING", 40, 265, 180, 55);

  // 오른쪽 인트로 영역
  fill(255);
  textSize(52);
  text("Introduce", 530, 210);

  fill(180, 220, 255);
  textSize(20);
  text(" This is game ", 530, 270); //여기 대충 소개하는 내용점 넣어줘
}

void drawSpaceBackground() { //이거 원하는 배경으로 교체할려면 갠톡
  randomSeed(10);

  noStroke();

  for (int i = 0; i < 120; i++) {
    float x = random(width);
    float y = random(height);
    float size = random(1, 3);

    float alpha = sin(frameCount * 0.05 + i) * 80 + 175;

    fill(255, alpha);
    ellipse(x, y, size, size);
  }
}

void drawButton(String label, float x, float y, float w, float h) {
  boolean hover = isMouseInside(x, y, w, h);

  if (hover) {
    fill(80, 150, 255);
  } else {
    fill(45, 70, 120);
  }

  stroke(160, 210, 255);
  strokeWeight(2);
  rect(x, y, w, h, 12);

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
    if (isMouseInside(40, 190, 180, 55)) {
      scene = 1;
    }

    if (isMouseInside(40, 265, 180, 55)) {
      scene = 2;
    }
  } else if (scene == 2) {
    if (isMouseInside(40, 400, 180, 55)) {
      scene = 0;
    }
  }
}

void drawGameScreen() { //이게 게임 시작 부분임 수정 ㄱㄱ
  background(20, 40, 30);

  fill(255);
  textSize(40);
  text("GAME START!", width / 2, height / 2);

  textSize(18);
  text("Connect the nextPage", width / 2, height / 2 + 50);
}

void drawSettingScreen() {
  background(15, 15, 35);

  // 왼쪽 설정 패널
  noStroke();
  fill(20, 25, 45, 230);
  rect(menuX, menuY, menuW, menuH);

  fill(255);
  textSize(32);
  text("SETTING", menuW / 2, 90);

  fill(180, 220, 255);
  textSize(18);
  text("Volume : 100%", menuW / 2, 170);
  text("Difficulty : Normal", menuW / 2, 220);

  drawButton("BACK", 40, 400, 180, 55);

  fill(255);
  textSize(36);
  text("Setting Screen", 530, 230);

  fill(180, 220, 255);
  textSize(18);
  text("this page is not exist. songHeyongsu", 530, 280);
}
