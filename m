MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: cramfs root filesystem corruption
Date: Fri, 31 May 2002 08:39:32 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E31937F64@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
To: <pruhland@microwavedata.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Let me guess?

Are you updateing the cramfs on a running system, i.e. a system where the cramfs
is mounted somewhere?

K.D.

> -----Original Message-----
> From: Paul Ruhland [mailto:pruhland@microwavedata.com]
> Sent: 30. maí 2002 18:51
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: cramfs root filesystem corruption
>
>
>
> I've found a few posts similar to this from about a year back
> in the main
> kernel list but I could never follow the thread to any conclusion.
>
> I'm running a cramfs root filesystem on an 850 system,
> linux-2.4.4 ( from denx
> ).  Everything has been running fine but the cramfs
> filesystem has started
> behaving badly.
>
> The cramfs image is in flash, mounted as root via mtd blockdevice.
>
> Typically the error occurs during flash reprogramming ( using
> mtd char device
> '/dev/mtd0' ) ...during/after flash programming the cramfs
> filesystem 'loses'
> information ( files disappear ).  The errors from syslog are
> 'error during
> decompression', typically the error numbers ( from
> 'linux/zlib_fs.h' ) are
> Z_BUF_ERROR, for the first error,  and Z_DATA_ERROR for the
> rest.  I've got
> my BDI breaking at the uncompress error and the source length is huge:
>
> (gdb) frame 0
> #0  cramfs_uncompress_block (dst=0xc078c000, dstlen=4096,
> src=0xc0145ac0,
> srclen=4969176) at uncompress.c:49
>
> The reprogramming of the flash is successful, all new data
> has been written to
> the correct location(s).  The cramfs image ( root filesystem
> ) in flash is
> NOT corrupt.  A hard reboot and everything is fine.
>
> Has anyone seen such cramfs problem before?  I'm just looking
> to see if there
> is any 'known' problems before I get to far into debugging this thing.
>
> --
> Paul Ruhland
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
