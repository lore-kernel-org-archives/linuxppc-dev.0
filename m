Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <059501c25971$606eb600$450fa8c0@amitesting>
From: "Michael Meriin" <Michael@KSWaves.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
References: <20020911074838.8927EFA8B@denx.denx.de>
Subject: Re: SPI Driver for 8xx 
Date: Wed, 11 Sep 2002 10:58:20 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Wolfgang,

Thank you very much for your quick response.
But I failed to get to : http://www.denx.de/re/linux.html :((
I will be happy to get both drivers, because I have to control several SPI
devices
and therefore the driver must be complicated ;))

Best Regards,
                     Michael Meriin



----- Original Message -----
From: "Wolfgang Denk" <wd@denx.de>
To: "Michael Meriin" <Michael@KSWaves.com>
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, September 11, 2002 09:48
Subject: Re: SPI Driver for 8xx


> Dear Michael,
>
> in message <058a01c2596d$171cb5a0$450fa8c0@amitesting> you wrote:
> >
> > I am looking for SPI driver for 8xx custom board.
> > Does anybody have such driver? If yes, how can I pick it up?
>
> We have two versions of SPI drivers for the 8xx in our kernel source:
>
> arch/ppc/8xx_io/cpm_spi.* is a plain simple SPI driver for the
>                                 MPC8xx
>
> arch/ppc/8xx_io/lwmon_spi.c     contains a more complicated, but very
>                                 specialized SPI driver, which might
> give you some ideas if you want to do
> tricky things
>
> See http://www.denx.de/re/linux.html for instructions how to get  the
> kernel source from our CVS server.
>
> Hope this helps,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> You Earth people glorified organized violence  for  forty  centuries.
> But you imprison those who employ it privately.
> -- Spock, "Dagger of the Mind", stardate 2715.1


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
