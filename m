From: bigmouth@pionet.net
Message-Id: <200104162315.SAA24595@mail1.pionet.net>
Subject: LinuxPPC and interrupt assignment of non-mac cards (adaptec 3950U2W)
To: linuxppc-dev-digest@lists.linuxppc.org
Content-type: text/plain
Mime-version: 1.0
Date: Mon, 16 Apr 2001 18:15 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Well, I seem to have opened up a big can of worms for a kernel/device driver novice.  Working on trying to get an adaptec 3940u2w card behaving on my G3 beige.  I know that the macos won't support this card in a million years, but I thought that linux would like it better.  It seems that the pci subsystem sees the card and identifies a memory address, but no IRQ.  A friend told me that all the irq information is taken from OF.  Is there no way for linux to say, "wait a minute, this has no IRQ.  Better get it one" to provide better support for non-mac cards?  Or does it already do that?  Here's the /proc/pci dump...

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Motorola MPC106 Grackle (rev 64).
      Fast devsel.  Fast back-to-back capable.  Master Capable.  No bursts.
  Bus  0, device  13, function  0:
    Ethernet controller: LiteOn Unknown device (rev 37).
      Vendor id=11ad. Device id=c115.
      Medium devsel.  Fast back-to-back capable.  IRQ 23.  Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
      I/O at 0xc00 [0xc01].
      Non-prefetchable 32 bit memory at 0x81800000 [0x81800000].
  Bus  0, device  14, function  0:
    SCSI storage controller: Adaptec AHA-3940U2 (rev 0).
      Medium devsel.  Fast back-to-back capable.  BIST capable.  Master Capable.  Latency=32.  Min Gnt=39.Max Lat=25.
      I/O at 0x800 [0x801].
      Non-prefetchable 64 bit memory at 0x81802000 [0x81802004].
  Bus  0, device  14, function  1:
    SCSI storage controller: Adaptec AHA-3940U2 (rev 0).
      Medium devsel.  Fast back-to-back capable.  BIST capable.  Master Capable.  Latency=32.  Min Gnt=39.Max Lat=25.
      I/O at 0x400 [0x401].
      Non-prefetchable 64 bit memory at 0x81801000 [0x81801004].
  Bus  0, device  16, function  0:
    Hot Swap Controller: Apple Unknown device (rev 1).
      Vendor id=106b. Device id=10.
      Medium devsel.  Master Capable.  Latency=32.
      Non-prefetchable 32 bit memory at 0xf3000000 [0xf3000000].
  Bus  0, device  18, function  0:
    VGA compatible controller: ATI Mach64 GT (Rage II) (rev 154).
      Medium devsel.  Fast back-to-back capable.  IRQ 22.  Master Capable.  Latency=32.  Min Gnt=8.
      Non-prefetchable 32 bit memory at 0x82000000 [0x82000000].
      I/O at 0x400 [0x401].


Please, any help would be great for me and the adaptec maintainer...

Sean


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
