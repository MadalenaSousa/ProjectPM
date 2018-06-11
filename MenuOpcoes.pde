class Opcoes extends Menu {

  Opcoes(PImage img, String topo, String option1, String option2, String option3, String option4) {
    super(img, topo, option1, option2, option3, option4);
  }  

  void desenhaMenu() {  
    if (notMuted) { // Define que string apresentar
      super.option1 = "Com Som";
    } else {
      super.option1 = "Sem Som";
    }  

    super.desenha();

    // Opções adicionais
    rectMode(CORNER);
    fill(#F5D57E);
    // Opção 3
    rect(x, y + 3 * alt, larg, alt, 50);
    // Opção 4
    rect(x, y + 4.5 * alt, larg, alt, 50);

    fill(255);
    // Opção 3
    textSize(t3);
    text(option3, width/2, y + 25 + 3 * alt);
    // Opção 4
    textSize(t4);
    text(option4, width/2, y + 25 + 4.5 * alt);
  }
}
