Message-ID: <3AF1A6C9.9B0F05DF@sgi.com>
Date: Thu, 03 May 2001 13:43:21 -0500
From: Steven Hein <ssh@sgi.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: booting from cramfs in flash
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


My cramfs adventure continues.....

Okay, so I have a cramfs filesystem image creaed created.
Now, how do I tell the kernel to boot using that filesystem
when the filesystem is an image in flash?

Maybe I'm on the wrong path, but my previous setup used a compressed
kernel and gzip'ed ext2 filesystem as an initial ramdisk, which
also served as my permanent filesystem.   So I thought I should
be able to just replace my old initrd with my new cramfs image,
tell the kernel where it is (in flash), and it would go.

But, that's not the case for me so far. If I pass the address in
flash of my cramfs image as the initrd_start
and initrd_end (in R3/R4, the kernel craps out because it can't reuse
the pages where I told it that the initrd lives).

So,how do I make this connection?  Or, do I still need an ext2
initrd like I used before?  If so, then how do I mount the CRAMFS
filesystem that is an image sitting flash?

Any help is greatly appreciated!

Steve


--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Steve Hein (ssh@sgi.com)              Engineering Diagnostics/Software
Silicon Graphics, Inc.
1168 Industrial Blvd.                 Phone: (715) 726-8410
Chippewa Falls, WI 54729              Fax:   (715) 726-6715
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
