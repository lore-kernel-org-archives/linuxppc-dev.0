Date: Sat, 26 Jun 1999 14:22:18 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Kazunori Aoshima <aoshimak@mail.cc.tohoku.ac.jp>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [Q] PowerStack installimage
In-Reply-To: <199906261814.DAA03596@mail.cc.tohoku.ac.jp>
Message-ID: <Pine.LNX.3.96LJ1.1b7.990626140212.13697C-100000@selq119.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 27 Jun 1999, Kazunori Aoshima wrote:

> Hi.
> 
> Now I make kernel and bootimages for R5.
> I compiled kernel-2.2.1 with prep_fb.patch, and 
> I would like to add zImage to "Linux1999installer.bin" as a 
> "ramdisk.image.gz".

I don't think "Linux1999installer.bin" is a gzipped file.  It is probably
a MacBinary file which contains BootX and such for Mac OS based install.

There is an image file for prep:
ftp://ftp.linuxppc.org/linuxppc-pre-R5/install/PREP-CHRP-BeBox/PREP.install.image

If you need to boot via floppy disks for installation, you can perhaps try
the ramdisk.image.gz at ftp://ppc.linux.or.jp/pub/users/toe/install-R5/.
I made this RAM disk because it was very hard to fit both the kernel image
and installer binaries into a single floppy disk.  To use this, put the
ramdisk.image.gz into arch/ppc/boot/ directory in the kernel source tree,
and try "make zImage.initrd" to create a bootable file.  The README file
at the install-R5 directory might help somehow.


Takashi Oe


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
