Message-Id: <200009231657.SAA00670@piglet.grunz.lu>
Date: Sat, 23 Sep 2000 18:57:35 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: bootvars problems
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

Anybody in the audience who could recompile bootvars for MacOS?

It currently seems to have a limitation on the size of the nvramrc
field, and I'm not even sure if Apple's default contents of nvramrc on
my box fits into that size. But for sure, the OF 1.0.5 patches don't fit
anymore.

Which means that once I've booted to MacOS (nvram reset), I need to
BootX once, reset the nvram to my values in Linux, and from then on I'm
back to normal, direct booting with quik.

Not catastrophic, but annoying...
Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
