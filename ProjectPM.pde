int altura, largura;
String[] linhas;
int n, m;
PImage [][] pedacos;
PImage img;

void setup() {
  largura = 800;
  altura = 450;

  size(800, 450);

  linhas =  loadStrings("ficheiro.txt");
  
  //Conversão de String para Int
  m = parseInt(linhas[1]); //9
  n = parseInt(linhas[0]); //16

  img =  loadImage(linhas[2]);
  img.loadPixels();
  img.resize(800, 450);

  //Criação de nova imagem
  pedacos = new PImage[n][m];

  for (int i=0; i<n; i++) {
    for (int j=0; j<m; j++) {
      pedacos[i][j] = createImage(largura/n, altura/m, RGB);
      pedacos[i][j].loadPixels();
    }
  }
}

void draw() {

  //image(img, 0, 0, largura, altura);

  //Definir como vai ser a imagem
  for (int i=0; i<n; i++) {
    for (int j=0; j<m; j++) {

      pedacos[i][j] = img.get(i*pedacos[i][j].width, j*pedacos[i][j].height, pedacos[i][j].width, pedacos[i][j].height);
  
      //Retângulo à volta da imagem, moldura
      noFill();
      stroke(0);
      strokeWeight(10);
      rect(pedacos[i][j].width * i, pedacos[i][j].height * j, pedacos[i][j].width, pedacos[i][j].height);
      
      //Display da nova imagem criada
      pedacos[i][j].updatePixels();
      image(pedacos[i][j], pedacos[i][j].width * i, pedacos[i][j].height * j);
      //pedacos[i][j].save("pedacos" + i + j + ".jpg");
    }
  }
}
