class Menu {
  PImage img;
  String topo, option1;
  PFont f;
  float larg, alt, x, y;
  int tt;

  Menu(PImage img, String topo, String option1) {
    this.img = img;
    this.topo = topo;
    this.option1 = option1;
    f = createFont("Baskerville", 100, true);
    x = 100;
    y = 400;
    larg = 400;
    alt = 100;
    tt = 45;
  }

  void desenha() {
    img.resize(600, 800);
    image(img, 0, 0);
    textAlign(CENTER, CENTER);
    noStroke();
    textFont(f);
    
    //Botões
    fill(#1C477E);
    rect(0, 100, 600, 100);
    fill(#F5D57E);
    rect(x, y, larg, alt);
    
    //Texto dos botões
    fill(255);
    textSize(90);
    text(topo, width/2, 135);
    textSize(tt);
    text(option1, width/2, 440);
  }
  
  //Deteta quando o cursor está sobre o botão de opção
  boolean cursorSobre() {
    if (mouseX >= x && mouseX <= x + larg && mouseY >= y && mouseY <= y + 100) {
      return true;
    } else {
      return false;
    }
  }
}
