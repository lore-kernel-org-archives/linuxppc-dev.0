Return-Path: <michael@ellerman.id.au>
Subject: Re: linux-next: kbuild tree build failure
From: Michael Ellerman <michael@ellerman.id.au>
To: Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <Pine.LNX.4.64.0807080437550.6791@localhost.localdomain>
References: <20080707184038.aaeb8d40.sfr@canb.auug.org.au>
	<Pine.LNX.4.64.0807071424240.6791@localhost.localdomain>
	<1215473798.8138.4.camel@localhost>
	<Pine.LNX.4.64.0807080437550.6791@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-f2U83HqNGoqntcbZYP1L"
Date: Thu, 10 Jul 2008 10:51:22 +1000
Message-Id: <1215651082.13950.7.camel@localhost>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Sam Ravnborg <sam@ravnborg.org>, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-f2U83HqNGoqntcbZYP1L
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-07-08 at 04:55 +0200, Roman Zippel wrote:
> Hi,
>=20
> On Tue, 8 Jul 2008, Michael Ellerman wrote:
>=20
> > I don't really see why it "doesn't make sense" for users to input 64-bi=
t
> > values, they're configuring addresses for a 64-bit kernel, so some of
> > the values are going to be 64 bit.
>=20
> Do you really expect users to insert random 64bit addresses without makin=
g=20
> a mistake?

Well yes :)  But I think that's because you're thinking of=20
"end-users" and I'm thinking of "users" like myself - ie. _I_ use
Kconfig and I do expect myself to be able to type a 64-bit address.


> > --- .config.orig	2008-07-08 09:30:00.000000000 +1000
> > +++ .config	2008-07-08 09:30:43.000000000 +1000
> > @@ -370,9 +370,8 @@
> >  CONFIG_HOTPLUG_PCI_RPA=3Dm
> >  CONFIG_HOTPLUG_PCI_RPA_DLPAR=3Dm
> >  # CONFIG_HAS_RAPIDIO is not set
> > -CONFIG_PAGE_OFFSET=3D0xc000000000000000
> > -CONFIG_KERNEL_START=3D0xc000000002000000
> > -CONFIG_PHYSICAL_START=3D0x02000000
> > +CONFIG_PAGE_OFFSET=3D0xc0000000
> > +CONFIG_PHYSICAL_START=3D0x2000000
>=20
> Why is this worse? These are constants, you're not supposed to change the=
m=20
> anyway.
> The remaining values are generated in page.h and should be the same as=20
> before. If that isn't the case and this patch produces a nonworking=20
> kernel, I'd like to hear about it.

You're right the built kernel is fine. So it's not a bug, but I think it
is nicer to have the real values in the .config.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-f2U83HqNGoqntcbZYP1L
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIdV0KdSjSd0sB4dIRAvT8AKDKfgXQfS/8JEykZwu1ggYhGDRwbwCgiUuh
YR3ZeOUxT2G+Gob3pyC+y1k=
=Lz5i
-----END PGP SIGNATURE-----

--=-f2U83HqNGoqntcbZYP1L--
