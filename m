Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 137C8DDE22
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 15:35:57 +1100 (EST)
Date: Wed, 16 Jan 2008 15:35:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] 8xx: Analogue & Micro Adder875 board support.
Message-Id: <20080116153544.730b20b6.sfr@canb.auug.org.au>
In-Reply-To: <20080115233045.GA21002@loki.buserror.net>
References: <20080115233045.GA21002@loki.buserror.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__16_Jan_2008_15_35_44_+1100_gRMJqmUTWX24Zk22"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__16_Jan_2008_15_35_44_+1100_gRMJqmUTWX24Zk22
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Scott,

On Tue, 15 Jan 2008 17:30:45 -0600 Scott Wood <scottwood@freescale.com> wro=
te:
>
> +++ b/arch/powerpc/platforms/8xx/adder875.c

> +static __initdata const struct cpm_pin adder875_pins[] =3D {

Sorry, but you can't have both const and __inittdata.  The section
attributes that each use conflict.  So just make it __initdata.

> +static __initdata const struct of_device_id __initdata of_bus_ids[] =3D {

Same here.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__16_Jan_2008_15_35_44_+1100_gRMJqmUTWX24Zk22
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHjYmlTgG2atn1QN8RAuQEAJ0Qx82pzpGZipCQIZr2JMMBNKOhTgCfSxPb
amvSc5Csv+blC2QrwuvvHwI=
=7W2g
-----END PGP SIGNATURE-----

--Signature=_Wed__16_Jan_2008_15_35_44_+1100_gRMJqmUTWX24Zk22--
