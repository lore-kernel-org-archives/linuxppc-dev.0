Message-ID: <3A422A2D.C5B4A8F1@nexus-tech.net>
Date: Thu, 21 Dec 2000 11:05:01 -0500
From: Kyle Harris <kharris@nexus-tech.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Software Emulation error
References: <200012211548.eBLFmJ727210@denx.local.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:
>
> Dear Kyle,
>
> in message <3A42057C.6449819F@nexus-tech.net> you wrote:
> >
> > Sorry, I guess more detailed info would be helpful. I'm running a 2.2.13
> > kernel on a TQM823 board. I have seen this error when using dd to write
> > to flash. But it's not consistent (sometimes dd works, sometimes it
> > doesn't). Then I wrote a program using the times() function and it
> > always fails. I went back and tried this with the original kernel and it
> > works! I recompiled with and without MATH_EMULATION, but essentially get
>
> Be careful what your running where - if you use  the  old  glibc-1.99
> based  tools  which  assume to have a FPU, you MUST run a kernel with
> MATH_EMULATION. If you use the CDK to  compile  you  own  stuff  with
> glibc-2.x  you  MUST  use  -msoft-float  (in  fact  that's enabled by
> default in the CDK).
>

This is a little too wierd. I recompiled with -msoft-float and sure
enough the application runs. I then recompiled w/o -msoft-float and
guess what? It still runs. I had also discovered earlier that it would
run under gdb, but not from the shell. I wonder if I might be having a
hardware problem.

Thanks for you help. Kyle.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
