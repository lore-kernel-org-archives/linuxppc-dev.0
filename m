Message-ID: <20030706212206.49489.qmail@web41509.mail.yahoo.com>
Date: Sun, 6 Jul 2003 14:22:06 -0700 (PDT)
From: bhupinder sahran <bhup_sah@yahoo.com>
Subject: Re: Problems in the kernel for EP8260 Board.
To: deepesh@india.tejasnetworks.com,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <1057294269.3f0507bd27111@pop-mail.india.tejasnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi
1.Pass the parameter root=/dev/ram0 from the boot
loader.
2. Disable the support for NFS in kernel.

U may have the success

Bhupi
www.gdatech.com


--- deepesh@india.tejasnetworks.com wrote:
>
> Hi,
>
>   I am having an EP8260 Board. And the linux I am
> using is from TimeSys.
> I made a gzipped ramdisk.image.gz. Following are the
> last few lines
> before the board hung.
>
> TCP: Hash tables configured (established 128 bind
> 210)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> RAMDISK: Compressed image found at block 0
> Freeing initrd memory: 4389k freed
> EXT2-fs warning: checktime reached, running e2fsck
> is recommended
> VFS: Mounted root (ext2 filesystem).
> Mounted devfs on /äv
> Root-NFS: No NFS server available, giving up.
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
