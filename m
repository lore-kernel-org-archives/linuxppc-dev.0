From: ghannon@cspi.com
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <85256B5F.00553845.00@pine.cspi.com>
Date: Wed, 13 Feb 2002 11:30:32 -0500
Subject: MVME5100 booting from SCSI disk
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm trying to find documentation on getting a Motorola 5100 board to boot
from a
hard drive.    What I spefically am wondering is do I need a "boot loader",
or is that
built into the kernel?

I can build a kernel (2.4.11) which works and until now have been using a
ROMFS, built into
zImage.initrd.pplus.  I am currently able to netboot or boot from flash.

I am thinking I can rebuild this kernel root=/dev/sda7 and I should be able
to get it
to use the hard drive as /.  My question is can I just put that new kernel
on a
bootable partition on the hard drive and get PPCbug to boot from that
partition, or do I need
some form of a bootloader?  (yaboot, lilo, other)    I do realize I should
be able to
flash this kernel and then have the board boot from flash and use the drive
as /.
Is this the more common approach?

If there is a good write up on this I would be glad to read about it, I
just haven't found it yet.
I do have the PPCbug manuals.

Thanks,
Gary Hannon
CSPI


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
