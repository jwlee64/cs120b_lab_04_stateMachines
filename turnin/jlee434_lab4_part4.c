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

enum States { start, unlocked, locked, p1_down, p1_up } state;

void tick() {
	switch ( state ){
		case start: 
			state = unlocked;
			break;
		case unlocked:
			if ( PINA == 0x80 ){
				state = locked;
			}
			else if ( PINA == 0x04 ){
				state = p1_down;
			}
			break;
		case locked:
			if ( PINA == 0x04 ){
				state = p1_down;
			}
			break;
		case p1_down:
			if ( PINA == 0x00 ){
				state = p1_up;
			} 
			else if ( PINA == 0x04 ){
				state = p1_down;
			} 
			else {
				if (PORTB == 0x00) // returns to state the lock is in
					state = locked;
				else
					state = unlocked;
			}
			break;
		case p1_up:
			if ( PINA == 0x01 ){
				if (PORTB == 0x01) // locks if door was unlocked 
					state = locked;
				else
					state = unlocked;
			} 
			else if ( PINA == 0x00 ){
				state = p1_up;
			} 
			else {
				if (PORTB == 0x00) // returns to state the lock is in
					state = locked;
				else
					state = unlocked;
			}
			break;
		default: state = start; 
			break;
	}
	switch ( state ){
		case start:
			PORTC = 0x00;
			break;
		case unlocked:
			PORTC = 0x01;
			PORTB = 0x01;
			break;
		case locked:
			PORTC = 0x02;
			PORTB = 0x00;
			break;
		case p1_down:
			PORTC = 0x03;
			break;
		case p1_up:
			PORTC = 0x04;
			break;
		default: state = start; 
			break;
	}
}

int main(void) {
    
    DDRA = 0x00; PORTA = 0xff;
    DDRB = 0xff; PORTB = 0x00;
    DDRC = 0xff; PORTC = 0x00;

    state = start;

    while (1) {
    	tick();
    }
    return 1;
}
