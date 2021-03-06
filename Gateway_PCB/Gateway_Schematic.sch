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
L Device:C_Small C1
U 1 1 5E37AEF1
P 8450 3150
F 0 "C1" H 8542 3196 50  0000 L CNN
F 1 "100n" H 8542 3105 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W2.0mm_P2.50mm" H 8450 3150 50  0001 C CNN
F 3 "~" H 8450 3150 50  0001 C CNN
	1    8450 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	8450 3050 8450 3000
Wire Wire Line
	8450 3250 8450 3300
$Comp
L power:+3.3V #PWR06
U 1 1 5E37BB65
P 8450 3000
F 0 "#PWR06" H 8450 2850 50  0001 C CNN
F 1 "+3.3V" H 8465 3173 50  0000 C CNN
F 2 "" H 8450 3000 50  0001 C CNN
F 3 "" H 8450 3000 50  0001 C CNN
	1    8450 3000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR07
U 1 1 5E37BBA4
P 8450 3300
F 0 "#PWR07" H 8450 3050 50  0001 C CNN
F 1 "GND" H 8455 3127 50  0000 C CNN
F 2 "" H 8450 3300 50  0001 C CNN
F 3 "" H 8450 3300 50  0001 C CNN
	1    8450 3300
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x40_Female J1
U 1 1 5E37189D
P 2050 4400
F 0 "J1" H 1944 2175 50  0000 C CNN
F 1 "Conn_01x40_Female" H 1944 2266 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_2x20_P2.54mm_Vertical" H 2050 4400 50  0001 C CNN
F 3 "~" H 2050 4400 50  0001 C CNN
	1    2050 4400
	-1   0    0    1   
$EndComp
Wire Wire Line
	2250 5300 2500 5300
Text GLabel 2500 5300 2    50   Input ~ 0
DIO1
Wire Wire Line
	2250 4900 2500 4900
Text GLabel 2500 4900 2    50   Input ~ 0
RST
Wire Wire Line
	2250 5700 2500 5700
Text GLabel 2500 5700 2    50   Input ~ 0
DIO0
Wire Wire Line
	2250 4000 2500 4000
Text GLabel 2500 4000 2    50   Input ~ 0
NSS
Wire Wire Line
	2250 4300 2500 4300
Text GLabel 2500 4300 2    50   Input ~ 0
MISO
Wire Wire Line
	2250 4500 2500 4500
Text GLabel 2500 4500 2    50   Input ~ 0
MOSI
Wire Wire Line
	2250 4100 2500 4100
Text GLabel 2500 4100 2    50   Input ~ 0
SCK
Wire Wire Line
	2250 6300 2400 6300
$Comp
L power:+3.3V #PWR02
U 1 1 5E37A7C9
P 2400 6300
F 0 "#PWR02" H 2400 6150 50  0001 C CNN
F 1 "+3.3V" H 2550 6400 50  0000 C CNN
F 2 "" H 2400 6300 50  0001 C CNN
F 3 "" H 2400 6300 50  0001 C CNN
	1    2400 6300
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x01_Female J4
U 1 1 5E390D2A
P 8150 2050
F 0 "J4" V 8090 1962 50  0000 R CNN
F 1 "Conn_01x01_Female" V 7999 1962 50  0000 R CNN
F 2 "Connector_Coaxial:SMA_Amphenol_901-144_Vertical" H 8150 2050 50  0001 C CNN
F 3 "~" H 8150 2050 50  0001 C CNN
	1    8150 2050
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8150 2250 8150 2350
Text GLabel 8150 2350 3    50   Input ~ 0
ANT
$Comp
L RF_AM_FM:RFM95W-868S2 U1
U 1 1 5E3934E9
P 7000 3200
F 0 "U1" H 6300 3800 50  0000 C CNN
F 1 "RFM95W-868S2" H 6300 3700 50  0000 C CNN
F 2 "RFM95:XCVR_RFM95W-915S2" H 3700 4850 50  0001 C CNN
F 3 "http://www.hoperf.com/upload/rf/RFM95_96_97_98W.pdf" H 3700 4850 50  0001 C CNN
	1    7000 3200
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR0101
U 1 1 5E393577
P 7000 2650
F 0 "#PWR0101" H 7000 2500 50  0001 C CNN
F 1 "+3.3V" H 6750 2700 50  0000 C CNN
F 2 "" H 7000 2650 50  0001 C CNN
F 3 "" H 7000 2650 50  0001 C CNN
	1    7000 2650
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 2650 7000 2700
Wire Wire Line
	7750 2900 7500 2900
