Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 77276DE123
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 18:02:20 +1000 (EST)
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Date: Mon, 21 Apr 2008 10:02:06 +0200
References: <47FDEF9B.5000506@semihalf.com>
	<fa686aa40804181553q622b3c1fi7a302712abe79be1@mail.gmail.com>
	<4809DF54.2080609@genesi-usa.com>
In-Reply-To: <4809DF54.2080609@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200804211002.07452.jbe@pengutronix.de>
Subject: Re: RFC: MPC5200 PSC AC97 driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matt,

On Saturday 19 April 2008 14:02, Matt Sealey wrote:
> Grant Likely wrote:
> > On Fri, Apr 18, 2008 at 12:11 PM, Matt Sealey <matt@genesi-usa.com> wro=
te:
> >>  Juergen Beisert wrote:
> >
> > BTW, is anyone trying to shepherd this driver into the ALSA tree?  Its
> > out of my area of expertise and responsibility, so I haven't been
> > pursuing it.
>
> We (well, I) were going to try but we got some oopses; from one thing or
> another, but with Juergen's fixes and cell-index in place, now it plays
> audio.
>
> Now it can be pushed to ALSA on that basis, but I'm still trying to get my
> head around where we need to throw patches and if it goes into ALSA Drive=
rs
> first or the kernel or both? It's kind of convoluted compared to the ease
> of just CC'ing netdev or linux-ide..

Please don't forget what Sylvian said about this driver: "I also completely=
=20
skipped the 5200 (not B) support ..." and your own "I think it should be le=
ft=20
noted here that the CCR size changed from 16 bits to 32 bits from 5200 to=20
5200B in order to reduce confusion.". Its not solved yet. So any user of an=
=20
old MPC5200 will be surprised...

Juergen

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=C2=A0Pengutronix - Linux Solutions for Science and Industry
=C2=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=C2=A0 =C2=A0 =C2=A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
