Message-ID: <3BAA0DCC.122CE6CB@mvista.com>
Date: Thu, 20 Sep 2001 11:39:56 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Josh Huber <huber@alum.wpi.edu>
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
		<3BA96CA2.20EC30C8@mvista.com> <871yl1zz4j.fsf@mclinux.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Josh Huber wrote:

> I'm seriously considering adding this support to ppcboot soon.

Why are you doing this?  Why can't you just use a standard zImage
format and bootloader like all other systems use?  It just seems
to me you are coding yourselves deeper into a hole where every
little kernel interface change means a new boot rom.

I would suggest just creating a standard interface to calling
an image and passing information.  Create a function in the
embed_config.c to parse it, and call it a day......


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
