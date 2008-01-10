Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/8] pseries: phyp dump: Docmentation
From: Michael Ellerman <michael@ellerman.id.au>
To: linasvepstas@gmail.com
In-Reply-To: <3ae3aa420801092012m5e47cbd7lc7a5f91842074af7@mail.gmail.com>
References: <4782B985.2090508@austin.ibm.com>
	<4782C026.8080302@austin.ibm.com> <20080109042911.GT14201@localdomain>
	<3ae3aa420801090731r2e25e42awcae385b448e20b16@mail.gmail.com>
	<20080109184437.GU14201@localdomain>
	<3ae3aa420801091833i6cf32616o2a060579be1f3191@mail.gmail.com>
	<20080110031723.GA22168@lixom.net>
	<3ae3aa420801092012m5e47cbd7lc7a5f91842074af7@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-4gEKaI/k4aiRac3zX06v"
Date: Thu, 10 Jan 2008 15:52:31 +1100
Message-Id: <1199940751.7880.34.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, lkessler@us.ibm.com, mahuja@us.ibm.com,
	Nathan Lynch <ntl@pobox.com>, Olof Johansson <olof@lixom.net>,
	strosake@us.ibm.com
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-4gEKaI/k4aiRac3zX06v
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-01-09 at 22:12 -0600, Linas Vepstas wrote:
> On 09/01/2008, Olof Johansson <olof@lixom.net> wrote:
> > On Wed, Jan 09, 2008 at 08:33:53PM -0600, Linas Vepstas wrote:
> >
> > > Heh. That's the elbow-grease of this thing.  The easy part is to get
> > > the core function working. The hard part is to test these various con=
figs,
> > > and when they don't work, figure out what went wrong. That will take
> > > perseverence and brains.
> >
> > This just sounds like a whole lot of extra work to get a feature that
> > already exists.
>=20
> Well, no. kexec is horribly ill-behaved with respect to PCI. The
> kexec kernel starts running with PCI devices in some random
> state; maybe they're DMA'ing or who knows what. kexec tries
> real hard to whack a few needed pci devices into submission
> but it has been hit-n-miss, and the source of 90% of the kexec
> headaches and debugging effort. Its not pretty.

Isn't that what EEH and the IOMMU are for? :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-4gEKaI/k4aiRac3zX06v
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHhaSPdSjSd0sB4dIRAowrAJ9qGc+rVNzzemi8zRITbVnb2Zn9mwCgvatJ
oG8jjuCplQ5GZ6tMSzIftI0=
=qqpY
-----END PGP SIGNATURE-----

--=-4gEKaI/k4aiRac3zX06v--
