class Perdeu extends Menu {
  boolean tocou;
  SoundFile som;

  Perdeu(PImage img, String topo, String option1, String option2, String option3, String option4, SoundFile som) {
    super(img, topo, option1, option2, option3, option4);
    this.som = som;
    tocou = false;
  }

  void stopMusic() { //pára a música quando voltamos para o jogo
    if (notMuted) {
      som.stop();
      tocou = false;
    }
  }

  void tocou() {
    if (notMuted) {
      if (tocou) { //Se já está a tocar
        return; //para aqui e não chega à instrução de tocar
      }
      som.play(); //Se não está a tocar, toca
      tocou = true; //Passa a estar definido como estando a tocar
    }
  }
}
