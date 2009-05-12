Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DFAE0DDDEE
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 12:37:51 +1000 (EST)
Subject: Re: device trees.
From: Michael Ellerman <michael@ellerman.id.au>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20090511225631.GA15371@yookeroo.seuss>
References: <4A0457BC.3040408@dlasys.net>
	<fa686aa40905091351k140c64a0w27eb44908218814@mail.gmail.com>
	<1242007203.7767.28.camel@concordia>
	<fa686aa40905102108l5c964893y2dfb84763e13511@mail.gmail.com>
	<4A07C664.6040609@dlasys.net>
	<fa686aa40905110651r1c18b78bpe8ffebe041726695@mail.gmail.com>
	<4A085612.9050602@dlasys.net>
	<fa686aa40905111047p5f350b0dh796564cc1383a336@mail.gmail.com>
	<4A089AC8.9080704@dlasys.net> <20090511225631.GA15371@yookeroo.seuss>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-QEToRSYOYBJ9QlA+gIoy"
Date: Tue, 12 May 2009 12:37:50 +1000
Message-Id: <1242095870.7421.30.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, "David H. Lynch Jr." <dhlii@dlasys.net>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-QEToRSYOYBJ9QlA+gIoy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-05-12 at 08:56 +1000, David Gibson wrote:
> On Mon, May 11, 2009 at 05:38:16PM -0400, David H. Lynch Jr. wrote:
> > Grant Likely wrote:
> > >>    Anyway, all I was looking for was a leg up on figuring out how to=
 do
> > >> what I want with them. Rather than starting from scratch.
> > >>    I am not looking to be convinced that I am approaching this all w=
rong.
> > >>    If you are happy with what you have - great. I am not.
> > >>    While I was not looking to restart a great debate over device tre=
es
> > >> - I do not actually think they are a bad idea.
> > >>    =20
> > >
> > > I still don't understand what you're worried about starting an arguin=
g
> > > about.  Pretty much any of the PowerPC maintainers can point at warts
> > > and problems in the current handling of device trees.  I'm not
> > > particularly happy with simpleImage (and I wrote it), but it takes
> > > time and effort to write something more capable.
> > >  =20
> >     I was not trying to start an argument, my initial question was
> >=20
> >    "Is there an example somewhere that shows building a device tree on =
the fly ?"
> >=20
> >    The responses have questioned why I want to do that rather than how =
can I do that.
> >    I was not actually seeking a debate over the merit of device trees, =
or u-boot, or libdft, or ....=20
>=20
> Probably the closest things to suitable examples here are
> arch/powerpc/kernel/prom_init.c, which builds the dtb from the "live"
> OF device tree.  At the moment that's a bit of a special case, but
> there's no inherent reason that logic couldn't be moved to the
> bootwrapper.
>=20
> The other, not in the main tree, is Paul's restodt, which builds a
> device tree from old-style PReP residual information.  I recall it was
> sent to the list as a userspace program (we were gathering information
> on the sorts of PReP out there).  I think Paul made at least a first
> cut at fusing it into the bootwrapper, but I don't know if that ever
> got sent out to the list.


There's also the iseries code, which is not pretty, but shows a very
minimal example of constructing a device tree on the fly, some of it
based on static config and some that's not.

The routines for constructing DT nodes and properties is about 110
lines, and most of that is brackets.

arch/powerpc/platforms/iseries/dt.c

cheers

--=-QEToRSYOYBJ9QlA+gIoy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoI4P4ACgkQdSjSd0sB4dKiwQCfekyJkMhR9BGnkQ4rYotceEI9
UgQAoMZr/0rTOEDSGdLEafmEIP51JTF9
=ZZMz
-----END PGP SIGNATURE-----

--=-QEToRSYOYBJ9QlA+gIoy--
