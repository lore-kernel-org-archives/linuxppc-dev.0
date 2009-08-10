Return-Path: <w.sang@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2D80FB6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Aug 2009 02:19:59 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id ABA48DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 02:19:58 +1000 (EST)
Date: Mon, 10 Aug 2009 18:19:42 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Artem Bityutskiy <dedekind@infradead.org>
Subject: Re: [PATCH] mtd/maps: add mtd-ram support to physmap_of
Message-ID: <20090810161942.GA27833@pengutronix.de>
References: <1247834363-28198-1-git-send-email-w.sang@pengutronix.de>
	<fa686aa40908072243x56d2160fk688149f4b7b912ae@mail.gmail.com>
	<1249795043.9157.37.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
In-Reply-To: <1249795043.9157.37.camel@localhost>
Cc: devicetree-discuss@ozlabs.org, Vitaly Wool <vwool@ru.mvista.com>,
	Albrecht =?iso-8859-15?Q?Dre=DF?= <albrecht.dress@arcor.de>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Ken MacLeod <ken@bitsko.slc.ut.us>, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 09, 2009 at 08:17:23AM +0300, Artem Bityutskiy wrote:
> On Fri, 2009-08-07 at 23:43 -0600, Grant Likely wrote:
> > On Fri, Jul 17, 2009 at 6:39 AM, Wolfram Sang<w.sang@pengutronix.de> wr=
ote:
> > > Use physmap_of to access RAMs as mtd and add documenation for it. Thi=
s approach
> > > is a lot less intrusive as adding an of-wrapper around plat-ram.c. As=
 most
> > > extensions of plat-ram.c (e.g. custom map-functions) can't be mapped =
to the
> > > device tree anyhow, extending physmap_of seems to be the cleanest app=
roach.
> > >
> > > Tested with a phyCORE-MPC5121e.
> > >
> > > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> >=20
> > Looks good to me.
> >=20
> > Acked-by: Grant Likely <grant.likely@secretlab.ca>
>=20
> This patch is sitting in my l2-mtd-2.6.git tree.

Great, thanks a lot (and for your l2-tree in general!). One question: Are t=
he
additional Acked-bys added later? I could think they might be useful for
David's review...

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqASJ4ACgkQD27XaX1/VRtxLwCeKVSaOJ+BJhVWeZMsFQ17Mpqt
uWEAn3VzrFmKQpaJo8EcQPP1/DAgMgLr
=k6lN
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
