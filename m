Message-ID: <3439AB3A99ECD5409F3A52ACF814744D158D93@norcom2.norcom.net>
From: Lokesh Kumar <kumar.lokesh@wrx-us.com>
To: "'Steven Blakeslee'" <BlakesleeS@embeddedplanet.com>,
	Lokesh Kumar <kumar.lokesh@wrx-us.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: mpc8xx memory mapped 16550 extrenal uart driver
Date: Fri, 3 Oct 2003 13:45:49 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


HI Steven,
Let me tell few more details of the board I have. I am using SMC1 and 2 as
serial and SCC1 as serial as well. Then there is the fourth serial  which is
16550 memory mapped. I want to load the driver for the 16550 as module, and
do all the mapping and chip select setup in the module itself.

Now, if I use serial.c as the module for 16550, are there any things I need
to do i.e. tty names, minor and major numbers etc?

Lokesh

-----Original Message-----
From: Steven Blakeslee [mailto:BlakesleeS@embeddedplanet.com]
Sent: Friday, October 03, 2003 9:49 AM
To: 'Lokesh Kumar'; 'linuxppc-embedded@lists.linuxppc.org'
Subject: RE: mpc8xx memory mapped 16550 extrenal uart driver


You can do the mapping anywhere you want, anywhere you do specific board
initialization is a good spot.  Check out
arch/ppc/platforms/sandpoint_setup.c
arch/ppc/platforms/sandpoint_serial.h
for an example on setting up the serial device.


-----Original Message-----
From: Lokesh Kumar [mailto:kumar.lokesh@wrx-us.com]
Sent: Friday, October 03, 2003 9:26 AM
To: 'Steven Blakeslee'; Lokesh Kumar;
'linuxppc-embedded@lists.linuxppc.org'
Subject: RE: mpc8xx memory mapped 16550 extrenal uart driver


Hi Steven,
Thanks for the quick reply. I did look at serial.c, however, i did not find
where do we map the device to the memory i.e. where are we doing chip select
setting and stuff. I saw that being done for CONFIG_SERIAL_TTTECH. Is that
what you are referring to or I am missing the point completely?

Lokesh

-----Original Message-----
From: Steven Blakeslee [mailto:BlakesleeS@embeddedplanet.com]
Sent: Friday, October 03, 2003 9:16 AM
To: 'Lokesh Kumar'; 'linuxppc-embedded@lists.linuxppc.org'
Subject: RE: mpc8xx memory mapped 16550 extrenal uart driver


It's already in there.  drivers/char/serial.c

-----Original Message-----
From: Lokesh Kumar [mailto:kumar.lokesh@wrx-us.com]
Sent: Friday, October 03, 2003 9:02 AM
To: 'linuxppc-embedded@lists.linuxppc.org'
Subject: mpc8xx memory mapped 16550 extrenal uart driver



Hi gurus,

Does anybody know of a driver for an external 16550 memory mapped uart
driver for an mpc855 based board? Any help is appreciated?


Lokesh Kumar
Wireless Matrix USA Inc.
703-262-4032


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
