/*
Copyright (c) 2022 Sebastian Ponce. All rights reserved.

This work is licensed under the terms of the MIT license.  
For a copy, see <https://opensource.org/licenses/MIT>.
*/


#pragma once

namespace cudatrix
{
    class Scalar
    {
    public:
        float value;
    };
    void scalarSum(float *a, float *b);
    void scalarMult(float *a, float *b);
    void matrixSum(float **matrix1, float **matrix2, float **resultantMatrix, int rows_1, int rows_2, int columns_1, int columns_2);
    void matrixMult(float **matrix1, float **matrix2, float **resultantMatrix, int rows_1, int rows_2, int columns_1, int columns_2);
}