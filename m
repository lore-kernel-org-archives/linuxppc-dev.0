Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8E1ADDDEDA
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 14:24:44 +1000 (EST)
Date: Thu, 10 Apr 2008 14:24:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 83xx/85xx: Reorganize defconfigs
Message-Id: <20080410142430.256fd23e.sfr@canb.auug.org.au>
In-Reply-To: <6BE67DBD-325A-4628-8480-7EA0FE79DBE5@kernel.crashing.org>
References: <Pine.LNX.4.64.0804091017440.18753@blarg.am.freescale.net>
	<20080410103131.f0dcf730.sfr@canb.auug.org.au>
	<6BE67DBD-325A-4628-8480-7EA0FE79DBE5@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__10_Apr_2008_14_24_30_+1000_GQPqN6q5gKUD/sme"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__10_Apr_2008_14_24_30_+1000_GQPqN6q5gKUD/sme
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Apr 2008 22:11:38 -0500 Kumar Gala <galak@kernel.crashing.org> wr=
ote:
>
> Yeah the are mpc85xx_defconfig and mpc83xx_defconfig.

So should we add mpc83xx_defconfig to the kisskb builds and remove
mpc885_ads_defconfig (we already do a mpc85xx_defconfig build)?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__10_Apr_2008_14_24_30_+1000_GQPqN6q5gKUD/sme
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH/ZaDTgG2atn1QN8RAqjxAJ4j9lSeapMdYA1xTiBDMXep6dWOgwCeLg9R
AJYlkHZofFmb4O1g5jZrxlQ=
=GRcS
-----END PGP SIGNATURE-----

--Signature=_Thu__10_Apr_2008_14_24_30_+1000_GQPqN6q5gKUD/sme--
