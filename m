To: Steve Rossi <srossi@labs.mot.com>
Cc: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: high priority interrupts disabled 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 10 Dec 2001 12:04:16 CST."
             <3C14F91F.F382ABE3@labs.mot.com>
Date: Mon, 10 Dec 2001 19:38:06 +0100
Message-Id: <20011210183811.E0D6B10E11@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3C14F91F.F382ABE3@labs.mot.com> you wrote:
>
> Another observation that I've made is that the problem doesn't occur all the
> time, but it seems to be triggered when IRQ2 is asserted during IRQ6
> processing (or while IRQ6 is asserted). If IRQ6 really is being installed with
> SA_INTERRUPT, it would make sense that IRQ2 wouldn't get serviced until IRQ6
> completes, but IRQ6 completes over 120 times before IRQ2 is serviced - that
> doesn't make sense.

Maybe you can get more information using the Linux Trace Toolkit;  if
necessary,  add  some  custom  traces  in  the suspected areas of the
interrupt handlers. See http://www.opersys.com/LTT/index.html

Hope this helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
People are very flexible and learn to adjust to strange  surroundings
--  they can become accustomed to read Lisp and Fortran programs, for
example.   - Leon Sterling and Ehud Shapiro, Art of Prolog, MIT Press

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
