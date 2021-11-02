#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "mnist.h"

int convert(double in)
{
    int sign = (in < 0) ? 0x00008000:0;
    in *= (in < 0) ? -1.0:1.0;
    
    printf("|Val| = %.8lf\n", in);

    int res = round(in*(1<<8));
    
    printf("res = 0x%x\tsign = 0x%x\n", res | sign, sign);
    return res | sign;
    
}

int main(int argc, char** argv)
{
    load_mnist();
    FILE* infile, *outfile;
    
    if(argc < 3)
    {
        printf("Please run s ./transcribe <inputfile> <outputfile>\n");
        exit(1);
    }
    
    infile = fopen(argv[1], "r");
    outfile = fopen(argv[2], "w");
    
    char line[15];
    double val;
    while(fscanf(infile, "%lf\n", &val) && !feof(infile))
    {
        printf("Read from file: %.8lf\n", val);
        fprintf(outfile, "16'h%x\n", convert(val));
    }
    
    FILE* mnist_file = fopen("inputs.txt", "w");
    
    for(int j = 0; j < 10; j++)
    {
        for(int i = 0; i < 784; i++)
        {
            printf("MNIST pixel: %.8lf\n", train_image[j][i]);
            fprintf(mnist_file, "16'h%x\n", convert(train_image[j][i]));
        }
    }
    
    fclose(infile);
    fclose(outfile);
    
    return 0;
}

