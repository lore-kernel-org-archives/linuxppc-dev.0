Date: Wed, 18 Jul 2001 21:28:08 -0500 (CDT)
From: Grant Erickson <erick205@umn.edu>
To: linuxppc-embedded@lists.linuxppc.org
Subject: PCI-to-PCMCIA/CardBus, Hardhat Linux 2.4.2, and the 405GP
Message-Id: <Pine.SOL.4.20.0107182123580.21428-100000@garnet.tc.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am attempting to get a SanDisk or IBM MicroDrive CardFlash interface
device working with a Walnut (IBM 405GP Rev. D) platforms and am using
MontaVista's 2.4.2-mvista_010329 Linux kernel to do so. The PCI-to-CardBus
adapter is a TI1420.

Are there any tricks or pitfalls to get this working? I haven't been too
wildly successful yet using either compiled in or module-based drivers.

Also, the PCMCIA-HOWTO seems fairly explicit that a PCMCIA IDE/ATA drive
such as the IBM MicroDrive or SanDisk cannot be used as a boot device (but
can be used as a root device w/ initrd). Has anyone out there done
otherwise (i.e. built-in drivers, no initrd, w/ a simple root=/dev/hda)?

ANY insight would be greatly appreciated.


--
 Grant Erickson                       University of Minnesota Alumni
  o mail:erick205@umn.edu                                 1996 BSEE
  o http://www.umn.edu/~erick205                          1998 MSEE


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
