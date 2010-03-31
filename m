Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 58ADFB7C48
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Mar 2010 12:52:31 +1100 (EST)
Date: Wed, 31 Mar 2010 12:52:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH 1/12] arch/powerpc/kernel: Add missing unlock
Message-Id: <20100331125225.3714c9f6.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.64.1003291733150.21896@ask.diku.dk>
References: <Pine.LNX.4.64.1003291733150.21896@ask.diku.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__31_Mar_2010_12_52_25_+1100_6WvQH3F2B.u.+QJk"
Cc: kernel-janitors@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__31_Mar_2010_12_52_25_+1100_6WvQH3F2B.u.+QJk
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Julia,

On Mon, 29 Mar 2010 17:33:34 +0200 (CEST) Julia Lawall <julia@diku.dk> wrot=
e:
>
> From: Julia Lawall <julia@diku.dk>
>=20
> Add an unlock before exiting the function.

Thanks for this.

> Signed-off-by: Julia Lawall <julia@diku.dk>

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__31_Mar_2010_12_52_25_+1100_6WvQH3F2B.u.+QJk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkuyqtkACgkQjjKRsyhoI8wchQCeO0mO1cTe2HbjLlJ0XKe7lA7z
Uc4AmgM1Ki+gVC52iFCoEMNOVkFAUsGO
=hDu/
-----END PGP SIGNATURE-----

--Signature=_Wed__31_Mar_2010_12_52_25_+1100_6WvQH3F2B.u.+QJk--
