Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2306CDE710
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 21:26:15 +1000 (EST)
Date: Thu, 10 Apr 2008 21:26:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 83xx/85xx: Reorganize defconfigs
Message-Id: <20080410212605.c1c20cc6.sfr@canb.auug.org.au>
In-Reply-To: <6D34DE41-ED8D-455A-89F3-288C9445691E@kernel.crashing.org>
References: <Pine.LNX.4.64.0804091017440.18753@blarg.am.freescale.net>
	<20080410103131.f0dcf730.sfr@canb.auug.org.au>
	<6BE67DBD-325A-4628-8480-7EA0FE79DBE5@kernel.crashing.org>
	<20080410142430.256fd23e.sfr@canb.auug.org.au>
	<6D34DE41-ED8D-455A-89F3-288C9445691E@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__10_Apr_2008_21_26_05_+1000_4tMwTHvjSavwcuzR"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__10_Apr_2008_21_26_05_+1000_4tMwTHvjSavwcuzR
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

On Thu, 10 Apr 2008 03:51:42 -0500 Kumar Gala <galak@kernel.crashing.org> w=
rote:
>
> We should probably add mpc83xx_defconfig to kisskb.  However, =20
> mpc885_ads_defconfig is an 8xx (extreme low end) and mpc85xx_defconfig =20
> (higher end) cover two different processor families so we shouldn't =20
> drop mpc885_ads_defconfig.

Ah, ok.  I misread the name as one of those that was moved (which it
obviously wasn't).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__10_Apr_2008_21_26_05_+1000_4tMwTHvjSavwcuzR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH/flSTgG2atn1QN8RAqwTAJ9Rqbc1F3MaoBKg9bBpt8uSxkItRwCgh9iN
G+XICfIJrrQi3BXyyBByhlI=
=eSKa
-----END PGP SIGNATURE-----

--Signature=_Thu__10_Apr_2008_21_26_05_+1000_4tMwTHvjSavwcuzR--
