To: "Michael Meriin" <Michael@KSWaves.com>
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: SPI Driver for 8xx 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 11 Sep 2002 10:27:39 +0200."
             <058a01c2596d$171cb5a0$450fa8c0@amitesting>
Date: Wed, 11 Sep 2002 09:48:33 +0200
Message-Id: <20020911074838.8927EFA8B@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Michael,

in message <058a01c2596d$171cb5a0$450fa8c0@amitesting> you wrote:
>
> I am looking for SPI driver for 8xx custom board.
> Does anybody have such driver? If yes, how can I pick it up?

We have two versions of SPI drivers for the 8xx in our kernel source:

arch/ppc/8xx_io/cpm_spi.*	is a plain simple SPI driver for the
                                MPC8xx

arch/ppc/8xx_io/lwmon_spi.c     contains a more complicated, but very
                                specialized SPI driver, which might
				give you some ideas if you want to do
				tricky things

See http://www.denx.de/re/linux.html for instructions how to get  the
kernel source from our CVS server.

Hope this helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You Earth people glorified organized violence  for  forty  centuries.
But you imprison those who employ it privately.
	-- Spock, "Dagger of the Mind", stardate 2715.1

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
