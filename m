Subject: Re: Problems in the kernel for EP8260 Board.
From: Seb James <seb@peak.uklinux.net>
To: deepesh@india.tejasnetworks.com
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <1057294269.3f0507bd27111@pop-mail.india.tejasnetworks.com>
References: <1057294269.3f0507bd27111@pop-mail.india.tejasnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1057510536.3992.22.camel@darius.hypercube>
Mime-Version: 1.0
Date: 06 Jul 2003 17:55:37 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2003-12-31 at 00:00, deepesh@india.tejasnetworks.com wrote:
> Hi,
>
>   I am having an EP8260 Board. And the linux I am using is from TimeSys.
> I made a gzipped ramdisk.image.gz. Following are the last few lines
> before the board hung.
>
> TCP: Hash tables configured (established 128 bind 210)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> RAMDISK: Compressed image found at block 0
> Freeing initrd memory: 4389k freed
> EXT2-fs warning: checktime reached, running e2fsck is recommended
> VFS: Mounted root (ext2 filesystem).
> Mounted devfs on /äv
> Root-NFS: No NFS server available, giving up.

You're trying to mount your root filesystem for the target over a
network and you need to set up a host to serve out the target's root
filesystem using NFS.

> VFS: Unable to mount root fs via NFS, trying floppy.
> modprobe: modprobe: Can't open dependencies file
> /lib/modules/2.4.7-timesys-3.1.180/modules.dep
> (N
> )
>
> Thank you,
> Deepesh
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
