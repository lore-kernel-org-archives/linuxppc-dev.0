Message-ID: <394DD724.D5E44BE0@student.ethz.ch>
Date: Mon, 19 Jun 2000 10:17:40 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Ani Joshi <ajoshi@shell.unixbox.com>
CC: linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: ATI Mach64 support in XFree86 4.0 update...
References: <Pine.LNX.4.10.10006181702190.22994-100000@shell.unixbox.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[I 'forward' this to debian-powerpc as well]

Ani Joshi wrote:
>
> Since there have been many people asking about mach64 support int xfree
> 4.0 I figured I might as well give you all the status of the driver.
>
> I am almost done with 'porting' the ATI driver to ppc and so far its
> working quite well.  While I'm not completely finished with all the
> acceleration, what is completed are:  ScreenToScreen blits, rect fills,
> sold lines, and 8x8 mono pattern fills.

Sounds like the most important stuff is there :)


> Unfortunately due to some binary driver incompatibilities between current
> xfree86 cvs and Jack Howarth's 4.0-stock rpms, the driver seems to not
> work with his rpms.  Luckily, the next xfree86 release is around the
> corner so once that happens I will merge the driver and put up a
> compatibile release.

If you happen to have a 4.0b version of the driver (what version is the one in
your FTP dir?), I'd be happy to make it available for people to test with my
experimental tarballs.

Does the driver use/need FBDev? Does it need PCI patches on some machines?


> For those interested in the driver's development, I will be placing info
> and binary snapshots (xfree liscence prohibits me from releasing source),
> at:
>
> ftp://devel.linuxppc.org/users/ajoshi/xf4
>
> Here you will find x11perf results comparison between the driver and
> Xpmac, a bootlog of the driver, and some other various things i throw up
> there.
>
> ani


Michel


--
0 and 1. Now what could be so hard about that?
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
