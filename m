Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/3] Add a new member name to structure irq_host
From: Michael Ellerman <michael@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <91856a9e02132d2deb4368eee954c931@kernel.crashing.org>
References: <11851892302391-git-send-email-g.chen@freescale.com>
	<11851892311178-git-send-email-g.chen@freescale.com>
	<1185228277.5439.141.camel@localhost.localdomain>
	<1185232974.13740.11.camel@concordia.ozlabs.ibm.com>
	<f55fea27ac3a248cc99d52462d413e1e@kernel.crashing.org>
	<1185918267.5495.505.camel@localhost.localdomain>
	<91856a9e02132d2deb4368eee954c931@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-LZeIE0CwNyALILJZT/9v"
Date: Wed, 01 Aug 2007 09:06:23 +1000
Message-Id: <1185923183.5380.0.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Chen Gong <g.chen@freescale.com>, paulus@samba.org, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-LZeIE0CwNyALILJZT/9v
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-08-01 at 00:13 +0200, Segher Boessenkool wrote:
> >>> Which makes me think (again) that we should have an optional
> >>> device_node
> >>> pointer in irq_host. I know you said you wanted the irq stuff to be=20
> >>> OF
> >>> agnostic, but the reality is most of the implementations do have an=20
> >>> OF
> >>> node. And all of the newer irq_host implementations do, with the
> >>> exception of PS3 and celleb - which are special.
> >>
> >> How do you suggest to get a reasonable display name out of
> >> the device tree?  The recommended human-readable name for
> >> interrupt controller nodes is "interrupt-controller"...
> >> You cannot use "device_type" either, and using "compatible"
> >> requires selecting one of its string entries, and likely
> >> using a lookup table after that, too.
> >
> > In that case, I would display the node full path.
>=20
> Those tend to be quite long, in the cases where there are
> multiple interrupt controllers in the system; and really
> useless otherwise.  I think the interrupt controllers should
> still just fill in the names "manually".

They tend to be long, but they're unique, which is what you want, and
they're only for debugging anyway.

> It's a good thing to have an of_node in the irq_host struct
> anyway, though :-)

I posted patches for that last week.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-LZeIE0CwNyALILJZT/9v
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGr8BvdSjSd0sB4dIRAjj9AJ9m6fVDikRPQQxoq5F4TtjE7JHcWQCgjKPB
4exs2I52dtaw8yfBslgPEOk=
=1MP8
-----END PGP SIGNATURE-----

--=-LZeIE0CwNyALILJZT/9v--
