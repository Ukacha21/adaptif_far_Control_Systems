#include <Arduino.h>

// --- PIN DEFINITIONS ---
const int ENCODER_A = 2; // Interrupt pin INT0
const int ENCODER_B = 3; // Interrupt pin INT1
const int MOTOR_PWM = 9; // L298N ENB - we used the other side of the motor driver
const int MOTOR_IN1 = 7; // L298N IN3
const int MOTOR_IN2 = 8; // L298N IN4
const int POT_PIN = A1; // we used analog 1

// --- SYSTEM CONSTANTS ---
const float PPR = 600.0; // Pulses per revolution
// If your encoder is on the output shaft, use 600. 
// If it's on the motor before reduction, multiply by gear ratio.
// Based on photo, encoder is on the output shaft.

volatile long encoderPosition = 0;



// --- CONTROL VARIABLES ---
float currentAngle = 0.0;
float targetAngle = 0.0;
float error = 0.0;
float Kp = 5.0; // Proportional Gain (Stiffness) - Adjust this!
int motorSpeed = 0;
int deadzone = 2; // Degrees of allowed error to prevent jitter

void setup() {
  Serial.begin(115200); // Use high baud rate for plotter
  
  pinMode(ENCODER_A, INPUT_PULLUP);
  pinMode(ENCODER_B, INPUT_PULLUP);
  pinMode(MOTOR_PWM, OUTPUT);
  pinMode(MOTOR_IN1, OUTPUT);
  pinMode(MOTOR_IN2, OUTPUT);
  
  // Attach interrupt for Encoder
  attachInterrupt(digitalPinToInterrupt(ENCODER_A), readEncoder, RISING);
}

void loop() {
  // 1. Read Potentiometer and Map to Angle (-270 to 270)
  int potValue = analogRead(POT_PIN);
  targetAngle = map(potValue, 0, 1023, -270, 270);
  
  // 2. Calculate Current Angle from Encoder
  // 360 degrees / (PPR * 4 for quadrature) if reading both edges, 
  // but here we use simple single interrupt reading:
  currentAngle = (encoderPosition / PPR) * 360.0;
  
  // 3. Calculate Error
  error = targetAngle - currentAngle;
  
  // 4. Control Logic (Proportional Controller)
  // "Decrease speed accordingly" means P-control
  int controlSignal = abs(error) * Kp;
  
  // Clamp speed between 0 and 255
  motorSpeed = constrain(controlSignal, 0, 255);
  
  // Minimum speed to overcome friction (e.g. 50 PWM)
  if (motorSpeed < 50 && abs(error) > deadzone) {
    motorSpeed = 50;
  }
  
  // 5. Drive Motor
  if (abs(error) <= deadzone) {
    stopMotor();
  } else if (error > 0) {
    moveCW(motorSpeed);
  } else {
    moveCCW(motorSpeed);
  }
  
  // 6. Serial Plotter Output
  // Format: "Label:Value, Label:Value"
  Serial.print("Target:");
  Serial.print(targetAngle);
  Serial.print(", ");
  Serial.print("Current:");
  Serial.print(currentAngle);
  Serial.print(", ");
  Serial.print("potAnalog: ");
  Serial.println(potValue);
  
  delay(10); // Stability delay
}

// --- MOTOR FUNCTIONS ---
void moveCW(int speed) {
  digitalWrite(MOTOR_IN1, HIGH);
  digitalWrite(MOTOR_IN2, LOW);
  analogWrite(MOTOR_PWM, speed);
}

void moveCCW(int speed) {
  digitalWrite(MOTOR_IN1, LOW);
  digitalWrite(MOTOR_IN2, HIGH);
  analogWrite(MOTOR_PWM, speed);
}

void stopMotor() {
  digitalWrite(MOTOR_IN1, LOW);
  digitalWrite(MOTOR_IN2, LOW);
  analogWrite(MOTOR_PWM, 0);
}

// --- INTERRUPT SERVICE ROUTINE ---
void readEncoder() {
  // Read state of B to determine direction
  if (digitalRead(ENCODER_B) == LOW) {
    encoderPosition++;
  } else {
    encoderPosition--;
  }
}