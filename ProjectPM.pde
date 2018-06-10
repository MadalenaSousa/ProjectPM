import processing.sound.*;

Jogo nivelSimples;
Status status;
Principal principal; 
Ganhou ganhou; 
Perdeu perdeu;
Opcoes opcoes;
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
  principal = new Principal(azulejo, "15 PUZZLE", "Jogar", "Opções");
  ganhou = new Ganhou(azulejo, "GANHOU!", "Próximo Nível", "Menu Principal", new SoundFile(this, "win.mp3"));
  perdeu = new Perdeu(azulejo, "PERDEU!", "Jogar Novamente", "Menu Principal", new SoundFile(this, "lose.mp3"));
  opcoes = new Opcoes(azulejo, "OPÇÕES", "Sem Som", " ");

  //NIVEIS
  nivelSimples = new NivelSimples(n, m, img, altura, largura, status, nBaralhar, nLimite);
}


void draw() {
  background(0);

  //Ativar o menu Principal
  if (status.selected == Status.MENU) {
    ganhou.stopMusic();
    perdeu.stopMusic();
    principal.desenha();

    //Ativar o Jogo
  } else if (status.selected == Status.JOGO) {
    ganhou.stopMusic();
    perdeu.stopMusic();
    nivelSimples.desenhaJogo();

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
    opcoes.desenha();
  }

  //Fazer o texto ficar maior quando o cursor está sobre o retângulo
  if (principal.cursorSobreOption1()) {
    principal.t1 = 75;
  } else {
    principal.t1 = 70;
  }
  if (opcoes.cursorSobreOption1()) {
    opcoes.t1 = 75;
  } else {
    opcoes.t1 = 70;
  }
  if (perdeu.cursorSobreOption1()) {
    perdeu.t1 = 50;
  } else {
    perdeu.t1 = 45;
  }
  if (ganhou.cursorSobreOption1()) {
    ganhou.t1 = 50;
  } else {
    ganhou.t1 = 45;
  }

  if (principal.cursorSobreOption2()) {
    principal.t2 = 75;
  } else {
    principal.t2 = 70;
  }
  if (opcoes.cursorSobreOption2()) {
    opcoes.t2 = 75;
  } else {
    opcoes.t2 = 70;
  }
  if (perdeu.cursorSobreOption2()) {
    perdeu.t2 = 50;
  } else {
    perdeu.t2 = 45;
  }
  if (ganhou.cursorSobreOption2()) {
    ganhou.t2 = 50;
  } else {
    ganhou.t2 = 45;
  }
}

void mousePressed() {
  //Clicar e iniciar o JOGO
  if (status.selected == Status.MENU) {
    if (principal.cursorSobreOption1()) {
      nivelSimples.startNivel();
    } else if (principal.cursorSobreOption2()) {
      status.selected = Status.OPCOES;
    }
  }

  //Clicar no botão de Jogar Novamente e reeiniciar o Jogo
  if (status.selected == Status.GANHOU) {
    if (ganhou.cursorSobreOption1()) {
      //nivelTimer.startNivel();
    } else if (ganhou.cursorSobreOption2()) {
      status.selected = Status.MENU;
    }
  }

  //Clicar no botão de Jogar Novamente e reeiniciar o Jogo
  if (status.selected == Status.PERDEU) {
    if (perdeu.cursorSobreOption1()) {
      nivelSimples.startNivel();
    } else if (perdeu.cursorSobreOption2()) {
      status.selected = Status.MENU;
    }
  }

  //Mover as peças + Som do movimento Válido
  if (status.selected == Status.JOGO) {
    nivelSimples.moverPecaSom(move);
    nivelSimples.somErrado(wrong);
  }
}
