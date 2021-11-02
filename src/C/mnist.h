#ifndef _mnist_h_
#define _mnist_h_

// set appropriate path for data
#define TRAIN_IMAGE "./data/train-images-idx3-ubyte"
#define TRAIN_LABEL "./data/train-labels-idx1-ubyte"
#define TEST_IMAGE "./data/t10k-images-idx3-ubyte"
#define TEST_LABEL "./data/t10k-labels-idx1-ubyte"

#define SIZE 784 // 28*28
#define NUM_TRAIN 60000
#define NUM_TEST 10000
#define LEN_INFO_IMAGE 4
#define LEN_INFO_LABEL 2

#define MAX_IMAGESIZE 1280
#define MAX_BRIGHTNESS 255
#define MAX_FILENAME 256
#define MAX_NUM_OF_IMAGES 1

unsigned char image[MAX_NUM_OF_IMAGES][MAX_IMAGESIZE][MAX_IMAGESIZE];
int width[MAX_NUM_OF_IMAGES], height[MAX_NUM_OF_IMAGES];

int info_image[LEN_INFO_IMAGE];
int info_label[LEN_INFO_LABEL];

unsigned char train_image_char[NUM_TRAIN][SIZE];
unsigned char test_image_char[NUM_TEST][SIZE];
unsigned char train_label_char[NUM_TRAIN][1];
unsigned char test_label_char[NUM_TEST][1];

double train_image[NUM_TRAIN][SIZE];
double test_image[NUM_TEST][SIZE];
int  train_label[NUM_TRAIN];
int test_label[NUM_TEST];

void FlipLong(unsigned char * ptr);
void read_mnist_char(char *file_path, int num_data, int len_info, int arr_n, unsigned char data_char[][arr_n], int info_arr[]);
void image_char2double(int num_data, unsigned char data_image_char[][SIZE], double data_image[][SIZE]);
void label_char2int(int num_data, unsigned char data_label_char[][1], int data_label[]);
void load_mnist();
void print_mnist_pixel(double data_image[][SIZE], int num_data);
void print_mnist_label(int data_label[], int num_data);
void save_image(int n, char name[]);
void save_mnist_pgm(double data_image[][SIZE], int index);

#endif
