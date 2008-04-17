Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 74405DDE2A
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 01:23:48 +1000 (EST)
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Date: Thu, 17 Apr 2008 17:23:26 +0200
References: <47FDEF9B.5000506@semihalf.com>
	<200804171619.56615.jbe@pengutronix.de>
	<4807684C.4000508@genesi-usa.com>
In-Reply-To: <4807684C.4000508@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200804171723.27002.jbe@pengutronix.de>
Subject: Re: RFC: MPC5200 PSC AC97 driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 17 April 2008 17:10, Matt Sealey wrote:
> Juergen Beisert wrote:
> > Hi,
> > +	/* the fifo starts right after psc ends */
> > +	priv->fifo =3D (struct mpc52xx_psc_fifo*)&priv->psc[1];	/* FIXME */
>
> Wouldn't
>
> 	priv->fifo =3D (struct mpc52xx_psc_fifo*) (priv->psc + sizeof(struct
> mpc52xx_psc));
>
> Be a little less obtuse use of C?

"priv->psc" is of type "struct mpc52xx_ac97_priv*". If I add 0x58 to it,=20
wouldn't I add 0x58 times the size of "struct mpc52xx_ac97_priv"?

Juergen

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=C2=A0Pengutronix - Linux Solutions for Science and Industry
=C2=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=C2=A0 =C2=A0 =C2=A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
