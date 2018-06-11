import processing.sound.*;

Jogo jogo, nivelSimples, nivelTimer;
Status status;
Principal principal; 
Ganhou ganhou; 
Perdeu perdeu;
Opcoes opcoes;
Menu menu;
SoundFile wrong, move;

boolean notMuted;
PImage img, img2, image1, image2;
int l;
float limg1, aimg1, limg2, aimg2;
int largura, altura;

void setup() {
  size(1000, 800);

  //CARREGAMENTOS
  String[] linhas = loadStrings("texto.txt");
  img = loadImage(linhas[3]);
  img2 = loadImage(linhas[4]);
  PImage fundo = loadImage(linhas[2]);
  image1 = loadImage("image1small.jpg");
  image2 = loadImage("image2small.jpg");

  //VARIÁVEIS
  int n = parseInt(linhas[0]); //8
  int m = parseInt(linhas[1]); //6
  int nBaralhar = parseInt(linhas[5]); //100
  int nLimite = parseInt(linhas[6]); //2 * nBaralhar
  largura = 600;
  altura = 800;
  notMuted = true;

  //OBJETOS
  status = new Status(Status.MENU);
  move = new SoundFile(this, "move.mp3");
  wrong = new SoundFile(this, "wrong.mp3");

  //MENUS
  principal = new Principal(fundo, "15 PUZZLE", "Normal", "Limite de Jogadas", "Contra-Relógio", "Opções");
  ganhou = new Ganhou(fundo, "GANHOU!", "Jogar Novamente", "Menu Principal", "", "", new SoundFile(this, "win.mp3"));
  perdeu = new Perdeu(fundo, "PERDEU!", "Jogar Novamente", "Menu Principal", "", "", new SoundFile(this, "lose.mp3"));
  opcoes = new Opcoes(fundo, "OPÇÕES", "Sem Som", "Imagem", "", "Menu Principal");
  menu = new Menu(fundo, "OPÇÕES", "Sem Som", "Imagem", "", "Menu Principal");

  limg1 = opcoes.larg-25;
  aimg1 = opcoes.alt-25;
  limg2 = opcoes.larg-25;
  aimg2 = opcoes.alt-25;

  //NIVEIS
  jogo = new Jogo(n, m, img, altura, largura, status, nBaralhar);
  nivelSimples = new NivelSimples(n, m, img, altura, largura, status, nBaralhar, nLimite);
  nivelTimer = new NivelTimer(n, m, img, altura, largura, status, nBaralhar);
}


void draw() {
  background(0);

  //Ativar o menu Principal
  if (status.selected == Status.MENU) {
    ganhou.stopMusic();
    perdeu.stopMusic();
    principal.desenhaMenu();

    //Ativar o menu Perdeu
  } else if (status.selected == Status.PERDEU) {
    perdeu.desenha();
    perdeu.tocou(); //Iniciar a música de Perder

    //Ativar o menu Ganhou
  } else if (status.selected == Status.GANHOU) {
    ganhou.desenha();
    ganhou.tocou(); //Iniciar a música de ganhar

    //Ativar o menu Opções
  } else if (status.selected == Status.OPCOES) {
    ganhou.stopMusic();
    perdeu.stopMusic();
    opcoes.desenhaMenu();
    imageMode(CENTER);
    image(image1, opcoes.x+limg1/2+10, opcoes.y + 1.5 * opcoes.alt + 10 +  aimg1/2, limg1, aimg1);
    image(image2, opcoes.x+limg2/2+10, opcoes.y + 3 * opcoes.alt + 10 + aimg2/2, limg2, aimg2);

    //Ativar o nivel Jogo
  } else if (status.selected == Status.JOGO) {
    ganhou.stopMusic();
    perdeu.stopMusic();
    jogo.desenha();
    l = Status.JOGO;

    //Ativar nivel Simples
  } else if (status.selected == Status.SIMPLES) {
    ganhou.stopMusic();
    perdeu.stopMusic();
    nivelSimples.desenhaJogo();
    l = Status.SIMPLES;

    //Ativar nivel Timer
  } else if (status.selected == Status.TIMER) {
    ganhou.stopMusic();
    perdeu.stopMusic();
    nivelTimer.desenhaJogo();
    l = Status.TIMER;
  }

  //Fazer o texto ficar maior quando o cursor está sobre o retângulo
  if (principal.cursorSobreOption1()) {
    principal.t1 = 35;
  } else {
    principal.t1 = 30;
  }
  if (opcoes.cursorSobreOption1()) {
    opcoes.t1 = 35;
  } else {
    opcoes.t1 = 30;
  }
  if (perdeu.cursorSobreOption1()) {
    perdeu.t1 = 35;
  } else {
    perdeu.t1 = 30;
  }
  if (ganhou.cursorSobreOption1()) {
    ganhou.t1 = 35;
  } else {
    ganhou.t1 = 30;
  }

  if (principal.cursorSobreOption2()) {
    principal.t2 = 35;
  } else {
    principal.t2 = 30;
  }
  if (opcoes.cursorSobreOption2()) {
    limg1 = opcoes.larg-20;
    aimg1 = opcoes.alt-20;
  } else {
    limg1 = opcoes.larg-25;
    aimg1 = opcoes.alt-25;
  }
  if (perdeu.cursorSobreOption2()) {
    perdeu.t2 = 35;
  } else {
    perdeu.t2 = 30;
  }
  if (ganhou.cursorSobreOption2()) {
    ganhou.t2 = 35;
  } else {
    ganhou.t2 = 30;
  }

  if (principal.cursorSobreOption3()) {
    principal.t3 = 35;
  } else {
    principal.t3 = 30;
  }
  if (opcoes.cursorSobreOption3()) {
    limg2 = opcoes.larg-20;
    aimg2 = opcoes.alt-20;
  } else {
    limg2 = opcoes.larg-25;
    aimg2 = opcoes.alt-25;
  }
  if (perdeu.cursorSobreOption3()) {
    perdeu.t3 = 35;
  } else {
    perdeu.t3 = 30;
  }
  if (ganhou.cursorSobreOption3()) {
    ganhou.t3 = 35;
  } else {
    ganhou.t3 = 30;
  }

  if (principal.cursorSobreOption4()) {
    principal.t4 = 35;
  } else {
    principal.t4 = 30;
  }
  if (opcoes.cursorSobreOption4()) {
    opcoes.t4 = 35;
  } else {
    opcoes.t4 = 30;
  }
  if (perdeu.cursorSobreOption4()) {
    perdeu.t4 = 35;
  } else {
    perdeu.t4 = 30;
  }
  if (ganhou.cursorSobreOption4()) {
    ganhou.t4 = 35;
  } else {
    ganhou.t4 = 30;
  }
}

