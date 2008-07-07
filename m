Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 57644DDDF7
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 13:26:25 +1000 (EST)
Date: Mon, 7 Jul 2008 13:26:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: linuxppc-dev@ozlabs.org
Subject: Re: the printk problem
Message-Id: <20080707132615.f6b6247b.sfr@canb.auug.org.au>
In-Reply-To: <1215393276.8970.36.camel@pasglop>
References: <20080625131101.GA6205@digi.com> <20080704104634.GA31634@digi.com>
	<20080704111540.ddffd241.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0807041147450.2815@woody.linux-foundation.org>
	<alpine.LFD.1.10.0807041250220.2815@woody.linux-foundation.org>
	<1215212420.8970.8.camel@pasglop>
	<alpine.LFD.1.10.0807041622270.2815@woody.linux-foundation.org>
	<1215393276.8970.36.camel@pasglop>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__7_Jul_2008_13_26_15_+1000_+HtuUZKAXIshAXYD"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__7_Jul_2008_13_26_15_+1000_+HtuUZKAXIshAXYD
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 07 Jul 2008 11:14:36 +1000 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> On Fri, 2008-07-04 at 16:25 -0700, Linus Torvalds wrote:
> >=20
> > On Sat, 5 Jul 2008, Benjamin Herrenschmidt wrote:
> > >=20
> > > I'll give it a try using =EF=BB=BFprobe_kernel_address() instead on m=
onday.
> >=20
> > Here's the updated patch which uses probe_kernel_address() instead (and=
=20
> > moves the whole #ifdef mess out of the code that wants it and into a=20
> > helper function - and maybe we should then put that helper into=20
> > kallsyms.h, but that's a different issue).
> >=20
> > Still all happily untested, of course. And still with no actual users=20
> > converted.
>=20
> Did a few tests and it seems to work. I'll stick a patch converting
> powerpc to use %pS for oops display in -next.

After you post it to linuxppc-dev and get review comments, of course ...

And after the patch to make %pS work goes in ...
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__7_Jul_2008_13_26_15_+1000_+HtuUZKAXIshAXYD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhxjNcACgkQjjKRsyhoI8w9YACguWEk7l0t/Y/ZyW5ji0P/dx7E
HHwAn2GkvJp+ergijyBZAvhWSoC3tsrn
=X1SN
-----END PGP SIGNATURE-----

--Signature=_Mon__7_Jul_2008_13_26_15_+1000_+HtuUZKAXIshAXYD--
