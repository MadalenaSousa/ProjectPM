int altura, largura;
String[] linhas;
int n, m;
PImage [][] pedacos;
PImage img;
int count;

void setup() {
  size(800, 450);

  largura = 800;
  altura = 450;

  count = 0;

  linhas =  loadStrings("ficheiro.txt");

  //conversão de String para Int
  m = parseInt(linhas[0]); //16
  n = parseInt(linhas[1]); //9

  img =  loadImage(linhas[2]);
  img.loadPixels();
  img.resize(800, 450);

  //criação de nova imagem
  pedacos = new PImage[n][m];

  for (int i=0; i<n; i++) {
    for (int j=0; j<m; j++) {
      pedacos[i][j] = createImage(largura/m, altura/n, RGB);
      pedacos[i][j].loadPixels();
    }
  }
}

void draw() {
  background(0);
  //image(img, 0, 0, largura, altura);

  for (int i=0; i<n; i++) {
    for (int j=0; j<m; j++) {

      //contador
      if (count < n*m) {
        count++;
      }

      //definição da imagem
      pedacos[i][j] = img.get(j*pedacos[i][j].width, i*pedacos[i][j].height, pedacos[i][j].width, pedacos[i][j].height);

      //retângulo à volta da imagem, moldura
      noFill();
      stroke(0);
      strokeWeight(10);
      rect(pedacos[i][j].width * j, pedacos[i][j].height * i, pedacos[i][j].width, pedacos[i][j].height);

      //display das novas imagens criadas, exceto a ultima
      if (i != (n-1) || j != (m-1)) {
        pedacos[i][j].updatePixels();
        image(pedacos[i][j], pedacos[i][j].width * j, pedacos[i][j].height * i);
        //pedacos[i][j].save("pedacos" + count + ".jpg"); //usamos isto para garantir que as imagens estavam realmente a ser criadas como queriamos
      }
    }
  }
}
