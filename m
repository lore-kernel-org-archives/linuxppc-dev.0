Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] update sysfs kset initialisation in PPC64 DLPAR IO driver
From: Michael Ellerman <michael@ellerman.id.au>
To: Greg KH <gregkh@suse.de>
In-Reply-To: <20070511071606.GB1211@suse.de>
References: <464322F3.3010808@shadowen.org>
	<2c705c055fcd12202673ee8a3056153b@pinky>
	<20070510141221.GA26709@suse.de>
	<46434041.7020903@shadowen.org>  <20070511071606.GB1211@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-9fM6HOSO93kqWbFKOdcv"
Date: Fri, 11 May 2007 17:58:09 +1000
Message-Id: <1178870289.3923.6.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-9fM6HOSO93kqWbFKOdcv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-05-11 at 00:16 -0700, Greg KH wrote:
> On Thu, May 10, 2007 at 04:54:41PM +0100, Andy Whitcroft wrote:
> > Greg KH wrote:
> > > On Thu, May 10, 2007 at 03:00:50PM +0100, Andy Whitcroft wrote:
> > >> Move the rpadlpar device from "struct subsystem" to "struct kset"
> > >> following the changes in sysfs.
> > >>
> > >> Signed-off-by: Andy Whitcroft <apw@shadowen.org>
> > >> ---
> > >>
> > >> 	Ok, this patch seems to sort out the compile problem
> > >> 	here and indeed boots and runs kernbench.  Perhaps
> > >> 	you could confirm this is sufficient.
> > >=20
> > > As per the discussion on the pci hotplug list, no, this doesn't seem =
to
> > > fix the problem.  The developers there are looking into it.  If you c=
an
> > > test out patches for this, I'm sure the people there would appreciate
> > > the help.
> >=20
> > Sure anything they have for testing, send them to me ...
>=20
> They have the same patch that you made (I made it), yet they reported
> that it didn't work properly for them.
>=20
> Can you test your patch out on "real" hardware?

I tested it on real hardware, but it can't hurt for Andy to try it too I
guess.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-9fM6HOSO93kqWbFKOdcv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGRCIRdSjSd0sB4dIRAhwWAKCW3P81yq8niHMm4c1WlXH9SQNilwCgyCy+
GEAmYifw9pFkVV7fw1MkA0Y=
=mESi
-----END PGP SIGNATURE-----

--=-9fM6HOSO93kqWbFKOdcv--
