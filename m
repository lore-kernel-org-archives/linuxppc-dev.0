Message-ID: <397C11D7.51A7DBAB@student.ethz.ch>
Date: Mon, 24 Jul 2000 11:52:23 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel build headers [was: Re: problems about __cli()]
References: <200007240811.JAA05417@hyperion.valhalla.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:

> [root@athena stable-dma-int]# make vmlinux
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o
> scripts/split-include scripts/split-include.c
> In file included from /usr/include/errno.h:36,
>                  from scripts/split-include.c:26:
> /usr/include/bits/errno.h:25: linux/errno.h: No such file or directory
>
> On 2.4.0-test4 (just to see if the build script makes *any* difference):
>
> [root@athena linux-2.4.0-t4-wrk]# make vmlinux
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o
> scripts/split-include scripts/split-include.c
> In file included from /usr/include/errno.h:36,
>                  from scripts/split-include.c:26:
> /usr/include/bits/errno.h:25: linux/errno.h: No such file or directory

You are lacking the glibc header files. On my Debian potato system I have:

> dpkg -S linux/errno.h
libc6-dev: /usr/include/linux/errno.h


Michel


--
What do you mean, my birth certificate expired?
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
