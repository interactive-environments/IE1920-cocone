#include <WiFiNINA.h>
#include <MQTT.h>
#define PIN     5
//wifi settings
const char ssid[] = "Science-Centre-EVENT";
const char pass[] = "ScienceCentre";

//mqtt settings
const char mqtt_clientID[] = "COCONE";
const char mqtt_username[] = "electro-forest";
const char mqtt_password[] = "fe8708c4cd16348a";
WiFiClient net;
MQTTClient client;
unsigned long lastMillis = 0;


int toSend = 0;

void connect() {
  Serial.print("checking wifi...");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.println(WiFi.status());
    delay(1000);
  }

  Serial.print("\nconnecting...");
  while (!client.connect(mqtt_clientID, mqtt_username, mqtt_password)) {+
    Serial.print("x");
    delay(1000);
  }

  Serial.println("\nconnected!");

  client.subscribe("/minorinteractive/studio/KEIZEN");
}

void messageReceived(String &topic, String &payload) {
//  Serial.println("incoming: " + topic + " - " + payload);
  if ((payload).toInt() == 1){
    toSend = 1;
  } else {
    toSend = 0;
  }
}


void setup() {
  Serial.begin(9600);
  Serial.println("WiFi.begin");
  WiFi.begin(ssid, pass);
  pinMode(PIN, OUTPUT);
  // Note: Local domain names (e.g. "Computer.local" on OSX) are not supported by Arduino.
  // You need to set the IP address directly.
  //
  // MQTT brokers usually use port 8883 for secure connections.
  client.begin("broker.shiftr.io", net);
  client.onMessage(messageReceived);

  connect();

}

void loop() {
  client.loop();
  delay(10);  // <- fixes some issues with WiFi stability

  if (!client.connected()) {
    connect();
  }
  
  // publish a message roughly every second.
  if (millis() - lastMillis > 1
   000) {
    lastMillis = millis();
    Serial.println(toSend);
    digitalWrite(PIN, toSend);
//    if (toSend == 1) toSend = 0; else toSend = 1;
//    if (toSend == 1){
//    client.publish("/minorinteractive/studio/KEIZEN", "0");
//    } else {
//    client.publish("/minorinteractive/studio/KEIZEN", "1");
//    }
  }
}
