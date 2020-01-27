EESchema Schematic File Version 4
LIBS:PCB-cache
EELAYER 29 0
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
L power:+5V #PWR07
U 1 1 5E336D89
P 2350 4300
F 0 "#PWR07" H 2350 4150 50  0001 C CNN
F 1 "+5V" H 2365 4473 50  0000 C CNN
F 2 "" H 2350 4300 50  0001 C CNN
F 3 "" H 2350 4300 50  0001 C CNN
	1    2350 4300
	1    0    0    -1  
$EndComp
Wire Wire Line
	1450 5000 1600 5000
$Comp
L Device:C_Small C1
U 1 1 5E3A44F3
P 1300 4000
F 0 "C1" H 1392 4046 50  0000 L CNN
F 1 "100n" H 1392 3955 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W2.0mm_P2.50mm" H 1300 4000 50  0001 C CNN
F 3 "~" H 1300 4000 50  0001 C CNN
	1    1300 4000
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C2
U 1 1 5E3A5299
P 1700 4000
F 0 "C2" H 1792 4046 50  0000 L CNN
F 1 "100n" H 1792 3955 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W2.0mm_P2.50mm" H 1700 4000 50  0001 C CNN
F 3 "~" H 1700 4000 50  0001 C CNN
	1    1700 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2850 5350 2650 5350
Text GLabel 2650 5350 0    50   Input ~ 0
RESET
$Comp
L power:GND #PWR01
U 1 1 5E3A239C
P 1450 5450
F 0 "#PWR01" H 1450 5200 50  0001 C CNN
F 1 "GND" H 1455 5277 50  0000 C CNN
F 2 "" H 1450 5450 50  0001 C CNN
F 3 "" H 1450 5450 50  0001 C CNN
	1    1450 5450
	-1   0    0    -1  
$EndComp
Connection ~ 1950 5000
Wire Wire Line
	1950 5000 1800 5000
Wire Wire Line
	2200 5000 1950 5000
Connection ~ 1450 5400
Wire Wire Line
	1450 5400 1450 5450
Wire Wire Line
	1450 5400 1450 5000
Wire Wire Line
	1600 5400 1450 5400
$Comp
L Device:C_Small C4
U 1 1 5E3883EA
P 1700 5400
F 0 "C4" V 1550 5400 50  0000 C CNN
F 1 "22p" V 1450 5400 50  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D5.0mm_W2.5mm_P2.50mm" H 1700 5400 50  0001 C CNN
F 3 "~" H 1700 5400 50  0001 C CNN
	1    1700 5400
	0    1    -1   0   
$EndComp
$Comp
L Device:C_Small C3
U 1 1 5E3879F2
P 1700 5000
F 0 "C3" V 1471 5000 50  0000 C CNN
F 1 "22p" V 1562 5000 50  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D5.0mm_W2.5mm_P2.50mm" H 1700 5000 50  0001 C CNN
F 3 "~" H 1700 5000 50  0001 C CNN
	1    1700 5000
	0    -1   1    0   
$EndComp
Connection ~ 1950 5400
Wire Wire Line
	1950 5400 1800 5400
Wire Wire Line
	2200 5400 1950 5400
Wire Wire Line
	1950 5400 1950 5350
Wire Wire Line
	1950 5050 1950 5000
$Comp
L Device:Crystal Y1
U 1 1 5E364CDC
P 1950 5200
F 0 "Y1" V 1904 5331 50  0000 L CNN
F 1 "16MHz" V 1995 5331 50  0000 L CNN
F 2 "Crystal:Crystal_HC49-U_Vertical" H 1950 5200 50  0001 C CNN
F 3 "~" H 1950 5200 50  0001 C CNN
	1    1950 5200
	0    -1   1    0   
$EndComp
Wire Wire Line
	2200 5250 2200 5400
Wire Wire Line
	2200 5150 2200 5000
Wire Wire Line
	2850 5250 2200 5250
Wire Wire Line
	2850 5150 2200 5150
Wire Wire Line
	2850 4650 2650 4650
Text GLabel 2650 4650 0    50   Input ~ 0
DIO0
Wire Wire Line
	2850 4750 2650 4750
Text GLabel 2650 4750 0    50   Input ~ 0
DIO1
Wire Wire Line
	1500 4100 1700 4100
Wire Wire Line
	1500 4100 1300 4100
Connection ~ 1500 4100
$Comp
L power:GND #PWR03
U 1 1 5E3BFBF5
P 1500 4200
F 0 "#PWR03" H 1500 3950 50  0001 C CNN
F 1 "GND" H 1505 4027 50  0000 C CNN
F 2 "" H 1500 4200 50  0001 C CNN
F 3 "" H 1500 4200 50  0001 C CNN
	1    1500 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	1500 4100 1500 4200
Connection ~ 1500 3900
Wire Wire Line
	1500 3900 1700 3900
Wire Wire Line
	1300 3900 1500 3900
