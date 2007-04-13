Return-Path: <michael@ellerman.id.au>
Subject: Re: xmon debugger doc?
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070413034850.GA12654@lixom.net>
References: <1176410647.27519.6.camel@stevo-desktop>
	<20070413034850.GA12654@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-A8OM2OulcIobFejKOQEo"
Date: Fri, 13 Apr 2007 13:58:29 +1000
Message-Id: <1176436709.4734.19.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Steve Wise <swise@opengridcomputing.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-A8OM2OulcIobFejKOQEo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-04-12 at 22:48 -0500, Olof Johansson wrote:
> On Thu, Apr 12, 2007 at 03:44:07PM -0500, Steve Wise wrote:
> > Can someone please point me at ppc64 xmon debugger usage /
> > documentation? I've had little luck finding info on-line.
>=20
> The help output from it is pretty much all there is.
>=20
> You might have better luck asking on linuxppc-dev@ozlabs.org though
> (adding as Cc).
>=20
> There's also an old writeup at
> http://mbligh.org/linuxdocs/Kernel/DebuggingPPC64 for the very basics
> of digging through a crash. Some of it is likely out of date by now.

A good trick which the help output doesn't mention is that % and $ are
special in input, so you can do:

0:mon> di %pc

disassemble instructions at address pointed to by register PC

Other regs are eg: %lr, %r1, %r12.
And it works with di, d and other commands.

Also:

0:mon> di $.xmon_register_spus

disassemble instructions at address of symbol .xmon_register_spus.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-A8OM2OulcIobFejKOQEo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBGHv/ldSjSd0sB4dIRAk7JAJ9NY+aKw3VhQus0jAUd2ei1LiLUpwCfe+5t
dG3ZFDrI15ADUOjwkYJ73Xc=
=XXGf
-----END PGP SIGNATURE-----

--=-A8OM2OulcIobFejKOQEo--
