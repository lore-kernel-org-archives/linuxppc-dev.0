Message-ID: <20000524150506.D9100@lx.c-side.com>
Date: Wed, 24 May 2000 15:05:06 -0700
From: Neil Russell <caret@c-side.com>
To: diekema_jon <diekema@bucks.si.com>
Cc: all@cideas.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Floating Point problems with Linux on the EST SBC8260
References: <20000524134257.A9100@lx.c-side.com> <m12uikI-001SyaC@bucks>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m12uikI-001SyaC@bucks>; from diekema_jon on Wed, May 24, 2000 at 05:31:18PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I ported 2.2.14 to the SBC8260 myself.  I did this because the 2.3 kernel
was unstable at the time I started.  I asked Dan for his work but we was
reluctant.

Initially, the kernel panic'ed trying to run init because the C library
uses the FPU by default (this is one of the reasons for the stuff Dan
did for the 860).  This problem was solved by upgrading the CPU to rev A.1,
which has a fully functioning FPU.

The first time I brought the kernel up I just used a /bin/sh, and no init.
The shell I used was statically linked (from /bin/ash.static I think).

I'm part way getting the SCC ethernet to work and fixing the way I do
bootinfo.  I'll look to making a patch after that (hopefully within a
week).

My development environment is a G3 blue and white MAC, running Linux 1999 Q3.
I compile the kernel native on that machine.  All applications that I
use are directly from that CD.  I make a RAM disk image that I download
to the board.  This RAM disk has very little in it.


Neil.




On Wed, May 24, 2000 at 05:41:12PM -0400, diekema_jon wrote:
> From: Neil Russell <caret@c-side.com>
>
> > I'm running 2.2.14 the SBC8260 and some other hardware.
>
> I wasn't aware of a MPC8260 Linux 2.2.x port.  Where did you get this
> source code?  Is this is something that you crafted yourself?  Are
> you able to run init without the kernel panicing?  If so, is it
> possible to get this source?
>
> If you haven't figured it out yet, we are struggling with Linux 2.3.99+.
>
>

On Wed, May 24, 2000 at 05:31:18PM -0400, diekema_jon wrote:
> >From caret@c-side.com (Neil Russell)
>
> > I tried this on my board.  I'm running 2.2.14 the SBC8260 and some other
> > hardware.  I ran the code you posted and it produced exactly the results
> > that it should have.
>
> What does your development/target environment look like?
>
> - What toolset are you using?
> - What is the toolset hosted on?
> - Are you using hard or soft floating point?
> - What are you using for a root file system?
>   Or, what distribution is being used for the root
>   file system?

--
Neil Russell <caret@c-side.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
