From: "Prabhakar Kalasani" <kalasani@sena.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RPX-CLLF porting
Date: Fri, 14 May 2004 16:57:56 +0900
Message-ID: <ACEDKFIMODAHBNCONGOHGEOFCDAA.kalasani@sena.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
I have got RPX-CLLF target , I'm trying to port PPC Linux , I made tftp,nfs
and DHCP setup and I could able to load the kernel using tftp , the problem
is I couldn't able to run the kernel .

Here is the Log:

MPC8xx PlanetCore Boot Loader v2.00
Copyright 2001 Embedded Planet.  All rights reserved.
DRAM available size = 16 MB
wvCV
DRAM OK

Autoboot in 2 seconds.
ESC to abort, SPACE or ENTER to go.
Autoboot aborted.

>set
Baud                                           = 9600
Multiplier   (Clock multiplier)                = 5
Board                                          = CLLF
Revision                                       = BW31
Processor                                      = 855
Variant                                        = T
DRam         (Mbytes onboard dram)             = 16
Cols         (Columns onboard dram)            = 10
NVRam        (Kbytes onboard nvram)            = 512
Sttm         (Degrees C*10)                    = 0
Twirl                                          = Y
ICache                                         = N
SYPCR                                          = FFFF0689
RAMtest                                        = Y
RestoreCE    (Cannot go to ram if set)         = N
SerPort      (Serial port to use for monitor)  = SMC1
SerOut       (Serial output of loader)         = Always
RS232        (Enable rs232 drivers)            = Y
IP                                             = 192.168.222.200
Target                                         = 192.168.222.208
File                                           = vmlinux
ENET                                           = 0010EC002D1E
DefaultENET                                    = ENET
TftpRAM                                        = High
Start                                          = 400000
Format                                         = NetBin
Autoboot                                       = Confirm

>t
Load using tftp via Ethernet
Enter server IP address <192.168.222.208> :
Enter server filename   <vmlinux> :
Enter (B)inary or (S)record input mode <B> :
Enter address offset  : <00400000 hex> :
.512.1024..2048...
Total bytes = 1839078 in 9948811 uSecs
Loaded addresses 00400000 through 005C0FE5.
Start address = 00400000
>g
[Go 00400000]

There after no responce from the target...

Anybody can help ?
Thanks in advance

Regards,
KP

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
