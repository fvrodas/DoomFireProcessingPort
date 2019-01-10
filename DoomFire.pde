int[] colors = {
                0xFF070707,
                0xFF1F0707,
                0xFF2F0F07,
                0xFF470F07,
                0xFF571707,
                0xFF671F07,
                0xFF771F07,
                0xFF8F2707,
                0xFF9F2F07,
                0xFFAF3F07,
                0xFFBF4707,
                0xFFC74707,
                0xFFDF4F07,
                0xFFDF5707,
                0xFFDF5707,
                0xFFD75F07,
                0xFFD75F07,
                0xFFD7670F,
                0xFFCF6F0F,
                0xFFCF770F,
                0xFFCF7F0F,
                0xFFCF8717,
                0xFFC78717,
                0xFFC78F17,
                0xFFC7971F,
                0xFFBF9F1F,
                0xFFBF9F1F,
                0xFFBFA727,
                0xFFBFA727,
                0xFFBFAF2F,
                0xFFB7AF2F,
                0xFFB7B72F,
                0xFFB7B737,
                0xFFCFCF6F,
                0xFFDFDF9F,
                0xFFEFEFC7,
                0xFFFFFFFF
};

int FIRE_HEIGHT = 0;
int FIRE_WIDTH = 0;

int firePixels[];

void setup() {
  background(0);
  size(240, 240, P2D);
  frameRate(27);
 
  
  FIRE_HEIGHT = height ;
  FIRE_WIDTH = width;
  
  loadPixels();
  
  firePixels = new int[FIRE_WIDTH * FIRE_HEIGHT];
  
  for(int i = 0; i < FIRE_WIDTH * FIRE_HEIGHT; i++) {
    firePixels[i] = 35;
  }
  
  for(int i = 0; i < FIRE_WIDTH; i++) {
    firePixels[i] = 36;
  }
}

void draw() {
  clear();
  doFire();
  for (int y = 0; y < FIRE_HEIGHT; y++) {
      for(int x = 0; x < FIRE_WIDTH; x++) {
        int index = firePixels[y * FIRE_WIDTH + x];
        pixels[y * FIRE_WIDTH + x] = colors[index];
      }
  }
  showText();
  updatePixels();
}

void spreadFire(int src) {
    int pixel = firePixels[src];
    if(pixel == 0) {
        firePixels[src - FIRE_WIDTH] = 0;
    } else {
        int randIdx = round(random(3)) & 3;
        int dst = src - randIdx + 1;
        firePixels[abs(dst - FIRE_WIDTH)] = pixel - (randIdx & 1);
    }
}

void doFire() {
  for(int x = 0; x < FIRE_WIDTH; x++) {
    for(int y = 1; y < FIRE_HEIGHT; y++) {
       spreadFire(y * FIRE_WIDTH + x);
    }
  }
}

void showText() {
  PFont font = loadFont("AmazDooMRight-48.vlw");
  textFont(font, 60);
  textAlign(CENTER, CENTER);
  fill(255);
  text("Processing", width / 2, height / 2);
  noFill();
}
