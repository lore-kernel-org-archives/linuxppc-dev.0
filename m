Return-Path: <michael@ellerman.id.au>
Subject: Re: the printk problem
From: Michael Ellerman <michael@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080707132615.f6b6247b.sfr@canb.auug.org.au>
References: <20080625131101.GA6205@digi.com> <20080704104634.GA31634@digi.com>
	<20080704111540.ddffd241.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0807041147450.2815@woody.linux-foundation.org>
	<alpine.LFD.1.10.0807041250220.2815@woody.linux-foundation.org>
	<1215212420.8970.8.camel@pasglop>
	<alpine.LFD.1.10.0807041622270.2815@woody.linux-foundation.org>
	<1215393276.8970.36.camel@pasglop>
	<20080707132615.f6b6247b.sfr@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-RsOWnTUXZPB0e9SfEjQF"
Date: Mon, 07 Jul 2008 13:28:18 +1000
Message-Id: <1215401298.9862.1.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-RsOWnTUXZPB0e9SfEjQF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-07-07 at 13:26 +1000, Stephen Rothwell wrote:
> On Mon, 07 Jul 2008 11:14:36 +1000 Benjamin Herrenschmidt <benh@kernel.cr=
ashing.org> wrote:
> >
> > On Fri, 2008-07-04 at 16:25 -0700, Linus Torvalds wrote:
> > >=20
> > > On Sat, 5 Jul 2008, Benjamin Herrenschmidt wrote:
> > > >=20
> > > > I'll give it a try using =EF=BB=BFprobe_kernel_address() instead on=
 monday.
> > >=20
> > > Here's the updated patch which uses probe_kernel_address() instead (a=
nd=20
> > > moves the whole #ifdef mess out of the code that wants it and into a=20
> > > helper function - and maybe we should then put that helper into=20
> > > kallsyms.h, but that's a different issue).
> > >=20
> > > Still all happily untested, of course. And still with no actual users=
=20
> > > converted.
> >=20
> > Did a few tests and it seems to work. I'll stick a patch converting
> > powerpc to use %pS for oops display in -next.
>=20
> After you post it to linuxppc-dev and get review comments, of course ...
>=20
> And after the patch to make %pS work goes in ...

Wasn't that already merged via the trivial scheduler fixes tree or
something? ;)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-RsOWnTUXZPB0e9SfEjQF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIcY1SdSjSd0sB4dIRAu5tAKCDrQyuAjgyimU1RrMB94sQ5ymuIACeM7En
h07jmQW7FXQs9HkCtPsRnUY=
=25Yt
-----END PGP SIGNATURE-----

--=-RsOWnTUXZPB0e9SfEjQF--