$Comp
L power:+5V #PWR02
U 1 1 5E3BF301
P 1500 3800
F 0 "#PWR02" H 1500 3650 50  0001 C CNN
F 1 "+5V" H 1515 3973 50  0000 C CNN
F 2 "" H 1500 3800 50  0001 C CNN
F 3 "" H 1500 3800 50  0001 C CNN
	1    1500 3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	1500 3900 1500 3800
$Comp
L Device:C_Small C16
U 1 1 5E62D242
P 8450 2450
F 0 "C16" H 8542 2496 50  0000 L CNN
F 1 "100n" H 8542 2405 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W2.0mm_P2.50mm" H 8450 2450 50  0001 C CNN
F 3 "~" H 8450 2450 50  0001 C CNN
	1    8450 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	8450 2350 8450 2300
$Comp
L power:+3.3V #PWR019
U 1 1 5E648358
P 8450 2300
F 0 "#PWR019" H 8450 2150 50  0001 C CNN
F 1 "+3.3V" H 8465 2473 50  0000 C CNN
F 2 "" H 8450 2300 50  0001 C CNN
F 3 "" H 8450 2300 50  0001 C CNN
	1    8450 2300
	1    0    0    -1  
$EndComp
Wire Wire Line
	8450 2550 8450 2600
$Comp
L power:GND #PWR020
U 1 1 5E648E95
P 8450 2600
F 0 "#PWR020" H 8450 2350 50  0001 C CNN
F 1 "GND" H 8455 2427 50  0000 C CNN
F 2 "" H 8450 2600 50  0001 C CNN
F 3 "" H 8450 2600 50  0001 C CNN
	1    8450 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	9650 5300 9500 5300
Wire Wire Line
	9650 5400 9500 5400
Text GLabel 9500 5400 0    50   Input ~ 0
RX
Wire Wire Line
	2850 5650 2650 5650
Text GLabel 2650 5650 0    50   Input ~ 0
RX
Text GLabel 9500 5300 0    50   Input ~ 0
TX
Wire Wire Line
	2850 5750 2650 5750
Text GLabel 2650 5750 0    50   Input ~ 0
TX
Wire Wire Line
	9650 5500 9500 5500
Wire Wire Line
	9650 5200 9500 5200
Wire Wire Line
	9500 5200 9500 5150
$Comp
L power:+5V #PWR026
U 1 1 5E2D514F
P 9500 5150
F 0 "#PWR026" H 9500 5000 50  0001 C CNN
F 1 "+5V" H 9515 5323 50  0000 C CNN
F 2 "" H 9500 5150 50  0001 C CNN
F 3 "" H 9500 5150 50  0001 C CNN
	1    9500 5150
	1    0    0    -1  
$EndComp
Wire Wire Line
	9500 5500 9500 5550
$Comp
L power:GND #PWR027
U 1 1 5E2D7839
P 9500 5550
F 0 "#PWR027" H 9500 5300 50  0001 C CNN
F 1 "GND" H 9505 5377 50  0000 C CNN
F 2 "" H 9500 5550 50  0001 C CNN
F 3 "" H 9500 5550 50  0001 C CNN
	1    9500 5550
	1    0    0    -1  
$EndComp
$Comp
L Device:Battery_Cell BT1
U 1 1 5E634119
P 6850 1500
F 0 "BT1" H 6968 1596 50  0000 L CNN
F 1 "Li-Ion" H 6968 1505 50  0000 L CNN
F 2 "Library:Battery_Holder" V 6850 1560 50  0001 C CNN
F 3 "~" V 6850 1560 50  0001 C CNN
	1    6850 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	6000 1350 6000 1250
Wire Wire Line
	6000 1550 6000 1650
Wire Wire Line
	6850 1600 6850 1650
Wire Wire Line
	6850 1650 6850 1700
$Comp
L power:GND #PWR015
U 1 1 5E63412B
P 6850 1700
F 0 "#PWR015" H 6850 1450 50  0001 C CNN
F 1 "GND" H 6855 1527 50  0000 C CNN
F 2 "" H 6850 1700 50  0001 C CNN
F 3 "" H 6850 1700 50  0001 C CNN
	1    6850 1700
	1    0    0    -1  
$EndComp
$Comp
L Device:CP_Small C12
U 1 1 5E634172
P 6450 1450
F 0 "C12" H 6538 1496 50  0000 L CNN
F 1 "100u" H 6538 1405 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.00mm" H 6450 1450 50  0001 C CNN
F 3 "~" H 6450 1450 50  0001 C CNN
	1    6450 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	6450 1350 6450 1250
Wire Wire Line
	6450 1550 6450 1650
$Comp
L Device:CP_Small C13
U 1 1 5E63417A
P 7300 1450
F 0 "C13" H 7388 1496 50  0000 L CNN
F 1 "100u" H 7388 1405 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.00mm" H 7300 1450 50  0001 C CNN
F 3 "~" H 7300 1450 50  0001 C CNN
	1    7300 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	7300 1350 7300 1250
