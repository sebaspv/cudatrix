#include "kernel.cuh"
#include <cuda_runtime.h>


__global__ void scalarSumKernel(float *scalar1, float *scalar2)
{
  scalar1[threadIdx.x] += scalar2[threadIdx.x];
}

__global__ void scalarMultKernel(float *scalar1, float *scalar2)
{
  scalar1[threadIdx.x] *= scalar2[threadIdx.x];
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

void cudatrix::scalarMult(float *a, float *b)
{
  float *a_d;
  float *b_d;
  cudaMallocManaged(&a_d, 1 * sizeof(float));
  cudaMemcpy(a_d, a, 1 * sizeof(float), cudaMemcpyHostToDevice);
  cudaMallocManaged(&b_d, 1 * sizeof(float));
  cudaMemcpy(b_d, b, 1 * sizeof(float), cudaMemcpyHostToDevice);
  scalarMultKernel<<<1, 1>>>(a_d, b_d);
  cudaDeviceSynchronize();
  cudaMemcpy(a, a_d, 1 * sizeof(float), cudaMemcpyDeviceToHost);
  cudaMemcpy(b, b_d, 1 * sizeof(float), cudaMemcpyDeviceToHost);
  cudaFree(a_d);
  cudaFree(b_d);
}

void cudatrix::matrixSum(float **matrix1, float **matrix2, float **resultantMatrix, int rows_1, int rows_2, int columns_1, int columns_2)
{
  cudatrix::Scalar value1;
  cudatrix::Scalar value2;

  for (int i = 0; i < rows_1; i++)
  {
    for (int j = 0; j < columns_2; j++)
    {
      resultantMatrix[i][j] = 0.0;
      for (int k = 0; k < rows_2; k++)
      {
        value1.value = matrix1[i][k];
        value2.value = matrix2[k][j];
        cudatrix::scalarSum(&value1.value, &value2.value);
        resultantMatrix[i][j] = value1.value;
      }
    }
  }
}

void cudatrix::matrixMult(float **matrix1, float **matrix2, float **resultantMatrix, int rows_1, int rows_2, int columns_1, int columns_2)
{
  cudatrix::Scalar value1;
  cudatrix::Scalar value2;

  for (int i = 0; i < rows_1; i++)
  {
    for (int j = 0; j < columns_2; j++)
    {
      resultantMatrix[i][j] = 0.0;
      for (int k = 0; k < rows_2; k++)
      {
        value1.value = matrix1[i][k];
        value2.value = matrix2[k][j];
        cudatrix::scalarMult(&value1.value, &value2.value);
        resultantMatrix[i][j] = value1.value;
      }
    }
  }
}