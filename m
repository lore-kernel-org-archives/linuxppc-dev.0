Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Add idle power save for ppc 4xx
From: Michael Ellerman <michael@ellerman.id.au>
To: Josh Boyer <jwboyer@gmail.com>
In-Reply-To: <1207019732.12155.81.camel@vader.jdub.homelinux.org>
References: <10aea37177130bbe5de7.1206969157@thinkpadL>
	<1206983237.12155.60.camel@vader.jdub.homelinux.org>
	<20080331130518.2a6b0264@zod.rchland.ibm.com>
	<1206987598.9165.10.camel@thinkpadL>
	<1207011862.7490.5.camel@concordia.ozlabs.ibm.com>
	<1207019732.12155.81.camel@vader.jdub.homelinux.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-a0lBqzHQhHYMabPV+ro+"
Date: Tue, 01 Apr 2008 14:30:58 +1100
Message-Id: <1207020658.15411.4.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-a0lBqzHQhHYMabPV+ro+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-03-31 at 22:15 -0500, Josh Boyer wrote:
> On Tue, 2008-04-01 at 12:04 +1100, Michael Ellerman wrote:
> > > > > I'm assuming you pass a dtb to the virtual guest when you start i=
t up.
> > > > > Could you define a property in the CPU node there that can be par=
sed to
> > > > > use the power_save function instead of always making it the defau=
lt?
> > > >=20
> > > > Actually, you probably don't want this as a property in the device
> > > > tree.  It doesn't describe hardware.  A Kconfig option might be
> > > > warranted though.
> > >=20
> > > I'll go with the Kconfig option.=20
> >=20
> > Go with a device-tree check. The pseries kernel supports both bare-meta=
l
> > and hypervisor in the same kernel image, and it works out which it's
> > running on by looking at the device-tree. This seems equivalent to me?
>=20
> After some back and forth on IRC, we decided on that as well.  I love
> being right, then wrong, then right again.
>=20
> /me needs more sleep.

Better to be right twice rather than once, no?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-a0lBqzHQhHYMabPV+ro+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH8axydSjSd0sB4dIRAh5hAJ4wSfWPVIb4eonJTiOaeeq88zBQDQCfc61r
37UMGpm3e/p1BfWWX/026l4=
=282b
-----END PGP SIGNATURE-----

--=-a0lBqzHQhHYMabPV+ro+--
