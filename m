Message-ID: <D73A25AA6E54D511AD74009027B1110F5BB16C@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'sutra'" <pierre.sutra@com2gether.net>,
	linuxppc-dev@lists.linuxppc.org
Subject: RE: SPI bus on MPC8xx
Date: Thu, 8 Apr 2004 10:44:08 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


You could assign a known virtual address to the physical address you want to
view.  You can then dump that virtual address to see the physical contents.

-----Original Message-----
From: sutra [mailto:pierre.sutra@com2gether.net]
Sent: Thursday, April 08, 2004 9:50 AM
To: linuxppc-dev@lists.linuxppc.org
Subject: SPI bus on MPC8xx



Hello,

I'd like to know if somebody know how to debug physical addresses via
bdigdb ( on a MPC8XX  the dual port RAM of the CPM for example) because
bdi always translate adresses to physical one and when i need to access
physical addresses i can't.
Is it possible to force some space addresses not to be translated by bdi
or not ? ( i have looked the bdi user manual and did not find anything
intresting)

thanks you


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
