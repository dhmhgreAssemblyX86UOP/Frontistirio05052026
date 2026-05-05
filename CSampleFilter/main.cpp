#include <stdio.h>

#define N 8

void filter3(const int input[], int output[], int length) {
    /* Local hardcoded coefficient array */
    int coeff[3] = { 1, 2, 1 };

    int i;

    output[0] = coeff[0] * input[0];

    if (length > 1) {
        output[1] =
            coeff[0] * input[1] +
            coeff[1] * input[0];
    }

    for (i = 2; i < length; i++) {
        output[i] =
            coeff[0] * input[i] +
            coeff[1] * input[i - 1] +
            coeff[2] * input[i - 2];
    }
}

int main() {
    int samples[N] = { 10, 20, 30, 40, 50, 60, 70, 80 };
    int result[N];
    int i;

    filter3(samples, result, N);

    for (i = 0; i < N; i++) {
        printf("%d ", result[i]);
    }

    return 0;
}