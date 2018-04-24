Pedacos pedacos;
int largura, altura;
String[] linhas;
int count;

void setup() {
  background(0);
  size(875, 490);

  largura = 800;
  altura = 450;
  count = 0;
  linhas = loadStrings("ficheiro.txt");

  pedacos = new Pedacos(altura, largura, parseInt(linhas[1]), parseInt(linhas[0]), loadImage("img.jpg"));
  pedacos.desenha();
}

void draw() {
}
