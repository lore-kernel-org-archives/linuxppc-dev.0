Message-ID: <38F3F9B9.9DB92F87@worldnet.att.net>
Date: Tue, 11 Apr 2000 21:21:13 -0700
From: Logan Hall <warrior514@worldnet.att.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.3.99-pre5 compile problems
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi-
I just downloaded the 2.3.99-pre5 kernel in hopes of getting my
/dev/mixer working.  This is on a G3 beige tower.  It apears to have
problems with the dma sound for ppc.  here is the error:

dmasound_core.c: In function `dmasound_init':
dmasound_core.c:1196: `irq_installed' undeclared (first use in this
function)

So far 2.3.99-pre3 has worked well for me.  It has alowed me to use my
usb trackball and my entrega 4 port usb pci card, but my ethernet no
longer works, and my /dev/mixer apears broken as all sound come out
faint from the internal speaker and not from the av monitors speakers.
I have tried several mixer apps and they all fail with errors relating
to /dev/mixer.  This worked in 2.2.14.  Also as for the etherent, it
apears from the kernel routeing table and the boot mesages that the
ethernet is recongized and set up but the link light on the hub never
lights up and no data can be transfered, this too worked in 2.2.14.  Any
ideas if 2.3.99-pre5 will fix either of these issues.  I am encouraged
by the fact that the sound driver has been changed sence pre3 so I hope
this will help my sound.  Thanks.
--

----
Logan Hall

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
