Message-ID: <004901c2e83f$e9643f40$6649a8c0@LEIYINGDU>
From: "Leiying Du" <ldu@solectek.com>
To: "'LinuxPPC-Embedded'" <linuxppc-embedded@lists.linuxppc.org>
Subject: BDI2000 debug zImage
Date: Tue, 11 Mar 2003 18:34:31 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm using the BDI2000 with firmware version 1.12 to debug the zImage file
that I made. The zImage file can be flashed into the ROM and boot up
properly. From the BDI2000 telnet interface, I type in load

Loading zImage , please wait ....
- File offset 0x00010000 to address 0x00500000 size 25380
- File offset 0x0001C570 to address 0x0050C570 size 3160272
Loading program file passed

Then I can single step from the 0x500000. But the board will get into the
check stop state if I type in go command.

The host section in the BDI2000 configuration file are flollow:
FILE    zImage
FORMAT  IMAGE
LOAD      MANUAL

Is this the correct way to debug kernel with initrd? Thanks.



Ly


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
