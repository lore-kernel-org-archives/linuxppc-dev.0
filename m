Message-ID: <81A66F72DCACD511B0600002A551BFCB4E9CDC@kuumex05.barco.com>
From: =?iso-8859-1?Q?=22Callebaut=2C_Beno=EEt=22?= <benoit.callebaut@barco.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Intel 82559 Mac/Phy and interrupts on MPC8245
Date: Mon, 9 Dec 2002 14:59:03 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
I am trying to use a 82559 mac/phy on our custom board. It is attached to
the PCI bus of the PPC.
The only "nonstandard" feature is that its interrupt line is directly
connected to the EPIC forcing me to
use the EPIC in direct mode.
The code of the eepro100.c driver is modified to take this in account but
all goes no so smoothly since I don't receive the interrupts.
It seems that the MSR register is not correctly configured: MSR[EE]=0
instead of 1 and MSR[IP]= 1 instead of 0
I tried to change this in the kernel but I didn't find the right place.
The others registers seems to be correctly configured.
Does someone have any clue on how this works of more detailed doc on the
82559 that the one of Intel ?


----------------------------------------------------------------------------
------
Benoit Callebaut
Software Development Engineer
Barco | Control Rooms
Noordlaan 5, 8520 Kuurne, Belgium

Tel 	+32(0)56 36 84 28
Fax 	+32(0)56 36 86 05

mailto:benoit.callebaut@barco.com
http://www.barcocontrolrooms.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
