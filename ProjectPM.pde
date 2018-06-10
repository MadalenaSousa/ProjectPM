import processing.sound.*;

Jogo nivelSimples, nivelTimer;
Status status;
Principal principal; 
Ganhou ganhou; 
Perdeu perdeu;
SoundFile wrong, move;

void setup() {
  size(1000, 800);

  //CARREGAMENTOS
  String[] linhas = loadStrings("texto.txt");
  PImage img = loadImage(linhas[2]);
  PImage azulejo = loadImage("azulejo.jpg");

  //VARIÁVEIS
  int n = parseInt(linhas[0]); //8
  int m = parseInt(linhas[1]); //6
  int nBaralhar = parseInt(linhas[3]); //100
  int nLimite = parseInt(linhas[4]); //2 * nBaralhar
  int largura = 600;
  int altura = 800;

  //OBJETOS
  status = new Status(Status.MENU);
  move = new SoundFile(this, "move.mp3");
  wrong = new SoundFile(this, "wrong.mp3");

  //MENUS
  principal = new Principal(azulejo, "15 PUZZLE", "Jogar");
  ganhou = new Ganhou(azulejo, "GANHOU!", "Próximo Nível", new SoundFile(this, "win.mp3"));
  perdeu = new Perdeu(azulejo, "PERDEU!", "Jogar Novamente", new SoundFile(this, "lose.mp3"));

  //NIVEIS
  nivelSimples = new NivelSimples(n, m, img, altura, largura, status, nBaralhar, nLimite);
  nivelTimer = new NivelTimer(n, m, img, altura, largura, status, nBaralhar, nLimite);
}


void draw() {
  background(0);

  //Ativar o menu Principal
  if (status.selected == Status.MENU) {
    ganhou.stopMusic();
    perdeu.stopMusic();
    principal.desenha();

    //Ativar o menu Perdeu
  } else if (status.selected == Status.PERDEU) {
    perdeu.desenha();
    perdeu.tocou(); //Iniciar a música de Perder

    //Ativar o menu Ganhou
  } else if (status.selected == Status.GANHOU) {
    ganhou.desenha();
    ganhou.tocou(); //Iniciar a música de ganhar
  
    //Ativar nivel Simples
  } else if (status.selected == Status.SIMPLES) {
    ganhou.stopMusic();
    perdeu.stopMusic();
    nivelSimples.desenhaJogo();

    //Ativer nivel Timer
  } else if (status.selected == Status.TIMER) {
    ganhou.stopMusic();
    perdeu.stopMusic();
    //println("in");
    nivelTimer.desenhaJogo();
  }

  //Fazer o texto ficar maior quando o cursor está sobre o retângulo
  if (principal.cursorSobre()) {
    principal.tt = 75;
  } else {
    principal.tt = 70;
  }

  if (perdeu.cursorSobre()) {
    perdeu.tt = 50;
  } else {
    perdeu.tt = 45;
  }

  if (ganhou.cursorSobre()) {
    ganhou.tt = 50;
  } else {
    ganhou.tt = 45;
  }
}

void mousePressed() {
  //Clicar e iniciar o JOGO
  if (status.selected == Status.MENU) {
    if (principal.cursorSobre()) {
      nivelSimples.startNivel();
    }
  } else if (status.selected == Status.GANHOU) {
    if (ganhou.cursorSobre()) {
      println("in");
      status.selected = Status.TIMER;
      nivelTimer.startNivel();
    }
  } else if (status.selected == Status.PERDEU) {
    if (perdeu.cursorSobre()) {
      nivelSimples.startNivel();
    }
  }

  //Mover as peças + Som do movimento Válido
  if (status.selected == Status.SIMPLES || status.selected == Status.TIMER) {
    nivelSimples.moverPecaSom(move);
    nivelSimples.somErrado(wrong);
  }
}
