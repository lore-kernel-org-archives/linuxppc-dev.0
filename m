To: Josh Huber <huber@alum.wpi.edu>
Cc: Tom Rini <trini@kernel.crashing.org>, Dan Malek <dan@mvista.com>,
	Stefan Roese <stefan.roese@esd-electronics.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: CPCI-405 port (PPC405GP) 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 20 Sep 2001 12:32:08 EDT."
             <87k7ytygaf.fsf@mclinux.com>
Date: Sun, 23 Sep 2001 20:00:07 +0200
Message-Id: <20010923180012.755801009E@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <87k7ytygaf.fsf@mclinux.com> Josh Huber wrote:
> Tom Rini <trini@kernel.crashing.org> writes:
>
> > But the bi_recs in 2.5 won't look like 2.4.current.
>
> bummer...can it not be changed in a compatible manner?

Where can I get more information what it will look like in  2.5?  I'd
like to be able to have PPCBoot prepared for this change, and ideally
in  a way that provides a soft migration from current kernel versions
to the new stuff.

Keep in mind that PPCBoot is in use for 50+ boards from  many  diffe-
rent hardware manufacturers. And the number is growing every week.


Or is there even a discussion of this stuff where one  can  at  least
inject  ideas  or point out thinks that might cause problems - BEFORE
everything is cast in stone?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Time is an illusion perpetrated by the manufacturers of space.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
