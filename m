Date: Thu, 24 Oct 2002 11:10:47 -0500 (CDT)
Message-Id: <200210241610.g9OGAan28995@postal.somerset.sps.mot.com>
From: Ed Swarthout <Ed.Swarthout@Motorola.com>
To: Franz.Sirl-ppc@lauterbach.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: RE: syscall register clobber list
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz wrote:
> I'm currently testing a more comprehensive patch, which I will
> submit soon (see the stuff in current glibc cvs to get a glimpse).

Great.

> Out of interest, what are you building that needs these macros?

Just defining __KERNEL_SYSCALLS__ and including linux/unistd.h
causes the errors.  linux/init/main.c does this.

Ed


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
