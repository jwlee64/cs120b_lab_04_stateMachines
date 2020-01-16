/*	Author: josiahlee
 *  Partner(s) Name: Shiyou Wang
 *	Lab Section:
 *	Assignment: Lab #  Exercise #
 *	Exercise Description: [optional - include for your own benefit]
 *
 *	I acknowledge all content contained herein, excluding template or example
 *	code, is my own original work.
 */
#include <avr/io.h>
#ifdef _SIMULATE_
#include "simAVRHeader.h"
#endif

enum States { start, none_pressed, A0_pressed, A1_pressed, both_pressed } state;

void tick() {
	unsigned char a = (PINA & 0x03);
	switch ( state ){
		case start: 
			state = none_pressed; 
			PORTC = 0x07;
			break;
		case none_pressed: 	
			if ( a == 0x01 ) {
				state = A0_pressed;
				if ( PORTC < 9 )
					PORTC = PORTC + 1;
			}
			else if (a == 0x02) {
				state = A1_pressed;
				if ( PORTC > 0 )
					PORTC = PORTC - 1;
			}
			else if (a == 0x03) {
				state = both_pressed;
			}
			break;
		case A0_pressed: 	
			if ( a == 0x00 ) state = none_pressed;
			else if (a == 0x02) state = A1_pressed;
			else if (a == 0x03) state = both_pressed;
			break;
		case A1_pressed: 
			if (a == 0x00) state = none_pressed;
			else if ( a == 0x01 ) state = A0_pressed;
			else if (a == 0x03) state = both_pressed;
			break;
		case both_pressed: 	
			if (a == 0x00) state = none_pressed;
			else if ( a == 0x01 ) state = A0_pressed;
			else if (a == 0x02) state = A1_pressed;
			break;
		default: state = start; 
			break;
	}
	switch ( state ){
		case none_pressed: 	
			break;
		case A0_pressed: 	
			break;
		case A1_pressed: 
			break;
		case both_pressed: 	
			PORTC = 0x00;
			break;
		default: state = start; 
			break;
	}
}

int main(void) {
    
    DDRA = 0x00; PORTA = 0xff;
    DDRC = 0xff; PORTC = 0x00;

    state = start;

    while (1) {
    	tick();
    }
    return 1;
}
