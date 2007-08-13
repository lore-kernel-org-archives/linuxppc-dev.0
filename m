Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 91196DDE02
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 11:39:59 +1000 (EST)
Date: Mon, 13 Aug 2007 11:39:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: DTC 1.0.0 Release Coming?
Message-Id: <20070813113949.b85be7ec.sfr@canb.auug.org.au>
In-Reply-To: <20070812092627.GB6803@localhost.localdomain>
References: <E1IE314-0000qF-5x@jdl.com>
	<20070726142739.GB18684@localhost.localdomain>
	<E1IE59h-0001tt-JE@jdl.com>
	<20070727013331.GB1561@localhost.localdomain>
	<20070806084813.5432ba91@weaponx.rchland.ibm.com>
	<20070810013001.GF17370@localhost.localdomain>
	<20070809203754.2e9192c5@zod.rchland.ibm.com>
	<20070810025944.GI17370@localhost.localdomain>
	<18109.2103.507694.281225@cargo.ozlabs.ibm.com>
	<46BD1272.9060107@am.sony.com>
	<20070812092627.GB6803@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__13_Aug_2007_11_39_49_+1000_7p1ObjU5+Y.Ie2E="
Cc: linuxppc-dev@ozlabs.org, Loeliger <jdl@jdl.com>,
	Paul Mackerras <paulus@samba.org>, Jon
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__13_Aug_2007_11_39_49_+1000_7p1ObjU5+Y.Ie2E=
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 12 Aug 2007 19:26:27 +1000 David Gibson <dwg@au1.ibm.com> wrote:
>
> On Fri, Aug 10, 2007 at 06:35:46PM -0700, Geoff Levand wrote:
> >=20
> > We could also ship a generated .S file (dtc -O asm -o ps3-dt.S
> > ps3.dts), which would be easier to maintain in the source tree than a
> > binary file, then use something like this in the wrapper script:
> >  =20
> >   ${CROSS}gcc -c -o ${platform}-dt.o ${platform}-dt.S
> >   ${CROSS}objcopy -O binary ${platform}-dt.o ${platform}.dtb
> >=20
> > Untested, but it seems like it would work.
>=20
> Yes, I'm aware of that option and am considering it.

Seems like a better option than a binary blob ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__13_Aug_2007_11_39_49_+1000_7p1ObjU5+Y.Ie2E=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGv7ZqTgG2atn1QN8RAtlKAJ0UsWtKA4atG8y36F/8o/Z9ZRFfwwCfXzfD
QIO7j+66+jFUlE7pAERE6U0=
=DvwP
-----END PGP SIGNATURE-----

--Signature=_Mon__13_Aug_2007_11_39_49_+1000_7p1ObjU5+Y.Ie2E=--
