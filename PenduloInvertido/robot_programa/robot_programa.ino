
//#include <I2Cdev.h>
#include <Wire.h>
#include <MPU6050.h>
#include <lib_pids.h>


MPU6050 sensor;

// Pines motores
const int pinSTBY = 16;
const int pinPWMA = 15;
const int pinAIN2 = 2;
const int pinAIN1 = 4;
const int pinPWMB = 18;
const int pinBIN1 = 5;
const int pinBIN2 = 17;

const int vel_max = 160;
const int vel_min = 5;




// Valores sensor
short int ax, ay, az;
short int gx, gy, gz;
long tiempo_prev ;
float dt ;
float ang_x , ang_y, ang_z ;
float ang_x_prev , ang_y_prev, ang_z_prev ;

// Cosas PID
float error = 0;
float salida_pid;
float kp, ki, kd;

lib_pids PID;


void moveMotor ( int pinPWM , int pinIN1 , int pinIN2 , float speed )
 {


  if ( speed > 0) 
  {
    if (speed > vel_max) 
    { 
      speed = vel_max;
    }
    if (speed <= vel_min)
    {
      speed = speed*0;
    }
    digitalWrite ( pinIN1 , HIGH ) ;
    digitalWrite ( pinIN2 , LOW ) ;
    analogWrite ( pinPWM , speed ) ;
  } else 
  {
    if (speed < - vel_max) 
    { 
      speed = - vel_max;
    }
    if (speed > -vel_min)
    {
      speed = speed*0;
    }

    digitalWrite ( pinIN1 , LOW ) ;
    digitalWrite ( pinIN2 , HIGH ) ;
    analogWrite ( pinPWM , - speed ) ;
  }
}

void enableMotors () 
{
  digitalWrite ( pinSTBY , HIGH ) ;
}



void setup() 
{
  Serial.begin(57600);
  Wire.begin();
  sensor.initialize();
  
  if ( sensor.testConnection()) Serial.println (" Sensor iniciado correctamente " ) ;
  else Serial.println( " Error al iniciar el sensor " ) ;

  

  pinMode ( pinSTBY , OUTPUT ) ;
  pinMode ( pinPWMA , OUTPUT ) ;
  pinMode ( pinAIN2 , OUTPUT ) ;
  pinMode ( pinAIN1 , OUTPUT ) ;
  pinMode ( pinPWMB , OUTPUT ) ;
  pinMode ( pinBIN1 , OUTPUT ) ;
  pinMode ( pinBIN2 , OUTPUT ) ;

  // pid normal
  //kp = 11;
  //ki = 3;  
  //kd = 0.5;

  // Pid iir
  //kp = 10;
  //ki = 200;
  //kd = 0.25;


  // Pid pasabaja
  kp = 10;
  ki = 190;
  kd = 0.5;

  

  PID.begin(kp,ki,kd);

}

void loop() 
{

  sensor.getRotation(&gx,&gy,&gz);
  sensor.getAcceleration(&ax, &ay, &az) ;

  dt = ( millis () - tiempo_prev ) /1000.0;
  tiempo_prev = millis () ;

  float accel_ang_x = atan ( ay / sqrt ( pow ( ax ,2) + pow ( az ,2) ) ) *(180.0/3.14) ;
  float accel_ang_y = atan ( - ax / sqrt ( pow ( ay ,2) + pow ( az ,2) ) ) *(180.0/3.14) ;
  float accel_ang_z = atan ( az / sqrt ( pow ( ay ,2) + pow ( ax ,2) ) ) *(180.0/3.14) ;

  ang_x = 0.98*( ang_x_prev +( gx /131) * dt ) + 0.02* accel_ang_x ;
  ang_y = 0.98*( ang_y_prev +( gy /131) * dt ) + 0.02* accel_ang_y ;
  ang_z = 0.98*( ang_z_prev +( gz /131) * dt ) + 0.02* accel_ang_z ;


  ang_x_prev = ang_x ;
  ang_y_prev = ang_y ;
  ang_z_prev = ang_z ;


  //Mostrar los angulos separadas por un [ tab ]
  Serial . print ( " Rotacion en X : " ) ;
  Serial . print ( ang_x ) ;
  Serial . print ( " Rotacion en Y : " ) ;
  Serial . print ( ang_y ) ;

  // Cosas PID
  // PID simple
  
  error = -3 - ang_x;
  if (abs(error) < 0.5){error = error/10;}
  
  //salida_pid = PID.simple(error,dt);
  //salida_pid = PID.filtro_iir(error,dt);
  salida_pid = PID.filtro_pasabaja(error,dt);

  Serial . print ( " Salida PID : " ) ;
  Serial . println ( salida_pid ) ;

  enableMotors () ;
  moveMotor ( pinPWMA , pinAIN1 , pinAIN2 , salida_pid ) ;
  moveMotor ( pinPWMB , pinBIN1 , pinBIN2 , salida_pid ) ;


  delay(10);

// El  chasis se mueve al reves que las ruedas
// visto de perfil,  si se quiere mover el chasis en sentido horario, las ruedas moverlas en sentido antihorario

}
