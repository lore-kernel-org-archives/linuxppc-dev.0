To: Dan Malek <dan@mvista.com>
Cc: Cindy Peters <cinpet@adaptivemicro.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCMCIA/IDE transfer rates 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 15 Aug 2001 15:45:40 EDT."
             <3B7AD164.790DD47A@mvista.com>
Date: Wed, 15 Aug 2001 22:01:51 +0200
Message-Id: <20010815200156.0291810CBA@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3B7AD164.790DD47A@mvista.com> you wrote:
> Wolfgang Denk wrote:
>
> > Seeker 1...Seeker 2...Seeker 3...start 'em...done...done...done...
> >               -------Sequential Output-------- ---Sequential Input-- --Random--
> >               -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
> > Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
> > MPC823E   250   534 90.4  3028 68.6  1533 64.4   542 97.6  3316 94.5  45.2  4.5
> >
> > Note that this is a normal 2.5" disk drive usually used in laptops  -
> > quite  slow.
>
> Well, actually quite respectable for PIO.  I'm not sure my G4 runs
> much faster in PIO mode :-).

Well, it's a 823-E (big caches) running at 66 MHz (both CPU  and  bus
clock). I have slower systems (like MPC850), too :-(

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The world is no nursery.                              - Sigmund Freud

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
