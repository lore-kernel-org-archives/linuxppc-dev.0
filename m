Message-ID: <388809E5.619D80C9@huawei.com.cn>
Date: Fri, 21 Jan 2000 15:25:25 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
To: kd@flaga.is
CC: jim Lewis <jlewis@mvista.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: gdbserver
References: <OFFF644F53.7F60D0CE-ON0025684E.0050176B@flaga.is>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>




kd@flaga.is wrote:

> Hi,
>
> I am trying to get gdbserver to run on my mpc823 board. (The precompiled
> gdbserver is not working for me, it does not seem to get argc and argv
> correctly into main() and always terminates with "usage info".
>
> Using the vanilla gdb-4.18 is of no use, since it has not support for ppc.
> Using the gdbserver source that Dan posted here a few weeks back results in
> the
> the following undefined symbols,
> PTRACE_POKEUSR
> PTRACE_PEEKUSR
> KERNEL_U_ADDR
> when compiling low-linux.c

Now I have the same problem. Have you solved it? I downloaded gdbserver.tar.gz
form Dan's web site and put it in the gdb-4.17 's tree
(gdb-4.17/gdb/gdbserver)which are copied from the SRC RPM on the LinuxPPC CD.

If I enter this directory , then type "make", an error occurs:
    make:***No rule to make target '../config/powerpc/linux.mt',needed by
Makefile.Stop
Yes, ../config/powerpc doesn't have file "linux.mt".I don't how to modify
Makefile.

Also I find that there are three symbol link files nm.h , tm.h and xm.h which
are pointed to nm-linux.h , tm-linux.h, and xm-linux.h in ../config/powerpc
respectively. But nm-linux.h and tm.linux.h don't exist , only xm-linux.h
exists in ../config/powerpc.
How do you solve all the above problems?
Thank you very much.
dony


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
