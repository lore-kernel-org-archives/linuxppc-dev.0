Message-ID: <0B0A39652BB0D411BCCF00508B9512EC08AEB555@tx14exm05.ftw.mot.com>
From: Yu Bo-BOYU1 <Bo.Yu@motorola.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: question about open_pic and serial port
Date: Tue, 22 Oct 2002 10:23:20 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Does the current version Mvista preview 2.1 fully support serial mode of 107
EPIC ?
If so, what is interrupt number for serial mode interrupt 0 of mpc107 ? I
reviewed
the old messages on this list and the open_pic.c and there are some threads
talking
about the first 16 interrupts are reserved for 8259 only. Does that mean
serial mode interrupt
0 match interrupt 16 on open_pic interrupt table ?

Plus, I changed the base address of boot/common/ns16550.c to drive the TI
752 uart.
It appears working before kernel starts. Then it hang. It seems that the
same file (ns16550.c)
is not used after kernel starts. Which serial device driver is used after
kernel starts ?

Starting at 0x800000...

loaded at:     00800000 0089E1BC
zimage at:     00805870 0089AC70
avail ram:     00400000 00800000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel





Thanks.

Bo Yu
Motorola, GTSS
1-817-245-6725


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
