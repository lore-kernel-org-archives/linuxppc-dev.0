Date: Thu, 11 Jan 2001 15:43:25 -0600
From: erik cameron <cameron@dura.spc.uchicago.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: '99 powerbook (lombard)/xfree 4.0.x
Message-ID: <20010111154325.D2651@ccp.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


has anyone tested (successfully) xfree86 4 with a '99 powerbook g3,
specifically using the r128 driver?  i've been having all sorts of
problems with it, and there seems to be a dearth of information on this
hardware/software combination.  i've tried 4.0.1 and 4.0.2, both from
packages and from source, and i've tried several of the r128_drv.o files.
this, from /var/log/XFree86.0.log, seems important:

(--) PCI: (0:17:0) ATI Mach64 LI rev 220, Mem @ 0x81000000/24, 0x80881000/12, I/O @ 0x0c00/8

this shows up during the pci scan.  i'm assuming that the only problem
is getting the x server to recognize the card as a rage 128...  have any
of you seen this?

this is the final result:

(II) ATI: ATI driver (version 6.2.3) for chipsets: ati
(II) R128: Driver for ATI Rage 128 chipsets: ATI Rage 128 RE (PCI),
        ATI Rage 128 RF (AGP), ATI Rage 128 RG (AGP), ATI Rage 128 RK (PCI),
        ATI Rage 128 RL (AGP), ATI Rage 128 Pro PF (AGP), ATI Rage 128 PR,
        ATI Rage 128 Mobility LE (PCI), ATI Rage 128 Mobility LF (AGP),
        ATI Rage 128 Mobility MF (AGP), ATI Rage 128 Mobility ML (AGP)
(II) RADEON: Driver for ATI Radeon chipsets: ATI Radeon QD (AGP),
        ATI Radeon QE (AGP), ATI Radeon QF (AGP), ATI Radeon QG (AGP)
(EE) No devices detected.

relevant info:
'99 (lombard) powerbook g3
ati rage 128 3d lt pro
kernel version 2.2.18pre21
debian 2.2
using atyfb console driver

thanks.


--
erik cameron
unix systems administrator
center for computational psychology
university of chicago

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
