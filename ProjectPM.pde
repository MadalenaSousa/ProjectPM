import processing.sound.*;

Jogo nivelSimples, nivelTimer;
Status status;
Principal principal; 
Ganhou ganhou; 
Perdeu perdeu;
Opcoes opcoes;
SoundFile wrong, move;
boolean notMuted = true;

void setup() {
  size(1000, 800);

  //CARREGAMENTOS
  String[] linhas = loadStrings("texto.txt");
  PImage img = loadImage(linhas[3]);
  PImage fundo = loadImage(linhas[2]);

  //VARIÁVEIS
  int n = parseInt(linhas[0]); //8
  int m = parseInt(linhas[1]); //6
  int nBaralhar = parseInt(linhas[5]); //100
  int nLimite = parseInt(linhas[6]); //2 * nBaralhar
  int largura = 600;
  int altura = 800;

  //OBJETOS
  status = new Status(Status.MENU);
  move = new SoundFile(this, "move.mp3");
  wrong = new SoundFile(this, "wrong.mp3");

  //MENUS
  principal = new Principal(fundo, "15 PUZZLE", "Jogar", "Opções");
  ganhou = new Ganhou(fundo, "GANHOU!", "Próximo Nível", "Menu Principal", new SoundFile(this, "win.mp3"));
  perdeu = new Perdeu(fundo, "PERDEU!", "Jogar Novamente", "Menu Principal", new SoundFile(this, "lose.mp3"));
  opcoes = new Opcoes(fundo, "OPÇÕES", "Sem Som", "Menu Principal");


  //NIVEIS
  nivelSimples = new NivelSimples(n, m, img, altura, largura, status, nBaralhar, nLimite);
  nivelTimer = new NivelTimer(n, m, img, altura, largura, status, nBaralhar);
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

    //Ativar o menu Opções
  } else if (status.selected == Status.OPCOES) {
    ganhou.stopMusic();
    perdeu.stopMusic();
    opcoes.desenhaMenu();

    //Ativar nivel Simples
  } else if (status.selected == Status.SIMPLES) {
    ganhou.stopMusic();
    perdeu.stopMusic();
    nivelSimples.desenhaJogo();

    //Ativer nivel Timer
  } else if (status.selected == Status.TIMER) {
    ganhou.stopMusic();
    perdeu.stopMusic();
    nivelTimer.desenhaJogo();
  }

  //Fazer o texto ficar maior quando o cursor está sobre o retângulo
  if (principal.cursorSobreOption1()) {
    principal.t1 = 55;
  } else {
    principal.t1 = 50;
  }
  if (opcoes.cursorSobreOption1()) {
    opcoes.t1 = 55;
  } else {
    opcoes.t1 = 50;
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
    principal.t2 = 55;
  } else {
    principal.t2 = 50;
  }
  if (opcoes.cursorSobreOption2()) {
    opcoes.t2 = 35;
  } else {
    opcoes.t2 = 30;
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
    principal.t2 = 55;
  } else {
    principal.t2 = 50;
  }
  if (opcoes.cursorSobreOption3()) {
    opcoes.t2 = 35;
  } else {
    opcoes.t2 = 30;
  }
  if (perdeu.cursorSobreOption3()) {
    perdeu.t2 = 35;
  } else {
    perdeu.t2 = 30;
  }
  if (ganhou.cursorSobreOption3()) {
    ganhou.t2 = 35;
  } else {
    ganhou.t2 = 30;
  }

  if (principal.cursorSobreOption4()) {
    principal.t2 = 55;
  } else {
    principal.t2 = 50;
  }
  if (opcoes.cursorSobreOption4()) {
    opcoes.t2 = 35;
  } else {
    opcoes.t2 = 30;
  }
  if (perdeu.cursorSobreOption4()) {
    perdeu.t2 = 35;
  } else {
    perdeu.t2 = 30;
  }
  if (ganhou.cursorSobreOption4()) {
    ganhou.t2 = 35;
  } else {
    ganhou.t2 = 30;
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
  } else if (status.selected == Status.GANHOU) {
    if (ganhou.cursorSobreOption1()) {
      status.selected = Status.TIMER;
      nivelTimer.startNivel();
    } else if (ganhou.cursorSobreOption2()) {
      status.selected = Status.MENU;
    }
  } else if (status.selected == Status.PERDEU) {
    if (perdeu.cursorSobreOption1()) {
      nivelSimples.startNivel();
    } else if (perdeu.cursorSobreOption2()) {
      status.selected = Status.MENU;
    }
  } else if (status.selected == Status.OPCOES) {
    if (perdeu.cursorSobreOption1()) {
      notMuted = !notMuted;
    } else if (perdeu.cursorSobreOption2()) {
      status.selected = Status.MENU;
    }
  }

  //Mover as peças + Som do movimento Válido
  if (status.selected == Status.SIMPLES) {
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
