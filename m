Message-Id: <sddccfb6.046@mail.frequentis.com>
Date: Thu, 21 Nov 2002 12:20:51 +0100
From: "Gerhard TAEUBL" <Gerhard.TAEUBL@frequentis.com>
To: <linuxppc-embedded@lists.linuxppc.org>,
	<flavio.pereira@za.flextronics.com>
Subject: Re: Cramfs root file system
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi!

First try root=/dev/mtdblock3 rw.

I try a long time ago this with my 'flashdisk' I copied at runtime all needed files, and reload the kernel (I use the comandline as fixcoded string..) and it works. Important is, that the kernel supports your filesystem at boottime! I think it isn't a good idea to use it as module!

Have fun
Gerhard

>>> "Flavio Pereira" <flavio.pereira@za.flextronics.com> 11/21/02 12:09pm >>>

Hi All

Im trying to use a cramfs image as a root-file system at kernel boot
time.

I've built a cramfs image, copied it into my flash device (mtd3), and
can successfully mount it at runtime.

However at boot time I use root=dev/mtdblock3 (or dev/mtd3 im not sure
which one to use) and I get the following errors...

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
request_module[block-major-2]: Root fs not mounted
VFS: Cannot open root device "mtdblock3" or 02:00
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 02:00

Now, is it possible to do what Im trying to do, if so are there any
suggestions as to what I'm doing wrong?

Thanks
Flavio Pereira


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
