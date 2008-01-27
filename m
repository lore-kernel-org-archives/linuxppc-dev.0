Return-Path: <michael@ellerman.id.au>
Subject: Re: Patches added to for-2.6.25/master branches of powerpc.git
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18330.53318.857148.409675@cargo.ozlabs.ibm.com>
References: <18330.53318.857148.409675@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-lO8gAKY8AsccRZv31SBm"
Date: Sun, 27 Jan 2008 11:49:48 +1100
Message-Id: <1201394998.6659.3.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-lO8gAKY8AsccRZv31SBm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2008-01-26 at 17:16 +1100, Paul Mackerras wrote:
> This includes commits pulled from Josh Boyer, Kumar Gala, Grant
> Likely, and Olof Johansson.  I reverted the "Fake NUMA emulation for
> PowerPC" commit because it changed behaviour even when the fake numa
> command-line option wasn't given.
>=20
> I'll be asking Linus to pull within the next few days, so please
> remind me about anything else that should go in 2.6.25.

Can you grab these four assuming there's no objections in the meantime.

http://patchwork.ozlabs.org/linuxppc/patch?q=3Dellerman&id=3D16430
http://patchwork.ozlabs.org/linuxppc/patch?q=3Dellerman&id=3D16433
http://patchwork.ozlabs.org/linuxppc/patch?q=3Dellerman&id=3D16434
http://patchwork.ozlabs.org/linuxppc/patch?q=3Dellerman&id=3D16437

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-lO8gAKY8AsccRZv31SBm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHm9UsdSjSd0sB4dIRAn49AKDKqxfwcwyic+3k4XW7k66K1l8lnwCgrnBJ
ho/mmx8a1Z4TBQ2abssazW8=
=a112
-----END PGP SIGNATURE-----

--=-lO8gAKY8AsccRZv31SBm--
