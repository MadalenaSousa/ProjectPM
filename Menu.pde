class Menu {
  PImage img;
  String topo, option1;

  Menu(PImage img, String topo, String option1) {
    this.img = img;
    this.topo = topo;
    this.option1 = option1;
  }

  void desenha() {
    img.resize(600, 800);
    image(img, 0, 0);

    noStroke();
    textFont(f, 90);

    fill(#1C477E);
    rect(0, 100, 600, 100);
    fill(#F5D57E);
    rect(100, 400, 400, 102);

    fill(255);
    text(topo, 60, 180);
    textFont(f, 50);
    text(option1, 190, 482);
  }
}
