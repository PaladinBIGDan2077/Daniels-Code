/* Pi calculator for Aztec C using printf consistently */
#define MAXDIG 8192  /* Further reduced for printf overhead */

main() {
    int digits;
    int i, j, k, q, x, len;
    int a[MAXDIG];  /* Fixed size array */
    int nines, predigit;
    char outbuf[10];  /* Small buffer for printf */
    int outpos;
    
    printf("Pi Calculator\nDigits (1-%d): ", MAXDIG);
    scanf("%d", &digits);
    
    if (digits <= 0 || digits > MAXDIG) {
        printf("Invalid input\n");
        return;
    }
    
    /* Initialize */
    len = (10 * digits) / 3;
    if (len > MAXDIG) len = MAXDIG;
    for (i = 0; i < len; ++i)
        a[i] = 2;
    
    nines = 0;
    predigit = 0;
    outpos = 0;
    
    printf("3.");  /* The leading 3 */
    
    /* Main loop */
    for (j = 1; j <= digits; ++j) {
        q = 0;
        
        /* Work backwards */
        for (i = len; i > 0; --i) {
            x = 10 * a[i-1] + q * i;
            a[i-1] = x % (2*i - 1);
            q = x / (2*i - 1);
        }
        
        a[0] = q % 10;
        q = q / 10;
        
        /* Output handling - buffer digits for efficient printf */
        if (q == 9) {
            ++nines;
        } else if (q == 10) {
            outbuf[outpos++] = predigit + 1 + '0';
            for (k = 0; k < nines; ++k)
                outbuf[outpos++] = '0';
            predigit = 0;
            nines = 0;
        } else {
            if (j != 1)  /* Skip first digit */
                outbuf[outpos++] = predigit + '0';
            predigit = q;
            for (k = 0; k < nines; ++k)
                outbuf[outpos++] = '9';
            nines = 0;
        }
        
        /* Flush buffer when full or at end */
        if (outpos > 8 || j == digits) {
            outbuf[outpos] = '\0';
            printf("%s", outbuf);
            outpos = 0;
        }
    }
    printf("\n");
}