#include "Arduino.h"
#include "lib_pids.h"


lib_pids::lib_pids()
{
}

void lib_pids::begin(float kp,float ki,float kd)
{
  _kp = kp;
  _ki = ki;
  _kd = kd;

  // Para pid pasabaja
  _A1_p = -kp;  _tau = kd/(kp*_N_pid);
}


float lib_pids::simple(float error_v,float dt_v)
{
  // v pasado por valor, p pasado por puntero
  // Pasar integral y error previo por referencia, ej PID.simple(error,dt,&integral,&error_previo,kp,ki,kd)
  // Se pasa por puntero la integral y error previo para que se cambie en el programa
  
  if (dt_v == 0)  
  { 
    return 0.0;
  } // para evitar kd/0

  _integral_simple = (_integral_simple) + error_v*dt_v;
  _derivada_simple = (error_v - _error_previo_simple)/dt_v;

  _error_previo_simple = error_v;

   //kp * error_v + ki* (*integral_p) + kd * derivada;
  return _kp * error_v + _ki* (_integral_simple) + _kd * _derivada_simple;

}


float lib_pids::filtro_iir(float error0_v, float dt_v)
{


  if (dt_v == 0)  
  { 
    return 0.0;
  } // para evitar kd/0
  _pidA0 = _kp + _ki *dt_v + _kd/dt_v;
  _pidA1 = -_kp - (2 * _kd)/dt_v;
  _pidA2 = _kd/ dt_v;

  // Mirar poner esto en el setup o algo, que no haya que pasar error 2 y error 1
  _error_previo_iir2 = _error_previo_iir1;
  _error_previo_iir1 = _error_previo_iir0;
  _error_previo_iir0 = error0_v;
  _salida_previa_iir = _salida_previa_iir + _pidA0 * _error_previo_iir0 + _pidA1* _error_previo_iir1 + _pidA2 * _error_previo_iir2;

  return _salida_previa_iir;

}


float lib_pids::filtro_pasabaja(float error0_v, float dt_v)
{
  if (dt_v == 0)  
  { 
    return 0.0;
  } // para evitar kd/0


  // Poner valores a las variables
  _A0_p = _kp + _ki * dt_v;
  _A0d =_kd/dt_v;
  _A1d =-2.0*_kd/dt_v;
  _A2d =_kd/dt_v;
  _alpha= dt_v/(2*_tau);
  _alpha_1= _alpha/(_alpha+1);
  _alpha_2 = (_alpha -1)/(_alpha +1);


  _error2_pb = _error1_pb;
  _error1_pb = _error0_pb;
  _error0_pb = error0_v;

  // Pi
  _salida_pid = _salida_pid + _A0_p * _error0_pb + _A1_p * _error1_pb;

  // D
  _d1 = _d0;
  _d0 = _A0d * _error0_pb + _A1d * _error1_pb + _A2d * _error2_pb;
  _fd1 = _fd0;
  _fd0 = _alpha_1 * (_d0 + _d1) - _alpha_2 * _fd1;
  _salida_pid = _salida_pid + _fd0;

  return _salida_pid;

}


