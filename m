Return-Path: <robbat2@gentoo.org>
Received: from mail.isohunt.com (b01.ext.isohunt.com [208.71.112.51])
	by ozlabs.org (Postfix) with ESMTP id 43AEBDDF1B
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 21:24:17 +1100 (EST)
Date: Mon, 26 Nov 2007 02:24:14 -0800
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: Michel D?nzer <michel@tungstengraphics.com>, linuxppc-dev@ozlabs.org
Subject: Re: Access to PCI Expansion ROMs on PPC
Message-ID: <20071126102414.GF14557@curie-int.orbis-terrarum.net>
References: <20071125015707.GO3174@curie-int.orbis-terrarum.net>
	<9e4733910711241813r3412d459l95fb3b84cbee1d8a@mail.gmail.com>
	<20071125111535.GB14557@curie-int.orbis-terrarum.net>
	<20071125114919.GC14557@curie-int.orbis-terrarum.net>
	<9e4733910711250530r454c01ecoe8867a7f492b8704@mail.gmail.com>
	<20071125194101.GD14557@curie-int.orbis-terrarum.net>
	<20071126085928.GE14557@curie-int.orbis-terrarum.net>
	<1196068814.22865.108.camel@thor.sulgenrain.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FeAIMMcddNRN4P4/"
In-Reply-To: <1196068814.22865.108.camel@thor.sulgenrain.local>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--FeAIMMcddNRN4P4/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2007 at 10:20:14AM +0100, Michel D?nzer wrote:
> > Regarding the sub-thread on x86 emulation, that is totally out of scope
> > for this. The 'AtomBIOS' of the ATI cards, consists of multiple parts (I
> > may have minor errors here, ask airlied if you need more
> > clarification):
> > a) Initialization code (I think arch-specific)
> > b) AtomBIOS script interpreter (I think arch-specific)
> > c) AtomBIOS scripts (card-specific, but not arch-specific)
> > d) Data tables (card-specific, but not arch-specific)
> >=20
> > The AtomBIOS parts of the various drivers need data from c+d primarily,
> > and provide their own script interpreter, or not using the scripts, just
> > the data tables.
> Are you sure the X1900 Mac Edition ROM contains any ATOM data structures
> though? I rather doubt it.
That's what I'm trying to ascertain actually, because it directly
impacts what work needs to be done in the drivers.

If it was me writing the ROMs in the first place (but it's not), from
what I understand of the ATOM, I'd have OpenFirmware versions of a+b,
and then could re-use c+d.

The fact that both Nvidia and ATI OF-powered cards fail when trying to
access their expansion ROMs, I'm inclined to think there is something in
accessing them that we are missing, and that the ROMs must exist (the
sata_mv one existed and was accessible).

On actually accessing the rest of the ATI X1900 card, the avivotool from
git://people.freedesktop.org/~airlied/radeontool.git (avivo branch) can
actually access the rest of the rest of the card registers.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--FeAIMMcddNRN4P4/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFHSp7OPpIsIjIzwiwRAg0hAJ0VJGmHmZgHI30CvuXxoARpsnemggCfYXme
spZPJ0KIOuFOZUjBH9SCYLQ=
=6MC/
-----END PGP SIGNATURE-----

--FeAIMMcddNRN4P4/--
