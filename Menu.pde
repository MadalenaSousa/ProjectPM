class Menu {
  PImage img;
  String topo, option1, option2, option3, option4;
  PFont f;
  float larg, alt, x, y;
  int t1, t2, t3, t4;

  Menu(PImage img, String topo, String option1, String option2, String option3, String option4) {
    this.img = img;
    this.topo = topo;
    this.option1 = option1;
    this.option2 = option2;
    this.option3 = option3;
    this.option4 = option4;
    f = createFont("Oswald Semibold", 30);
    larg = 300;
    alt = 65;
    x = width/2 - larg/2;
    y = 400;
    t1 = 20;
    t2 = 20;
    t3 = 20;
    t4 = 20;
  }

  //Estrutura geral dos menus
  void desenha() {
    img.resize(1000, 800);
    imageMode(CORNER);
    image(img, 0, 0);
    textAlign(CENTER, CENTER);
    noStroke();
    textFont(f);

    //Botões
    rectMode(CENTER);
    fill(#1C477E);
    rect(width/2, 150, 600, 100, 50);
    rectMode(CORNER);
    fill(#F5D57E);
    //opção 1
    rect(x, y, larg, alt, 50);
    //opção 2
    rect(x, y + 1.5 * alt, larg, alt, 50);

    //Texto dos botões
    fill(255);
    textSize(90);
    text(topo, width/2, 135);

    textSize(t1);
    text(option1, width/2, y + 25);
    textSize(t2);
    text(option2, width/2, y + 25 + 1.5 * alt);
  }

  // Deteta quando o cursor está sobre o botão de opção1
  boolean cursorSobreOption1() {
    if (mouseX >= x && mouseX <= x + larg && mouseY >= y && mouseY <= y + alt) {
      return true;
    } else {
      return false;
    }
  }

  // Deteta quando o cursor está sobre o botão de opção2
  boolean cursorSobreOption2() {
    if (mouseX >= x && mouseX <= x + larg && mouseY >=  y + 1.5 * alt && mouseY <=  y + 1.5 * alt + alt) {
      return true;
    } else {
      return false;
    }
  }

  // Deteta quando o cursor está sobre o botão de opção2
  boolean cursorSobreOption3() {
    if (mouseX >= x && mouseX <= x + larg && mouseY >= y + 3 * alt && mouseY <= y + 3 * alt + alt) {
      return true;
    } else {
      return false;
    }
  }

  // Deteta quando o cursor está sobre o botão de opção2
  boolean cursorSobreOption4() {
    if (mouseX >= x && mouseX <= x + larg && mouseY >= y + 20 + 4.5 * alt && mouseY <= y + 20 + 4.5 * alt + alt) {
      return true;
    } else {
      return false;
    }
  }
}
