class Menu {
  PImage img;
  String topo, option1, option2;
  PFont f;
  float larg, alt, x, y;
  int t1, t2;

  Menu(PImage img, String topo, String option1, String option2) {
    this.img = img;
    this.topo = topo;
    this.option1 = option1;
    this.option2 = option2;
    f = createFont("Baskerville", 100, true);
    x = 300;
    y = 400;
    larg = 400;
    alt = 100;
    t1 = 45;
    t2 = 45;
  }

  //Estrutura geral dos menus
  void desenha() {
    img.resize(600, 800);
    image(img, 0, 0);
    image(img, 500, 0);
    textAlign(CENTER, CENTER);
    noStroke();
    textFont(f);

    //Botões
    rectMode(CENTER);
    fill(#1C477E);
    rect(width/2, 150, 600, 100);
    rectMode(CORNER);
    fill(#F5D57E);
    rect(x, y, larg, alt);
    rect(x, y+200, larg, alt);

    //Texto dos botões
    fill(255);
    textSize(90);
    text(topo, width/2, 135);
    textSize(t1);
    text(option1, width/2, 440);
    textSize(t2);
    text(option2, width/2, 640);
  }

  //Deteta quando o cursor está sobre o botão de opção1
  boolean cursorSobreOption1() {
    if (mouseX >= x && mouseX <= x + larg && mouseY >= y && mouseY <= y + 100) {
      return true;
    } else {
      return false;
    }
  }

  //Deteta quando o cursor está sobre o botão de opção2
  boolean cursorSobreOption2() {
    if (mouseX >= x && mouseX <= x + larg && mouseY >= y + 200 && mouseY <= y + 300) {
      return true;
    } else {
      return false;
    }
  }
}
