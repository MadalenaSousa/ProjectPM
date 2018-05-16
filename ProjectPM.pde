Pedacos pedacos;
int largura, altura;
String[] linhas;
int count;

void setup() {
  background(0);
  size(625, 835);

  largura = 600;
  altura = 800;
  count = 0;
  linhas = loadStrings("texto.txt");

  pedacos = new Pedacos(altura, largura, parseInt(linhas[0]), parseInt(linhas[1]), loadImage("img.jpg"));
  pedacos.desenha();
}

void draw() {
}
