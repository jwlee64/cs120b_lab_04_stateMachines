# Test file for "cs120b_lab_04_stateMachines"


# commands.gdb provides the following functions for ease:
#   test "<message>"
#       Where <message> is the message to print. Must call this at the beginning of every test
#       Example: test "PINA: 0x00 => expect PORTC: 0x01"
#   checkResult
#       Verify if the test passed or failed. Prints "passed." or "failed." accordingly, 
#       Must call this at the end of every test.
#   expectPORTx <val>
#       With x as the port (A,B,C,D)
#       The value the port is epected to have. If not it will print the erroneous actual value
#   setPINx <val>
#       With x as the port or pin (A,B,C,D)
#       The value to set the pin to (can be decimal or hexidecimal
#       Example: setPINA 0x01
#   printPORTx f OR printPINx f 
#       With x as the port or pin (A,B,C,D)
#       With f as a format option which can be: [d] decimal, [x] hexadecmial (default), [t] binary 
#       Example: printPORTC d
#   printDDRx
#       With x as the DDR (A,B,C,D)
#       Example: printDDRB

echo ======================================================\n
echo Running all tests..."\n\n

test "initial - PINA: 0x00 => PORTB: 0x01, PORTC: 0x01"
set state = start
setPINA 0x00
continue 5
expectPORTB 0x01
expectPORTC 0x01
checkResult

test "double press doesnt lock- PINA: 0x00, 0x80 => PORTB: 0x01, PORTC: 0x01"
set state = start
setPINA 0x00
continue 5
setPINA 0x81
continue 5
expectPORTB 0x01
expectPORTC 0x01
checkResult

test "locked - PINA: 0x00, 0x80 => PORTB: 0x00, PORTC: 0x02"
set state = start
setPINA 0x00
continue 5
setPINA 0x80
continue 5
expectPORTB 0x00
expectPORTC 0x02
checkResult

test "p1_down, locked - PINA: 0x00, 0x80, 0x00, 0x04 => PORTB: 0x00, PORTC: 0x03"
set state = start
setPINA 0x00
continue 5
setPINA 0x80
continue 5
setPINA 0x00
continue 5
setPINA 0x04
continue 5
expectPORTB 0x00
expectPORTC 0x03
checkResult

# incorrect code
test "p1_down, locked -> locked  - PINA: 0x00, 0x80, 0x00, 0x04, 0x01 => PORTB: 0x00, PORTC: 0x02"
set state = start
setPINA 0x00
continue 5
setPINA 0x80
continue 5
setPINA 0x00
continue 5
setPINA 0x04
continue 5
setPINA 0x01
continue 5
expectPORTB 0x00
expectPORTC 0x02
checkResult

# double press
test "p1_down, locked -> locked  - PINA: 0x00, 0x80, 0x00, 0x04, 0x03 => PORTB: 0x00, PORTC: 0x02"
set state = start
setPINA 0x00
continue 5
setPINA 0x80
continue 5
setPINA 0x00
continue 5
setPINA 0x04
continue 5
setPINA 0x03
continue 5
expectPORTB 0x00
expectPORTC 0x02
checkResult

test "p1_up, locked - PINA: 0x00, 0x80, 0x00, 0x04, 0x00 => PORTB: 0x00, PORTC: 0x04"
set state = start
setPINA 0x00
continue 5
setPINA 0x80
continue 5
setPINA 0x00
continue 5
setPINA 0x04
continue 5
setPINA 0x00
continue 5
expectPORTB 0x00
expectPORTC 0x04
checkResult

# incorrect code
test "p1_up, locked -> locked - PINA: 0x00, 0x80, 0x00, 0x04, 0x00, 0x02 => PORTB: 0x00, PORTC: 0x02"
set state = start
setPINA 0x00
continue 5
setPINA 0x80
continue 5
setPINA 0x00
continue 5
setPINA 0x04
continue 5
setPINA 0x00
continue 5
setPINA 0x02
continue 5
expectPORTB 0x00
expectPORTC 0x02

# double press
test "p1_up, locked -> locked - PINA: 0x00, 0x80, 0x00, 0x04, 0x00, 0x03 => PORTB: 0x00, PORTC: 0x02"
set state = start
setPINA 0x00
continue 5
setPINA 0x80
continue 5
setPINA 0x00
continue 5
setPINA 0x04
continue 5
setPINA 0x00
continue 5
setPINA 0x03
continue 5
expectPORTB 0x00
expectPORTC 0x02

test "p1_up, locked -> unlocked - PINA: 0x00, 0x80, 0x00, 0x04, 0x00, 0x01 => PORTB: 0x01, PORTC: 0x01"
set state = start
setPINA 0x00
continue 5
setPINA 0x80
continue 5
setPINA 0x00
continue 5
setPINA 0x04
continue 5
setPINA 0x00
continue 5
setPINA 0x01
continue 5
expectPORTB 0x01
expectPORTC 0x01
checkResult

# ============================================================================================================
test "p1_down, unlocked - PINA: 0x00, 0x04 => PORTB: 0x01, PORTC: 0x03"
set state = start
setPINA 0x00
continue 5
setPINA 0x04
continue 5
expectPORTB 0x01
expectPORTC 0x03
checkResult

# incorrect code
test "p1_down, unlocked -> unlocked  - PINA: 0x00, 0x04, 0x01 => PORTB: 0x01, PORTC: 0x01"
set state = start
setPINA 0x00
continue 5
setPINA 0x04
continue 5
setPINA 0x01
continue 5
expectPORTB 0x01
expectPORTC 0x01
checkResult

# double press
test "p1_down, unlocked -> unlocked  - PINA: 0x00, 0x04, 0x03 => PORTB: 0x01, PORTC: 0x01"
set state = start
setPINA 0x00
continue 5
setPINA 0x04
continue 5
setPINA 0x03
continue 5
expectPORTB 0x01
expectPORTC 0x01
checkResult

test "p1_up, unlocked - PINA: 0x00, 0x04, 0x00 => PORTB: 0x01, PORTC: 0x04"
set state = start
setPINA 0x00
continue 5
setPINA 0x04
continue 5
setPINA 0x00
continue 5
expectPORTB 0x01
expectPORTC 0x04
checkResult

# incorrect code
test "p1_up, unlocked -> unlocked - PINA: 0x00, 0x04, 0x00, 0x02 => PORTB: 0x01, PORTC: 0x01"
set state = start
setPINA 0x00
continue 5
setPINA 0x04
continue 5
setPINA 0x00
continue 5
setPINA 0x02
continue 5
expectPORTB 0x01
expectPORTC 0x01

# double press
test "p1_up, unlocked -> unlocked - PINA: 0x00, 0x04, 0x00, 0x03 => PORTB: 0x01, PORTC: 0x01"
set state = start
setPINA 0x00
continue 5
setPINA 0x04
continue 5
setPINA 0x00
continue 5
setPINA 0x03
continue 5
expectPORTB 0x01
expectPORTC 0x01

test "p1_up, unlocked -> locked - PINA: 0x00, 0x04, 0x00, 0x01 => PORTB: 0x00, PORTC: 0x02"
set state = start
setPINA 0x00
continue 5
setPINA 0x04
continue 5
setPINA 0x00
continue 5
setPINA 0x01
continue 5
expectPORTB 0x00
expectPORTC 0x02
checkResult

# Report on how many tests passed/tests ran
set $passed=$tests-$failed
eval "shell echo Passed %d/%d tests.\n",$passed,$tests
echo ======================================================\n
