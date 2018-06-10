class Opcoes extends Menu {

  Opcoes(PImage img, String topo, String option1, String option2) {
    super(img, topo, option1, option2);
  }  

  void desenhaMenu() {  
    if (notMuted) {
      super.option1 = "Com Som";
    } else {
      super.option1 = "Sem Som";
    }  
    super.desenha();
  }
}
