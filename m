Date: Fri, 10 Dec 1999 16:00:13 -0800 (PST)
From: Brad Midgley <brad@turbolinux.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: dual framebuffers on bronze pb?
Message-ID: <Pine.LNX.4.10.9912101551180.3945-100000@web1.turbolinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi,

i was excited to try getting two framebuffers to show up using this
powerbook but it doesn't work.

on this machine, linux will drive exactly one video device. if an external
monitor or tv out cable is connected, that is the device linux tries to
drive. (with the tv out it fails to drive it correctly).

the boot messages show up this way, regardless of what is or isn't
connected:

MacOS display is /pci/ATY,LTProParent/ATY,264LTProA
atyfb: 3D RAGE LT PRO [0x4c49 rev 0xdc] 8M SDRAM, 29.498928 MHz XTAL, 230
MHz PLL, 100 Mhz MCLK
Console: switching to colour frame buffer device 128x48
fb0: ATY Mach64 frame buffer device on /pci/ATY,LTProParent

Evidently, this powerbook uses a specialized video chip that can drive two
outputs... is it feasible to use it that way?

Brad
brad@turbolinux.com | http://www.turbolinux.com/~brad/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
