#include "../cudatrix.cu"
#include "stdio.h"

int main()
{
  cudatrix::Scalar a;
  cudatrix::Scalar b;

  a.value = 100000.0;
  b.value = 10.0;

  cudatrix::scalarSum(&a.value, &b.value);
  printf("%f\n", a.value);
  return 0;
}