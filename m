To: Sébastien Côté <scote1@Matrox.COM>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Progress - new problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 12 Feb 2001 08:39:54 EST."
             <20010212083954.A768@dyn-52-73.matrox.com>
Date: Mon, 12 Feb 2001 14:52:25 +0100
Message-Id: <20010212135230.44A5D281D9@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Sébastien,

in message <20010212083954.A768@dyn-52-73.matrox.com> you wrote:
>
> > Oops? Why do you think this makes debugging more complicated? I don't
> > care where something is mapped, it's  the  job  of  the  debugger  to
> > resolve those addresses, isn't it?
>
> Yes, the debugger should do it but ours don't.  Also, I haven't found a way

Then convert it into a doorstop, and get a real debugger.

I strongly recommend the BDI2000  by  Abatron  (see  www.abatron.ch).
Send me a message when you want a quote for it.

> to tell it to load the kernel image at address 0 even if the linking was
> done for address 0xc0000000.  So I have to load the kernel with another

You can't specify any load offsets? Oh dear. Get a real debugger!

> > Are you really trying to run in little-endian mode? Really???
> > You are not supposed to do that.
>
> Yes, really!  I don't see why I shouldn't do that.  The kernel itself seems
> to be running fine (no panic, it goes to the scheduler).  My only problem
> right now is to load executables and I'm not sure it's endian related.

Be assured that this will not remain the only problem. From all I know,
the PowerPC version of Linux is a big-endian kernel by design.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Visit us at Embedded Systems: Feb 14-16 2001, Nuremberg, Halle 12/K01
(with TQ Components); our presentation "Starke Zwerge: Embedded Linux
auf PowerPC-Systemen" on Thursday, Feb 15 2001, 13:30 Forum Halle 11.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
