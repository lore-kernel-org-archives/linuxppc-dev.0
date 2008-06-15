Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 68C9BDDE02
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Jun 2008 10:49:01 +1000 (EST)
Date: Sun, 15 Jun 2008 10:48:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: hs@denx.de
Subject: Re: [PATCH] [8xx] powerpc: Add support for the MPC852 based mgsuvd
	board from keymile.
Message-Id: <20080615104856.a77a29f5.sfr@canb.auug.org.au>
In-Reply-To: <485415AC.9090001@denx.de>
References: <20080612152838.GA2756@loki.buserror.net> <4852A09B.100@denx.de>
	<4852977B.8030800@freescale.com> <4852D0D0.4030701@denx.de>
	<20080614175733.a2036f44.sfr@canb.auug.org.au>
	<485415AC.9090001@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__15_Jun_2008_10_48_56_+1000_feI7OgS1woo/sPdM"
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__15_Jun_2008_10_48_56_+1000_feI7OgS1woo/sPdM
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 14 Jun 2008 21:02:04 +0200 Heiko Schocher <hs@denx.de> wrote:
>
> [powerpc]  add support for the MPC852 based mgsuvd board from
>            keymile to arch/powerpc. Supported SMC1 (serial console),
>            SCC3 Ethernet (10Mbps hdx).
>=20
> Signed-off-by: Heiko Schocher <hs@denx.de>

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au> Structure/syntax of
Kconfig, Makefile, mgsuvd.c

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__15_Jun_2008_10_48_56_+1000_feI7OgS1woo/sPdM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhUZvgACgkQTgG2atn1QN/BrACeIxU9A26LRAMgHv+0I3DiDscj
nPkAn2WA4qTVEetNEevlhGq82cyUs3yL
=rNpY
-----END PGP SIGNATURE-----

--Signature=_Sun__15_Jun_2008_10_48_56_+1000_feI7OgS1woo/sPdM--
