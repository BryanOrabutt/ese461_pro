
#include <math.h>
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "nn.h"
#include "mnist.h"


#define LAMBDA .0001

double hidden_layer[HIDDEN]; //hidden layer activation value
double output_layer[OUTPUTS]; //output layer activiation value

double hidden_weights[INPUTS][HIDDEN]; //hidden layer weights 
double output_weights[HIDDEN][OUTPUTS]; //output layer weights

double output_real[NUM_TRAIN][OUTPUTS];

fixed hidden_weights_fp[INPUTS][HIDDEN];
fixed output_weights_fp[HIDDEN][OUTPUTS];


int train_order[NUM_TRAIN]; //order of training data for SGD

/* Activation function
 * f(x) = 0.5*x/(|x|+1)+0.5
 * all fixed point
 */
double activation(double in)
{
    double abs_in = (in < 0) ? -1*in:in;
    double ret = (0.5*in)/(abs_in+1)+0.5;
    
    if(!isfinite(ret)) ret = 1e-8;
    
	return ret;
    //return 1.0/(1.0+exp(-1.0*in));
}

/* Derivative of activation function
 * f'(x) = 0.5/(|x|+1)^2
 * all fixed point
 */
double deriv_activation(double in)
{
    double abs_in = (in < 0) ? -1*in:in;
	return 0.5/((abs_in+1)*(abs_in+1));
    //return exp(-1.0*in)/((exp(-1.0*in)+1)*(exp(-1.0*in)+1));
}

/* Prepare MNIST data.
 * Load data from files into vectors and convert vectors into fixed point.
 */
void init_data()
{    
    printf("Initializing data vectors\n");
	load_mnist();
    
    int i, j;
    
    for(i = 0; i < NUM_TRAIN; i++)
    {
        for(j = 0; j < OUTPUTS; j++)
        {
            output_real[i][j] = (train_label[i] == j) ? 1.0:0.0;
        }
    }
}

/* Random number between 0 and 1
 * Generates fixed point number between 0 and 1
 */
double rand01()
{
	double r = (double)rand()/RAND_MAX;
    r = -1.0 + 2*r;
	
	return r;
}

/* Initialize weight vectors.
 * Randomly assign all weights.
 */
void init_weights()
{
	int i, j;
	srand(time(0));

    printf("Initializing weight vectors...\n");
    
	for(i = 0; i < INPUTS; i++)
	{
		for(j = 0; j < HIDDEN; j++)
		{
			hidden_weights[i][j] = rand01()/sqrt(INPUTS);
            //if(j%2) hidden_weights[i][j] = hidden_weights[i][j]*-1.0;
		}
	}
	
	printf("Hidden layer weight vector initialized. Initializing output vector...\n");

	for(i = 0; i < HIDDEN; i++)
	{
		for(j = 0; j < OUTPUTS; j++)
		{
			output_weights[i][j] = rand01()/sqrt(HIDDEN);
            //if(j%2) output_weights[i][j] = output_weights[i][j]*-1.0;
		}
	}
	
	printf("Output layer weight vector initialized.\n");
}

static void print_weights()
{
    int i, j;
    
//     printf("Hidden weight matrix:\n");
//     
//     for(i = 0; i < INPUTS; i++)
//     {
//         for(j = 0; j < HIDDEN; j++)
//         {
//             printf("%.8lf ", hidden_weights[i][j]);
//         }
//         printf("\n");
//     }
    
    printf("Output weight matrix:\n");
    
    for(i = 0; i < HIDDEN; i++)
    {
        for(j = 0; j < OUTPUTS; j++)
        {
            printf("%.8lf ", output_weights[i][j]);
        }
        printf("\n");
    }
}

/* Feed forward
 * Compute each layer's activation and propogate results downstream.
 */
void feed_forward(double* in)
{
	int i, j;
	double s;
    

	//layer1
	for(i = 0; i < HIDDEN; i++)
	{
        s = 0;
		for(j = 0; j < INPUTS; j++)
        {
            s += hidden_weights[j][i]*in[j];
        }
        hidden_layer[i] = activation(s);
	}

	//layer2
	for(i = 0; i < OUTPUTS; i++)
    {
        s = 0;
        for(j = 0; j < HIDDEN; j++)
        {
            s += output_weights[j][i]*hidden_layer[j];
        }
        output_layer[i] = activation(s);        
    }
    
}

/* Initializ training order vector
 * Create a vector to store the order for computing training data
 */
static void init_train_order()
{
    int i;
    
    printf("Initializing training data order for stochastic gradient descent\n");
    
    for(i = 0; i < NUM_TRAIN; i++)
    {
        train_order[i] = i;
    }
    
    printf("Training data order initialized.\n");
}

