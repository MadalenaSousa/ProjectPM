class Opcoes extends Menu {

  Opcoes(PImage img, String topo, String option1, String option2, String option3, String option4) {
    super(img, topo, option1, option2, option3, option4);
  }  

  void desenhaMenu() {  
    if (notMuted) {
      super.option1 = "Com Som";
    } else {
      super.option1 = "Sem Som";
    }  
    super.desenha();
    rectMode(CORNER);
    fill(#F5D57E);
    //opção 3
    rect(x, y + 3 * alt, larg, alt, 50);
    //opção 4
    rect(x, y + 4.5 * alt, larg, alt, 50);

    fill(255);
    textSize(t3);
    text(option3, width/2, y + 25 + 3 * alt);
    textSize(t4);
    text(option4, width/2, y + 25 + 4.5 * alt);
  }
}
