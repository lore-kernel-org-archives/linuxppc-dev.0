Date: Thu, 20 Sep 2001 09:35:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Josh Huber <huber@alum.wpi.edu>
Cc: Dan Malek <dan@mvista.com>,
	Stefan Roese <stefan.roese@esd-electronics.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
Subject: Re: CPCI-405 port (PPC405GP)
Message-ID: <20010920093511.I13721@cpe-24-221-152-185.az.sprintbbd.net>
References: <3BA8DF9E.FD235CF6@mvista.com> <20010919155742.D8132@cpe-24-221-152-185.az.sprintbbd.net> <3BA9241B.4322817A@mvista.com> <20010919163101.E8132@cpe-24-221-152-185.az.sprintbbd.net> <3BA96CA2.20EC30C8@mvista.com> <871yl1zz4j.fsf@mclinux.com> <3BAA0DCC.122CE6CB@mvista.com> <87sndhyhw1.fsf@mclinux.com> <20010920090733.G13721@cpe-24-221-152-185.az.sprintbbd.net> <87k7ytygaf.fsf@mclinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87k7ytygaf.fsf@mclinux.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 20, 2001 at 12:32:08PM -0400, Josh Huber wrote:
> Tom Rini <trini@kernel.crashing.org> writes:
>
> > But the bi_recs in 2.5 won't look like 2.4.current.
>
> bummer...can it not be changed in a compatible manner?

Not really.  In 2.4 we toss the bi_recs near the end of the kernel+BSS,
i _think_.  In 2.5 we want r<3 or 4 or so> to be a pointer to where
they are.  This is why we've been waiting until 2.5, we want to break
compatibility.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
