Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <37EAC7E0.3AE82656@ctam.com.au>
Date: Fri, 24 Sep 1999 10:37:53 +1000
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
To: sébastien tadéoni <sebastien_tadeoni@yahoo.fr>
CC: linux ppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Questions on the MPC8xx-2.3.10 realease.
References: <19990923150552.23602.rocketmail@web601.yahoomail.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


sébastien tadéoni wrote:

> Hi PPCpeople;
>
> I worked recently on the mpc8xx-2.3.10 sources, and I
> had less problem for compilation than with the 2.2.5
> release, but it stays some 'undefined reference to
> :kbd_pt_regs, fg_console, no_scroll.....'.
>
> I think it is a configuration problem, but I don't
> find any solution (and I wonder if I will find the
> good configuration one day). I noticed like Brendan
> that some parameter are configured even if you didn't
> want.
> I edited the autoconf.h but no really changes.

Dan suggests (look at the mailing list archives) that linux-2.3.18.tgz
is what you should use instead of mpc8xx-2.3.10.tgz.  He also suggested
that he might remove the mpc8xx-2.3.10.tgz archive and I think that
would be a good idea if it has problems compiling or has some confusing
elements.  Since it is a bleeding edge release you must expect
problems.  I have reverted back to the embedded-2.2.5.tgz archive for my
port.  It compiles fine with the right options.  I would probably
recommend the 2.2.5 stuff for first timers (like me) as this is the most
stable version and there are apparently lots of MPC8xx boards using this
kernel.


> According to Dan, it seems to be tooo difficult to
> cross compile on a host pentium machine (I begin to be
> mainly agree with him),so I'm going to obtain a
> powermac station.
>
> However I would like to know before if someone has
> already succeeded to build a zImage or zImage.initrd
> configured for a MPC860 MBX board on a host pentium
> (II 400) station?

I have had no problems compiling the kernel with the x86->ppc
cross-compiler, though I would still love to have a PowerPC machine
instead of an x86.  The only problems I had have been choosing the right
configuration options.  Once you have sorted this out you should be
fine.  Have you installed a x86-ppc cross-compiler ?  I can help you if
you are having problems with it (building the compiler or using it to
compile the kernel).  Note that any questions on building an i86->ppc
cross-compiler should be sent to the crossgcc mailing list.  See
http://www.objsw.com for FAQ and subscription details.  I am using
egcs-1.1.2 and there is a prebuilt egcs-1.1.1 cross-compiler available
from the LinuxPPC web pages.

Brendan Simon.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
