#include "../cudatrix.cu"
#include "stdio.h"

int main()
{
  cudatrix::Scalar a;
  cudatrix::Scalar b;
  cudatrix::Scalar bMult;
  cudatrix::Scalar aMult;

  a.value = 100000.0;
  b.value = 10.0;
  bMult.value = 2.0;
  aMult.value = 3.0;

  cudatrix::scalarSum(&a.value, &b.value);
  cudatrix::scalarMult(&aMult.value, &bMult.value);
  printf("Scalar sum %f\n", a.value);
  printf("Scalar multiplication %f\n", aMult.value);
  return 0;
}