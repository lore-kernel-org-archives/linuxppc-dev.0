Message-ID: <D73A25AA6E54D511AD74009027B1110F4D0706@ORION>
From: Matt Hoover <HooverM@embeddedplanet.com>
To: "'Kiran Mandava'" <kiran.mandava@skystream.com>,
	linuxppc-embedded@lists.linuxppc.org
Cc: Obaid Haqqi <haqqio@embeddedplanet.com>
Subject: RE: ep8260 board linux port
Date: Fri, 19 Dec 2003 11:46:15 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kiran,

Please contact me regarding the EP8260 and Linux.

Regards,
Matt Hoover
440-646-0077 x136

-----Original Message-----
From: Kiran Mandava [mailto:kiran.mandava@skystream.com]
Sent: Thursday, December 18, 2003 2:44 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: ep8260 board linux port



Hello All,

  I am trying to port linux 2.4.22 onto ep8260 board. (256 MB RAM on 6xx
bus/ 32 MB Flash) using tools and source code from denx webisite.
  I was able to port u-boot and trying to boot linux now.
  i couldn't find any specific files to this board in the platform directory
although est8260.h file has the basic bd structure. the problem i am facing
is the processor loops in serial_console_write/ timer interrupt handler. i
made sure that i am passing the baudrate proeprly by looking at the bd
structure while passing teh control to start_kernel function.
  My console does display everything properly running u-boot but once the
control goes to linux don't see anything on the console.

i made only the following changes for th elinux boot.
	1. in uart.c made sure that the console port is defines as SMC1.
	2. defines the SMC2 to be serial port too
      3. FCC3 is configured as the ethernet.

and compiled and tried to boot the image, but i couldn't. i do have a BDI
JTAG device and i was able to see the RAM properly.

 could some one throw light on what i could be doing wrong, any sugestions
are greatley appreciated. I bet some one would have done this sucessfully
years before..




thanks,
kiran


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
