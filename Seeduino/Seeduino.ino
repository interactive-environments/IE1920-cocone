#include <FastLED.h>

#define LED_PIN_1     8
#define LED_PIN_2     5
#define LED_PIN_3     7

#define READ_PIN_1      2
#define READ_PIN_2      3

#define NUM_LEDS_1    140
#define NUM_LEDS_2    132
#define NUM_LEDS_3    128 

#define BRIGHTNESS  64
#define LED_TYPE    WS2812B
#define COLOR_ORDER GRB
CRGB leds1[NUM_LEDS_1];
CRGB leds2[NUM_LEDS_2];
CRGB leds3[NUM_LEDS_3];

#define UPDATES_PER_SECOND 9001

CRGBPalette16 currentPalette;
TBlendType    currentBlending;

extern CRGBPalette16 myRedWhiteBluePalette;
extern const TProgmemPalette16 myRedWhiteBluePalette_p PROGMEM;


void setup() {
    delay( 3000 ); // power-up safety delay
    pinMode(READ_PIN_1, INPUT);
    pinMode(READ_PIN_2, INPUT);
    FastLED.addLeds<LED_TYPE, LED_PIN_1, COLOR_ORDER>(leds1, NUM_LEDS_1).setCorrection( TypicalLEDStrip );
    FastLED.addLeds<LED_TYPE, LED_PIN_2, COLOR_ORDER>(leds2, NUM_LEDS_2).setCorrection( TypicalLEDStrip );
    FastLED.addLeds<LED_TYPE, LED_PIN_3, COLOR_ORDER>(leds3, NUM_LEDS_3).setCorrection( TypicalLEDStrip );
    FastLED.setBrightness(  BRIGHTNESS );
    Serial.begin(9600);
    SetupDrawPalette();       
    currentBlending = LINEARBLEND; 
}

int lastPin = 0;
void loop()
{
    int curPin = digitalRead(READ_PIN_1) + 2 * digitalRead(READ_PIN_2);
    Serial.println(curPin);
    if (curPin != lastPin){
      lastPin = curPin;
      switch(curPin){
        case 0:
          SetupBlackPalette();
        break;
        case 1:
          SetupDrawPalette();
        break;
        case 2:
          SetupDrawPalette1();
        break;
        case 3:
          SetupDrawPalette2();
        break;
      }
    }
    static uint8_t startIndex = 0;
    startIndex = startIndex + 1; /* motion speed */
    
    FillLEDsFromPaletteColors( startIndex);
    
    FastLED.show();
    FastLED.delay(1000 / UPDATES_PER_SECOND);
}
int speedMult = 1;
void FillLEDsFromPaletteColors( uint8_t colorIndex)
{
    uint8_t brightness = 255;
   
    colorIndex += speedMult*NUM_LEDS_1;
    for( int i = 0; i < NUM_LEDS_1; i++) {
        leds1[i] = ColorFromPalette( currentPalette, colorIndex, brightness, currentBlending);
        colorIndex -= speedMult;
    }
    colorIndex += speedMult*NUM_LEDS_2;
    for( int i = 0; i < NUM_LEDS_2; i++) {
        leds2[i] = ColorFromPalette( currentPalette, colorIndex, brightness, currentBlending);
        colorIndex -= speedMult;
    }
    colorIndex -= speedMult*NUM_LEDS_3;
    for( int i = 0; i < NUM_LEDS_3; i++) {
        leds3[i] = ColorFromPalette( currentPalette, colorIndex, brightness, currentBlending);
        colorIndex -= speedMult;
    }
}

void SetupDrawPalette()
{
    // 'black out' all 16 palette entries...
    fill_solid( currentPalette, 16, CRGB::Black);
    // and set every our colors
    currentPalette[0] = CRGB::Red;
    currentPalette[1] = CRGB::Orange;
    currentPalette[4] = CRGB::Red;
    currentPalette[5] = CRGB::Orange;
    currentPalette[8] = CRGB::Red;
    currentPalette[9] = CRGB::Orange;
    currentPalette[12] = CRGB::Red;
    currentPalette[13] = CRGB::Orange;
    speedMult = 1;
}
void SetupDrawPalette1()
{
    // 'black out' all 16 palette entries...
    fill_solid( currentPalette, 16, CRGB::Black);
    // and set every our colors
    currentPalette[0] = CRGB::Red;
    currentPalette[1] = CRGB::Orange;
    currentPalette[2] = CRGB::Yellow;
    currentPalette[3] = CRGB::Green;
    currentPalette[8] = CRGB::Red;
    currentPalette[9] = CRGB::Orange;
    currentPalette[10] = CRGB::Yellow;
    currentPalette[11] = CRGB::Green;
    speedMult = 1;
}
void SetupDrawPalette2()
{
    // 'black out' all 16 palette entries...
    fill_solid( currentPalette, 16, CRGB::Black);
    // and set every our colors
    currentPalette[0] = CRGB::Red;
    currentPalette[1] = CRGB::Orange;
    currentPalette[4] = CRGB::Red;
    currentPalette[5] = CRGB::Orange;
    currentPalette[8] = CRGB::Red;
    currentPalette[9] = CRGB::Orange;
    currentPalette[12] = CRGB::Red;
    currentPalette[13] = CRGB::Orange;
    speedMult = 3;
    
}

void SetupBlackPalette()
{
    fill_solid( currentPalette, 16, CRGB::Black);
}
