From: Brian Waite <waite@skycomputers.com>
To: Linux PPC <linuxppc-dev@lists.linuxppc.org>
Subject: Platform support for db64360
Date: Wed, 6 Aug 2003 13:58:17 -0400
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200308061358.17279.waite@skycomputers.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




Hi all,
        There have been a few threads about support for the db64360 Evaluation
board.
I have been using the _devel tree for a while now with a port from the
_galileo tree. I have also put together the MPSC driver and support for
u-boot. Here is a rundown of the known working things:
I've tried to break down the patches into logical order for readability. Let
me know if I can make it any better.

Dink32 bootloader (may need to move around CPU mappings in db64360.h)
uBoot bootloader
PCI/PCI-X
Gigabit Ethernet
Duart serial port
MPSC as uart
Internal SRAM
HW cache coherency
SW cache coherency
SMP (untested by me)

I realized that I can't post the patches here as they are large and are
getting rejected. What is the best way to get them out to people and into the
linuxppc_2_4_devel tree? Sorry for the noise.

Thanks
Brian


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
