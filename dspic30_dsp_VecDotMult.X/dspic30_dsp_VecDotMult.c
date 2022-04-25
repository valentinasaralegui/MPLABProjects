/*
 * File:   prueba.c
 * Author: Clase dsp 
 *
 * Created on April 20, 2022, 8:47 PM
 * 
 * SOLAMENTE MULTIPLICACION DE VECTORES DE 3 ELEMENTOS
 * 
 * ELEMENTO A ELEMENTO, NO PRODUCTO ESCALAR
 * 
 */

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
#include <math.h>
#include <time.h>

//int j = 0, text[4];
int __C30_UART = 2;

void Configurar_IO();
void Serial_SendString(char *str);
void Serial_PutChar(char Ch);
void vecdotmulti(void);

// VARIABLES PARA LA MULTIPLICACION NORMAL EN DOUBLE
double b[3]={0.21,-0.3,0.82};
double c[3]={0.2,0.47,-0.64};
double prodf=0.0;

// VARIABLES FRACTIONAL PARA HACER LA MULTIPLICACION EN PUNTO FLOTANTE Q1.15
fractional d[3]={Q15(0.21),Q15(-0.3),Q15(0.82)};
fractional e[3]={Q15(0.2),Q15(0.47),Q15(-0.64)};
fractional prod;

clock_t start, stop;
static double count=0.0;


int main(void) 
{   
    
    // CONFIG I2C 
	ADPCFG = 0xFFFE; //todos digitales menos el AN0
	I2CCONbits.I2CEN = 1; // HABILITAR I2C
	IFS0bits.MI2CIF = 0;
	I2CBRG = 217; // 100KHz
    //__delay_ms(1000);
    
    // VARIABLE AL BOLEO PARA IMPRIMIR EL AD
    uint16_t i;  //es un unsigned int de 16 bits
    char valor[4];
    
    
    // CONFIG ADC
    ADCON1 = 0;
    ADCON2 = 0;
    ADCON3 = 0x1F01;
    _CH0SA = 0;   
    
    Configurar_IO();
    uart2Config(9600);
    
    LCD_Begin(0x4E);
	LCD_Goto(1, 1); // Go to row 1 column 2
	LCD_Print("Prueba Uno");
    LCD_Goto(2, 1);
    LCD_Print("UCA 08 de abril");
    
    _ADON = 1;
    
    vecdotmulti();
    while(1);
    while(1)
    {
        
        //printf("ponemos a convertir\r\n");
        _SAMP = 1;
        _SAMP = 0;
        //printf("esperando que convienrta todo\r\n");
        //while(!_DONE);
        __delay32(100);
        //printf("conversion terminada\r\n");
        i = ADCBUF0 ;
        printf("se convirtio: %d\r\n",i);
        sprintf(valor,"%u",i);
        LCD_Goto(1,1);
        LCD_Print("      ");
        LCD_Goto(1,1);
        LCD_Print(valor);
    };

    return 0;
}

void vecdotmulti(void)
{
    printf("\t\t\t\t\t |||||PRODUCTO ESCALAR||||| \t\t\n\n");
    start=clock();  // sería el tic del cronómetro para ver cuánto tarda
    prod = VectorDotProduct(3,d,e); // profundidad del producto = 3
    stop=clock(); // este es el toc del cronómetro
    count=(double)(stop-start)-19.0;  // 19 TCY start clock
	printf("# TCY con dsp: %.1f\r\n",count);
    printf("# TCY: En realidad deberia dar: [17 + 4(numElems)]= 17+4*3=29 !\r\n\n");
    printf("Valor con dsp= %.7f \n\r",(double)Fract2Float(prod));
    
    // acá para abajo empieza el producto común sin dsp
    int i=0;
    start=clock();
    while (i<3)
    {
        prodf=prodf+b[i]*c[i];
        i++;
    }
    stop=clock();
    i=0;
    printf("Valor float= %.7f \n\r",prodf);

    count=(stop-start)-19.0;  // 19 TCY start clock
	printf("# TCY con float: %.1f\r\n",count);
    
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