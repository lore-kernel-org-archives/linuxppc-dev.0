Message-ID: <A3240F62EF3C2749B1A25D3BC9548F4103094F@ExchWENZ02.wenz.global.vpn>
From: Rod Boyce <rod_boyce@stratexnet.com>
To: "Dick Read (SkyLynx)" <dread@skylynx.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: quad uart driver for 852T
Date: Mon, 8 Dec 2003 15:08:33 -0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This driver is supported nativly by the Linux kernel see
drivers/char/serial.c and include/asm/serial.h

All you have to do is ioremap the address of the quad UART, fill out the
structure in include/asm/serial.h and add the interrupt connection code from
your hardware interrupt to the serial interrupt in serial.c

Rod

-----Original Message-----
From: Dick Read (SkyLynx) [mailto:dread@skylynx.com]
Sent: Tuesday, December 09, 2003 11:30 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: quad uart driver for 852T



Hello.  I am new to Embedded Linux and wish to find a driver or code for a
quad uart chip that I can use with the Analogue & Micro Adder II (MPC852T)
reference board.  I have never done a Linux driver before but am willing to
take the plunge here if I have to.  I see that someone as worked with a
16C554 on this mailing list and might have it working by now.  Besides the
suggestions for the UART code, what is the etiquette for asking people about
their work?  I have often heard Linux has tons of drivers but how do you
find the ones you need?

Thank you.
Dick Read
Skylynx Communications
206-780-5754


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