Wire Wire Line
	7300 1550 7300 1650
Wire Wire Line
	6000 1650 6100 1650
Wire Wire Line
	6000 1250 6100 1250
$Comp
L Device:C_Small C11
U 1 1 5E634184
P 6100 1450
F 0 "C11" H 6192 1496 50  0000 L CNN
F 1 "100n" H 6192 1405 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W2.0mm_P2.50mm" H 6100 1450 50  0001 C CNN
F 3 "~" H 6100 1450 50  0001 C CNN
	1    6100 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	6100 1550 6100 1650
Wire Wire Line
	6100 1250 6100 1350
$Comp
L Device:C_Small C14
U 1 1 5E63418C
P 7700 1450
F 0 "C14" H 7792 1496 50  0000 L CNN
F 1 "100n" H 7792 1405 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W2.0mm_P2.50mm" H 7700 1450 50  0001 C CNN
F 3 "~" H 7700 1450 50  0001 C CNN
	1    7700 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	7700 1550 7700 1650
Wire Wire Line
	7700 1250 7700 1350
$Comp
L Device:CP_Small C18
U 1 1 5E6341AB
P 9250 1450
F 0 "C18" H 9338 1496 50  0000 L CNN
F 1 "100u" H 9338 1405 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.00mm" H 9250 1450 50  0001 C CNN
F 3 "~" H 9250 1450 50  0001 C CNN
	1    9250 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	9250 1350 9250 1250
Wire Wire Line
	9250 1550 9250 1650
$Comp
L Device:C_Small C17
U 1 1 5E6341B3
P 8900 1450
F 0 "C17" H 8992 1496 50  0000 L CNN
F 1 "100n" H 8992 1405 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W2.0mm_P2.50mm" H 8900 1450 50  0001 C CNN
F 3 "~" H 8900 1450 50  0001 C CNN
	1    8900 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	8900 1550 8900 1650
Wire Wire Line
	8900 1250 8900 1350
Connection ~ 6100 1250
Connection ~ 6100 1650
Connection ~ 6450 1250
Connection ~ 6450 1650
Connection ~ 6850 1650
Connection ~ 7300 1250
Connection ~ 7300 1650
Connection ~ 7700 1250
Connection ~ 7700 1650
Wire Wire Line
	6100 1650 6450 1650
Wire Wire Line
	6100 1250 6450 1250
Wire Wire Line
	6850 1650 7300 1650
Wire Wire Line
	7300 1650 7700 1650
Wire Wire Line
	7300 1250 7700 1250
Connection ~ 8900 1250
Connection ~ 8900 1650
Connection ~ 9250 1250
Connection ~ 9250 1650
Wire Wire Line
	8900 1250 9250 1250
Wire Wire Line
	9250 1250 9500 1250
Wire Wire Line
	8900 1650 9250 1650
Wire Wire Line
	9250 1650 9500 1650
Wire Wire Line
	9500 1650 9500 1700
Wire Wire Line
	9500 1250 9500 1200
$Comp
L power:+5V #PWR024
U 1 1 5E6341E1
P 9500 1200
F 0 "#PWR024" H 9500 1050 50  0001 C CNN
F 1 "+5V" H 9515 1373 50  0000 C CNN
F 2 "" H 9500 1200 50  0001 C CNN
F 3 "" H 9500 1200 50  0001 C CNN
	1    9500 1200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR025
U 1 1 5E6341E7
P 9500 1700
F 0 "#PWR025" H 9500 1450 50  0001 C CNN
F 1 "GND" H 9505 1527 50  0000 C CNN
F 2 "" H 9500 1700 50  0001 C CNN
F 3 "" H 9500 1700 50  0001 C CNN
	1    9500 1700
	1    0    0    -1  
$EndComp
Wire Wire Line
	6450 1250 6850 1250
Wire Wire Line
	6850 1300 6850 1250
Connection ~ 6850 1250
Wire Wire Line
	6850 1250 7300 1250
Wire Wire Line
	6450 1650 6850 1650
Wire Wire Line
	8650 5350 8650 5650
$Comp
L power:GND #PWR021
U 1 1 5E671D81
P 8650 5650
F 0 "#PWR021" H 8650 5400 50  0001 C CNN
F 1 "GND" H 8655 5477 50  0000 C CNN
F 2 "" H 8650 5650 50  0001 C CNN
F 3 "" H 8650 5650 50  0001 C CNN
	1    8650 5650
	1    0    0    -1  
$EndComp
Wire Wire Line
	2400 4350 2350 4350
Wire Wire Line
	2350 4350 2350 4300
$Comp
L Regulator_Linear:LM7805_TO220 U1
U 1 1 5E700BF3
P 5550 3050
F 0 "U1" H 5550 3292 50  0000 C CNN
F 1 "BA33BC0T" H 5550 3201 50  0000 C CNN
F 2 "Package_TO_SOT_THT:TO-220-3_Vertical" H 5550 3275 50  0001 C CIN
F 3 "http://www.fairchildsemi.com/ds/LM/LM7805.pdf" H 5550 3000 50  0001 C CNN
	1    5550 3050
	1    0    0    -1  
