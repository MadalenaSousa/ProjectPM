class NivelTimer extends Jogo {

  boolean parar;
  long tInicial;
  int tempoLimiteM, tempoLimiteS;
  int tRestaS, tFinalS;
  ArrayList <Integer> recorde;

  NivelTimer(int n, int m, PImage img, int alturaImg, int larguraImg, Status status, int nBaralhar, int tempoLimiteM, int tempoLimiteS) {
    super(n, m, img, alturaImg, larguraImg, status, nBaralhar);
    parar = false;
    this.tempoLimiteM = tempoLimiteM;
    this.tempoLimiteS = tempoLimiteS;
    tFinalS = tempoLimiteM * 60 + tempoLimiteS; // Tempo limite total em segundos
    recorde = new ArrayList();
  }

  void startNivel() {
    moveBaralhar.clear(); // Limpa o array com os movimentos de baralhar
    misturar();  // Baralha
    moveJogador.clear(); // Limpa o array com os movimentos do jogador para poder voltar a jogar
    jaGanhou = false; // Garante que as variaveis que dizem se já perdeu ou ganhou o jogo estão a falso
    jaPerdeu = false;
    tRestaS = tFinalS; // O tempo que resta inicialmente é o tempo total limite
    tInicial = millis(); // tempo a que estou a comecar o nivel
  }

  // Estrutura geral do nível + Tempo
  void desenhaJogo() {
    super.desenha();

    int tempoMillis = (int)(millis() - tInicial); // Tempo que ja passou em millissegundos
    int tPassadoS = (tempoMillis/1000); // Tempo que ja passou convertido em segundos

    tRestaS = tFinalS - tPassadoS; 

    int tempoM = (int)(tRestaS/60); // Calcula o tempo que resta em minutos
    int tempoS = (tRestaS%60); // Calcula o tempo que resta em segundos

    rectMode(CENTER);
    fill(#C16085);
    rect(800, 305, 300, 65, 50);
    textAlign(CENTER, CENTER);
    rectMode(CENTER);
    fill(#C16085);
    rect(800, 505, 300, 65, 50);
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(30);
    text("Tempo de Sobra", 800, 300);
    textSize(50);
    text(nf(tempoM, 2)+":"+nf(tempoS, 2), 800, 400);
    textSize(30);
    text("Recorde", 800, 500);
    textSize(50);

    int recordeMin = parseInt(recorde())/60; // Converte o recorde para minutos e segundos
    int recordeSeg = parseInt(recorde())%60;

    text(nf(recordeMin, 2) + ":" + nf(recordeSeg, 2), 800, 600);
  }

  // Determina se, consoante o tempo, é ainda permitido jogar
  boolean permiteJogar() {
    if (tRestaS > 0) {
      return true;
    } else {
      return false;
    }
  }

  // Função que retorna o recorde
  String recorde() {
    if (jaGanhou) {
      recorde.add(tFinalS - tRestaS);
    }
    if (recorde.size() == 0) {
      return "";
    }
    int[] rec = new int[recorde.size()]; 
    for (int i = 0; i < recorde.size(); i++) {
      rec[i] = recorde.get(i);
    }
    return "" + min(rec);
  }
}
