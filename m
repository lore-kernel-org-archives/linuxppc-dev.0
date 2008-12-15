Return-Path: <michael@ellerman.id.au>
Subject: Re: Need help to understand why kdump is for 64 bit PPC only
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1228A590-B809-4EBB-BC6F-05525220656A@kernel.crashing.org>
References: <80872bab0812151058tdffd4b9ucd9031db21c9fc76@mail.gmail.com>
	<1228A590-B809-4EBB-BC6F-05525220656A@kernel.crashing.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-NVz0NnZjjIizb2aqbX98"
Date: Tue, 16 Dec 2008 07:33:04 +1100
Message-Id: <1229373184.8332.3.camel@localhost>
Mime-Version: 1.0
Cc: Frank Fan <linuxppcstudy@gmail.com>, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-NVz0NnZjjIizb2aqbX98
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-12-15 at 13:35 -0600, Kumar Gala wrote:
> On Dec 15, 2008, at 12:58 PM, Frank Fan wrote:
>=20
> > Hello,
> >
> > I am working on a freescale MPC8572 CPU board and use 32 bit =20
> > Linux2.6.28.  When I enable 64 bit, it shows "kdump" in "kernel =20
> > options". Otherwise, "kdump" is disabled.
> > Can someone give me some hint why kdump is for 64 bit PPC only?
>=20
> Probably because no one has implemented or tested it on ppc32/8572.

Pretty much, the 32-bit version of default_machine_kexec() is pretty
na=C3=AFve, but you never know it might work.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-NVz0NnZjjIizb2aqbX98
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklGvwAACgkQdSjSd0sB4dJPQwCgituIEUIsORwxxpzyAPkGDldm
x3oAmgP+YD7C22ClMY1bCIUsvR7kAXmV
=nXgY
-----END PGP SIGNATURE-----

--=-NVz0NnZjjIizb2aqbX98--
