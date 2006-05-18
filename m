Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/5] powerpc: Make early xmon logic immune to location
	of early parsing
From: Michael Ellerman <michael@ellerman.id.au>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20060517212955.GA31362@smtp.west.cox.net>
References: <1147852841.148164.91320074069.qpush@concordia>
	<20060517212955.GA31362@smtp.west.cox.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-npeKCdjJSPRDnGZXwoDx"
Date: Thu, 18 May 2006 10:03:05 +1000
Message-Id: <1147910586.7360.8.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>,
	Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-npeKCdjJSPRDnGZXwoDx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-05-17 at 14:29 -0700, Tom Rini wrote:
> On Wed, May 17, 2006 at 06:00:41PM +1000, Michael Ellerman wrote:
>=20
> > Currently early_xmon() calls directly into debugger() if xmon=3Dearly i=
s passed.
> > This ties the invocation of early xmon to the location of parse_early_p=
aram(),
> > which might change.
> >=20
> > Tested on P5 LPAR and F50.
> >=20
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>=20
> Please no, parse_early_param() is there so things like xmon or kgdb can
> be dropped into as soon as we're able to parse any params that might be
> usable early on.

Sure, did you read the rest of the series? I want to parse parameters
eariler, so early that xmon isn't ready to run when we parse them, so I
have to defer jumping into xmon until after xmon is initialised. The net
effect on when xmon runs is zero. Or did I miss your point?

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-npeKCdjJSPRDnGZXwoDx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEa7m5dSjSd0sB4dIRAvJKAJ0XE5XM0NIYT5kncOt9mlHphQ4N1QCfc/IF
41ucDwOSIc2kQWc9KfHsF3M=
=AFeF
-----END PGP SIGNATURE-----

--=-npeKCdjJSPRDnGZXwoDx--
