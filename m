Date: Wed, 12 Feb 2003 22:21:35 -0600
From: "William A. Gatliff" <bgat@billgatliff.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: PCI: Cannot allocate resource region {012}
Message-ID: <20030212222135.A7769@saturn.billgatliff.com>
Reply-To: bgat@billgatliff.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Guys:


I'm porting 2.4.20 to a custom MPC8245 system, based loosely on code
from MV's 2.4.19, in particular the mpc10x.c.

When my kernel boots, I see these:

PCI: Cannot allocate resource region 0 of device 00:02.0
PCI: Cannot allocate resource region 1 of device 00:02.0
PCI: Cannot allocate resource region 2 of device 00:02.0
...
PCI: Cannot allocate resource region 0 of device 00:1f.0
PCI: Cannot allocate resource region 1 of device 00:1f.0
PCI: Cannot allocate resource region 2 of device 00:1f.0


I have two PCI slots, plus an onboard eepro100.

After the kernel boots, my /proc/pci has this:

PCI devices found:
  Bus  0, device   0, function  0:
    Class 0600: PCI device 1057:0006 (rev 18).
      Prefetchable 32 bit memory at 0x0 [0xffffffff].
      Non-prefetchable 32 bit memory at 0x0 [0xfff].
      Prefetchable 32 bit memory at 0x0 [0xffffffff].
  Bus  0, device   1, function  0:
    Class 0200: PCI device 8086:1209 (rev 9).
      Master Capable.  Latency=128.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xbf87f000 [0xbf87ffff].
      I/O at 0xbff840 [0xbff87f].
      Non-prefetchable 32 bit memory at 0xbf840000 [0xbf85ffff].
  Bus  0, device   2, function  0:
    Class 0200: PCI device 8086:1209 (rev 9).
      Master Capable.  Latency=128.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0x80000000 [0x80000fff].
      I/O at 0x1000 [0x103f].
      Non-prefetchable 32 bit memory at 0x80020000 [0x8003ffff].
...
  Bus  0, device  31, function  0:
    Class 0200: PCI device 8086:1209 (rev 9).
      Master Capable.  Latency=128.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0x8001d000 [0x8001dfff].
      I/O at 0x2c40 [0x2c7f].
      Non-prefetchable 32 bit memory at 0x803c0000 [0x803dffff].


I'm no PCI expert, by far, and I'm not a well-versed PPC hacker
either.  (Oh, and simply cutting in mpc10x.c from mv's stuff was
probably a bad idea, too, but I had my reasons).  Can someone tell me
what's going on, and how to fix it?


Thanks!


b.g.
--
Bill Gatliff
http://billgatliff.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
