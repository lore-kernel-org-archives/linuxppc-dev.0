Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <89DEFCC5DB33D411A27F00508BCF8A821489FCB7@ZCH07EXM05.corp.mot.com>
From: Liu Fred-a18596 <fred.liu@motorola.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: unable to input in u-boot at Lite5200
Date: Thu, 11 Mar 2004 20:38:57 +0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Folks,

I have burned u-boot.1.0.0 into Lite5200 board (icecube, 16M Flash, 64M SDRAM).
u-boot printed fllowing information when I pushed the reset button.

*********************************************************************
U-Boot 1.0.0 (Mar 11 2004 - 19:44:40)

CPU:   MPC5200 (JTAG ID 0001101d) at 399.999 MHz
       Bus 133 MHz, IPB 66 MHz, PCI 33 MHz
Board: Motorola MPC5200 (IceCube)
I2C:   0 kHz, ready
DRAM:  64 MB
FLASH: 16 MB
*** Warning - bad CRC, using default environment

PCI:   Bus Dev VenId DevId Class Int
        00  1a  1057  5803  0680  00
86 kHz, In:    serial
Out:   serial
Err:   serial
Net:   FEC ETHERNET
Hit any key to stop autoboot:  0
## Booting image at 00100000 ...
Bad Magic Number
=>
***********************************************************************

All information seems good, but I can't input key to stop autoboot.
It seems  that it dont't accept any input from console.
I don't know why this happened.
Can anyone explain it?

Best regards,
Fred

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
