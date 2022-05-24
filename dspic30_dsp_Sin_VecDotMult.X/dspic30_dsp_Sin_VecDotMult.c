/*
 * File:   dspic30_dsp_Sin_VecDotMulti.c
 * Author: Diego 
 *
 * Created on May 24, 2022, 5:15 AM
 * 
 * SEÑAL SENOIDAL BAJO EL EFECTO DE UN ESCALÓN O UN IMPULSO
 * 
 * Frecuencia de la senoide: 5Hz
 * Frecuencia de sampleo: 120 Hz
 * Tiempo de sampleo: 8.333333333333333e-03 segundos
 * Interrupción del Timer1 -> PR1 = 781
 * 
 * Para las diferentes placas, recordar modificar:
 * la variable __C30_UART de este archivo (linea 49)
 * la variable Fcy que se encuentra en Configuracion.h
 * la configuracion #pragma config FOSFPR = FRC_PLL16 (para cristal interno con PLLx16)
 * la configuracion #pragma config FOSFPR = HS2_PLL16 (para el cristal externo)
 * que se encuentra en Configuracion.c
 */

#define escalon
//#define impulso

//#define usart
#define visualizer

#define senok1 estadosF[0]
#define senok2 estadosF[1]
#define inputk1 estadosF[2]
#define inputk2 estadosF[3]

#include <xc.h>
#include "Configuracion.h"
#include "I2C_Libreria.h"
#include "LCD_I2C.h" 
#include <libpic30.h>
#include "uartConfig.h" 
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <dsp.h>
#include <stdbool.h>


/******************************************/
/*       Definición de Variables          */
/******************************************/
int __C30_UART = 2;

// VARIABLES FRACTIONAL PARA HACER LA MULTIPLICACION EN PUNTO FLOTANTE Q1.15
fractional coeficientesF[4] = {Q15(9.659258262890683E-1), Q15(-5.000000000000000E-1), Q15(5.423073177866694E-4), Q15(5.423073177866696E-4)};
fractional estadosF[4] = {Q15(0.0), Q15(0.0), Q15(0.0), Q15(0.0)};

fractional seno = Q15(0.0);

double sampleo = 200000.0/Fcy , prnSeno = 0.0;

#ifdef escalon
fractional input = Q15(1.0);
double escalar = 2.0 ;
#endif

#ifdef impulso
fractional input = Q15(1.0);
double escalar = 240.0;
#endif

bool cuenta = true;

/******************************************/
/*       Prototipos de Funciones          */
/******************************************/
void Configurar_IO();
void Serial_SendString(char *str);
void Serial_PutChar(char Ch);
void vecdotmulti(void);

/******************************************/
/*     Función Interrupción Timer 1       */
/******************************************/
void __attribute__((interrupt,no_auto_psv)) _T1Interrupt(void)
    {
    IFS0bits.T1IF=0;    
    cuenta = true;
    return; 
    }

/******************************************/
/*          Función Principal             */
/******************************************/
int main(void)
{
    Configurar_IO();
    uart1Config(9600);
    
    //Configuracion TIMER 1
    T1CONbits.TCS = 0; //Timer Clock Source Select bit: Internal clock (FOSC/4)
    T1CONbits.TGATE = 0;
    T1CONbits.TCKPS1 = 1; //preescaler 256
    T1CONbits.TCKPS0 = 1; //preesclaer 256
    IEC0bits.T1IE = 1; // Habilito interrupciones timer 1
    T1CONbits.TON = 1;
    PR1 = 781;  

    while (1)
    {
        if(cuenta)
            vecdotmulti();
    };

    return 0;
}

void vecdotmulti(void)
{
    seno = 2.0*VectorDotProduct(4, coeficientesF, estadosF); // profundidad del producto = 4
    
    senok2 = senok1 ;
    senok1 = seno ;
    inputk2 = inputk1 ;
    inputk1 = input ;
    cuenta = false;
    
#ifdef escalon
    prnSeno = Fract2Float(seno);
#endif
#ifdef impulso
    prnSeno = 120.0*Fract2Float(seno);
#endif
    
#ifdef usart
#ifdef escalon
    printf("%.15f \n\r", (double)prnSeno);
#endif

#ifdef impulso
    input = 0 ;
    printf("%.15f \n\r", (double)prnSeno);
#endif
#endif

#ifdef visualizer
            char *ptr;
            ptr = (char *) &prnSeno;
            putc(0x03,stdout);
            int x;
            for (x = 0; x < sizeof(prnSeno) ; x++) // with the for we go around the four bytes of the float
                putc(*ptr++,stdout); // we send every byte to the UART    
            putc(0xfc,stdout);
#endif
}


/*************************************************************/
/* Función de Configuración de los Puertos de Entrada/Salida */
/*************************************************************/
void Configurar_IO()
{
    ADPCFG = 0xFFFE; //todos digitales menos el AN0
    TRISB = 0; /*	Puerto B como salida */
}

void Serial_SendString(char *str)
{
    char * p;
    p = str;
    while (*p)
        Serial_PutChar(*p++);
}

void Serial_PutChar(char Ch)
{ // wait for empty buffer 
    while (U2STAbits.UTXBF == 1);
    U2TXREG = Ch;
}