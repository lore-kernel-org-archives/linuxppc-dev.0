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
	<3BA96CA2.20EC30C8@mvista.com> <871yl1zz4j.fsf@mclinux.com>
	<3BAA0DCC.122CE6CB@mvista.com>
From: Josh Huber <huber@alum.wpi.edu>
Date: Thu, 20 Sep 2001 11:57:34 -0400
In-Reply-To: <3BAA0DCC.122CE6CB@mvista.com> (Dan Malek's message of "Thu, 20
 Sep 2001 11:39:56 -0400")
Message-ID: <87sndhyhw1.fsf@mclinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek <dan@mvista.com> writes:

> Why are you doing this?  Why can't you just use a standard zImage
> format and bootloader like all other systems use?  It just seems to
> me you are coding yourselves deeper into a hole where every little
> kernel interface change means a new boot rom.

Well, I was under the impression that the whole point of using bi_recs
was to avoid changes in the future.  Isn't that the point?  (a
consistant interface that's forward/backward compatible)

> I would suggest just creating a standard interface to calling an
> image and passing information.  Create a function in the
> embed_config.c to parse it, and call it a day......

It seems to me like a cleaner solution to have the bootloader
uncompress and pass information to the kernel directly...

--
Josh Huber

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