$EndComp
Connection ~ 5550 3350
Wire Wire Line
	5000 3100 5000 3050
Wire Wire Line
	5000 3300 5000 3350
$Comp
L power:+5V #PWR011
U 1 1 5E76FDC4
P 4850 3050
F 0 "#PWR011" H 4850 2900 50  0001 C CNN
F 1 "+5V" H 4865 3223 50  0000 C CNN
F 2 "" H 4850 3050 50  0001 C CNN
F 3 "" H 4850 3050 50  0001 C CNN
	1    4850 3050
	1    0    0    -1  
$EndComp
$Comp
L Device:CP_Small C10
U 1 1 5E78A591
P 5950 3200
F 0 "C10" H 6038 3246 50  0000 L CNN
F 1 "100u" H 6038 3155 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.00mm" H 5950 3200 50  0001 C CNN
F 3 "~" H 5950 3200 50  0001 C CNN
	1    5950 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	5950 3100 5950 3050
Wire Wire Line
	5950 3300 5950 3350
Wire Wire Line
	5550 3350 5950 3350
Wire Wire Line
	5850 3050 5950 3050
Connection ~ 5000 3050
Wire Wire Line
	5000 3050 5250 3050
Connection ~ 5000 3350
Wire Wire Line
	5000 3350 5550 3350
Wire Wire Line
	4850 3050 5000 3050
Wire Wire Line
	4850 3350 5000 3350
Connection ~ 5950 3050
Connection ~ 5950 3350
Wire Wire Line
	5950 3050 6250 3050
$Comp
L power:GND #PWR012
U 1 1 5E780033
P 4850 3350
F 0 "#PWR012" H 4850 3100 50  0001 C CNN
F 1 "GND" H 4855 3177 50  0000 C CNN
F 2 "" H 4850 3350 50  0001 C CNN
F 3 "" H 4850 3350 50  0001 C CNN
	1    4850 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5950 3350 6250 3350
$Comp
L power:GND #PWR014
U 1 1 5E7CAF37
P 6250 3350
F 0 "#PWR014" H 6250 3100 50  0001 C CNN
F 1 "GND" H 6255 3177 50  0000 C CNN
F 2 "" H 6250 3350 50  0001 C CNN
F 3 "" H 6250 3350 50  0001 C CNN
	1    6250 3350
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR013
U 1 1 5E7CA287
P 6250 3050
F 0 "#PWR013" H 6250 2900 50  0001 C CNN
F 1 "+3.3V" H 6265 3223 50  0000 C CNN
F 2 "" H 6250 3050 50  0001 C CNN
F 3 "" H 6250 3050 50  0001 C CNN
	1    6250 3050
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C9
U 1 1 5E3BFE07
P 5000 3200
F 0 "C9" H 5092 3246 50  0000 L CNN
F 1 "0.33u" H 5092 3155 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D5.0mm_W2.5mm_P5.00mm" H 5000 3200 50  0001 C CNN
F 3 "~" H 5000 3200 50  0001 C CNN
	1    5000 3200
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x04_Female J12
U 1 1 5E3CD64F
P 9850 5300
F 0 "J12" H 9878 5276 50  0000 L CNN
F 1 "Conn_01x04_Female" H 9878 5185 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x04_P2.54mm_Vertical" H 9850 5300 50  0001 C CNN
F 3 "~" H 9850 5300 50  0001 C CNN
	1    9850 5300
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02_Female J8
U 1 1 5E3EA4DC
P 8300 5150
F 0 "J8" V 8238 4962 50  0000 R CNN
F 1 "Conn_01x02_Female" V 8147 4962 50  0000 R CNN
F 2 "Connector_Molex:Molex_PicoBlade_53047-0210_1x02_P1.25mm_Vertical" H 8300 5150 50  0001 C CNN
F 3 "~" H 8300 5150 50  0001 C CNN
	1    8300 5150
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8400 5350 8650 5350
$Comp
L Connector:Conn_01x08_Female J7
U 1 1 5E40EF70
P 7700 3300
F 0 "J7" H 7728 3276 50  0000 L CNN
F 1 "Conn_01x08_Female" H 7728 3185 50  0000 L CNN
F 2 "Connector_PinSocket_2.00mm:PinSocket_1x08_P2.00mm_Vertical" H 7700 3300 50  0001 C CNN
F 3 "~" H 7700 3300 50  0001 C CNN
	1    7700 3300
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x08_Female J10
U 1 1 5E41130A
P 8650 3400
F 0 "J10" H 8542 2775 50  0000 C CNN
F 1 "Conn_01x08_Female" H 8542 2866 50  0000 C CNN
F 2 "Connector_PinSocket_2.00mm:PinSocket_1x08_P2.00mm_Vertical" H 8650 3400 50  0001 C CNN
F 3 "~" H 8650 3400 50  0001 C CNN
	1    8650 3400
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR016
U 1 1 5E427A29
P 6950 3000
F 0 "#PWR016" H 6950 2750 50  0001 C CNN
F 1 "GND" H 6955 2827 50  0000 C CNN
F 2 "" H 6950 3000 50  0001 C CNN
F 3 "" H 6950 3000 50  0001 C CNN
	1    6950 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6950 3000 7500 3000
