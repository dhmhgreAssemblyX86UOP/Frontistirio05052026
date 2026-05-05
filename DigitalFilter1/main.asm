TITLE Digital Filter in MASM x86
Include Irvine32.inc

.data
samples SDWORD 10, 20, 30, 40, 50, 60, 70, 80
samples_size = ($-samples)/TYPE samples
result  SDWORD 8 DUP(?)
.code

Filter3 PROC
push ebp
mov ebp,esp
sub esp,12
pushad
mov [EBP-4], SDWORD PTR  1d
mov [EBP-8], SDWORD PTR  2d
mov [EBP-12], SDWORD PTR 1d

mov esi,[EBP+8]  ;ESI holds the samples array start address
mov edi,[EBP+12] ;EDI holds the result array start address

;output[0] = coeff[0] * input[0];
mov eax, [ESI]
mov [EDI], eax

;if (length > 1) {
;       output[1] =
;            coeff[0] * input[1] +
;            coeff[1] * input[0];
;}



popad
mov esp,ebp
pop ebp
ret 12
Filter3 ENDP

main PROC

push samples_size
push OFFSET result
push OFFSET samples 
call Filter3


exit
main ENDP
END main 

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