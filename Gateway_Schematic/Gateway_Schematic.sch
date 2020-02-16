EESchema Schematic File Version 4
LIBS:Gateway_Schematic-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector:Raspberry_Pi_2_3 J1
U 1 1 5E370E54
P 4550 3950
F 0 "J1" H 3550 5450 50  0000 C CNN
F 1 "Raspberry_Pi_2_3" H 3550 5350 50  0000 C CNN
F 2 "" H 4550 3950 50  0001 C CNN
F 3 "https://www.raspberrypi.org/documentation/hardware/raspberrypi/schematics/rpi_SCH_3bplus_1p0_reduced.pdf" H 4550 3950 50  0001 C CNN
	1    4550 3950
	1    0    0    -1  
$EndComp
Wire Wire Line
	5350 4350 5600 4350
Wire Wire Line
	5350 4450 5600 4450
Wire Wire Line
	5350 4250 5600 4250
Text GLabel 5600 4350 2    50   Input ~ 0
MOSI
Text GLabel 5600 4250 2    50   Input ~ 0
MISO
Text GLabel 5600 4450 2    50   Input ~ 0
SCK
Wire Wire Line
	5350 3650 5600 3650
Text GLabel 5600 3650 2    50   Input ~ 0
DIO0
Wire Wire Line
	5350 4150 5600 4150
Text GLabel 5600 4150 2    50   Input ~ 0
NSS
Wire Wire Line
	3750 3450 3500 3450
Text GLabel 3500 3450 0    50   Input ~ 0
DIO1
Wire Wire Line
	3750 4150 3500 4150
Text GLabel 3500 4150 0    50   Input ~ 0
RST
Wire Wire Line
	4150 5250 4250 5250
Connection ~ 4250 5250
Wire Wire Line
	4250 5250 4350 5250
Connection ~ 4350 5250
Wire Wire Line
	4350 5250 4450 5250
Connection ~ 4450 5250
Wire Wire Line
	4450 5250 4550 5250
Connection ~ 4550 5250
Wire Wire Line
	4550 5250 4650 5250
Connection ~ 4650 5250
Wire Wire Line
	4650 5250 4750 5250
Connection ~ 4750 5250
Wire Wire Line
	4750 5250 4850 5250
Wire Wire Line
	4550 5250 4550 5300
$Comp
L power:GND #PWR02
U 1 1 5E371441
P 4550 5300
F 0 "#PWR02" H 4550 5050 50  0001 C CNN
F 1 "GND" H 4555 5127 50  0000 C CNN
F 2 "" H 4550 5300 50  0001 C CNN
F 3 "" H 4550 5300 50  0001 C CNN
	1    4550 5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	4650 2650 4700 2650
Wire Wire Line
	4350 2650 4400 2650
Wire Wire Line
	4400 2650 4400 2600
Connection ~ 4400 2650
Wire Wire Line
	4400 2650 4450 2650
Wire Wire Line
	4700 2650 4700 2600
Connection ~ 4700 2650
Wire Wire Line
	4700 2650 4750 2650
$Comp
L power:+5V #PWR01
U 1 1 5E371FD7
P 4400 2600
F 0 "#PWR01" H 4400 2450 50  0001 C CNN
F 1 "+5V" H 4415 2773 50  0000 C CNN
F 2 "" H 4400 2600 50  0001 C CNN
F 3 "" H 4400 2600 50  0001 C CNN
	1    4400 2600
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR03
U 1 1 5E372010
P 4700 2600
F 0 "#PWR03" H 4700 2450 50  0001 C CNN
F 1 "+3.3V" H 4715 2773 50  0000 C CNN
F 2 "" H 4700 2600 50  0001 C CNN
F 3 "" H 4700 2600 50  0001 C CNN
	1    4700 2600
	1    0    0    -1  
$EndComp
NoConn ~ 3750 3050
NoConn ~ 3750 3150
NoConn ~ 3750 3550
NoConn ~ 3750 3750
NoConn ~ 3750 3850
NoConn ~ 3750 3950
NoConn ~ 3750 4250
NoConn ~ 3750 4350
NoConn ~ 3750 4450
NoConn ~ 3750 4550
NoConn ~ 3750 4650
NoConn ~ 5350 4750
NoConn ~ 5350 4650
NoConn ~ 5350 4050
NoConn ~ 5350 3450
NoConn ~ 5350 3350
NoConn ~ 5350 3150
NoConn ~ 5350 3050
$Comp
L RF_AM_FM:RFM95W-868S2 U1
U 1 1 5E3753FD
P 7700 3150
F 0 "U1" H 7150 3850 50  0000 C CNN
F 1 "RFM95W-868S2" H 7150 3750 50  0000 C CNN
F 2 "" H 4400 4800 50  0001 C CNN
F 3 "http://www.hoperf.com/upload/rf/RFM95_96_97_98W.pdf" H 4400 4800 50  0001 C CNN
	1    7700 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	7700 2650 7700 2600
