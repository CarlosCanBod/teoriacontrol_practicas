#ifndef lib_pids_h
#define lib_pids_h

#include "Arduino.h"

class lib_pids
{
  public:

    lib_pids();

    void begin(float kp,float ki,float kd);

    float simple(float error_v,float dt_v);

    float filtro_iir(float error0_v, float dt_v);

    float filtro_pasabaja(float error0_v, float dt_v);


  private:

    float _salida_pid;
    float _kp;
    float _ki;
    float _kd;
    float _integral_simple;
    float _derivada_simple;
    float _error_previo_simple;
 

    // Para filtro iir
    float _pidA0;  
    float _pidA1;  
    float _pidA2;
    float _error_previo_iir0;
    float _error_previo_iir1;
    float _error_previo_iir2;
    float _salida_previa_iir;

    // Variables para el filtro pasabaja
    const int _N_pid = 5;

    float _error2_pb; // Error anterior para filtro pasabaja
    float _error1_pb;
    float _error0_pb;

    float _A0_p;
    float _A1_p;
    float _A0d;
    float _A1d;
    float _A2d;
    float _tau;
    float _alpha;
    float _alpha_1;
    float _alpha_2;
    float _d0;
    float _d1;
    float _fd0;
    float _fd1;

};

#endif
