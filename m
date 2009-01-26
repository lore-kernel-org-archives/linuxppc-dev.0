Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 1AF01DDF55
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jan 2009 20:26:11 +1100 (EST)
Date: Mon, 26 Jan 2009 10:26:05 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/8] powerpc/5200: update device tree binding documentation
Message-ID: <20090126092605.GB28453@pengutronix.de>
References: <20090121205506.31232.27908.stgit@localhost.localdomain>
	<20090125194853.GB26917@pengutronix.de>
	<fa686aa40901251746x644e22c6tf8862103c04db1dc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
In-Reply-To: <fa686aa40901251746x644e22c6tf8862103c04db1dc@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, devtree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> +system-frequency     Fsystem frequency; source of all
> >
> > Fsystem? Typo?
>=20
> Not really, that's the name of the clock in the MP5200 user guide.
> I'll clarify what I've written here though.

That will be helpful.

> > The unit would be nice here, too, I think.
>=20
> Unit?  Do you mean stating that it is in Hz?

Yes, like in the frequency next to it.

Kind regards,

   Wolfram

PS: The other patches look good to me, too. I just want to test them on
a real phyCORE-tiny this week.

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkl9ga0ACgkQD27XaX1/VRunoQCeKV8ZHSgWJ78sHIHDajFZRBkE
a8sAn1DkrQxKT64jjWfsTwW5wQ5XGBwb
=76P8
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
