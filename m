Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B47DEDDEC9
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 15:31:54 +1100 (EST)
Date: Wed, 12 Dec 2007 15:31:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] 8xx: Analogue & Micro Adder875 board support.
Message-Id: <20071212153148.cbd79b46.sfr@canb.auug.org.au>
In-Reply-To: <20071211212245.GA3620@loki.buserror.net>
References: <20071211212245.GA3620@loki.buserror.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__12_Dec_2007_15_31_48_+1100_pbNU03sUtrRn+0Xh"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__12_Dec_2007_15_31_48_+1100_pbNU03sUtrRn+0Xh
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Scott,

On Tue, 11 Dec 2007 15:22:45 -0600 Scott Wood <scottwood@freescale.com> wro=
te:
>
> +++ b/arch/powerpc/platforms/8xx/adder875.c
> +
> +static int __init adder875_probe(void)
> +{
> +	unsigned long root =3D of_get_flat_dt_root();
> +	return of_flat_dt_is_compatible(root, "analogue-and-micro,adder875");

You should include asm/prom.h to use the flattened device tree accessors.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__12_Dec_2007_15_31_48_+1100_pbNU03sUtrRn+0Xh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHX2Q4TgG2atn1QN8RAj/JAJ90TtXtECRaNbnT76HKAVzHlxrC3wCcDdAD
ZhO+zhAa5H1UkO8pm/n6zug=
=Q87e
-----END PGP SIGNATURE-----

--Signature=_Wed__12_Dec_2007_15_31_48_+1100_pbNU03sUtrRn+0Xh--