Wire Wire Line
	7500 3100 7350 3100
Wire Wire Line
	7500 3200 7350 3200
Wire Wire Line
	7500 3300 7350 3300
Wire Wire Line
	7500 3400 7350 3400
Wire Wire Line
	7500 3500 7350 3500
Wire Wire Line
	7500 3700 7350 3700
Text GLabel 7350 3200 0    50   Input ~ 0
MOSI
Text GLabel 7350 3100 0    50   Input ~ 0
MISO
Text GLabel 7350 3300 0    50   Input ~ 0
SCK
Text GLabel 7350 3400 0    50   Input ~ 0
NSS
Text GLabel 7350 3500 0    50   Input ~ 0
RESET
NoConn ~ 7500 3600
$Comp
L power:GND #PWR017
U 1 1 5E4DA783
P 7350 3700
F 0 "#PWR017" H 7350 3450 50  0001 C CNN
F 1 "GND" H 7355 3527 50  0000 C CNN
F 2 "" H 7350 3700 50  0001 C CNN
F 3 "" H 7350 3700 50  0001 C CNN
	1    7350 3700
	1    0    0    -1  
$EndComp
NoConn ~ 8850 3000
NoConn ~ 8850 3500
NoConn ~ 8850 3400
Wire Wire Line
	9000 3100 8850 3100
Wire Wire Line
	9000 3200 8850 3200
Wire Wire Line
	9000 3700 8850 3700
Text GLabel 9000 3100 2    50   Input ~ 0
DIO1
Text GLabel 9000 3200 2    50   Input ~ 0
DIO0
Wire Wire Line
	8850 3300 9350 3300
$Comp
L power:+3.3V #PWR022
U 1 1 5E58D10D
P 9350 3300
F 0 "#PWR022" H 9350 3150 50  0001 C CNN
F 1 "+3.3V" H 9365 3473 50  0000 C CNN
F 2 "" H 9350 3300 50  0001 C CNN
F 3 "" H 9350 3300 50  0001 C CNN
	1    9350 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	8850 3600 9350 3600
$Comp
L power:GND #PWR023
U 1 1 5E5A485A
P 9350 3600
F 0 "#PWR023" H 9350 3350 50  0001 C CNN
F 1 "GND" H 9355 3427 50  0000 C CNN
F 2 "" H 9350 3600 50  0001 C CNN
F 3 "" H 9350 3600 50  0001 C CNN
	1    9350 3600
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x01_Female J11
U 1 1 5E5A52CB
P 8950 2200
F 0 "J11" H 8842 1975 50  0000 C CNN
F 1 "Conn_01x01_Female" H 8842 2066 50  0000 C CNN
F 2 "Connector_Coaxial:SMA_Amphenol_901-144_Vertical" H 8950 2200 50  0001 C CNN
F 3 "~" H 8950 2200 50  0001 C CNN
	1    8950 2200
	0    -1   -1   0   
$EndComp
Text GLabel 9000 3700 2    50   Input ~ 0
ANT
Wire Wire Line
	8950 2400 8950 2550
Text GLabel 8950 2550 3    50   Input ~ 0
ANT
Wire Wire Line
	2700 4350 2850 4350
$Comp
L Device:R R1
U 1 1 5E61941E
P 2550 4350
F 0 "R1" V 2700 4350 50  0000 L CNN
F 1 "10k" V 2620 4305 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 2480 4350 50  0001 C CNN
F 3 "~" H 2550 4350 50  0001 C CNN
	1    2550 4350
	0    -1   -1   0   
$EndComp
NoConn ~ 2850 4850
Wire Wire Line
	2850 4950 2300 4950
$Comp
L power:+5V #PWR06
U 1 1 5E67827C
P 2300 4950
F 0 "#PWR06" H 2300 4800 50  0001 C CNN
F 1 "+5V" H 2315 5123 50  0000 C CNN
F 2 "" H 2300 4950 50  0001 C CNN
F 3 "" H 2300 4950 50  0001 C CNN
	1    2300 4950
	1    0    0    -1  
$EndComp
Wire Wire Line
	2850 5050 2550 5050
$Comp
L power:GND #PWR09
U 1 1 5E694AD0
P 2550 5050
F 0 "#PWR09" H 2550 4800 50  0001 C CNN
F 1 "GND" V 2555 4922 50  0000 R CNN
F 2 "" H 2550 5050 50  0001 C CNN
F 3 "" H 2550 5050 50  0001 C CNN
	1    2550 5050
	0    1    1    0   
