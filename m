From: Paul Miller <pmiller9@users.sourceforge.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 405EP peripheral memory access
Date: Wed, 29 Oct 2003 08:08:00 -0600
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200310290808.00654.pmiller9@users.sourceforge.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am new to Linux embedded programming.  I have experience programming
microcontrollers and DSPs without an operating system, so I have some
idea what I'm doing.  Anyhow, I'm trying to use the peripheral memory
bus on my 405EP CerfCube from Intrinsyc.  Does anyone have an example
that I can work from?

To setup the memory's timings, I need access to the DCR register.  In
the PowerPC datasheet it says to use assembly instructions mtdcr and
mfdcr.  I don't know much about assembly, but I found a kernel patch
that uses these functions.  So, working off this patch, I tried making
a simple program to read these registers.  When I run it, Linux reports
an "Illegal instruction" and doesn't let me access the register.

Does access to this bus need to be done in "kernel mode"?  If so, where
can I find more information about writing a kernel driver?  Ideally,
I'd like to just open a device file and read/write to the bus.

Thanks!
-Paul

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
