Message-ID: <3A6C88D1.39BC0E9E@nexus-tech.net>
Date: Mon, 22 Jan 2001 14:24:01 -0500
From: Kyle Harris <kharris@nexus-tech.net>
MIME-Version: 1.0
CC: LinuxPPC-embedded list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: initrd problems
References: <3A671191.A0254C18@matrox.com> <3A676DC6.FD21D5D8@matrox.com> <20010118130139.A5256@cx258813-a.chnd1.az.home.com> <3A6877E3.AA2238C2@matrox.com> <20010120073535.A15536@beef.az.mvista.com> <3A6C8248.88642C68@matrox.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sébastien Côté wrote:
> Ok, now this is exactly what I do.  The initrd doesn't get overwritten
> anymore.  The function mount_root is called, the root device is opened
> but I get a panic at:
>
>         sb = get_super(ROOT_DEV);
>         if (sb) { goto mount_it}
>         ...
>
>         read_unlock(&file_systems_lock);
>         panic("VFS: Unable to mount root fs on %s", kdevname(ROOT_DEV));

You'll also get this error if your kernel has not been built with
support for the filesystem (e.g. ext2) contained on your initrd.

Good luck, Kyle.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
