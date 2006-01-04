Return-Path: <stefan.eletzhofer@inquant.de>
From: Stefan Eletzhofer <stefan.eletzhofer@inquant.de>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20060104133618.0020E352B1E@atlas.denx.de>
References: <20060104133618.0020E352B1E@atlas.denx.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-2xC4ICLD1/RaHDiv9YFF"
Date: Wed, 04 Jan 2006 14:53:54 +0100
Message-Id: <1136382834.15908.17.camel@localhost>
Mime-Version: 1.0
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: "argument list too long"
Reply-To: stefan.eletzhofer@inquant.de
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-2xC4ICLD1/RaHDiv9YFF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am Mittwoch, den 04.01.2006, 14:36 +0100 schrieb Wolfgang Denk:
> In message <1136380085.15908.15.camel@localhost> you wrote:
> >=20
> > > +	find $(FINDHPATH) \( -name SCCS -o -name .svn \) -prune -o -follow =
-name \*.h ! -name modversions.h -print | xargs scripts/mkdep -- > .hdepend
> > >  	scripts/mkdep -- init/*.c > .depend
> >=20
> > Would'nt this overwrite .depend if xargs executes mkdep more than once?
>=20
> No, why should it? The filr eredirection happens just  once,  in  the
> shell,  even before xargs gets executed. It does not matter how often
> mkdep gets called then.

Gah. You're right, of course ;/=20

>=20
> > I'd suggest (beware, manually hacked diff ;):
>=20
> I have no idea what you're trying to fix or improve with this.

"problem is in front of keyboard" Oder so.

>=20
> Best regards,
>=20
> Wolfgang Denk
>=20
--=20
Stefan Eletzhofer
InQuant GmbH
Bahnhofstra=C3=9Fe 11
D-88214 Ravensburg
http://www.inquant.de
http://www.eletztrick.de
+49 (0) 751 35 44 112
+49 (0) 171 23 24 529 (Mobil)
+49 (0) 751 35 44 115 (FAX)

--=-2xC4ICLD1/RaHDiv9YFF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDu9Ny20PMGlcwuNARAkJVAJ9CI3CUtUdclB+KHXx6IYE8LSdZZQCfTPLH
sJrzwA76o6C+hGDKaz7rZ0o=
=ZFTa
-----END PGP SIGNATURE-----

--=-2xC4ICLD1/RaHDiv9YFF--
