Subject: Re: Bizarre initrd problem on CLLF860T
To: erammsu@kieraypc01.p.y.ki.era.ericsson.se (Marcus Sundberg)
Date: Mon, 17 Apr 2000 18:42:15 +1000 (EST)
Cc: greyham@research.canon.com.au (Graham Stoney),
        linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
In-Reply-To: <kfyvh1hp23n.fsf@kieraypc01.p.y.ki.era.ericsson.se> from "Marcus Sundberg" at Apr 17, 2000 10:23:56 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000417084215.B8A5B3C980@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marcus Sundberg writes:
> > RAMDISK: Compressed image found at block 0
> > VFS: Mounted root (ext2 filesystem)
> > VFS: Cannot open root device 00:00
> > Kernel panic: VFS: Unable to mount root fs on 00:00
>
> Looks like the initrd is sucessfully mounted, then /linuxrc is either
> executed quietly or fails to be executed. In either case the bootup
> continues, and fails to mount the real root device because it is not
> set to anything useful.

Yes, but I'm confused as to why...

> How is your bootup supposed to work? If you want to use the initrd
> as the real root file system you should pass root=/dev/ram to
> the kernel.

I'm just trying to boot to a standalone shell; I have no /linuxrc in my initrd,
and I do want to use the initrd as the real root file system. Also, I have:

    Boot arguments: root=/dev/ram

So it looks to me as though it _should_ work; but why is it trying to remount
device 00:00?  The ramdisk is supposed to be 01:00.

Mucho confusedo,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
