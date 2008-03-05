Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id DB752DDE20
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 10:17:37 +1100 (EST)
Date: Thu, 6 Mar 2008 10:17:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.25-rc3-mm1 ppc64 boot hang
Message-Id: <20080306101722.ea2428f3.sfr@canb.auug.org.au>
In-Reply-To: <20080305135425.c8ebf8e4.akpm@linux-foundation.org>
References: <20080304011928.e8c82c0c.akpm@linux-foundation.org>
	<1204752855.7939.42.camel@dyn9047017100.beaverton.ibm.com>
	<20080305135425.c8ebf8e4.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__6_Mar_2008_10_17_22_+1100_9YzGf63F54Gqejo="
Cc: Matthew Wilcox <willy@debian.org>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, Badari Pulavarty <pbadari@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__6_Mar_2008_10_17_22_+1100_9YzGf63F54Gqejo=
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Wed, 5 Mar 2008 13:54:25 -0800 Andrew Morton <akpm@linux-foundation.org>=
 wrote:
>
> The semaphore consolidation code enables interrupts early in boot, when it
> shouldn't.  This tends to make powerpc blow up.  Could be that this is wh=
at
> you're hitting.
>=20
> Matthew, is this ging to be fixed soon?

There is a new version of these patches in the current linux-next tree ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Thu__6_Mar_2008_10_17_22_+1100_9YzGf63F54Gqejo=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHzyoNTgG2atn1QN8RAh3oAJ0ehwJJuuzTm8suvAXRZqm2fTfFiwCeOAGZ
AwHV7VwMg0KY6ucf3X0OGpo=
=IdnR
-----END PGP SIGNATURE-----

--Signature=_Thu__6_Mar_2008_10_17_22_+1100_9YzGf63F54Gqejo=--
