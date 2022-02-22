#include "kernel.cuh"
#include <cuda_runtime.h>
#include "stdio.h"
__global__ void scalarSumKernel(float *scalar1, float *scalar2)
{
  scalar1[threadIdx.x] += scalar2[threadIdx.x];
}

void cudatrix::scalarSum(float *a, float *b)
{
  float *a_d;
  float *b_d;
  cudaMallocManaged(&a_d, 1 * sizeof(float));
  cudaMemcpy(a_d, a, 1 * sizeof(float), cudaMemcpyHostToDevice);
  cudaMallocManaged(&b_d, 1 * sizeof(float));
  cudaMemcpy(b_d, b, 1 * sizeof(float), cudaMemcpyHostToDevice);

  scalarSumKernel<<<1, 1>>>(a_d, b_d);
  cudaDeviceSynchronize();
  cudaMemcpy(a, a_d, 1 * sizeof(float), cudaMemcpyDeviceToHost);
  cudaMemcpy(b, b_d, 1 * sizeof(float), cudaMemcpyDeviceToHost);
  cudaFree(a_d);
  cudaFree(b_d);
}

void cudatrix::matrixSum(float **matrix1, float **matrix2, float **resultantMatrix, int rows_1, int rows_2, int columns_1, int columns_2)
{
  float value1;
  float value2;

  for (int i = 0; i < rows_1; i++)
  {
    for (int j = 0; j < columns_2; j++)
    {
      resultantMatrix[i][j] = 0.0f;
      for (int k = 0; k < rows_2; k++)
      {
        value1 = matrix1[i][k];
        value2 = matrix2[k][j];
        scalarSumKernel<<<1, 1>>>(&value1, &value2);
        cudaDeviceSynchronize();
        resultantMatrix[i][j] += value1;
      }
    }
  }
}