/* 
 * File:                uartConfig.h
 * Author:              Diego Lazcano
 * Comments:            Configuración de la UART para PIC30
 * Revision history:    01
 */

// #define BRGVAL ((Freq/BAUDRATE)/16)-1

#include <xc.h> 
void uartConfig(long int);
void uart2Config(long int );

/*************************************/
/* Función de Configuración del UART */
/*************************************/
void uartConfig(long int BAUDRATE) {//uart 1
    long int BRGVAL;
    BRGVAL = ((Freq/BAUDRATE)/16)-1 ;
    U1MODEbits.STSEL = 0; // 1 Stop bit
    U1MODEbits.PDSEL = 0; // No Parity, 8 data bits
    U1MODEbits.ABAUD = 0; // Auto-Baud Disabled
    U1BRG = BRGVAL; // BAUD Rate Setting for 9600
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