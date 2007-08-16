Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] [POWERPC] Invalid semicolon after if statement
From: Michael Ellerman <michael@ellerman.id.au>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <je7inva0w4.fsf@sykes.suse.de>
References: <Pine.LNX.4.64.0708151644090.15670@kivilampi-30.cs.helsinki.fi>
	<1187251702.8375.43.camel@concordia.ozlabs.ibm.com>
	<fa88c3e5b4b0f896a16688a525bcd744@kernel.crashing.org>
	<je7inva0w4.fsf@sykes.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Q/EWG6XxJq93AR8oY8c5"
Date: Fri, 17 Aug 2007 09:08:25 +1000
Message-Id: <1187305705.29237.3.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>,
	linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Q/EWG6XxJq93AR8oY8c5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-08-16 at 18:40 +0200, Andreas Schwab wrote:
> Segher Boessenkool <segher@kernel.crashing.org> writes:
>=20
> >> Thanks to the frickin compiler for warning us, not.
> >
> > 4.3: "warning: suggest braces around empty body in an 'if' statement"
> >
> > 4.1: "warning: empty body in an if-statement"
> >
> > Your GCC is too old :-)
>=20
> This warning is only enabled by -Wextra.  Only 4.3 has a separate option
> for it (-Wempty-body).

Oh good, so in 2011 we'll start getting a warning, sweet.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Q/EWG6XxJq93AR8oY8c5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGxNjpdSjSd0sB4dIRAqtFAJ0Roi/hqmkxMDDL4WA2VgcCTGGoswCfQCaG
2pMYh6SSIgPjrvNHB1RVdXU=
=xbTQ
-----END PGP SIGNATURE-----

--=-Q/EWG6XxJq93AR8oY8c5--
