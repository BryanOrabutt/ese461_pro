#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int main(int argc, char** argv)
{
    FILE* infile, *outfile;
    
    if(argc < 3)
    {
        printf("Please run ./rom_maker <inputfile> <outputfile>\n");
        exit(1);
    }
    
    infile = fopen(argv[1], "r");
    outfile = fopen(argv[2], "w");
    
    int val, address;
    address = 0;
    while(fscanf(infile, "16'h%x\n", &val) && !feof(infile))
    {
        printf("Read from file: 0x%x\n", val);
        fprintf(outfile, "17'h%x:\t16'h%x\n", address, val);
        address++;
    }
    
    fclose(infile);
    fclose(outfile);
    
    return 0;
}

