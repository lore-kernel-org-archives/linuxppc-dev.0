MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: Cramfs root file system
Date: Thu, 21 Nov 2002 13:09:35 +0200
Message-ID: <7899847F7C05BE43A0687AD18D97DA2207F285@srv_mail.azisa.co.za>
From: "Flavio Pereira" <flavio.pereira@za.flextronics.com>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
