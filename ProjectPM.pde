Pedacos pedacos;
int largura, altura;
String[] linhas;
int count;

void setup() {
  size(875, 490);

  largura = 800;
  altura = 450;

  count = 0;

  linhas = loadStrings("ficheiro.txt");

  pedacos = new Pedacos(altura, largura, parseInt(linhas[1]), parseInt(linhas[0]), loadImage("img.jpg"));
  pedacos.desenha();
}

void draw() {
  //image(img, 0, 0, largura, altura);

  /*for (int i=0; i<n; i++) {
   for (int j=0; j<m; j++) {
   
   //contador
   if (count < n*m) {
   count++;
   }

  //retângulo à volta da imagem, moldura
  noFill();
  stroke(0);
  strokeWeight(5);
  rect(pedacos[i][j].width * j, pedacos[i][j].height * i, pedacos[i][j].width, pedacos[i][j].height);*/
}
