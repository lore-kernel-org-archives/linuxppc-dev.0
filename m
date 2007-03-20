Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] [PPC32] ADMA support for PPC 440SPe processors.
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1174320799.5044.21.camel@localhost.localdomain>
References: <20070315232956.37DAB353A6C@atlas.denx.de>
	<200703170909.13869.sr@denx.de>
	<e9c3a7c20703171117w7989adfehda99416265eef906@mail.gmail.com>
	<200703171943.27465.sr@denx.de>
	<e9c3a7c20703171209m55fd9dfsbba0e4fff5c6350d@mail.gmail.com>
	<1174320799.5044.21.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-iMCOltxmGV+CYthZHLyv"
Date: Tue, 20 Mar 2007 14:06:35 +1100
Message-Id: <1174359995.10827.10.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Dan Williams <dan.j.williams@gmail.com>, linux-raid@vger.kernel.org,
	Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-iMCOltxmGV+CYthZHLyv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-03-19 at 17:13 +0100, Benjamin Herrenschmidt wrote:
> BTW folks. Would it be hard to change your spe_ prefixes to something
> else ? There's already enough confusion between the freescale SPE unit
> and the cell SPEs :-)
>=20
> (such confusion is annoying when grepp'ing for code that might touch a
> given functionality for example).

Please please please!

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-iMCOltxmGV+CYthZHLyv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBF/0+7dSjSd0sB4dIRAg9sAKCCbUIbUW9Ka6Y10utj/V64mepO8wCfZRvf
sFxfNO71pxFf1T+gztnif+k=
=m/iA
-----END PGP SIGNATURE-----

--=-iMCOltxmGV+CYthZHLyv--
