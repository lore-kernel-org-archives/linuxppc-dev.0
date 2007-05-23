Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5369BDDE2D
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 00:24:36 +1000 (EST)
Subject: Re: Kconfig warnings on latest GIT
From: Johannes Berg <johannes@sipsolutions.net>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0705230913420.535@localhost.localdomain>
References: <200705080004.14570.ismail@pardus.org.tr>
	<20070508143127.38fafa3c.kim.phillips@freescale.com>
	<4640D988.1040504@freescale.com> <20070510051042.GA16812@verge.net.au>
	<1178811570.3806.18.camel@johannes.berg>
	<20070511012216.GB10715@verge.net.au>
	<1178883937.8896.11.camel@johannes.berg>
	<20070514013230.GJ3588@verge.net.au>
	<1179147311.2647.47.camel@johannes.berg>
	<Pine.LNX.4.64.0705140923470.24559@gate.crashing.org>
	<1179159951.2647.49.camel@johannes.berg>
	<943F0161-121D-4697-AE69-78BD605A8033@kernel.crashing.org>
	<1179928646.14317.6.camel@johannes.berg>
	<Pine.LNX.4.64.0705230913420.535@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-S7zF+zkaPY6pUIFCHChx"
Date: Wed, 23 May 2007 16:26:05 +0200
Message-Id: <1179930365.14317.14.camel@johannes.berg>
Mime-Version: 1.0
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
	ppc-dev dev ML <linuxppc-dev@ozlabs.org>,
	Simon Horman <horms@verge.net.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-S7zF+zkaPY6pUIFCHChx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-23 at 09:14 -0500, Kumar Gala wrote:
> On Wed, 23 May 2007, Johannes Berg wrote:
>=20
> > On Wed, 2007-05-23 at 07:37 -0500, Kumar Gala wrote:
> >
> > > Was my patch ok, if so I'll push it up through my git tree to paul?
> >
> > Yeah, looks fine to me, or will the ARCH=3Dppc folks then scream and wa=
nt
> > that added to the Kconfig there as well?
>=20
> I can't imagine they will since pmac is only supported in ARCH=3Dpowerpc.

Oh right, that was the point of not mentioning
SYS_SUPPORTS_APM_EMULATION any more in the drivers/macintosh/Kconfig

johannes

--=-S7zF+zkaPY6pUIFCHChx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGVE79/ETPhpq3jKURAsoLAKCNDt2BvRicYLq+ZjM9YrU4hReDggCfcwwS
qDd9/PWsdM2kp9MLcElVhaA=
=k3Py
-----END PGP SIGNATURE-----

--=-S7zF+zkaPY6pUIFCHChx--
