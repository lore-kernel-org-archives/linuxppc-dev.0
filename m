From: "Jon Erick Ween" <jween@som.llu.edu>
To: daenzerm@student.ethz.ch
Cc: linuxppc-dev@lists.linuxppc.org
Subject: compile problems with header includes
Date: Mon, 6 Nov 2000 13:53:58 -0800
Message-ID: <7737441D14ED.AAA1D34@som.llu.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:

> [root@athena stable-dma-int]# make vmlinux
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o
> scripts/split-include scripts/split-include.c
> In file included from /usr/include/errno.h:36,
>		   from scripts/split-include.c:26:
> /usr/include/bits/errno.h:25: linux/errno.h: No such file or directory
>
> On 2.4.0-test4 (just to see if the build script makes *any* difference):
>
> [root@athena linux-2.4.0-t4-wrk]# make vmlinux
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o
> scripts/split-include scripts/split-include.c
> In file included from /usr/include/errno.h:36,
>		   from scripts/split-include.c:26:
> /usr/include/bits/errno.h:25: linux/errno.h: No such file or directory

You are lacking the glibc header files. On my Debian potato system I have:

> dpkg -S linux/errno.h
libc6-dev: /usr/include/linux/errno.h

I've been having this same problem too, but DO have the header files
installed. Any idea of what else might be broken for gcc not to find the
header? (I use a linuxppc2K/redhat system).

Jon

Jon Erik Ween, MD
Cognitive and Cerebrovascular Neurology
Loma Linda University


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
