class Ganhou extends Principal {
  SoundFile som;
  boolean tocou;

  Ganhou(PImage img, String topo, String option1, SoundFile som) {
    super(img, topo, option1);
    this.som = som;
    tocou = false;
  }

  void viraFalse() {
    tocou = false;
  }

  void tocou() {
    if (tocou) {
      return;
    }
    som.play();
    tocou = true;
  }
}
