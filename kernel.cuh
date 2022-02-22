#pragma once
#include <vector>

namespace cudatrix
{
    class Scalar
    {
    public:
        float value;
    };
    void scalarSum(float *a, float *b);
    void matrixSum(float **matrix1, float **matrix2, float **resultantMatrix, int rows_1, int rows_2, int columns_1, int columns_2);
}