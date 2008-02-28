Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 04ADADDE0D
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 11:02:01 +1100 (EST)
Date: Thu, 28 Feb 2008 11:01:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "John Linn" <John.Linn@xilinx.com>
Subject: Re: FW: [PATCH] Xilinx: BSP: Updated ML405 to match hardware used
	for testing
Message-Id: <20080228110153.00eb5e1d.sfr@canb.auug.org.au>
In-Reply-To: <20080227231521.4673DE3006A@mail124-dub.bigfish.com>
References: <20080227231521.4673DE3006A@mail124-dub.bigfish.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__28_Feb_2008_11_01_53_+1100_nqtVvoZRuPCt052E"
Cc: linuxppc-dev@ozlabs.org, git-dev <git-dev@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__28_Feb_2008_11_01_53_+1100_nqtVvoZRuPCt052E
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi John,

n Wed, 27 Feb 2008 16:15:18 -0700 "John Linn" <John.Linn@xilinx.com> wrote:
>
> The default config file for the ML405 and the xparameters*.h file
> were updated to match the hardware used for testing. The platform
> data in virtex_devices.c was updated for the LL TEMAC driver
> which now uses the dcr_host field to determine if it should use
> DCR for the DMA.
>=20
> Signed-off-by: John Linn <john.linn>

This was badly wrapped as well.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__28_Feb_2008_11_01_53_+1100_nqtVvoZRuPCt052E
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHxfn1TgG2atn1QN8RAlWLAJoDt9+Fd8x6w//yMha0YFXK2mDqcACfc7Er
XlSOZj4zH3X7FewIOQ67UFw=
=W/Cf
-----END PGP SIGNATURE-----

--Signature=_Thu__28_Feb_2008_11_01_53_+1100_nqtVvoZRuPCt052E--
