Date: Thu, 2 Aug 2001 13:26:56 +0200 (DFT)
From: Arne Kovac <kovac@zeus.stat-math.uni-essen.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Again booting 43p-140
Message-ID: <Pine.A41.4.10.10108021316500.20690-100000@zeus.stat-math.uni-essen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I also tried to install Linux on the 43p-140. This is what I did:

1) Updated the firmware to the latest release.

2) Installed a GXT130P in Slot 1 (closest to the motherboard).

3) Copied a zImage from SuSEs FTP server:

ftp://ftp.suse.com/pub/suse/ppc/7.1/unsorted/prep/43p_140/zImage.140.chrp

on an msdos floppy.

4) Booted to the OpenFirmware prompt and typed

0> setenv real-base c00000
0> setenv load-base 200000
0> boot floppy:,\zImage root=/dev/fd0 load_ramdisk=1 ramdisk_size=128000

5) Now the 43p-140 loads from disk and writes several lines on the screen,
last one: "Checking the display". Then the screen is cleared and the
following text appears

Copying OF device tree .............................................. done
returning 00010000 from prom_init
IBM,7043-140: reprogramming the memory controller

6) Then nothing happens

Any idea what I can do?

Arne


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
