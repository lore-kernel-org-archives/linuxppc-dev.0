Message-ID: <D73A25AA6E54D511AD74009027B1110F3C086C@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'XOL'" <xol@mail.ru>, linuxppc-embedded@lists.linuxppc.org
Subject: RE: Booting CLLF ppc862 board from flash
Date: Mon, 2 Jun 2003 09:09:56 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The Embedded Planet boards ship with a documentation CD that contains an
executable called the Planet Core FLASH burner.  This program will allow you
to burn the Linux kernel to FLASH.  Most Linux kernels have a small boot
section that is smart enough to copy the kernel to the location it was
compiled for and boot it.

-----Original Message-----
From: XOL [mailto:xol@mail.ru]
Sent: Sunday, June 01, 2003 7:02 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Booting CLLF ppc862 board from flash



Hello.
Sorry for my probably stupid question.
I'm new in embedded field.

I have CLLF ppc862 board from EmbeddedPlanet.
I have it running booting from tftp with root fs NFS mounted
on one of the desktop Linux PC.

Now I want to get it running in standalone mode from Flash.
My board has PCMCIA connector with Flash Card adapter. I have
flash card of 64K. Also there are on-board flash 64K and 32K RAM.
Are there any step-by-step howto about this issue.
Thank you in advance.
Best Regards.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
