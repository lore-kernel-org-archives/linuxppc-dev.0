Message-ID: <39CDB6CD.62FE8595@PsychiatryKills.com>
Date: Sun, 24 Sep 2000 03:09:50 -0500
From: Carl Potter <carl@PsychiatryKills.com>
Reply-To: carl@PsychiatryKills.com
MIME-Version: 1.0
To: bh40@calva.net
CC: mpalczew@u.washington.edu, linuxppc-dev@lists.linuxppc.org,
        elliptical@linuxstart.com
Subject: new iBook and booting.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello Ben,

I thought I'd be slick and buy one of the new and improved 466MHz
iBooks (NOT Key Lime :) that Apple released a couple of weeks ago
....and put Linux on it.  Well I've studied and searched my hiney off
over the past week and for the life of me I just can't get YDL or
LinuxPPC 2K to boot when 'append = "video=atyXXX"' is used (I've tried
both atyfb and aty128fb).  I'm getting very close to being certain that
it's the newness of my iBook that's stopping me.  I have broken down and
decided to bother you with what might be a valid issue with the new
iBooks.  Here's some info on the factors involved:


Yaboot version 0.8

open firmware prompt says:  Apple PowerBook2,2 3.3f3 BootROM built on
08/10/00 at 14:42:10
                            Copyright 1994-2000 Apple Computer, Inc.
                            All Rights Reserved.


observed phenomenon when booting:  (using either 2.2.17pre20-ben3 or
Mike Palczewski's iBook kernel) with append="video=aty(anything)" on
either YDL 1.2 or LinuxPPC 2000:

Welcome to Linux, kernel 2.2.17pre20-ben3

started at       :  0x01000000
linked at        :  0xc0000000
frame buffer at  :  0x96008000 (phys), 0x96008000 (log)
MSR              :  0x00003030
HID0             :  0xc010c0a4
ICTC             :  0x00000000

booting...
device tree used 37444 bytes
Total memory = 64MB; using 256kB for hash table (at c02c0000)
Linux version 2.2.17pre20-ben3 (benh@sawtooth.wanadoo.fr) (gcc version
2.95.3 19991030
(prerelease/franzo/20000625)) #2 Wed Sep 6 01:14:01 CEST 2000
PCI bus 0 controlled by pci at f0000000
PCI bus 0 controlled by pci at f2000000
PCI bus 0 controlled by pci at f4000000
Uni-N revision: 8, KeyLargo revision: 3
Registered 1 features controllers(s)
PMU driver initialized for Core99
pmac nvram is core99: 1
PowerMac using OpenPIC irq controller
OpenPIC Version 1.2 (4 CPUs and 64 IRQ sources) at 80040000
GMT Delta read from XPRAM: -300 minutes, DST: on
via_calibrate_decr: decrementer_count = 166440 (998641 ticks)
Console: colour dummy device 80x25


This is the point where the screen freezes, leaving the above message
perfectly readable, yet the kernel continues to boot normally and mounts
the drive.  I then have to blind-type my username, password, and issue a
"shutdown -r now".

Any light you might shed on this would be very appreciated.  I think
Linux on PPC is great stuff and I thank you for making possible what we
can already do with it.

Take care,

Carl Potter


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
