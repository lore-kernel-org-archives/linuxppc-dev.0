To: Tom Rini <trini@kernel.crashing.org>
Cc: "Mark A. Greer" <mgreer@mvista.com>,
	linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 19 Mar 2002 16:58:15 MST."
             <20020319235815.GU3762@opus.bloom.county>
Date: Wed, 20 Mar 2002 01:24:27 +0100
Message-Id: <20020320002432.336DD109F3@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20020319235815.GU3762@opus.bloom.county> you wrote:
>
> > The systems I see shipping in the next 6 months or so will  be  based
> > on 2.4 kernel; I think we should define this feature rather sooner or
> > later to try it out and get it right.
>
> Yes, but the place to work on things isn't 2.4, it's 2.5.

OK. Then stop all efforts on 2.4 _now_ ???

> > The command line is pretty limited in leght, and there are many  more
> > "interesting"  things  you want to pass to proprietary drivers etc. I
> > rather had common stuff like this somewhere else...
>
> Yes, but the question isn't what we'd rather do, it's what we need to do
> for right now, and what we need to do for the future.  This does make
> sense for the future, but not for right now.

We are changing the interface from bd_info to bi_recs.

We had the baudrate in  bd_info,  and  nobody  complained.  I'm  just
asking  to preserve the current state with as minimal changes visible
to the user as possible.

It is _you_ who is trying to start some cleanup removing things  that
have "always" been there!


> Right NOW we have something which works for most of the problems.  What
> Mark is talking about would be adding in a few more defines to
> include/asm-ppc/bootinfo.h and using them.  Not sort-of implementing
> what's been talked about and then do something better later.

If we replace  bd_info  now,  we  should  keep  all  the  entries  it
provided, right?


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I used to be indecisive, now I'm not sure.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
