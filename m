Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3B71157C.D09ED71@yahoo.com>
Date: Wed, 08 Aug 2001 16:03:32 +0530
From: Kapil Konde <kapilkk@yahoo.com>
MIME-Version: 1.0
To: linuxppclist <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Installing rtlinux on mpc860 board
References: <20010807130305.B735610CB8@denx.denx.de> <3B711266.B722A774@yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorry, I found that I had invalid link in my usr/src.

However when I do a meke xconfig I do not see any option like "RTLinux kernel
extension" in platform support.

Thanks and regards,
Kapil

Kapil Konde wrote:

> Hi,
>         Thanks for reply. I downloaded the rtlinux kernel you suggested and
> patched it from your ftp site. After I configured it and tried to do "make
> dep"  it gave me error  "llinux/limits.h no such file or directory" in
> scripts/mkdep.c . I have extracted the sources in my home directory. Is it
> necessry that I should extract it under /usr/src/linux or I am missing
> something.
>         Also I am a littlebit confused about what machine type I should
> select for my mdppro board.
>
> Thanks and regards,
> Kapil.
>
> Wolfgang Denk wrote:
>
> > In message <3B6FE359.29C966C5@yahoo.com> you wrote:
> > >
> > >         I am new to rtlinux. I want to install rtlinux on mpc860 board.
> > > I have a mpc860T mdppro board. Can somebody guide me on which rtlinux I
> > > should use and what are the steps that I will require to perform to
> > > install the rtlinux on board.
> >
> > We have a patch for RTLinux-3.0 on our  FTP  server,  as  well  as  a
> > kernel  that is known to work with this patch (there are other, newer
> > kernel versions as well, but these might need a little work  adapting
> > the  patch).  Included  with  the  patch  comes  a `README.DENX' with
> > detailed description of the patch and installation procedure.
> >
> > Please note that there is also  a  patch  for  RTAI-24.1.4.  We  will
> > maintain  RTAI  support  in  the  future,  but  may (or may not) drop
> > support for RTLinux (no technical reasons, just because of the patent
> > issue).
> >
> > Please see:
> > ftp://ftp.denx.de/pub/LinuxPPC/usr/src/linux-2.4.4-2001-05-12.tar.bz2
> > ftp://ftp.denx.de/pub/LinuxPPC/usr/src/rtlinux-3.0-denx.tar.bz2
> > ftp://ftp.denx.de/pub/LinuxPPC/usr/src/rtai-24.1.4-denx.tar.bz2
> > and maybe:
> > ftp://ftp.denx.de/pub/LinuxPPC/usr/src/linux-2.4.4-2001-07-23.tar.bz2
> >
> > Hope this helps,
> >
> > Wolfgang Denk
> >
> > --
> > Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> > Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> > Weekends were made for programming.                 - Karl Lehenbauer


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
