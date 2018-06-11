import processing.sound.*;

Jogo simples, limite, timer;
Status status;
Principal principal; 
Ganhou ganhou; 
Perdeu perdeu;
Opcoes opcoes;
Menu menu;
SoundFile wrong, move;
Solucao solucaoAnimacao;

boolean notMuted;
PImage img, img2, image1, image2;
int l;
float limg1, aimg1, limg2, aimg2;
int largura, altura;

void setup() {
  size(1000, 800);

  //CARREGAMENTOS
  String[] linhas = loadStrings("texto.txt");
  PImage fundo = loadImage(linhas[2]);
  img = loadImage(linhas[3]);
  img2 = loadImage(linhas[4]);
  image1 = loadImage(linhas[5]);
  image2 = loadImage(linhas[6]);

  //VARIÁVEIS
  int n = parseInt(linhas[0]); //8
  int m = parseInt(linhas[1]); //6
  int nBaralhar = parseInt(linhas[7]); //100
  int nLimite = parseInt(linhas[8]); //2 * nBaralhar
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
  perdeu = new Perdeu(fundo, "PERDEU!", "Jogar Novamente", "Menu Principal", "Ver Solução", "", new SoundFile(this, "lose.mp3"));
  opcoes = new Opcoes(fundo, "OPÇÕES", "Sem Som", "Imagem", "", "Menu Principal");
  menu = new Menu(fundo, "OPÇÕES", "Sem Som", "Imagem", "", "Menu Principal");

  // Tamanho das imagens icones
  limg1 = opcoes.larg-25;
  aimg1 = opcoes.alt-25;
  limg2 = opcoes.larg-25;
  aimg2 = opcoes.alt-25;

  //NIVEIS
  simples = new NivelSimples(n, m, img, altura, largura, status, nBaralhar);
  limite = new NivelLimite(n, m, img, altura, largura, status, nBaralhar, nLimite);
  timer = new NivelTimer(n, m, img, altura, largura, status, nBaralhar, parseInt(linhas[9]), parseInt(linhas[10]));
}


void draw() {
  background(0);

  // Desenhar o menu principal
  if (status.selected == Status.MENU) {
    ganhou.stopMusic();
    perdeu.stopMusic();
    principal.desenhaMenu();

    // Desenhar o menu perdeu
  } else if (status.selected == Status.PERDEU) {
    perdeu.desenhaMenu();
    perdeu.tocou(); //Iniciar a música de Perder

    // Desenhar solução
  } else if (status.selected == Status.SOLUCAO) {
    ganhou.stopMusic();
    perdeu.stopMusic();
    solucaoAnimacao.desenhaSolucao();

    // Desenhar o menu ganhou
  } else if (status.selected == Status.GANHOU) {
    ganhou.desenha();
    ganhou.tocou(); // Iniciar a música de ganhar

    // Desenhar o menu opções
  } else if (status.selected == Status.OPCOES) {
    ganhou.stopMusic();
    perdeu.stopMusic();
    opcoes.desenhaMenu();
    imageMode(CENTER); // Opções de imagem
    image(image1, opcoes.x+limg1/2+10, opcoes.y + 1.5 * opcoes.alt + 10 +  aimg1/2, limg1, aimg1);
    image(image2, opcoes.x+limg2/2+10, opcoes.y + 3 * opcoes.alt + 10 + aimg2/2, limg2, aimg2);

    // Desenhar o nivel simples
  } else if (status.selected == Status.SIMPLES) {
    ganhou.stopMusic();
    perdeu.stopMusic();
    simples.desenha();
    l = Status.SIMPLES; // Variável que regista o nível onde esteve

    // Desenhar nivel Limite
  } else if (status.selected == Status.LIMITE) {
    ganhou.stopMusic();
    perdeu.stopMusic();
    limite.desenhaJogo();
    l = Status.LIMITE;

    // Desenhar nivel timer
  } else if (status.selected == Status.TIMER) {
    ganhou.stopMusic();
    perdeu.stopMusic();
    timer.desenhaJogo();
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

    // Opção 1
    if (principal.cursorSobreOption1()) {
      status.selected = Status.SIMPLES;
      simples.startNivel();

      // Opção 2
    } else if (principal.cursorSobreOption2()) {
      status.selected = Status.LIMITE;
      limite.startNivel();

      // Opção 3
    } else if (principal.cursorSobreOption3()) {
      status.selected = Status.TIMER;
      timer.startNivel();

      // Opção 4
    } else if (principal.cursorSobreOption4()) {
      status.selected = Status.OPCOES;
    }


    // Botões do Menu Ganhou
  } else if (status.selected == Status.GANHOU) {

    // Opção 1
    if (ganhou.cursorSobreOption1()) {
      status.selected = l; // Reeiniciar o nivel onde estava
      simples.startNivel();
      limite.startNivel();
      timer.startNivel();
      // Opção 2
    } else if (ganhou.cursorSobreOption2()) {
      status.selected = Status.MENU;
    }


    //Botões do Menu Perdeu
  } else if (status.selected == Status.PERDEU) {

    // Opção 1
    if (perdeu.cursorSobreOption1()) {
      status.selected = l;
      simples.startNivel();
      limite.startNivel();
      timer.startNivel();
      // Opção 2
    } else if (perdeu.cursorSobreOption2()) {
      status.selected = Status.MENU;

      // Opção 3
    } else if (perdeu.cursorSobreOption3()) {
      status.selected = Status.SOLUCAO;
    }

    // Botões do Menu Opções
  } else if (status.selected == Status.OPCOES) {

    // Opção 1
    if (opcoes.cursorSobreOption1()) {
      notMuted = !notMuted; // Retirar o som

      // Opção 2
    } else if (opcoes.cursorSobreOption2()) {
      simples.alterarImagem(img, altura, largura); // 1ª opção de imagem
      limite.alterarImagem(img, altura, largura);
      timer.alterarImagem(img, altura, largura);

      // Opção 3
    } else if (opcoes.cursorSobreOption3()) {
      simples.alterarImagem(img2, altura, largura); // 1ª opção de imagem
      limite.alterarImagem(img2, altura, largura);
      timer.alterarImagem(img2, altura, largura);

      // Opção 4
    } else if (opcoes.cursorSobreOption4()) {
      status.selected = Status.MENU;
    }
  }


  // Voltar ao menu principal durante o jogo
  //Mover as peças + Som do movimento Válido
  else if (status.selected == Status.SIMPLES) {
    if (simples.cursorSobreDesistir()) {
      status.selected = Status.MENU;
    }
    simples.moverPecaSom(move);
    simples.somErrado(wrong);
  } else if (status.selected == Status.LIMITE) {
    if (limite.cursorSobreDesistir()) {
      status.selected = Status.MENU;
    }
    limite.moverPecaSom(move);
    limite.somErrado(wrong);
  } else if (status.selected == Status.TIMER) {
    if (timer.cursorSobreDesistir()) {
      status.selected = Status.MENU;
    }
    timer.moverPecaSom(move);
    timer.somErrado(wrong);
  } else if (status.selected == Status.SOLUCAO) {
    if (solucaoAnimacao.cursorSobreDesistir()) {
      status.selected = Status.MENU;
    }
  }
}

// Função que torna o som ativado ou desativado
void reproduzir(SoundFile som) {
  if (notMuted) {
    som.play();
  }
}
