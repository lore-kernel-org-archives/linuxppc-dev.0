Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Sat, 07 Sep 2002 18:59:02 +0200
From: o_y <o_yahav@netvision.net.il>
Subject: MPC860T FEC problem
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <MBBBIOFIICDAPDMKHBDEKEDLCAAA.o_yahav@netvision.net.il>
MIME-version: 1.0
Content-type: text/plain; charset=windows-1255
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello to all.
I'm trying to port linux 2.2.14 on MPC860T and busybox as initrd.
The eth0 device is working so i have network capability.
Now i'm trying to get the FEC device working.
In the booting process the FEC is initialized ok (or so i belive),
IRQ(FEC)=3.
The problem is : when i use the FEC as my network device there is no
interrupts
from this device (unlike when i use the eth0 device as my net device).
The LINK led and the TX led are on constantly when i connect the FEC to a
100TXBase switch.
I have not seen any initializetion of the BCSR4 so i initialize it with the
value
that ppcboot uses , so the ENABLE led is on too.
The device isn't working even when i use ppcboot (i configured ppcboot to
use it).

1. Why there is no initializetion of BCSR4 in the original code?
2. If BCSR4 must be initialized , what is the correct value?
3. Is any one have a code that succeeded getting FEC device to work?
4. IVEC(ILEVEL) bits of the FEC are initialized but when i read the value of
this
   register i get 0x00000000 . Is this the problem ? and if so how can i fix
it ?

thank you for your help
oshri.
o_yahav@netvision.net.il


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
