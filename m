Message-ID: <37E3935C.720A5F60@wanadoo.fr>
Date: Sat, 18 Sep 1999 15:27:56 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
CC: Kazumitsu Hanai <hanai@koto.kpu-m.ac.jp>,
        linuxppc-user <linuxppc-user@lists.linuxppc.org>
Subject: Re: Ethernet Adapters that actually work!
References: <v04010502b4091b88b70c@koto.kpu-m.ac.jp>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kazumitsu Hanai wrote (not for the first time):

> All ethernet cards, the chipsets of which are DEC 21*4*, will work with tulip
> driver in LinuxPPC.  *BUT*, be careful, the tulip driver contained in the
> kernel
> source, even the latest, is very old, and this driver does not work in
> LinuxPPC
> at all.  You must download the latest tulip.c, or at least newer than v0.91

Is there a known reason why the kernel sources contain a stone-age
version of tulip.c? Is everyone supposed to use de4x5 instead or what?
(I can confirm that for my Farallon card with its DECchip 21041, both
de4x5 from the kernel sources and tulip.c:v0.91 from the site given by
Kazumitsu Hanai are working. The Neanderthal tulip.c from the kernel
sources doesn't).

>From the 2.3.18 kernel in drivers/net/tulip.c:

  static const char version[] = "tulip.c:v0.89H 5/23/98
becker@cesdis.gsfc.nasa.gov\n";

That's from the era of kernel version 2.1.103!

Even better is the "information" in Documentation/networking/tulip.txt:

  This driver is designed to work with PCI Ethernet
  cards which use the DECchip DC21x4x family. This driver hopefully
  works with all of 1.2.x and 1.3.x kernels, but I tested only
  with 1.2.13, 1.3.39, 1.3.49, 1.3.52, 1.3.57 and later.

Well, a little later it is honest enough to suggest

  So, if your card is not a 9332dst, please try the de4x5.c driver
first.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
