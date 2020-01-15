class v3 {
  float x, y, z;
  float buffersize = 75;
  v3(float _x, float _y) {
    x = _x;
    y = _y;
  }
  int contain() {
    int retV = 0;
    if (x < buffersize) {
      //x = 0;
      retV = 1;
    }
    if (x > ledWidth-buffersize) {
      //x = ledWidth;
      retV = 2;
    }
    if (y < buffersize) {
      //y = 0;
      retV = 3;
    }
    if (y > ledHeight-buffersize) {
      //y = ledHeight;
      retV = 4;
    }
    return retV;
  }
}
