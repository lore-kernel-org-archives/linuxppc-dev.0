To: Dan Malek <dan@mvista.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Stefan Roese <stefan.roese@esd-electronics.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
Subject: Re: CPCI-405 port (PPC405GP)
References: <20010918115722.A5967@cpe-24-221-152-185.az.sprintbbd.net>
	<EFEAIMDCOOOHIEPHDNFJCEKKDCAA.stefan.roese@esd-electronics.com>
	<20010919071751.B8132@cpe-24-221-152-185.az.sprintbbd.net>
	<3BA8DF9E.FD235CF6@mvista.com>
	<20010919155742.D8132@cpe-24-221-152-185.az.sprintbbd.net>
	<3BA9241B.4322817A@mvista.com>
	<20010919163101.E8132@cpe-24-221-152-185.az.sprintbbd.net>
	<3BA96CA2.20EC30C8@mvista.com>
From: Josh Huber <huber@alum.wpi.edu>
Date: Thu, 20 Sep 2001 10:59:56 -0400
In-Reply-To: <3BA96CA2.20EC30C8@mvista.com> (Dan Malek's message of "Thu, 20
 Sep 2001 00:12:18 -0400")
Message-ID: <871yl1zz4j.fsf@mclinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek <dan@mvista.com> writes:

> No, let's not.  All of this stuff is on the way out.  We should be
> making modifications so the embedded boards support bi_recs....  All
> you are doing is inventing a new way to do the same thing that has
> always worked.  Yes, you are _way_ over engineering.

I'm seriously considering adding this support to ppcboot soon.  I
should discuss this on the ppcboot list fisrt, to make sure no one
else is working on it first though.

I definately agree that bi_recs is the way to go...

--
Josh Huber

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
