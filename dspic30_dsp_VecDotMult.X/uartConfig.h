#define Freq 24000000 // es la frecuencia de ciclo de instruccion
// en este caso trabajando con clock de 12MHz (HS2_PLL16)
// queda: multiplicado por 16 y dividido por 2 es decir 96MHz
// eso se divide por 4 para definir la frecuencia del ciclo
// lo que nos da 24MHz.

void uart1Config(long int);
void uart2Config(long int);

/*************************************/
/* Función de Configuración del UART1 */
/*************************************/
void uart1Config(long int BAUDRATE) {//uart 1
    long int BRGVAL1;
    BRGVAL1 = (int)(((Freq/BAUDRATE)/16))-1 ;
    U1MODEbits.STSEL = 0; // 1 Stop bit
    U1MODEbits.PDSEL = 0; // No Parity, 8 data bits
    U1MODEbits.ABAUD = 0; // Auto-Baud Disabled
    U1BRG = BRGVAL1; // BAUD Rate Setting for 9600
    U1STAbits.URXISEL = 0; // Interrupt after one RX character is received

    IFS0bits.U1RXIF = 0; // Clear the Recieve Interrupt Flag
    IEC0bits.U1RXIE = 1; // Enable Recieve Interrupts
    U1MODEbits.UARTEN = 1; // Enable UART
    U1STAbits.UTXEN = 1; // Enable UART TX
}

/*************************************/
/* Función de Configuración del UART2 */
/*************************************/
void uart2Config(long int BAUDRATE) {//uart 1
    long int BRGVAL2;
    BRGVAL2 = (int)(((Freq/BAUDRATE)/16))-1 ;
    U2MODEbits.STSEL = 0; // 1 Stop bit
    U2MODEbits.PDSEL = 0; // No Parity, 8 data bits
    U2MODEbits.ABAUD = 0; // Auto-Baud Disabled
    U2BRG = BRGVAL2; // BAUD Rate Setting for 9600
    U2STAbits.URXISEL = 0; // Interrupt after one RX character is received

    IFS1bits.U2RXIF = 0; // Clear the Recieve Interrupt Flag
    IEC1bits.U2RXIE = 1; // Enable Recieve Interrupts
    U2MODEbits.UARTEN = 1; // Enable UART
    U2STAbits.UTXEN = 1; // Enable UART TX
}