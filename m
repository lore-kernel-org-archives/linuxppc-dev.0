Message-ID: <3A9BDC55.FCD90F9A@ipno.in2p3.fr>
Date: Tue, 27 Feb 2001 17:56:53 +0100
From: xav <grave@ipno.in2p3.fr>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Cc: paubert@iram.es
Subject: Problem requesting IRQ with 2.4.2 kernel
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

I'm using a clone of the bk tree to compile a 2.4.2 kernel.
I have also downloaded the code from Gabriel Paubert for the
pci2vme chip from TUNDRA.

Before with a 2.4.0 kernel I succesfully inmod the code.
But know I have the following error :
Unable to grab interrupt 16 for VME !
Trying to free free IRQ16

And if I have a look at /proc/pci I have the following :
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Motorola Raven (rev 5).
      IRQ 16.
      I/O at 0x0 [0xffffffff].
      Non-prefetchable 32 bit memory at 0xfc000000 [0xfc03ffff].
  Bus  0, device  11, function  0:
    ISA bridge: Symphony Labs W83C553 (rev 16).
      IRQ 16.
  Bus  0, device  11, function  1:
    IDE interface: Symphony Labs SL82c105 (rev 5).
      IRQ 16.
      Master Capable.  No bursts.  Min Gnt=2.Max Lat=40.
      I/O at 0xffffff0 [0xffffff7].
      I/O at 0xfffffec [0xfffffef].
      I/O at 0xfffffe0 [0xfffffe7].
      I/O at 0xfffffdc [0xfffffdf].
      I/O at 0xfffffc0 [0xfffffcf].
      I/O at 0xfffffb0 [0xfffffbf].
  Bus  0, device  13, function  0:
    Bridge: Tundra Semiconductor Corp. CA91C042 [Universe]
(rev1).
      IRQ 16.
      Master Capable.  No bursts.  Min Gnt=3.
      Non-prefetchable 32 bit memory at 0xeffef000 [0xeffeffff].
      I/O at 0xfffe000 [0xfffefff].


How can avoid all this pci board to have the same IRQ ?
Is this an openPic related problem ?

O+ xavier

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
