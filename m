Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Stephan Linke" <Stephan.Linke@epygi.de>
To: <wd@denx.de>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: problems running I2C and/or SPI on 857 board 
Date: Tue, 26 Mar 2002 11:03:47 +0100
Message-ID: <FCEAKDJJAPHPLJFINDAJEENDCDAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20020325131107.8D3B6109F3@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At the moment all my tries are based on the existing drivers in PPCBOOT.
Using no microcode patch, and DPRAM allocation.
DPRAM allocation pointed out a bug so I guess it's not that well tested yet
:( .
Trying fixed DPRAM offsets and microcode now...

Thanks, Stephan

> -----Original Message-----
> From: wd@denx.de [mailto:wd@denx.de]
> Sent: Montag, 25. März 2002 14:11
> To: Stephan Linke
> Cc: Linuxppc-Embedded
> Subject: Re: problems running I2C and/or SPI on 857 board
>
>
> In message <FCEAKDJJAPHPLJFINDAJCEMMCDAA.Stephan.Linke@epygi.de>
> you wrote:
> >
> > I'm trying to get I2C and/or SPI running on a 857 board.
> Register settings
> > and BDs look good. But when the start command is issued nearly nothing
> > happens as if there would be no clock.
>
> I guess your implementation is basedon existing code? Which one?
> [Hint: we have I2C running on a couple of systems...]
>
> > Is there anyone who has an idea?
>
> Start from some code that is known to work?
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> The existence of god implies a violation of causality.
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
