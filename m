Message-ID: <005101c4233c$abf8b670$6f01a8c0@xiphos.ca>
From: "Joshua Lamorie" <jpl@xiphos.ca>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Cascaded interrupt controllers
Date: Thu, 15 Apr 2004 18:54:56 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Gidday there,

I have a board containing a Virtex-II Pro and a few other FPGAs.  I have an
OPB between the Virtex-II Pro and a Virtex-II which contains a UART,
Interrupt controller and other peripherals.

I currently have linux booting just fine, and a single UART talking nicely
to the primary interrupt controller on the Virtex-II OPB.  I'm trying to
modify the xilinx_pic.c code in arch/ppc/kernel as well as elements of
arch/ppc/platforms/xilinx_ml300.[ch] and several files within
arch/ppc/platforms/xilinx_ocp.

I've been using ppc4xx_pic as an example, but I can't figure out where to
register, or initialize the interrupt that goes from the second INTC to the
first.  When it's running all I see in /proc/interrupts is the interrupt for
the serial port.

I'm afraid I'm a little new to this level of the linux kernel, and
definitely new to powerpc architecture.

Can anyone give me any pointers to good examples of setting things up?  It
doesn't appear that anything uses irq_action which seems to be how things
are done for a intel Pee Cee.

I'll post whichever elements of code would be most useful.

Thanks

Joshua

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
