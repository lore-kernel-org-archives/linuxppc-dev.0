Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D0240DDED7
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 11:36:47 +1100 (EST)
Date: Tue, 8 Jan 2008 11:36:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH] Use <linux/of_{platform, device}.h> and not <asm/...>
	variants.
Message-Id: <20080108113637.5208a0c7.sfr@canb.auug.org.au>
In-Reply-To: <E1JBwNX-0006XF-26@jdl.com>
References: <E1JBwNX-0006XF-26@jdl.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__8_Jan_2008_11_36_37_+1100_K+FC.Pt8nlaoBHPH"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__8_Jan_2008_11_36_37_+1100_K+FC.Pt8nlaoBHPH
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jon,

On Mon, 07 Jan 2008 12:07:15 -0600 Jon Loeliger <jdl@jdl.com> wrote:
>
> From: Jon Loeliger <jdl@freescale.com>
>=20
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> ---
>=20
> Paul,
>=20
> Continue to fight the Good Fight by removing
> old include file references that managed to
> creep in recently.
>=20
> These are the last few in arch/powerpc directly.
> If you could pick this up for .25, that be good!

Thanks for doing this.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__8_Jan_2008_11_36_37_+1100_K+FC.Pt8nlaoBHPH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHgsWYTgG2atn1QN8RAnZmAJ0SsMdZCXWtOyAlSXYUtf2EFPiAyACcCc9b
LDGUHofYfHpefxE3zQmDvi0=
=12l1
-----END PGP SIGNATURE-----

--Signature=_Tue__8_Jan_2008_11_36_37_+1100_K+FC.Pt8nlaoBHPH--
