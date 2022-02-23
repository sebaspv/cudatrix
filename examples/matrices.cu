#include "../cudatrix.cu"
#include "stdio.h"
#include <vector>
#include <algorithm>

int main()
{
    // initialize matrices
    float **matrix1;
    float **matrix2;
    float **resultantMatrix;
    int rows = 2;
    int columns = 2;
    int rows1 = 2;
    int columns1 = 2;
    matrix1 = new float *[rows];
    matrix2 = new float *[rows];
    resultantMatrix = new float *[rows];

    for (int i = 0; i < rows; i++)
    {
        matrix1[i] = new float[columns];
        matrix2[i] = new float[columns];
        resultantMatrix[i] = new float[columns];
    }
    for (int i = 0; i < rows; i++)
    {
        for (int j = 0; j < columns; j++)
        {
            matrix1[i][j] = 100.0f; // initialize matrix1 with values of 100
            matrix2[i][j] = 20.0f;  // initialize matrix2 with values of 20
        }
    }
    cudatrix::matrixSum(matrix1, matrix2, resultantMatrix, rows, rows1, columns, columns1);
    printf("Matrix 1: \n");
    for (int i = 0; i < rows; i++)
    {
        for (int j = 0; j < columns; j++)
        {
            printf("%f ", matrix1[i][j]);
        }
        printf("\n");
    }
    printf("Matrix 2: \n");
    for (int i = 0; i < rows1; i++)
    {
        for (int j = 0; j < columns1; j++)
        {
            printf("%f ", matrix2[i][j]); // successful sum!
        }
        printf("\n");
    }
    printf("-----------------------------\n");
    printf("\nSum of both matrices:\n");
    for (int i = 0; i < rows; i++)
    {
        for (int j = 0; j < columns; j++)
        {
            printf("%f ", resultantMatrix[i][j]); // successful sum!
        }
        printf("\n");
    }
}