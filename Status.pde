//classe de controlo dos menus
class Status {

  static final int MENU = 0;
  static final int PERDEU = 1;
  static final int GANHOU = 2;
  static final int SIMPLES = 3;
  static final int TIMER = 4;
  int selected;

  Status(int selected) {
    this.selected = selected;
  }
}
