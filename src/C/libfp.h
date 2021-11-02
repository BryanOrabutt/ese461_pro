#ifndef _libfp_h_
#define _libfp_h_

typedef int fixed;

fixed fpadd(fixed a, fixed b, int bits);
fixed fpsub(fixed a, fixed b, int bits);
fixed fpmult(fixed a, fixed b, int bits, int fp);
fixed fpdiv(fixed a, fixed b, int bits, int fp);
fixed fpabs(fixed a, int bits, int fp);
fixed float_to_fixed(double in, int bits, int fp);
double fixed_to_float(fixed in, int fp);

#endif
