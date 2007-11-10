Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 399A7DDEC6
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 11:31:34 +1100 (EST)
Date: Sat, 10 Nov 2007 11:31:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH v4 04/13] [POWERPC] Add generic support for simple
	MPC5200 based boards
Message-Id: <20071110113133.86aa3de2.sfr@canb.auug.org.au>
In-Reply-To: <20071109171202.16289.2618.stgit@hekate.izotz.org>
References: <20071109171137.16289.39575.stgit@hekate.izotz.org>
	<20071109171202.16289.2618.stgit@hekate.izotz.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__10_Nov_2007_11_31_33_+1100_mFav9cNvW3/T5e36"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__10_Nov_2007_11_31_33_+1100_mFav9cNvW3/T5e36
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 09 Nov 2007 18:12:02 +0100 Marian Balakowicz <m8@semihalf.com> wrot=
e:
>
> +++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
>
> +static int __init mpc5200_simple_probe(void)
> +{
> +	unsigned long node =3D of_get_flat_dt_root();

You need to include asm/prom.h to use the flattened device tree accessors.

> +	/* list of the supported boards */
> +	const char *board[] =3D {=09
> +		"tqc,tqm5200",
> +		"promess,motionpro",
> +		"schindler,cm5200",
> +		NULL
> +	};

Make that static.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__10_Nov_2007_11_31_33_+1100_mFav9cNvW3/T5e36
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQFHNPvrTgG2atn1QN8RAnCzAJiCL/q5+0BT/RZcB/3dqprS1zkgAJ4zyCkl
XZCb1nPijb/z6LrUadYZwg==
=4f89
-----END PGP SIGNATURE-----

--Signature=_Sat__10_Nov_2007_11_31_33_+1100_mFav9cNvW3/T5e36--
