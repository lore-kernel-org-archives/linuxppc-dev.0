To: Dan Malek <dan@mvista.com>
Cc: Josh Huber <huber@alum.wpi.edu>,
	Tom Rini <trini@kernel.crashing.org>,
	Stefan Roese <stefan.roese@esd-electronics.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: CPCI-405 port (PPC405GP) 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 24 Sep 2001 00:32:33 EDT."
             <3BAEB761.194CE057@mvista.com>
Date: Sat, 29 Sep 2001 09:53:46 +0200
Message-Id: <20010929075351.24C39100A2@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Dan,

in message <3BAEB761.194CE057@mvista.com> you wrote:
>
> > There are 50+ boards using the PPCBoot concept by now, and the number
> > is growing every week.
>
> Yeah, but there are lots more that don't use it, and people want to
> just pull those boards off the shelf and have those work as well.
> Quite frankly PPCboot is pretty good on 8xx, but not many of the other
> boards where people want to run Linux.

Just for the record: the last state I know of (I haven't looked into
this for about two weeks) is:

	8xx  - 32 boards
	8240 -  3 boards
	8260 -  7 boards
	74xx -  1 board
	4xx  -  9 boards

PPCBoot is more than just 8xx by today.

> Remember, PPCboot started from code I wrote long ago.  It doesn't
> look much like it anymore, but I still have a personal interest
> in it's success :-).

That's good to know.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Shakespeare's Law of Prototyping: (Hamlet III, iv, 156-160)
        O, throw away the worser part of it,
        And live the purer with the other half.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
