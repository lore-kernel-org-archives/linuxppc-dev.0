Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id A8D10DDDF7
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 20:42:44 +1000 (EST)
From: "Joakim Tjernlund" <Joakim.Tjernlund@transmode.se>
To: "'David Brownell'" <david-b@pacbell.net>,
	"'Andrew Morton'" <akpm@linux-foundation.org>
References: <200804301537.07965.david-b@pacbell.net>
	<20080430154631.b86797de.akpm@linux-foundation.org>
	<200804301555.34110.david-b@pacbell.net>
In-Reply-To: <200804301555.34110.david-b@pacbell.net>
Subject: RE: [patch 2.6.25-git] spi_mpc83xx much improved driver
Date: Thu, 1 May 2008 12:42:01 +0200
Message-ID: <010301c8ab77$fd8d8f70$f8a8ae50$@Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: spi-devel-general@lists.sourceforge.net, 12o3l@tiscali.nl,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: David Brownell [mailto:david-b@pacbell.net]
> Sent: den 1 maj 2008 00:56
> To: Andrew Morton
> Cc: spi-devel-general@lists.sourceforge.net; =
joakim.tjernlund@transmode.se; linuxppc-dev@ozlabs.org;
> 12o3l@tiscali.nl
> Subject: Re: [patch 2.6.25-git] spi_mpc83xx much improved driver
>=20
> On Wednesday 30 April 2008, Andrew Morton wrote:
> > > +=A0=A0=A0=A0=A0spin_lock_irq(&mpc83xx_spi->lock);
> >
> > irq-safe.
> >
> > > ...
> > >
> > > +=A0=A0=A0=A0=A0spin_lock(&mpc83xx_spi->lock);
> >
> > not irq-safe.
> >
> > Deliberate?
>=20
> That latter one is inside an #if 0/#endif block, so it won't matter.
> The #if 0 block bothered me.  Maybe Joakim can remove it.

The non irq-safe spin_lock was there before my patch and now it is
removed with the #if 0/#endif block. I don't need this code but
I left it there disabled to make it clear for everyone else
that it was removed. I can remove it but I rather leave it
there for one release so everyone will have a chance to see
it and object if they feel differently.

>=20
> (By the way, I'd feel safer about this patch if there were an
> ack or two from more PPC folk...)

 Yeah, that would be good.

 Jocke
