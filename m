Date: Wed, 19 May 1999 15:30:00 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Andreas Bogk <andreas@andreas.org>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.3.3 compile error on ppc
In-Reply-To: <m31zgd0w4t.fsf@soma.andreas.org>
Message-ID: <Pine.LNX.4.05.9905191522510.8961-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 19 May 1999, Andreas Bogk wrote:

> 
> Hollis R Blanchard <hollis+@andrew.cmu.edu> writes:
> 
> > be broken for us for a little. Were you having problems with 2.2.x?
> 
> There is a problem with 2.2.9, and here's the patch:
> 
> diff -r -u linux-2.2.9/arch/ppc/kernel/syscalls.c linux/arch/ppc/kernel/syscalls.c
> --- linux-2.2.9/arch/ppc/kernel/syscalls.c	Sat May  8 20:14:01 1999
> +++ linux/arch/ppc/kernel/syscalls.c	Wed May 19 18:36:23 1999
> @@ -30,6 +30,7 @@
>  #include <linux/shm.h>
>  #include <linux/stat.h>
>  #include <linux/mman.h>
> +#include <linux/file.h>
>  #include <linux/sys.h>
>  #include <linux/ipc.h>
>  #include <linux/utsname.h>
> 
> I wonder why such trivial problems creep into so-called stable
> releases of the Linux kernel again and again.

Well.  This I assume is because this problem shows up only under certian
configs.  I just compiled a 2.2.9 w/o that patch(vger so it might be
possible something just missed a merge to linus).

> Does nobody care that on i386, you just go to ftp.kernel.org and
> download the latest version and it just works, whereas on PowerPC you
> have to find out:

2.2.0->2.2.8 compile fine.  Various 2.1.1xx's compile fine.  Considering
we haven't been around all that long (in an official manner, pmac wise),
it's not too bad.

> - what CVS is
> - what vger is
> - what CVS tags are
> - which tag the one is which gives you a stable version ?

The last two are only true because 2.3.x is now out.  The first two I'm
almost sure are in a FAQ by now.  x86 has it's own little neuances(sp)
too. (RH6 doesn't ship w/ a Linus kernel approved compiler anymore, I find
that funny, and don't tell me you've never had a problem w/ lilo).

> I don't care that the development kernel breaks on PPC. But that the
> official stable kernel breaks is a huge problem.

The official kernel releases are only ever checked on x86.  So sometimes
they'll be broken (not usually on a stable tree).

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
