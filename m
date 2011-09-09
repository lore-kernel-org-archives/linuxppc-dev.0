Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B9F46B6F9C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Sep 2011 19:07:38 +1000 (EST)
Date: Fri, 9 Sep 2011 11:07:27 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Zang Roy-R61911 <r61911@freescale.com>
Subject: Re: [PATCH 2/2 v2] eSDHC: Fix errors when booting kernel with fsl
	esdhc
Message-ID: <20110909090727.GH1912@pengutronix.de>
References: <1311329717-13954-1-git-send-email-tie-fei.zang@freescale.com>
	<1311329717-13954-2-git-send-email-tie-fei.zang@freescale.com>
	<20110722101512.GA1576@oksana.dev.rtsoft.ru>
	<2239AC579C7D3646A720227A37E0268118FD3B@039-SN1MPN1-005.039d.mgd.msft.net>
	<20110812100450.GA23333@oksana.dev.rtsoft.ru>
	<2239AC579C7D3646A720227A37E026811A1F8D@039-SN1MPN1-005.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIIRZ1HQ6FgrlPgb"
In-Reply-To: <2239AC579C7D3646A720227A37E026811A1F8D@039-SN1MPN1-005.039d.mgd.msft.net>
Cc: Xu Lei-B33228 <B33228@freescale.com>,
	Wood Scott-B07421 <B07421@freescale.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--WIIRZ1HQ6FgrlPgb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > I would do it in the IO accessors.
> >=20
> > Thanks,
> Any update for your comment?

It is still valid. You can go that road.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--WIIRZ1HQ6FgrlPgb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk5p108ACgkQD27XaX1/VRvIBQCffGKejoGw9ddEjayX38ZnzzXs
CUIAn3n1SHj50BgI6OV4liBgPzO7h/7N
=gdxp
-----END PGP SIGNATURE-----

--WIIRZ1HQ6FgrlPgb--
