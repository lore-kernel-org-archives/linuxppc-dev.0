Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7E521DDF8C
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 10:02:05 +1100 (EST)
Date: Thu, 13 Dec 2007 10:01:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/8] fsl_soc: Factor fsl_get_sys_freq() out of the wdt
	init.
Message-Id: <20071213100157.425ce53d.sfr@canb.auug.org.au>
In-Reply-To: <20071212173601.GC5596@loki.buserror.net>
References: <20071212173519.GA5577@loki.buserror.net>
	<20071212173601.GC5596@loki.buserror.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__13_Dec_2007_10_01_57_+1100_HJ4h1XvpJ9wQFlnx"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__13_Dec_2007_10_01_57_+1100_HJ4h1XvpJ9wQFlnx
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Scott,

Just one little nit ...

On Wed, 12 Dec 2007 11:36:01 -0600 Scott Wood <scottwood@freescale.com> wro=
te:
>
> -	ret =3D platform_device_add_data(dev, freq, sizeof(int));
> +	ret =3D platform_device_add_data(dev, &freq, sizeof(int));
                                                          ^^^
Surely you want "u32" or "freg" here?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__13_Dec_2007_10_01_57_+1100_HJ4h1XvpJ9wQFlnx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHYGhqTgG2atn1QN8RAs3GAJ9XOkLHn5wgu2k1JZMmK6NGHsVikgCglI/J
/Z/qth2CQ0Xqd/WjPDhNtQQ=
=/v0n
-----END PGP SIGNATURE-----

--Signature=_Thu__13_Dec_2007_10_01_57_+1100_HJ4h1XvpJ9wQFlnx--
