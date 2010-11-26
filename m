Return-Path: <michael@ellerman.id.au>
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
From: Michael Ellerman <michael@ellerman.id.au>
To: Mitch Bradley <wmb@firmworks.com>
In-Reply-To: <4CEF3AB1.9060200@firmworks.com>
References: <1290607413.12457.44.camel@concordia>
	<1290692075.689.20.camel@concordia>
	<AANLkTiknyKi1pzvUP2WnasudZwH27-a0FxCX0BSHBdQp@mail.gmail.com>
	<1290741341.9453.377.camel@concordia> <4CEF3AB1.9060200@firmworks.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-RjdHicf3+TnoU3RV7KT8"
Date: Fri, 26 Nov 2010 16:50:06 +1100
Message-ID: <1290750606.9453.394.camel@concordia>
Mime-Version: 1.0
Cc: linux-arch <linux-arch@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-RjdHicf3+TnoU3RV7KT8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-11-25 at 18:42 -1000, Mitch Bradley wrote:
> On 11/25/2010 5:15 PM, Michael Ellerman wrote:
> > On Thu, 2010-11-25 at 09:17 -0700, Grant Likely wrote:
> >> On Thu, Nov 25, 2010 at 6:34 AM, Michael Ellerman
> >> <michael@ellerman.id.au>  wrote:
> >>> On Thu, 2010-11-25 at 01:03 +1100, Michael Ellerman wrote:
> >>>> Hi all,
> >>>>
> >>>> There were some murmurings on IRC last week about renaming the of_*(=
)
> >>>> routines.
> >>> ...
> >>>> The thinking is that on many platforms that use the of_() routines
> >>>> OpenFirmware is not involved at all, this is true even on many power=
pc
> >>>> platforms. Also for folks who don't know the OpenFirmware connection
> >>>> it reads as "of", as in "a can of worms".
> >>> ...
> >>>> So I'm hoping people with either say "YES this is a great idea", or =
"NO
> >>>> this is stupid".
> >>>
> >>> I'm still hoping, but so far it seems most people have got better thi=
ngs
> >>> to do, and of those that do have an opinion the balance is slightly
> >>> positive.
> >>
> >> I assume you'll be also publishing the script that you use for
> >> generating the massive patch.  I expect that there will be a few
> >> iterations of running the rename script to convert over all the
> >> stragglers.
> >
> > Yep sure, I'll just make it less crap first.
> >
> >> It should also be negotiated with Linus about when this
> >> patch should get applied.  I do NOT want to cause massive merge pain
> >> during the merge window.
> >
> > Obviously.
> >
> >> Andrew/Linus: Before Michael proceeds too far with this rename, are
> >> you okay with a mass rename of the device tree functions from of_* to
> >> dt_*?  Nobody likes the ambiguous 'of_' prefix ("of?  of what?"), but
> >> to fix it means large cross-tree patches and potential merge
> >> conflicts.
> >
> > It'd also be good to hear from DaveM, sparc is the platform with the
> > strongest link to real OF AFAIK, so the of_() names make more sense
> > there.
>=20
>=20
> One Laptop Per Child ships real Open Firmware on its x86 Linux systems,=
=20
> of which approximately 2 million have been shipped or ordered.  An ARM=
=20
> version, also with OFW, is in the works.

OK. I don't see any code under arch/x86 or arch/arm that uses of_()
routines though? Or is it under drivers or something?

> That said, I don't particularly like the abbreviation "of" either; I=20
> abbreviate Open Firmware as "OFW".
>=20
> I don't mind using "dt_" to apply to device tree things; I think it's=20
> clearer than "of_".   Ideally, it would be nice to acknowledge the=20
> historical connection in some way, but confusing nomenclature probably=
=20
> is not the way to go about it.

Cool. I think there will still be a few things that have OF in the name,
at least for a while, and I'm sure the doco will still mention OF, so I
don't think the connection will be lost.

cheers


--=-RjdHicf3+TnoU3RV7KT8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkzvSo4ACgkQdSjSd0sB4dKAFgCfZ/XVl0IpdzYDesUlbE8qBCw+
ruAAnjUMgjlQFEEreJ3xCjQfwY9duecT
=uzOw
-----END PGP SIGNATURE-----

--=-RjdHicf3+TnoU3RV7KT8--
