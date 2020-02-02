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
Wire Wire Line
	2250 5500 2400 5500
$Comp
L power:GND #PWR01
U 1 1 5E37C329
P 2400 5500
F 0 "#PWR01" H 2400 5250 50  0001 C CNN
F 1 "GND" H 2550 5500 50  0000 C CNN
F 2 "" H 2400 5500 50  0001 C CNN
F 3 "" H 2400 5500 50  0001 C CNN
	1    2400 5500
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x08_Female J2
U 1 1 5E37EAFD
P 6450 3900
F 0 "J2" H 6477 3876 50  0000 L CNN
F 1 "Conn_01x08_Female" H 6477 3785 50  0000 L CNN
F 2 "Connector_PinSocket_2.00mm:PinSocket_1x08_P2.00mm_Vertical" H 6450 3900 50  0001 C CNN
F 3 "~" H 6450 3900 50  0001 C CNN
	1    6450 3900
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR03
U 1 1 5E3803B6
P 6100 4000
F 0 "#PWR03" H 6100 3850 50  0001 C CNN
F 1 "+3.3V" H 5850 4050 50  0000 C CNN
F 2 "" H 6100 4000 50  0001 C CNN
F 3 "" H 6100 4000 50  0001 C CNN
	1    6100 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6100 4000 6250 4000
Wire Wire Line
	7600 3600 7800 3600
$Comp
L power:GND #PWR04
U 1 1 5E381581
P 7800 3600
F 0 "#PWR04" H 7800 3350 50  0001 C CNN
F 1 "GND" H 7950 3550 50  0000 C CNN
F 2 "" H 7800 3600 50  0001 C CNN
F 3 "" H 7800 3600 50  0001 C CNN
	1    7800 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	7600 3800 7850 3800
Text GLabel 7850 3800 2    50   Input ~ 0
RST
Wire Wire Line
	7600 3900 7850 3900
Text GLabel 7850 3900 2    50   Input ~ 0
NSS
Text GLabel 7850 4000 2    50   Input ~ 0
SCK
Wire Wire Line
	7600 4100 7850 4100
Text GLabel 7850 4100 2    50   Input ~ 0
MOSI
Wire Wire Line
	7600 4000 7850 4000
Wire Wire Line
	7600 4200 7850 4200
Text GLabel 7850 4200 2    50   Input ~ 0
MISO
NoConn ~ 6250 3800
NoConn ~ 6250 3900
NoConn ~ 6250 4100
NoConn ~ 6250 4200
NoConn ~ 6250 4300
NoConn ~ 7600 3700
Wire Wire Line
	6250 3700 6050 3700
$Comp
L power:GND #PWR05
U 1 1 5E38FD01
P 6050 3700
F 0 "#PWR05" H 6050 3450 50  0001 C CNN
F 1 "GND" H 6200 3650 50  0000 C CNN
F 2 "" H 6050 3700 50  0001 C CNN
F 3 "" H 6050 3700 50  0001 C CNN
	1    6050 3700
	-1   0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x01_Female J4
U 1 1 5E390D2A
P 5550 2950
F 0 "J4" V 5490 2862 50  0000 R CNN
F 1 "Conn_01x01_Female" V 5399 2862 50  0000 R CNN
F 2 "Connector_Coaxial:SMA_Amphenol_901-144_Vertical" H 5550 2950 50  0001 C CNN
F 3 "~" H 5550 2950 50  0001 C CNN
	1    5550 2950
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6000 3600 6250 3600
Text GLabel 6000 3600 0    50   Input ~ 0
ANT
Wire Wire Line
	5550 3150 5550 3250
Text GLabel 5550 3250 3    50   Input ~ 0
ANT
$Comp
L Connector:Conn_01x08_Female J3
U 1 1 5E37EB67
P 7400 4000
F 0 "J3" H 7294 3375 50  0000 C CNN
F 1 "Conn_01x08_Female" H 7294 3466 50  0000 C CNN
F 2 "Connector_PinSocket_2.00mm:PinSocket_1x08_P2.00mm_Vertical" H 7400 4000 50  0001 C CNN
F 3 "~" H 7400 4000 50  0001 C CNN
	1    7400 4000
	-1   0    0    1   
$EndComp
NoConn ~ 7600 4300
$EndSCHEMATC