#ifndef _nn_h_
#define _nn_h_

#include "libfp.h"

#define INPUTS 784
#define OUTPUTS 10
#define HIDDEN 128
#define BATCH 10

#define GAMMA 0.01

double activation(double in);
double deriv_activation(double in);
void init_weights();
void init_data();
double rand01();
void feed_forward(double* in);
void shuffle();
void train(int epoch, double lr, int reuse);
void test();

#endif
