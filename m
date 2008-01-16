Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 94211DDE2D
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 15:40:58 +1100 (EST)
Date: Wed, 16 Jan 2008 15:40:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] mpc82xx: Embedded Planet EP8248E support
Message-Id: <20080116154053.1306272a.sfr@canb.auug.org.au>
In-Reply-To: <20080115233047.GB21002@loki.buserror.net>
References: <20080115233047.GB21002@loki.buserror.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__16_Jan_2008_15_40_53_+1100_t0kyY1/uvqsHfhob"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__16_Jan_2008_15_40_53_+1100_t0kyY1/uvqsHfhob
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Scott,

On Tue, 15 Jan 2008 17:30:47 -0600 Scott Wood <scottwood@freescale.com> wro=
te:
>
> +++ b/arch/powerpc/platforms/82xx/ep8248e.c

> +static __initdata const struct cpm_pin ep8248e_pins[] =3D {

Again, const doesn't mix with __initdata so just use __initdata.

> +static  __initdata const struct of_device_id of_bus_ids[] =3D {

Here as well.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__16_Jan_2008_15_40_53_+1100_t0kyY1/uvqsHfhob
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHjYrZTgG2atn1QN8RApj7AJ41UwSeCMe0zyHYWk80JeX0rx18QgCcCQ6z
LPDELRj+etmI76H/MJPwPKo=
=TU3s
-----END PGP SIGNATURE-----

--Signature=_Wed__16_Jan_2008_15_40_53_+1100_t0kyY1/uvqsHfhob--