/* Shuffle training data order
 * Shuffles the training data order needed by SGD.
 */
void shuffle()
{
    printf("Shuffling input order.\n");
    
    int n = NUM_TRAIN;
    if (n > 1) 
    {
        size_t i;
        for (i = 0; i < n - 1; i++) 
        {
          size_t j = i + rand() / (RAND_MAX / (n - i) + 1);
          int t = train_order[j];
          train_order[j] = train_order[i];
          train_order[i] = t;
        }
    }
    
    printf("Shuffle done.\n");
}

/* Compute prediction
 * Determine the output neruon with highest activation and use it as the
 * predicted value.
 */
static int prediction()
{
    int i = 0;
    int res = 0;
    double max = 0;
    
    for(i = 0; i < OUTPUTS; i++)
    {
        //double val = fixed_to_float(output_layer[i], 8);
        if(max < output_layer[i])
        {
            max = output_layer[i];
            res = i;
        }
    }
    
    return res;
}

/* Write output data
 * Writes weight values to data files.
 */
static void write_data()
{
    int i, j;
    
    FILE* file_o, *file_ofp;
    FILE* file_h, *file_hfp;
    
    printf("Writing output data.\n");
    printf("Double value of output weight: ./output_weights.txt\n");
    printf("Hex value of fixed point output weight: ./output_weights_fp.txt\n");
    printf("Double value of hidden layer weight: ./hidden_weights.txt\n");
    printf("Hex value of fixed point hidden layer weight: ./hidden_weights_fixed.txt\n");
    
    file_o = fopen("./output_weights.txt", "w");
    file_ofp = fopen("./output_weights_fp.txt", "w");
    file_h = fopen("./hidden_weights.txt", "w");
    file_hfp = fopen("./hidden_weights_fixed.txt", "w");
    
    for(i = 0; i < INPUTS; i++)
    {
        for(j = 0; j < HIDDEN; j++)
        {
            char line[25];
            sprintf(line, "16'h%x\n", float_to_fixed(hidden_weights[i][j], 16, 8));
            fputs(line, file_hfp);
            memset(line, 0, 15);
            sprintf(line, "%.8lf\n", hidden_weights[i][j]);
            fputs(line, file_h);
        }
    }
    
    for(i = 0; i < HIDDEN; i++)
    {
        for(j = 0; j < OUTPUTS; j++)
        {
            char line[25];
            sprintf(line, "16'h%x\n", float_to_fixed(output_weights[i][j], 16, 8));
            fputs(line, file_ofp);
            memset(line, 0, 15);
            sprintf(line, "%.8lf\n", output_weights[i][j]);
            fputs(line, file_o);
        }
    }
    
    fclose(file_o);
    fclose(file_ofp);
    fclose(file_h);
    fclose(file_hfp);
    
}

static void load_weights()
{
    int i, j;
    i = j = 0;
    
    FILE* file_o;
    FILE* file_h;
    
    printf("Loading weight data.\n");
    
    file_o = fopen("./output_weights.txt", "r");
    file_h = fopen("./hidden_weights.txt", "r");
    
    for(i = 0; i < INPUTS; i++)
    {
        for(j = 0; j < HIDDEN; j++)
        {            
            fscanf(file_h, "%lf", &hidden_weights[i][j]);
        }
    }
    
    for(i = 0; i < HIDDEN; i++)
    {
        for(j = 0; j < OUTPUTS; j++)
        {            
            fscanf(file_o, "%lf", &output_weights[i][j]);
        }
    }
    
    fclose(file_o);
    fclose(file_h);
    
}


/* Train the network
 * Trains the network:
 * Loads input data,
 * Initializes weight vectors.
 * Intialize training order
 * Compute network and perform stochastic gradient descent for EPOCH iterations.
 * write data after compltetion.
 */