void mousePressed() {
  // Botões do Menu Principal
  if (status.selected == Status.MENU) {
    if (principal.cursorSobreOption1()) {
      status.selected = Status.JOGO;
      jogo.startNivel();
    } else if (principal.cursorSobreOption2()) {
      status.selected = Status.SIMPLES;
      nivelSimples.startNivel();
    } else if (principal.cursorSobreOption3()) {
      status.selected = Status.TIMER;
      nivelTimer.startNivel();
    } else if (principal.cursorSobreOption4()) {
      status.selected = Status.OPCOES;
    }

    // Botões do Menu Ganhou
  } else if (status.selected == Status.GANHOU) {
    if (ganhou.cursorSobreOption1()) {
      status.selected = l;
      jogo.startNivel();
      nivelSimples.startNivel();
      nivelTimer.startNivel();
    } else if (ganhou.cursorSobreOption2()) {
      status.selected = Status.MENU;
    }

    //Botões do Menu Perdeu
  } else if (status.selected == Status.PERDEU) {
    if (perdeu.cursorSobreOption1()) {
      status.selected = l;
      jogo.startNivel();
      nivelSimples.startNivel();
      nivelTimer.startNivel();
    } else if (perdeu.cursorSobreOption2()) {
      status.selected = Status.MENU;
    }

    // Botões do Menu Opções
  } else if (status.selected == Status.OPCOES) {
    if (opcoes.cursorSobreOption1()) {
      notMuted = !notMuted;
      
    } else if (opcoes.cursorSobreOption2()) {
      jogo.alterarImagem(img, altura, largura);
      nivelSimples.alterarImagem(img, altura, largura);
      nivelTimer.alterarImagem(img, altura, largura);
      
    } else if (opcoes.cursorSobreOption3()) {
      jogo.alterarImagem(img2, altura, largura);
      nivelSimples.alterarImagem(img2, altura, largura);
      nivelTimer.alterarImagem(img2, altura, largura);
      
    } else if (opcoes.cursorSobreOption4()) {
      status.selected = Status.MENU;
    }
  }

  //Mover as peças + Som do movimento Válido
  if (status.selected == Status.JOGO) {
    jogo.moverPecaSom(move);
    jogo.somErrado(wrong);
  } else if (status.selected == Status.SIMPLES) {
    nivelSimples.moverPecaSom(move);
    nivelSimples.somErrado(wrong);
  } else if (status.selected == Status.TIMER) {
    nivelTimer.moverPecaSom(move);
    nivelTimer.somErrado(wrong);
  }
}

void reproduzir(SoundFile som) {
  if (notMuted) {
    som.play();
  }
}
