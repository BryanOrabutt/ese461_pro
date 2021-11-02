#include "libfp.h"
#include <math.h>

/* Fixed point add 
 * Can be computed as normal just need to truncate upper bits caused by overflows.
 */
fixed fpadd(fixed a, fixed b, int bits)
{
	unsigned int mask = 0xffffffff;
	mask >>= bits;
    int sign_mask = 0x8000;
    fixed res = 0;
    if((a & sign_mask) && (b & sign_mask))
    {
        res = a + b;
        res = res & mask;
        res |= sign_mask;
    }
    else if((a & sign_mask) && !(b & sign_mask))
    {
        res = b - a;
        res = res & mask;
        if( (a & ~sign_mask) > b) res |= sign_mask;
        else res &= ~sign_mask;
    }
    else if(b & sign_mask)
    {
        res = a - b;
        res = res & mask;
        if( (a & ~sign_mask) < b) res |= sign_mask;
        else res &= ~sign_mask;
    }
    else
    {
        res = a + b;
        res = res & mask;
        res &= ~sign_mask;
    }
    
	return res;
}

/* Fixed point sub 
 * Can be computed as normal, just need to truncate upper bits caused by overflows.
 */
fixed fpsub(fixed a, fixed b, int bits)
{
	unsigned int mask = 0xffffffff;
	mask >>= bits;
    int sign_mask = 0x8000;
    fixed res = 0;
    if((a & sign_mask) && (b & sign_mask))
    {
        res = b - a;
        res = res & mask;
        if( (a & ~sign_mask) > b) res |= sign_mask;
        else res &= ~sign_mask;
    }
    else if((a & sign_mask) && !(b & sign_mask))
    {
        res = a + b;
        res = res & mask;
        res |= sign_mask;
    }
    else if(b & sign_mask)
    {
        res = a + b;
        res = res & mask;
        res &= ~sign_mask;
    }
    else
    {
        res = a - b;
        res = res & mask;
        if( a < b) res |= sign_mask;
        else res &= ~sign_mask;
    }
	return res;
}

/* Fixed point multiply.
 * Perform integer multiplication of each fixed point number.
 * Since each is scaled by 2^fp, the result is scaled by 2^2fp
 * Divide by 2^fp to scale back result.
 */
fixed fpmult(fixed a, fixed b, int bits, int fp)
{
	int scale = 1 << fp;
	unsigned int mask = 0xffffffff;
	mask >>= bits;

    int sign_mask = 0x8000;
	mask >>= bits;
    fixed res =  (((long)a*(long)b)/scale) & mask;;
    if((a & sign_mask) ^ (b & sign_mask)) res |= sign_mask;
    else res &= ~sign_mask;
	return res;
}

/* Fixed point divide
 * Similar to mult, both numbers are scaled by 2^fp
 * So a normal divide would cancel the 2^fp
 * We must multiply numerator bny 2^fp to compensate.
 */
fixed fpdiv(fixed a, fixed b, int bits, int fp)
{
	int scale = 1 << fp;
	unsigned int mask = 0xffffffff;
    int sign_mask = 0x8000;
	mask >>= bits;
    fixed res =  (((long)a*scale)/b) & mask;
    if((a & sign_mask) ^ (b & sign_mask)) res |= sign_mask;
    else res &= ~sign_mask;
	return res;
}

/* Fixed point absolute value
 * Isolate the integer portion and fractional portion.
 * Perform twos complement transform on integer portion to get
 * positive value if the sign bit is a 1.
 * Shift the integer portion back into place and or with the fractional
 * portion for the result.
 */
fixed fpabs(fixed a, int bits, int fp)
{
    int sign_mask = 0x80000;
	return a & (~sign_mask);
}

/* Floting point to fixed point conversion
 * Scale the floating point number by the scale factor and
 * round the result.
 */
fixed float_to_fixed(double in, int bits, int fp)
{
	unsigned int mask = 0xffffffff;
    int sign_mask = 0x80000;
	mask >>= bits;
    if(in < 0)
    {
        mask &= ~sign_mask;
    }
	return (fixed) (round(in*(1 << fp))) & mask;
}

/* Fixed point to floating point conversion
 * Divide by the scale factor (floating point)
 */
double fixed_to_float(fixed in, int fp)
{
    int sign_mask = 0x8000;
    int neg = (sign_mask & in) ? 1:0;
    double res = ((double) in/ (double) (1 << fp));
    if(neg) res *= -1.0;
    return res;
}