$EndComp
NoConn ~ 2850 5450
NoConn ~ 2850 5550
Text GLabel 2650 6550 0    50   Input ~ 0
BUTTON
Wire Wire Line
	2850 6550 2650 6550
Wire Wire Line
	2850 6450 2250 6450
$Comp
L power:GND #PWR05
U 1 1 5E77CBB3
P 2250 6450
F 0 "#PWR05" H 2250 6200 50  0001 C CNN
F 1 "GND" V 2255 6322 50  0000 R CNN
F 2 "" H 2250 6450 50  0001 C CNN
F 3 "" H 2250 6450 50  0001 C CNN
	1    2250 6450
	0    1    1    0   
$EndComp
Wire Wire Line
	2850 6250 2150 6250
$Comp
L power:+5V #PWR04
U 1 1 5E783E41
P 2150 6250
F 0 "#PWR04" H 2150 6100 50  0001 C CNN
F 1 "+5V" H 2165 6423 50  0000 C CNN
F 2 "" H 2150 6250 50  0001 C CNN
F 3 "" H 2150 6250 50  0001 C CNN
	1    2150 6250
	1    0    0    -1  
$EndComp
Wire Wire Line
	2850 6150 2650 6150
Text GLabel 2650 6150 0    50   Input ~ 0
SCK
Wire Wire Line
	2850 6050 2650 6050
Text GLabel 2650 6050 0    50   Input ~ 0
MISO
Wire Wire Line
	2850 5950 2650 5950
Text GLabel 2650 5950 0    50   Input ~ 0
MOSI
Wire Wire Line
	2850 5850 2650 5850
Text GLabel 2650 5850 0    50   Input ~ 0
NSS
$Comp
L Connector:Conn_01x28_Female J2
U 1 1 5E7FA35C
P 3050 5650
F 0 "J2" H 3078 5626 50  0000 L CNN
F 1 "Conn_01x28_Female" H 3078 5535 50  0000 L CNN
F 2 "Package_DIP:DIP-28_W7.62mm" H 3050 5650 50  0001 C CNN
F 3 "~" H 3050 5650 50  0001 C CNN
	1    3050 5650
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C5
U 1 1 5E7AF997
P 2650 6350
F 0 "C5" H 2742 6396 50  0000 L CNN
F 1 "100n" H 2700 6250 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W2.0mm_P2.50mm" H 2650 6350 50  0001 C CNN
F 3 "~" H 2650 6350 50  0001 C CNN
	1    2650 6350
	0    1    1    0   
$EndComp
Wire Wire Line
	2550 6350 2450 6350
$Comp
L power:GND #PWR08
U 1 1 5E7AF99F
P 2450 6350
F 0 "#PWR08" H 2450 6100 50  0001 C CNN
F 1 "GND" H 2455 6177 50  0000 C CNN
F 2 "" H 2450 6350 50  0001 C CNN
F 3 "" H 2450 6350 50  0001 C CNN
	1    2450 6350
	0    1    1    0   
$EndComp
Wire Wire Line
	2750 6350 2850 6350
NoConn ~ 2850 6750
NoConn ~ 2850 6850
NoConn ~ 2850 6950
NoConn ~ 2850 7050
$Comp
L Connector:Conn_01x02_Female J3
U 1 1 5E9300CA
P 5050 1250
F 0 "J3" H 4900 1500 50  0000 L CNN
F 1 "Conn_01x02_Female" H 4600 1400 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x02_P2.54mm_Vertical" H 5050 1250 50  0001 C CNN
F 3 "~" H 5050 1250 50  0001 C CNN
	1    5050 1250
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02_Female J4
U 1 1 5E937AE2
P 5050 1550
F 0 "J4" H 4900 1300 50  0000 L CNN
F 1 "Conn_01x02_Female" H 4650 1200 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x02_P2.54mm_Vertical" H 5050 1550 50  0001 C CNN
F 3 "~" H 5050 1550 50  0001 C CNN
	1    5050 1550
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02_Female J5
U 1 1 5E93EE97
P 5800 1350
F 0 "J5" H 5650 1000 50  0000 L CNN
F 1 "Conn_01x02_Female" H 5300 1100 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x02_P2.54mm_Vertical" H 5800 1350 50  0001 C CNN
F 3 "~" H 5800 1350 50  0001 C CNN
	1    5800 1350
	-1   0    0    1   
$EndComp
$Comp
L Connector:Conn_01x02_Female J6
U 1 1 5E945A8A
P 5800 1650
F 0 "J6" H 5650 1800 50  0000 L CNN
F 1 "Conn_01x02_Female" H 5300 1900 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x02_P2.54mm_Vertical" H 5800 1650 50  0001 C CNN
F 3 "~" H 5800 1650 50  0001 C CNN
	1    5800 1650
	-1   0    0    1   
