Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <8D4C69676E66D511A1CB00508BBBB1921BCEF9@ranmx1.ran.harris.com>
From: "Walser, Martin" <mwalser@harris.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: unable to uncompess kernel image
Date: Tue, 5 Feb 2002 09:56:34 -0500 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I've successfully developed a kernel which mounts over nfs.
Now I want to make a zImage.initrd. To do so, I've first made a ramdisk.image.gz
and copied it to /arch/ppc/mbxboot.
Then I made make zImage.initrd.
After that, I've used mkimage to encapsulate /arch/ppc/mbxboot/zvmlinux.initrd
to boot it with ppcboot.

When ppcboot starts booting, the following message is shown:

## Booting image at 00100000 ...
   Image Name:   2.4.4 for initrd on COM660
   Created:      2002-02-05  14:37:47 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    888587 Bytes = 867 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... Error: Bad gzipped data
GUNZIP ERROR - must RESET board to recover

Any ideas?

regards
Martin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
