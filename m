Date: Wed, 17 May 2000 12:49:06 -0400 (EDT)
From: Pavel Roskin <pavel_roskin@geocities.com>
To: Steve Rossi <srossi@ccrl.mot.com>
cc: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: more on e2fsck
In-Reply-To: <3922CB9E.873738B6@ccrl.mot.com>
Message-ID: <Pine.LNX.4.21.0005171245200.3357-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, Steve!

> is there possibly some disparity between the kernel's ext2 fs code and
> what
> mke2fs and e2fsck are doing? if anyone has any further thoughts on this
> I would appreciate it.

"ulimit -c unlimited" will enable coredumps. Note that "ulimit" is a bash
builtin. Then run on a PowerPC (or use a cross-debugger)
gdb e2fsck -core core
(gdb) where

You will need unstripped e2fsck. Try to figure out what's going on. Send a
bug report if you feel it's needed.

Regards,
Pavel Roskin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
