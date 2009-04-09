Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 13115DE0D2
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 13:00:56 +1000 (EST)
Subject: Re: [PATCH] mpic_find() was overloaded to do two things introduce
	mpic_is_ipi() and simplify mpic_find()
From: Michael Ellerman <michael@ellerman.id.au>
To: Tony Breeds <tony@bakeyournoodle.com>
In-Reply-To: <8a6c1abce00c6f85d9714269d11bc3fac73a5402.1239164732.git.tony@bakeyournoodle.com>
References: <8a6c1abce00c6f85d9714269d11bc3fac73a5402.1239164732.git.tony@bakeyournoodle.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-lXyV6deYdHFk/z08FUr2"
Date: Thu, 09 Apr 2009 13:00:54 +1000
Message-Id: <1239246054.6214.46.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-lXyV6deYdHFk/z08FUr2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-04-08 at 14:26 +1000, Tony Breeds wrote:
> Also silences the warning:
> arch/powerpc/sysdev/mpic.c: In function 'mpic_irq_set_priority':
> arch/powerpc/sysdev/mpic.c:1382: warning: 'is_ipi' may be used uninitiali=
zed in this function
>=20
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> ---
> Only compile tested.

Not even compile tested, but looks good.

Acked-by: Michael Ellerman <michael@ellerman.id.au>

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-lXyV6deYdHFk/z08FUr2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkndZOYACgkQdSjSd0sB4dKqIQCfUMiiZ8+6JZmtAHA9VpkYUZ/q
E8sAn2d3nZKQI7fYugoy83PF5h9jLVbf
=dw9T
-----END PGP SIGNATURE-----

--=-lXyV6deYdHFk/z08FUr2--
