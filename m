Message-ID: <313680C9A886D511A06000204840E1CF08F42FF9@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>
Cc: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: FW: How reliable Linux 2.6 is on PowerPC platform at this poi
	nt ?
Date: Tue, 13 Jul 2004 05:22:22 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Benjamin,

Thanks for replying.

I would als like to ask you another (perhaps not specifically PPC related,
but rather Real Time/Embedded ...
but that is what PPC arch is typically used for ... ;-) ) question...

The idea has to do with the existant (prior to port, aka "legacy") PSOS RTOS
application (running on Power PC board) - particularly evaluating such
"legacy application in terms of its latency sensitivity and thus attempting
to "predict"
whether "vanilla" free-source Linux introduces unacceptable (for the legacy
application to be ported) latencies, due to Linux's (even version 2.6 ?)
higher degree of non-deterministic behavior (comparing with PSOS).

The thought (behind the idea) is that increasing the clock tick period from
10 ms (to some greater value) on PSOS RTOS will be approximately
"equivalent" to behaviour of Linux, which presumably operates at higher
latencies than PSOS (in overall) - due to the fact that even if Linux 2.6
kernel preemptive option is configured, there is still lots of kernel
critical processing, which is not preemptive ...

Couple more details - justifying in my view that increasing the clock tick
period from 10 ms (to some greater value) on PSOS RTOS will "simulate" the
Linux behavior ...

Obviously PSOS kernel (to some degree identically to what happens in Linux
at the clock tick time) uses clock tick time for (re)scheduling. However,
(in my understang - please correct me I am wrong in my assumption re what
happens in Linux at clock time), PSOS does "more" deterministic scheduling
at the clock tick time - comparing with what happens in Linux, (even in
Linux 2.6).
In my (current) understanding (in Linux, 2.6 included ?), though the kernel
timer and other kernel services (like tasklets) are processed during this
interrupt - this processing (especially as far as handling tasklets is
concerned) means "putting" "new" tasklet's functions into the "delayed
queue" (to be executed at "some non-guaranted" time "later") and "try" (just
try, again no guarantee ...) to execute some of "outstanding" "old"
tasklet's functions
from the "delayed queue" ?

Am I correct ?

Thanks,
Best Regards,
Alex Povolotsky


-----Original Message-----
From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
Sent: Friday, July 09, 2004 11:09 AM
To: Povolotsky, Alexander
Cc: 'linuxppc-dev@lists.linuxppc.org'
Subject: Re: FW: How reliable Linux 2.6 is on PowerPC platform at this
point ?


On Fri, 2004-07-09 at 04:30, Povolotsky, Alexander wrote:
> Hi,
>
> Any takers ?

Should be as reliable as x86 by now ;)

Ben.

> TIA,
> Best Regards,
> Alex Povolotsky
>
> -----Original Message-----
> From: Andrew Morton [mailto:akpm@osdl.org]
> Sent: Friday, July 09, 2004 5:27 AM
> To: Povolotsky, Alexander
> Subject: Re: How reliable Linux 2.6 is on PowerPC platform at this point?
>
> "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com> wrote:
> >
> > Hi Andrew,
> >
> > How reliable Linux 2.6 is on PowerPC platform at this point ?
>
> I suspect it's good if you pick the right release, but I am very much not
> the right person to ask, sorry.
>
> I suggest you ask the folks on linuxppc-dev@lists.linuxppc.org
>
--
Benjamin Herrenschmidt <benh@kernel.crashing.org>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
** This list is shutting down 7/24/2004.
