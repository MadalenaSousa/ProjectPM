PImage img;
String[] ficheiro;
PImage[][] segments = new PImage[10][10];
int n, m;
 
void setup() {
  size(1160, 600);
  ficheiro =  loadStrings("ficheiro.txt");
  
  n = parseInt(ficheiro[0]);
  m = parseInt(ficheiro[1]);
  img=loadImage("img.jpg");
for(int i=0; i<10;i++){
 for(int j=0; j<10; j++){ 
   segments[i][j] = img.get(i*116,j*10,116,10);
 
    }}
}
    void draw(){
  for(int i=0; i<10;i++){
    for(int j=0; j<10; j++){ 
        background(255);
        /// image(img, 0,0);

      noFill();
      rect(i,j,116,10);
      image(segments[i][j], i*116, j*10,segments[i][j].width,segments[i][j].height);
      
      i=i+116;
      j=j+60;



}}
  
    
}
