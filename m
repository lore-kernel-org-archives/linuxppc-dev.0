Message-ID: <D73A25AA6E54D511AD74009027B1110F3C0AD2@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'Paul Miller'" <pmiller9@users.sourceforge.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: 405EP peripheral memory access
Date: Wed, 29 Oct 2003 09:31:52 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I would recommend you get the following books.


Embedded Linux: Hardware, Software, and Interfacing by Craig Hollabaugh

Linux Device Drivers, 2nd Edition by Alessandro Rubini, Jonathan Corbet

Building Embedded Linux Systems by Karim Yaghmour



-----Original Message-----
From: Paul Miller [mailto:pmiller9@users.sourceforge.net]
Sent: Wednesday, October 29, 2003 9:08 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: 405EP peripheral memory access



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
