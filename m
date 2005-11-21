Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CC1EB681BE
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Nov 2005 21:32:16 +1100 (EST)
Date: Mon, 21 Nov 2005 21:32:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: hs@denx.de
Message-Id: <20051121213208.1bd0dea4.sfr@canb.auug.org.au>
In-Reply-To: <AHEILKONAKAEJPHNMOPNKELACDAA.hs@denx.de>
References: <AHEILKONAKAEJPHNMOPNKELACDAA.hs@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__21_Nov_2005_21_32_08_+1100_Ln5eTjSvmeAN.4op"
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH]	ppc32:	Add support for PM82x Boards
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__21_Nov_2005_21_32_08_+1100_Ln5eTjSvmeAN.4op
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Heiko,

On Mon, 21 Nov 2005 11:24:58 +0100 "Heiko Schocher" <hs@denx.de> wrote:
>
> Hello
>=20
> the following Patch (against 2.6 kernel.org tree, COMMIT_ID:
> f093182d313edde9b1f86dbdaf40ba4da2dbd0e7) adds support for
> the Microsys PM82x Boards. Verified on the PM827 Board.
>=20
> not included yet: support for MTD, I2C, RTC.
>=20
> Note: 2 previously submitted Patches are required:
>=20
> Thu, 4 Nov 2005 [PATCH] ppc32: Fix SCC Uart write problem after 2. open()
> Tue, 3 Nov 2005 [PATCH] ppc32: fix: swallowed chars when booting.
>=20
> Signed-off-by: Heiko Schocher <hs@denx.de>

Unfortunately, the patch was badly wrapped by your mailer ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__21_Nov_2005_21_32_08_+1100_Ln5eTjSvmeAN.4op
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDgaIuFdBgD/zoJvwRAh5RAJ4n0n0REXoxQjQ6EWob0biDNsrT/gCgktij
qrRaXq1Xg+RnBDxuuMxmCYQ=
=fJ2J
-----END PGP SIGNATURE-----

--Signature=_Mon__21_Nov_2005_21_32_08_+1100_Ln5eTjSvmeAN.4op--
