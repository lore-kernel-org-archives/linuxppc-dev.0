Message-ID: <3A8DB870.B10DA7A2@opersys.com>
From: Karim Yaghmour <karym@opersys.com>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ltrace for ppc
References: <20010216210927.A9F26DBA2E@atlas.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Date: Fri, 16 Feb 2001 18:29:16 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:
>
> > If you're interested in ltrace, you may want to take a look at the
> > Linux trace toolkit (http://www.opersys.com/LTT). It runs fine
> > on PPC too.
>
> I'm *very* interested in any toolkit that can provide point-to-point
> _timing_ of system calls, IRQ handling, system usage. latency etc. etc. (a
> la TIMEPEGS or Andrew Morton's amlat on x86).

LTT will definitely give all this and more. It will give you IRQ timings
precise down to the microsecond, same with system calls and any latency.
The measurements it gives are exact, not sampled. Everything you get
corresponds exactly to what happened on your hardware down to the microsecond.
It runs fine on my PowerBook. Give a try and let me know what you think.

>
> what do we have (existing) on PPC?
>
> I did an IRQ latency thing on 2.2.x and Cort has proposed using RTlinux to
> make IRQ measurements (well, I think he's done it, actually)...  that will
> give headlines - but not tell us which drivers/functions are the rouges.

LTT will give you the breakdown of how Linux reacts to each IRQ and it is
extendable. Therefore, if you'd like to insert additional trace points in a
driver or another or even an uninstrumented part of the kernel, you'll be able
to create new trace events and see them as part of the trace.

> I was considering doing a port of Andrew Morton's stuff - but got stuck when
> I tried to run with HZ=1024 - it trashed adb... and I haven't got back to it
> yet.

About Andrew Morton's stuff, any pointers?

Best regards,

Karim

===================================================
                 Karim Yaghmour
               karym@opersys.com
          Operating System Consultant
 (Linux kernel, real-time and distributed systems)
===================================================

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
