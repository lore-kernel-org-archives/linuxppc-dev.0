Date: Wed, 17 Mar 2004 16:04:01 +0100 (CET)
From: Oliver Korpilla <korpo@01019freenet.de>
To: grave@ipno.in2p3.fr
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Linux on the MVME 5500 and others
Message-ID: <Pine.LNX.4.58.0403171554340.5476@corpster>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I read your post (below) to the LinuxPPC list, and I'm trying something to
do along the lines of what you did for a study project.

My target hardware is MVME 2100, MVME 5500 and VMIVME 7050 (Intel).

Since I'm new to real-time applications, I'd greatly appreciate, if I
could use what you mentioned in the original post below.

I wanted to use RTAI, and get a hard realtime response out of the Tundra
Universe 2 bridge on these boards. I'm still at the start and looking for
documentation and related projects.

If you'd be willing to share with me your stuff, it wouldn't need to be
polished, and I'd be glad to help out polishing it.

Of main interest to me would be of course your solution for the Universe
driver, if it isn't proprietary to your firm/lab/organisation.

With kind regards,
Oliver Korpilla
CS student
University of Applied Sciences at Landshut

*Hi Everybody,
*
*Everything is now running on my mvme5500 board : linux-2.4.20 + motorolla
*patches + rtai 2.4.18 patches our local universe driver with a few
*modifications After a setpci in order to have a sufficent pci window for
*the tundra windows (Thanks to Ajit Prem) everythings works.
*
*We have setup a test crate with irq at 500 Hz. The irq handler write to
*the VME only after 4.3 microseconds. The only bigger value is about 6/7
*microseconds due to caching effects.
*
*I will put order in the driver code before putting the sources on the web
*(mixed code from 2300/5100 with the one for the 5500 board).
*
*xavier


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
