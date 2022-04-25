#include <stdint.h>
#include "I2C_Libreria.h"
//#include <libpic30.h>
#include <subordinate_errors.h>
#include <stddef.h>
#include "Configuracion.h"

extern void __delay32(unsigned long cycles);
#define __delay_ms(d) \
  { __delay32( (unsigned long) (((unsigned long long) d)*(FCY)/1000ULL)); }
#define __delay_us(d) \
  { __delay32( (unsigned long) (((unsigned long long) d)*(FCY)/1000000ULL)); }

#define LCD_FIRST_ROW          0x80
#define LCD_SECOND_ROW         0xC0
#define LCD_THIRD_ROW          0x94
#define LCD_FOURTH_ROW         0xD4
#define LCD_CLEAR              0x01
#define LCD_RETURN_HOME        0x02
#define LCD_ENTRY_MODE_SET     0x04
#define LCD_CURSOR_OFF         0x0C
#define LCD_UNDERLINE_ON       0x0E
#define LCD_BLINK_CURSOR_ON    0x0F
#define LCD_MOVE_CURSOR_LEFT   0x10
#define LCD_MOVE_CURSOR_RIGHT  0x14
#define LCD_TURN_ON            0x0C
#define LCD_TURN_OFF           0x08
#define LCD_SHIFT_LEFT         0x18
#define LCD_SHIFT_RIGHT        0x1E
#define LCD_BACKLIGHT          0x08
#define LCD_NOBACKLIGHT        0x00

#ifndef LCD_TYPE
   #define LCD_TYPE 2           // 0=5x7, 1=5x10, 2=2 lines
#endif

char RS=0;
uint8_t i2c_addr, backlight_val = LCD_BACKLIGHT;


void Expander_Write(uint8_t value)
{
  I2C_Start();
  I2C_Tx(i2c_addr);
  I2C_Tx(value | backlight_val);
  I2C_Stop();
}

void LCD_Write_Nibble(uint8_t n)
{
  n |= RS&1;
  Expander_Write(n & 0xFB);
  __delay_us(1);
  Expander_Write(n | 0x04);
  __delay_us(1);
  Expander_Write(n & 0xFB);
  __delay_us(100);
}

void LCD_Cmd(uint8_t Command)
{
  RS = 0;
  LCD_Write_Nibble(Command & 0xF0);
  LCD_Write_Nibble((Command << 4) & 0xF0);
  if((Command == LCD_CLEAR) || (Command == LCD_RETURN_HOME))
    __delay_ms(2);
}

void LCD_Goto(uint8_t row, uint8_t col)
{
  switch(row)
  {
    case 2:
      LCD_Cmd(LCD_SECOND_ROW + col - 1);
      break;
    case 3:
      LCD_Cmd(LCD_THIRD_ROW  + col - 1);
      break;
    case 4:
      LCD_Cmd(LCD_FOURTH_ROW + col - 1);
    break;
    default:      // case 1:
      LCD_Cmd(LCD_FIRST_ROW  + col - 1);
  }

}

void LCD_PutC(char LCD_Char)
{
  RS = 1;
  LCD_Write_Nibble(LCD_Char & 0xF0);
  LCD_Write_Nibble((LCD_Char << 4) & 0xF0);
}

void LCD_Print(char* LCD_Str)
{
  uint8_t i = 0;
  RS = 1;
  while(LCD_Str[i] != '\0')
  {
    LCD_Write_Nibble(LCD_Str[i] & 0xF0);
    LCD_Write_Nibble( (LCD_Str[i++] << 4) & 0xF0 );
  }
}

void LCD_Begin(uint8_t _i2c_addr)
{
  i2c_addr = _i2c_addr;
  Expander_Write(0);

  __delay_ms(40);
  LCD_Cmd(3);
  __delay_ms(5);
  LCD_Cmd(3);
  __delay_ms(5);
  LCD_Cmd(3);
  __delay_ms(5);
  LCD_Cmd(LCD_RETURN_HOME);
  __delay_ms(5);
  LCD_Cmd(0x20 | (LCD_TYPE << 2));
  __delay_ms(50);
  LCD_Cmd(LCD_TURN_ON);
  __delay_ms(50);
  LCD_Cmd(LCD_CLEAR);
  __delay_ms(50);
  LCD_Cmd(LCD_ENTRY_MODE_SET | LCD_RETURN_HOME);
  __delay_ms(50);
}

void Backlight() {
  backlight_val = LCD_BACKLIGHT;
  Expander_Write(0);
}

void noBacklight() {
  backlight_val = LCD_NOBACKLIGHT;
  Expander_Write(0);
}