$EndComp
Wire Wire Line
	3750 1650 4200 1650
$Comp
L Diode:1N62xxA D5
U 1 1 5E6341BF
P 3200 1450
F 0 "D5" V 3154 1529 50  0000 L CNN
F 1 "P6KE24A" V 3245 1529 50  0000 L CNN
F 2 "Diode_THT:D_DO-15_P15.24mm_Horizontal" H 3200 1250 50  0001 C CNN
F 3 "https://www.vishay.com/docs/88301/15ke.pdf" H 3150 1450 50  0001 C CNN
	1    3200 1450
	0    1    1    0   
$EndComp
Wire Wire Line
	4850 1550 4850 1650
Wire Wire Line
	4600 1650 4850 1650
Wire Wire Line
	3000 1250 3000 1450
Connection ~ 3000 1250
Connection ~ 3200 1250
Wire Wire Line
	3200 1250 3000 1250
Connection ~ 3200 1650
Wire Wire Line
	1900 1650 3200 1650
Wire Wire Line
	3000 1050 3000 1250
Wire Wire Line
	3200 1650 3750 1650
Wire Wire Line
	3200 1250 3750 1250
Connection ~ 3750 1650
Wire Wire Line
	3750 1250 4200 1250
Connection ~ 3750 1250
Wire Wire Line
	4200 1650 4600 1650
Connection ~ 4200 1650
Wire Wire Line
	4200 1250 4600 1250
Connection ~ 4200 1250
Connection ~ 4600 1650
Wire Wire Line
	4600 1250 4850 1250
Connection ~ 4600 1250
$Comp
L Device:D_Schottky_ALT D4
U 1 1 5E634166
P 2750 1450
F 0 "D4" H 2750 1250 50  0000 C CNN
F 1 "1N5819 YJ" H 2750 1350 50  0000 C CNN
F 2 "Diode_THT:D_DO-41_SOD81_P10.16mm_Horizontal" H 2750 1450 50  0001 C CNN
F 3 "~" H 2750 1450 50  0001 C CNN
	1    2750 1450
	-1   0    0    1   
$EndComp
$Comp
L Device:D_Schottky_ALT D2
U 1 1 5E634160
P 2250 1450
F 0 "D2" H 2250 1250 50  0000 C CNN
F 1 "1N5819 YJ" H 2250 1350 50  0000 C CNN
F 2 "Diode_THT:D_DO-41_SOD81_P10.16mm_Horizontal" H 2250 1450 50  0001 C CNN
F 3 "~" H 2250 1450 50  0001 C CNN
	1    2250 1450
	-1   0    0    1   
$EndComp
$Comp
L Device:D_Schottky_ALT D3
U 1 1 5E63415A
P 2750 1050
F 0 "D3" H 2750 750 50  0000 C CNN
F 1 "1N5819 YJ" H 2750 850 50  0000 C CNN
F 2 "Diode_THT:D_DO-41_SOD81_P10.16mm_Horizontal" H 2750 1050 50  0001 C CNN
F 3 "~" H 2750 1050 50  0001 C CNN
	1    2750 1050
	-1   0    0    1   
$EndComp
$Comp
L Device:D_Schottky_ALT D1
U 1 1 5E634154
P 2250 1050
F 0 "D1" H 2250 750 50  0000 C CNN
F 1 "1N5819 YJ" H 2250 850 50  0000 C CNN
F 2 "Diode_THT:D_DO-41_SOD81_P10.16mm_Horizontal" H 2250 1050 50  0001 C CNN
F 3 "~" H 2250 1050 50  0001 C CNN
	1    2250 1050
	-1   0    0    1   
$EndComp
$Comp
L Connector:Screw_Terminal_01x02 J1
U 1 1 5E63414E
P 1550 1300
F 0 "J1" H 1550 950 50  0000 C CNN
F 1 "Dynamo" H 1550 1050 50  0000 C CNN
F 2 "TerminalBlock:TerminalBlock_Altech_AK300-2_P5.00mm" H 1550 1300 50  0001 C CNN
F 3 "~" H 1550 1300 50  0001 C CNN
	1    1550 1300
	-1   0    0    1   
$EndComp
Wire Wire Line
	2100 1050 2000 1050
Wire Wire Line
	2000 1050 2000 1250
Wire Wire Line
	2000 1450 2100 1450
Wire Wire Line
	2900 1050 3000 1050
Wire Wire Line
	3000 1450 2900 1450
Connection ~ 2000 1250
Wire Wire Line
	2000 1250 2000 1450
Wire Wire Line
	1900 1250 2000 1250
Wire Wire Line
	2400 1050 2500 1050
Wire Wire Line
	2400 1450 2500 1450
Wire Wire Line
	2500 1050 2500 950 
Wire Wire Line
	2500 950  1750 950 
Wire Wire Line
	1750 950  1750 1200
Connection ~ 2500 1050
Wire Wire Line
	2500 1050 2600 1050
