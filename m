Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D3B65DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 13:52:07 +1000 (EST)
Date: Tue, 28 Apr 2009 13:52:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: drivers/video/logo/logo_linux_mono.c build error
Message-Id: <20090428135202.9c9bbadb.sfr@canb.auug.org.au>
In-Reply-To: <20090427145031.99d4e0ac.akpm@linux-foundation.org>
References: <20090427145031.99d4e0ac.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__28_Apr_2009_13_52_02_+1000_EYFjHkyClVVtNj3u"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__28_Apr_2009_13_52_02_+1000_EYFjHkyClVVtNj3u
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, 27 Apr 2009 14:50:31 -0700 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> powerpc allmodconfig, current mainline:
>=20
> drivers/video/logo/logo_linux_mono.c:11: error: logo_linux_mono_data caus=
es a section type conflict
>=20
> switching it from __initconst to __initdata "fixes" it.

Interesting.  The program that generates the .c file above produces
__initdata for me ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__28_Apr_2009_13_52_02_+1000_EYFjHkyClVVtNj3u
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkn2fWIACgkQjjKRsyhoI8xcvACfeUQWp1Hu5Vw1U2SThftyDp7P
CHYAnjvwL9UdUvyVXsr+9VsPddi84tpb
=w57Q
-----END PGP SIGNATURE-----

--Signature=_Tue__28_Apr_2009_13_52_02_+1000_EYFjHkyClVVtNj3u--
