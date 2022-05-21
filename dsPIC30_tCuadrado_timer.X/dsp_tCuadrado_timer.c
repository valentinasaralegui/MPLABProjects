/*
 * File:   dsp_tCuadrado_timer.c
 * Author: Diego Lazcano
 * Para imprimir el impulso habilitar #define impulso
 * Para imprimir el escalon habilitar #define escalon
 * 
 * Para imprimir por la usart el numero #define usart
 * Para plotear en el MPLABX Data Visualizer #define visualizer
 */
#define escalon
//#define impulso

#define usart
//#define visualizer

#define t2k3 estados[0]
#define t2k2 estados[1]
#define t2k1 estados[2]
#define t2 estados[3]
#define imp estados[4]
#define impk1 estados[5]
#define impk2 estados[6]
#define impk3 estados[7]

#define ct2k3 coef[0]
#define ct2k2 coef[1]
#define ct2k1 coef[2]
#define cimpk1 coef[3]
#define cimpk2 coef[4]
#define cimpk3 coef[5]

#include <xc.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <libpic30.h>
#include "regConfig.h"
#include "uartConfig.h"
#include <time.h>
#include <stdbool.h>

double coef[6] = {1.0 , -3.0 , 3.0 , 3.014081790123459E-06 , 1.205632716049384E-05 , 3.014081790123456E-06
 };

double estados[8]={0};
char *ptr;
uint8_t a = 0;
    
void Configurar_IO();

void Serial_SendString(char *str);
void Serial_PutChar(char Ch);

double sampleo = 500000.0/Freq; //recordar que Frec es el Fcy
//int cuenta = 1;
bool cuenta = true;

/******************************************/
/* Función Principal                      */
/******************************************/
int __C30_UART = 2; 

void __attribute__((interrupt,no_auto_psv)) _T1Interrupt(void)
    {
    IFS0bits.T1IF=0;    
    cuenta = true;
    return; 
    }

int main(void) {
    
    ADPCFG = 0xffff;
    Configurar_IO();
    uart2Config(9600);
    
    //Configuracion TIMER 1
    T1CONbits.TCS = 0; //Timer Clock Source Select bit: Internal clock (FOSC/4)
    T1CONbits.TGATE = 0;
    T1CONbits.TCKPS1 = 1; //preescaler 256
    T1CONbits.TCKPS0 = 1; //preesclaer 256
    
    IEC0bits.T1IE = 1; // Habilito interrupciones timer 1
    T1CONbits.TON = 1;
    PR1 = 1674;  
    
#ifdef escalon
    imp = 1.0;
#endif
#ifdef impulso
    imp = 1.0/sampleo;
#endif
    while(1)
    {   
        if(cuenta)
        {
            a=a+1;
#ifdef visualizer
            ptr = (char *) &t2;
            putc(0x03,stdout);
            int x;
            for (x = 0; x < sizeof(t2) ; x++) // with the for we go around the four bytes of the float
                putc(*ptr++,stdout); // we send every byte to the UART        
            ptr = (char *) &a;
            for (x = 0; x < sizeof(a) ; x++) // with the for we go around the four bytes of the float
                putc(*ptr++,stdout); // we send every byte to the UART        
            putc(0xfc,stdout);
#endif

            t2 = cimpk1*impk1 + cimpk2*impk2 + cimpk3*impk3 + ct2k1*t2k1 + ct2k2*t2k2 + ct2k3*t2k3 ;
            t2k3 = t2k2;
            t2k2 = t2k1 ;
            t2k1 = t2;
            impk3 = impk2;
            impk2 = impk1;
            impk1 = imp;
#ifdef usart
            printf("%f\r\n",t2);
#endif
            
#ifdef impulso
            imp = 0;
#endif

            if(a==97)
            {
                memset(estados, 0, sizeof(estados));
#ifdef escalon
                imp = 1.0;
#endif
#ifdef impulso
                imp = 1.0/sampleo;
#endif
                a = 0;
            }
            cuenta = false;
        }
        
    }
    
    return 0;
     
}

/*************************************************************/
/* Función de Configuración de los Puertos de Entrada/Salida */
/*************************************************************/
void Configurar_IO() {
    TRISB = 0; /*	Puerto B como salida */
}
// Send a string out to the serial interface.

void Serial_SendString(char *str) {
    char * p;
    p = str;
    while (*p)
        Serial_PutChar(*p++);
}
// Send a character out to the serial interface.

void Serial_PutChar(char Ch) { // wait for empty buffer 
    while (U2STAbits.UTXBF == 1);
    U2TXREG = Ch;
}