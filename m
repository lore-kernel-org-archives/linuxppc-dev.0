Date: Thu, 20 Sep 2001 09:07:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Josh Huber <huber@alum.wpi.edu>
Cc: Dan Malek <dan@mvista.com>,
	Stefan Roese <stefan.roese@esd-electronics.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
Subject: Re: CPCI-405 port (PPC405GP)
Message-ID: <20010920090733.G13721@cpe-24-221-152-185.az.sprintbbd.net>
References: <EFEAIMDCOOOHIEPHDNFJCEKKDCAA.stefan.roese@esd-electronics.com> <20010919071751.B8132@cpe-24-221-152-185.az.sprintbbd.net> <3BA8DF9E.FD235CF6@mvista.com> <20010919155742.D8132@cpe-24-221-152-185.az.sprintbbd.net> <3BA9241B.4322817A@mvista.com> <20010919163101.E8132@cpe-24-221-152-185.az.sprintbbd.net> <3BA96CA2.20EC30C8@mvista.com> <871yl1zz4j.fsf@mclinux.com> <3BAA0DCC.122CE6CB@mvista.com> <87sndhyhw1.fsf@mclinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87sndhyhw1.fsf@mclinux.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 20, 2001 at 11:57:34AM -0400, Josh Huber wrote:
> Dan Malek <dan@mvista.com> writes:
>
> > Why are you doing this?  Why can't you just use a standard zImage
> > format and bootloader like all other systems use?  It just seems to
> > me you are coding yourselves deeper into a hole where every little
> > kernel interface change means a new boot rom.
>
> Well, I was under the impression that the whole point of using bi_recs
> was to avoid changes in the future.  Isn't that the point?  (a
> consistant interface that's forward/backward compatible)

But the bi_recs in 2.5 won't look like 2.4.current.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
