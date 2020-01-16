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

enum States { start, PB0_on_btnR, PB1_on_btnP, PB1_on_btnR, PB0_on_btnP } state;

void tick() {
	switch ( state ){
		case start: state = PB0_on_btnR; 
			break;
		case PB0_on_btnR: if (PINA) state = PB1_on_btnP;
			break;
		case PB1_on_btnP: if (!PINA) state = PB1_on_btnR; 
			break;
		case PB1_on_btnR: if (PINA) state = PB0_on_btnP;
			break;
		case PB0_on_btnP: if (!PINA) state = PB0_on_btnR;
			break;
		default: state = start; 
			break;
	}
	switch ( state ){
		case PB0_on_btnR: PORTB = 0x01;
			break;
		case PB1_on_btnP: PORTB = 0x02;
			break;
		case PB1_on_btnR: PORTB = 0x02;
			break;
		case PB0_on_btnP: PORTB = 0x01;
			break;
		default: PORTB = 0x00; 
			break;
	}
}

int main(void) {
    
    DDRA = 0x00; PORTA = 0xff;
    DDRB = 0xff; PORTB = 0x00;

    state = start;

    while (1) {
    	tick();
    }
    return 1;
}
