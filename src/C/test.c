#include "nn.h"
#include <stdio.h>
#include <stdlib.h>


int main(int argc, char** argv)
{
    char* tmp;
    char* tmp2;
    char* tmp3;
    
    if(argc < 5)
    {
        printf("Please run program with ./nn_test <int: num epochs> <double: learning rate> <char: 't' or 'v'> <int: reuse_weights>. Use nonzero values.\n");
        return -1;
    }
    
    int epochs = (int)strtol(argv[1], NULL, 10);
    double lr = strtod(argv[2], &tmp); 
    
    if(argv[3][0] == 't')
    {
        if((int)strtol(argv[4], &tmp2, 10) == 1)
        {
            train(epochs, lr, 1);
        }
        else
        {
            train(epochs, lr, 0);            
        }
    }
    else
    {
        test();
    }


    return 0;
}
