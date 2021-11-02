
TARGET=nn_test

CC=gcc
WARN=-Wall
LD_FLAGS=-lm
SRC=$(foreach dir, ., $(wildcard $(dir)/*.c))
CFLAGS= $(WARN) -g -std=c99 -O3

all: $(SRC)
	$(CC) -o $(TARGET) $(CFLAGS) $(LD_FLAGS) $(SRC)

clean: $(TARGET)
	rm $(TARGET)
	rm *.txt
	rm *.csv
