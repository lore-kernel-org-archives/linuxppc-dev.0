Message-ID: <3A6C9BED.8E960844@matrox.com>
Date: Mon, 22 Jan 2001 15:45:33 -0500
From: Sébastien Côté <scote1@matrox.com>
MIME-Version: 1.0
To: Kyle Harris <kharris@nexus-tech.net>
CC: LinuxPPC-embedded list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: initrd problems
References: <3A671191.A0254C18@matrox.com> <3A676DC6.FD21D5D8@matrox.com> <20010118130139.A5256@cx258813-a.chnd1.az.home.com> <3A6877E3.AA2238C2@matrox.com> <20010120073535.A15536@beef.az.mvista.com> <3A6C8248.88642C68@matrox.com> <3A6C88D1.39BC0E9E@nexus-tech.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kyle Harris wrote:
>
> Sébastien Côté wrote:
> > Ok, now this is exactly what I do.  The initrd doesn't get overwritten
> > anymore.  The function mount_root is called, the root device is opened
> > but I get a panic at:
> >
> >         sb = get_super(ROOT_DEV);
> >         if (sb) { goto mount_it}
> >         ...
> >
> >         read_unlock(&file_systems_lock);
> >         panic("VFS: Unable to mount root fs on %s", kdevname(ROOT_DEV));
>
> You'll also get this error if your kernel has not been built with
> support for the filesystem (e.g. ext2) contained on your initrd.

Unfortunately, that's not the problem.  I get the same error if I point
r4 (initrd_start) to an invalid value so I guess the problem must be
with initrd.  Maybe initrd_start shouldn't be 0 when I get to that
point, now I just need to find why it changed!


Thanks anyway,

Sébastien Côté

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
