From: "dong in kang" <dkang@east.isi.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: devfs with ramdisk problem
Date: Wed, 5 May 2004 13:16:02 -0400
Message-ID: <000001c432c4$a4b23de0$45a97241@Yongkoo>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <OFB11061F4.41BFEA1B-ON85256E8B.005920D7-85256E8B.00594340@nanometrics.ca>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 I've had trouble with ramdisk with devfs.
I've used the Linux Linux v.2.4.22 for months on a custom PPC board.
I frequently changed the kernel and the content of the ramdisk.
Sometimes, booting fails with the following error messages.
--------- error messages -------
RAMDISK: Compressed image found at block 0
RAMDISK: nblocks = 0
RAMDISK: crd_load, kmalloc(4096, 496)
Freeing initrd memory: 5204k freed
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
VFS: Cannot open root device "rd/0" or 00:00
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 00:00
--------- end of error messages ---------
When it happens, sometimes I could make it work with the same kernel and
ramdisk but with different kernel configuration (esp. turning on/off
debugging flags of Kernel hacking menu).
However, now it keeps failing.

 Can anybody help me?

The RAMDISK size is 30M, the memory of the system is 128M, and the size of
zImage.initrd is about 7M. And the kernel command line is:
mem=128M load_ramdisk= 1 ramdisk_size=30720 console=ttyS0,57600
root=/dev/rd/0 init=/bin/sh


 Thanks,

 Dong-In


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