void train(int epoch, double lr, int reuse)
{
    int j, k, x, b;
    int p = 0;
    init_data();
    init_train_order();
    
    if(reuse != 1)
    {
        init_weights();   
    }
    else
    {
        load_weights();
    }
    
    clock_t start, end, epoch_start, epoch_end;
    double cpu_time, epoch_time;
    
    double max = 0;
    double loss = 0;
    
    printf("Running training for %d epochs...\n", epoch);
    
    start = clock();
    
    for(int n = 0; n < epoch; n++)
    {
        double acc = 0;
        int correct = 0;
        epoch_start = clock();
        printf("====================> Epoch %d <====================\n", n);
        shuffle();
        printf("Computing...\n");
    
        for(x = 0; x < NUM_TRAIN; x++)
        {
            loss = 0;
            int i = train_order[x];
            feed_forward(train_image[i]);
            p = prediction();
        
            double dout[OUTPUTS];
            double dhidden[HIDDEN];
            
            for(j = 0; j < OUTPUTS; j++)
            {
                //loss += output_real[i][j]*log(output_layer[j]) + (1.0-output_real[i][j])*log(1.0-output_layer[j]);
                //printf("Index: %d\tOut: %.8lf\tTruth: %.8lf\tLabel: %d\n",j, output_layer[j], output_real[i][j], train_label[i]);
                double derr = (output_real[i][j] - output_layer[j]);
                loss += derr*derr;
                //double derr = (-output_real[i][j]/output_layer[j]) + (1.0-output_real[i][j])/(1.0-output_layer[j]);
                dout[j] = derr*deriv_activation(output_layer[j]);
                //printf("output %d gradient: %.8lf\n", j, dout[j]);
            }
            
            //loss *= -1.0;
            loss /= OUTPUTS;
        
            for(j = 0; j < HIDDEN; j++)
            {
                double derr = 0;
                for(k = 0; k < OUTPUTS; k++)
                {
                    derr += dout[k]*output_weights[j][k];
                }
                
                dhidden[j] = derr*deriv_activation(hidden_layer[j]);
                //printf("hidden %d gradient: %.8lf\n", j, dhidden[j]);
            }

            correct += (p == train_label[i]) ? 1:0; 
            
            for(j = 0; j < OUTPUTS; j++)
            {
                for(k = 0; k < HIDDEN; k++)
                {
                    //printf("Out%d%d update: %.8lf\n", k,j,dout[j]*lr*hidden_layer[k]);
                    output_weights[k][j] += lr*(dout[j]*hidden_layer[k]);
                    //output_weights[k][j] -= LAMBDA*output_weights[k][j];
                    
                    if(output_weights[k][j] < -10.0)
                    {
                        output_weights[k][j] = -10.0;
                    }
                    else if(output_weights[k][j] > 10.0) 
                    {
                        output_weights[k][j] = 10.0;
                    }
                }
            }
            
            for(j = 0; j < HIDDEN; j++)
            {
                for(k = 0; k < INPUTS; k++)
                {
                    //printf("Hidden%d%d update: %.8lf\n", k,j,dhidden[j]*lr*train_image[i][k]);
                    hidden_weights[k][j] += lr*(dhidden[j]*train_image[i][k]);
                    //hidden_weights[k][j] -= LAMBDA*hidden_weights[k][j];
                
                    if(hidden_weights[k][j] < -10.0) 
                    {
                        hidden_weights[k][j] = -10.0;
                    }
                    else if(hidden_weights[k][j] > 10.0) 
                    {
                        hidden_weights[k][j] = 10.0;
                    }
                }
            }
        }
        
        acc = (double)correct/NUM_TRAIN;
        if(acc > max)
        {
            max = acc;
            printf("Checkpoint reached. Accuracy improved. Saving...\n");
            write_data();
        }
        
        epoch_end = clock();
        epoch_time = ((double)(epoch_end - epoch_start))/CLOCKS_PER_SEC;
        //print_weights();
        
        printf("Epoch completed in %f seconds\n", epoch_time);
        printf("Accuracy = %.8f%%\tLoss: %.8f\n", acc*100.0, loss);
    }
    
    end = clock();
    
    cpu_time = ((double)(end - start))/CLOCKS_PER_SEC;
    printf("Training completed in %f seconds\n", cpu_time);
    
    //write_data();
}

/* Perform test computation
 * For every item in the test set, compute the activation of the network.
 * Find the predicted value and detrmine how accurate the network is.
 */
void test(int reuse)
{
    int i, j;
    init_data();
    
    if(reuse)
    {
        load_weights();
    }
    
    FILE* fout;
    double acc = 0;
    int correct = 0;
    
    fout = fopen("predictions.csv", "w");
    
    fputs("Label\tPrediction\n", fout);
    
    printf("Beginning testing...\n");
    
    for(i = 0; i < NUM_TEST; i++)
    {
        char line[15];
        for(j = 0; j < INPUTS; j++)
        {
            feed_forward(test_image[i]);
        }
        
        sprintf(line, "%d\t%d\n", test_label[i], prediction());
        
        fputs(line, fout);
        
        correct += (prediction() == test_label[i]) ? 1:0;
        if((i%100) == 0)
        {
            printf("Tested %d, accuracy so far: %.8lf%%\n", i+1, (double)correct*100.0/(i+1));
        }
        
    }
    
    fclose(fout);
    acc = (double)correct/NUM_TEST;
    
    printf("Results written to predictions.csv.\n Accuracy = %.8f%%\n", acc*100.0);
}

 
