Message-ID: <3A8D8F81.7BB25F04@opersys.com>
From: Karim Yaghmour <karym@opersys.com>
MIME-Version: 1.0
To: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
Cc: Anton Blanchard <anton@linuxcare.com.au>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: ltrace for ppc
References: <20010214081000.A28509@linuxcare.com> <20010215124800.A22625@drow.them.org>
Content-Type: text/plain; charset=us-ascii
Date: Fri, 16 Feb 2001 15:58:57 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


If you're interested in ltrace, you may want to take a look at the
Linux trace toolkit (http://www.opersys.com/LTT). It runs fine
on PPC too.

Best regards,

Karim

Daniel Jacobowitz wrote:
>
> On Wed, Feb 14, 2001 at 08:10:00AM +1100, Anton Blanchard wrote:
> >
> > Hi,
> >
> > ltrace is a cool little program for tracing library calls. I ported it
> > to ppclinux a while ago but the ltrace maintainer seems to have ignored
> > my patch.
> >
> > For anyone interested the patch can be found at:
> >
> > http://linuxcare.com.au/anton/patches/ltrace_ppc_patch
> >
> > It should apply cleanly to the latest source (I got mine from the debian
> > archive).
>
> You did?  Wow!  I spent ages trying to do this...
>
> Oh, looking at your patch I remember what happened.  It's a bloody
> miracle that ltrace works at all on any architecture; the PLT tricks
> that the PPC plays are not at all uncommon, as I recall.  I got
> derailed trying to make it insert breakpoints at the proper time.
>
> Thanks for the patch; I'll probably keep bugging the author about
> this...
>
> Dan
>
> /--------------------------------\  /--------------------------------\
> |       Daniel Jacobowitz        |__|        SCS Class of 2002       |
> |   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
> |         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
> \--------------------------------/  \--------------------------------/
>

--
===================================================
                 Karim Yaghmour
               karym@opersys.com
          Operating System Consultant
 (Linux kernel, real-time and distributed systems)
===================================================

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
