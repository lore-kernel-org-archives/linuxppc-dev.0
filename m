Return-Path: <michael@ellerman.id.au>
Subject: Re: [patch 0/3] PS3 bugfix patches for 2.6.23
From: Michael Ellerman <michael@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20070808174740.8426f5f6.sfr@canb.auug.org.au>
References: <20070808033119.833895506@am.sony.com>
	<20070808171738.40d99505.sfr@canb.auug.org.au>
	<20070808174740.8426f5f6.sfr@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-06uw7VEfFNKpQ7+r66nu"
Date: Wed, 08 Aug 2007 22:06:29 +1000
Message-Id: <1186574789.9296.0.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-06uw7VEfFNKpQ7+r66nu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-08-08 at 17:47 +1000, Stephen Rothwell wrote:
> Hi Geoff,
>=20
> On Wed, 8 Aug 2007 17:17:38 +1000 Stephen Rothwell <sfr@canb.auug.org.au>
> wrote:
> >
> >   LD      .tmp_vmlinux1
> > arch/powerpc/platforms/built-in.o: In function `of_has_vicinity':
> > /home/sfr/kernels/linus/arch/powerpc/platforms/cell/spu_base.c:681:
> > undefined reference to `.spu_devnode'
>=20
> Ben pointed out patch "[PATCH v2] cell: move SPU affinity init to
> spu_management_of_ops" to me.

Can someone please merge it!

:)

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-06uw7VEfFNKpQ7+r66nu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGubHFdSjSd0sB4dIRAo8wAJ9f2mzNKmlbpqWlnD5ZCFx+PGfd1wCdEune
lRiomXx57/6oqC58et5yvg8=
=rafY
-----END PGP SIGNATURE-----

--=-06uw7VEfFNKpQ7+r66nu--