Text GLabel 7750 2900 2    50   Input ~ 0
ANT
Text GLabel 6250 2900 0    50   Input ~ 0
SCK
Wire Wire Line
	6500 2900 6250 2900
Wire Wire Line
	6500 3000 6250 3000
Text GLabel 6250 3000 0    50   Input ~ 0
MOSI
Wire Wire Line
	6500 3100 6250 3100
Text GLabel 6250 3100 0    50   Input ~ 0
MISO
Wire Wire Line
	6500 3200 6250 3200
Text GLabel 6250 3200 0    50   Input ~ 0
NSS
$Comp
L power:GND #PWR0102
U 1 1 5E398A51
P 6300 3600
F 0 "#PWR0102" H 6300 3350 50  0001 C CNN
F 1 "GND" H 6450 3550 50  0000 C CNN
F 2 "" H 6300 3600 50  0001 C CNN
F 3 "" H 6300 3600 50  0001 C CNN
	1    6300 3600
	-1   0    0    1   
$EndComp
Wire Wire Line
	6500 3400 6250 3400
Text GLabel 6250 3400 0    50   Input ~ 0
RST
Wire Wire Line
	7500 3600 7750 3600
Text GLabel 7750 3600 2    50   Input ~ 0
DIO0
Wire Wire Line
	7500 3500 7750 3500
Text GLabel 7750 3500 2    50   Input ~ 0
DIO1
NoConn ~ 7500 3400
NoConn ~ 7500 3300
NoConn ~ 7500 3200
NoConn ~ 7500 3100
Wire Wire Line
	6900 3800 7000 3800
Wire Wire Line
	7000 3800 7100 3800
Connection ~ 7000 3800
Wire Wire Line
	7000 3800 7000 3850
$Comp
L power:GND #PWR0103
U 1 1 5E39C9C6
P 7000 3850
F 0 "#PWR0103" H 7000 3600 50  0001 C CNN
F 1 "GND" H 7005 3677 50  0000 C CNN
F 2 "" H 7000 3850 50  0001 C CNN
F 3 "" H 7000 3850 50  0001 C CNN
	1    7000 3850
	1    0    0    -1  
$EndComp
Wire Wire Line
	2250 2500 2400 2500
$Comp
L power:GND #PWR0104
U 1 1 5E39DA9D
P 2400 2500
F 0 "#PWR0104" H 2400 2250 50  0001 C CNN
F 1 "GND" H 2550 2500 50  0000 C CNN
F 2 "" H 2400 2500 50  0001 C CNN
F 3 "" H 2400 2500 50  0001 C CNN
	1    2400 2500
	1    0    0    -1  
$EndComp
NoConn ~ 2250 2400
NoConn ~ 2250 2600
NoConn ~ 2250 2700
NoConn ~ 2250 2800
NoConn ~ 2250 2900
NoConn ~ 2250 3000
NoConn ~ 2250 3100
NoConn ~ 2250 3200
NoConn ~ 2250 3300
NoConn ~ 2250 3400
NoConn ~ 2250 3500
NoConn ~ 2250 3600
NoConn ~ 2250 3700
NoConn ~ 2250 3800
NoConn ~ 2250 3900
NoConn ~ 2250 4200
NoConn ~ 2250 4600
NoConn ~ 2250 4700
NoConn ~ 2250 4800
NoConn ~ 2250 5000
NoConn ~ 2250 5100
NoConn ~ 2250 5200
NoConn ~ 2250 5400
NoConn ~ 2250 5500
NoConn ~ 2250 5600
NoConn ~ 2250 5800
NoConn ~ 2250 5900
NoConn ~ 2250 6000
NoConn ~ 2250 6100
NoConn ~ 2250 6200
Wire Wire Line
	2250 4400 2400 4400
$Comp
L power:GND #PWR?
U 1 1 5E3A3FD5
P 2400 4400
F 0 "#PWR?" H 2400 4150 50  0001 C CNN
F 1 "GND" H 2550 4400 50  0000 C CNN
F 2 "" H 2400 4400 50  0001 C CNN
F 3 "" H 2400 4400 50  0001 C CNN
	1    2400 4400
	1    0    0    -1  
$EndComp
$EndSCHEMATC