Wire Wire Line
	7600 3750 7700 3750
Connection ~ 7700 3750
Wire Wire Line
	7700 3750 7800 3750
Wire Wire Line
	7700 3750 7700 3800
$Comp
L power:+3.3V #PWR04
U 1 1 5E375DB2
P 7700 2600
F 0 "#PWR04" H 7700 2450 50  0001 C CNN
F 1 "+3.3V" H 7715 2773 50  0000 C CNN
F 2 "" H 7700 2600 50  0001 C CNN
F 3 "" H 7700 2600 50  0001 C CNN
	1    7700 2600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR05
U 1 1 5E375E01
P 7700 3800
F 0 "#PWR05" H 7700 3550 50  0001 C CNN
F 1 "GND" H 7705 3627 50  0000 C CNN
F 2 "" H 7700 3800 50  0001 C CNN
F 3 "" H 7700 3800 50  0001 C CNN
	1    7700 3800
	1    0    0    -1  
$EndComp
$Comp
L Device:Antenna AE1
U 1 1 5E375EFB
P 8250 2600
F 0 "AE1" H 8330 2591 50  0000 L CNN
F 1 "Antenna" H 8330 2500 50  0000 L CNN
F 2 "" H 8250 2600 50  0001 C CNN
F 3 "~" H 8250 2600 50  0001 C CNN
	1    8250 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	8200 2850 8250 2850
Wire Wire Line
	8250 2850 8250 2800
Wire Wire Line
	7200 2850 6950 2850
Text GLabel 6950 2850 0    50   Input ~ 0
SCK
Wire Wire Line
	7200 2950 6950 2950
Text GLabel 6950 2950 0    50   Input ~ 0
MOSI
Wire Wire Line
	7200 3050 6950 3050
Text GLabel 6950 3050 0    50   Input ~ 0
MISO
Wire Wire Line
	7200 3150 6950 3150
Text GLabel 6950 3150 0    50   Input ~ 0
NSS
Wire Wire Line
	7200 3350 6950 3350
Text GLabel 6950 3350 0    50   Input ~ 0
RST
Wire Wire Line
	8200 3550 8450 3550
Text GLabel 8450 3550 2    50   Input ~ 0
DIO0
Wire Wire Line
	8200 3450 8450 3450
Text GLabel 8450 3450 2    50   Input ~ 0
DIO1
NoConn ~ 8200 3350
NoConn ~ 8200 3250
NoConn ~ 8200 3150
NoConn ~ 8200 3050
$Comp
L Device:C_Small C1
U 1 1 5E37AEF1
P 9000 2900
F 0 "C1" H 9092 2946 50  0000 L CNN
F 1 "100n" H 9092 2855 50  0000 L CNN
F 2 "" H 9000 2900 50  0001 C CNN
F 3 "~" H 9000 2900 50  0001 C CNN
	1    9000 2900
	1    0    0    -1  
$EndComp
Wire Wire Line
	9000 2800 9000 2750
Wire Wire Line
	9000 3000 9000 3050
$Comp
L power:+3.3V #PWR06
U 1 1 5E37BB65
P 9000 2750
F 0 "#PWR06" H 9000 2600 50  0001 C CNN
F 1 "+3.3V" H 9015 2923 50  0000 C CNN
F 2 "" H 9000 2750 50  0001 C CNN
F 3 "" H 9000 2750 50  0001 C CNN
	1    9000 2750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR07
U 1 1 5E37BBA4
P 9000 3050
F 0 "#PWR07" H 9000 2800 50  0001 C CNN
F 1 "GND" H 9005 2877 50  0000 C CNN
F 2 "" H 9000 3050 50  0001 C CNN
F 3 "" H 9000 3050 50  0001 C CNN
	1    9000 3050
	1    0    0    -1  
$EndComp
Wire Notes Line
	3100 2250 3100 5950
Wire Notes Line
	3100 5950 6000 5950
Wire Notes Line
	6000 5950 6000 2250
Wire Notes Line
	6000 2250 3100 2250
Wire Notes Line
	6300 4600 9450 4600
Wire Notes Line
	9450 4600 9450 2250
Wire Notes Line
	9450 2250 6300 2250
Wire Notes Line
	6300 2250 6300 4600
Text Notes 3600 5800 0    200  ~ 0
Control Unit
Text Notes 6350 4400 0    200  ~ 0
Communication Unit
$EndSCHEMATC