Wire Wire Line
	2500 1450 2500 1550
Wire Wire Line
	2500 1550 1750 1550
Wire Wire Line
	1750 1550 1750 1300
Connection ~ 2500 1450
Wire Wire Line
	2500 1450 2600 1450
Wire Wire Line
	1900 1250 1900 1650
Wire Wire Line
	3200 1650 3200 1600
Wire Wire Line
	3200 1250 3200 1300
$Comp
L Device:CP_Small C6
U 1 1 5E634131
P 3750 1450
F 0 "C6" H 3838 1496 50  0000 L CNN
F 1 "1000u" H 3838 1405 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D10.0mm_P5.00mm" H 3750 1450 50  0001 C CNN
F 3 "~" H 3750 1450 50  0001 C CNN
	1    3750 1450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR010
U 1 1 5E634124
P 4200 1700
F 0 "#PWR010" H 4200 1450 50  0001 C CNN
F 1 "GND" H 4205 1527 50  0000 C CNN
F 2 "" H 4200 1700 50  0001 C CNN
F 3 "" H 4200 1700 50  0001 C CNN
	1    4200 1700
	1    0    0    -1  
$EndComp
Wire Wire Line
	4200 1650 4200 1700
Wire Wire Line
	3750 1350 3750 1250
Wire Wire Line
	3750 1550 3750 1650
Wire Wire Line
	4600 1250 4600 1350
Wire Wire Line
	4600 1550 4600 1650
Wire Wire Line
	4200 1550 4200 1650
Wire Wire Line
	4200 1350 4200 1250
Wire Wire Line
	4850 1250 4850 1350
$Comp
L Device:C_Small C8
U 1 1 5E63410C
P 4600 1450
F 0 "C8" H 4692 1496 50  0000 L CNN
F 1 "100n" H 4692 1405 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W2.0mm_P2.50mm" H 4600 1450 50  0001 C CNN
F 3 "~" H 4600 1450 50  0001 C CNN
	1    4600 1450
	1    0    0    -1  
$EndComp
$Comp
L Device:CP_Small C7
U 1 1 5E634106
P 4200 1450
F 0 "C7" H 4288 1496 50  0000 L CNN
F 1 "100u" H 4288 1405 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.00mm" H 4200 1450 50  0001 C CNN
F 3 "~" H 4200 1450 50  0001 C CNN
	1    4200 1450
	1    0    0    -1  
$EndComp
Connection ~ 4850 1250
Connection ~ 4850 1650
Connection ~ 6000 1250
Connection ~ 6000 1650
Wire Wire Line
	7700 1650 8400 1650
Connection ~ 8400 1650
Wire Wire Line
	8400 1650 8900 1650
$Comp
L Connector:Conn_01x03_Female J9
U 1 1 5EA85B05
P 8400 1050
F 0 "J9" V 8338 862 50  0000 R CNN
F 1 "Conn_01x03_Female" V 8247 862 50  0000 R CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x03_P2.54mm_Vertical" H 8400 1050 50  0001 C CNN
F 3 "~" H 8400 1050 50  0001 C CNN
	1    8400 1050
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8400 1250 8400 1650
Wire Wire Line
	7700 1250 8300 1250
Wire Wire Line
	8500 1250 8900 1250
NoConn ~ 2850 6650
Text GLabel 7600 5350 0    50   Input ~ 0
BUTTON
$Comp
L Device:R R2
U 1 1 5ECC6F67
P 7900 5350
F 0 "R2" V 8050 5350 50  0000 L CNN
F 1 "1k" V 7970 5305 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 7830 5350 50  0001 C CNN
F 3 "~" H 7900 5350 50  0001 C CNN
	1    7900 5350
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7600 5350 7750 5350
Wire Wire Line
	8200 5350 8300 5350
Connection ~ 8200 5350
Wire Wire Line
	8050 5350 8200 5350
$Comp
L power:GND #PWR018
U 1 1 5ECB146B
P 8200 5650
F 0 "#PWR018" H 8200 5400 50  0001 C CNN
F 1 "GND" H 8205 5477 50  0000 C CNN
F 2 "" H 8200 5650 50  0001 C CNN
F 3 "" H 8200 5650 50  0001 C CNN
	1    8200 5650
	1    0    0    -1  
$EndComp
Wire Wire Line
	8200 5350 8200 5400
Wire Wire Line
	8200 5600 8200 5650
$Comp
L Device:C_Small C15
U 1 1 5EC75BB7
P 8200 5500
F 0 "C15" H 8292 5546 50  0000 L CNN
F 1 "100n" H 8292 5455 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W2.0mm_P2.50mm" H 8200 5500 50  0001 C CNN
F 3 "~" H 8200 5500 50  0001 C CNN
	1    8200 5500
	1    0    0    -1  
$EndComp
NoConn ~ 2850 4450
NoConn ~ 2850 4550
NoConn ~ 5700 4850
$EndSCHEMATC