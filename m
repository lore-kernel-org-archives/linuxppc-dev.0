Message-ID: <20020524235414.36023.qmail@web11508.mail.yahoo.com>
Date: Fri, 24 May 2002 16:54:14 -0700 (PDT)
From: Khai Trinh <kqtrinh@yahoo.com>
Subject: Re: in_ntoa built error
To: Matt Porter <porter@cox.net>
Cc: Dan Kegel <dkegel@ixiacom.com>,
	"'linuxppc-embedded@lists.linuxppc.org '" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20020524164039.A21633@home.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


But Matt, if I turn on CONFIG_BLK_DEV_INITRD or
CONFIG_ROOT_NFS, the code will fail to build with
built error in in_ntoa as I stated earlier. Dan
suggested I replaced it with NIPQUAD. Did he mean
in_ntoa or inet_ntoa?

Regards,
--Khai

--- Matt Porter <porter@cox.net> wrote:
>
> On Fri, May 24, 2002 at 04:03:59PM -0700, Khai Trinh
> wrote:
> >
> > By the way, the snippet of the failing log of the
> > kernel when it was downloading are captured below:
>
> <snip>
>
> > NET4: Unix domain sockets 1.0/SMP for Linux
> NET4.0.
> >
> > kmod: failed to exec /sbin/modprobe -s -k
> > block-major-22, errno = 2
> >
> > VFS: Cannot open root device "" or 16:01
> >
> > Please append a correct "root=" boot option
> >
> > Kernel panic: VFS: Unable to mount root fs on
> 16:01
>
> This is normal behavior for your configuration.  On
> the ebony
> port, the default ROOT_DEV is 16:01 (/dev/hda1) if
> you
> don't have CONFIG_BLK_DEV_INITRD or CONFIG_ROOT_NFS
> configured.  You can even see kmod trying to load
> an ide driver for you.
>
> With CONFIG_ROOT_NFS enabled, it will attempt to
> root from 00:ff,
> the nfs pseudo root device.
>
> Regards,
> --
> Matt Porter
> porter@cox.net
> This is Linux Country. On a quiet night, you can
> hear Windows reboot.
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
