Return-Path: <sfr@canb.auug.org.au>
Date: Sat, 28 Oct 2006 10:27:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
Message-Id: <20061028102749.42c574f6.sfr@canb.auug.org.au>
In-Reply-To: <1161968926.2426.415.camel@cashmere.sps.mot.com>
References: <453FB582.20802@bplan-gmbh.de>
	<1161816783.22582.132.camel@localhost.localdomain>
	<45409760.7030902@bplan-gmbh.de>
	<1161866964.27827.2.camel@localhost.localdomain>
	<4540B0A9.6070404@bplan-gmbh.de>
	<528646bc0610260902o4d4996a4i3dcf2a9b874037c7@mail.gmail.com>
	<4541118F.60002@bplan-gmbh.de>
	<528646bc0610261300s3e93e53fk5732990089b68d35@mail.gmail.com>
	<1161919709.25682.61.camel@localhost.localdomain>
	<45421C97.80501@bplan-gmbh.de> <45421FFD.8070407@bplan-gmbh.de>
	<1161968926.2426.415.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__28_Oct_2006_10_27_49_+1000_hDfJrN4WPO0RGiVL"
Cc: akpm@osdl.org, sl@bplan-gmbh.de,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>,
	sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__28_Oct_2006_10_27_49_+1000_hDfJrN4WPO0RGiVL
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 27 Oct 2006 12:08:46 -0500 Jon Loeliger <jdl@freescale.com> wrote:
>
> On Fri, 2006-10-27 at 10:04, Nicolas DET wrote:
>
> > > diff -uprN a/include/asm-powerpc/mpc52xx.h b/include/asm-powerpc/mpc52xx.h
> > > --- a/include/asm-powerpc/mpc52xx.h	1970-01-01 01:00:00.000000000 +0100
> > > +++ b/include/asm-powerpc/mpc52xx.h	2006-10-27 15:51:55.000000000 +0200
> > > @@ -0,0 +1,414 @@
> > > +/*
> > > + * include/asm-ppc/mpc52xx.h
> > > + *
> >
> > Fixed to powerpc
>
> I thought we were removing the names of files from
> within the file itself, right?

Correct. They add nothing and become stale.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__28_Oct_2006_10_27_49_+1000_hDfJrN4WPO0RGiVL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFQqQFFdBgD/zoJvwRAkc0AJ0dKVSPY7gCqiECARUBxayufX8H7ACfbadV
cHNxcMu15jkHCJX9NiQ54xI=
=cr9m
-----END PGP SIGNATURE-----

--Signature=_Sat__28_Oct_2006_10_27_49_+1000_hDfJrN4WPO0RGiVL--
