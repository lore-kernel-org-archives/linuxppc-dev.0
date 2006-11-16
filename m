Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 7/16] powerpc: add support for ps3 platform
From: Michael Ellerman <michael@ellerman.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <455BC1E1.2010300@am.sony.com>
References: <4554DACB.8060809@am.sony.com> <20061115180440.GB18856@lst.de>
	<455BC1E1.2010300@am.sony.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-gzB25fI1gXrKUCKKF2P4"
Date: Thu, 16 Nov 2006 13:13:01 +1100
Message-Id: <1163643181.8805.19.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-gzB25fI1gXrKUCKKF2P4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-11-15 at 17:41 -0800, Geoff Levand wrote:
> Christoph Hellwig wrote:

> >> +#if !defined(PPC_MSG_MIGRATE_TASK)
> >> +static const int PPC_MSG_MIGRATE_TASK =3D 2;
> >> +#endif
> >=20
> > This looks rather odd, what is it trying to do?
>=20
>=20
> For some reason the definition of PPC_MSG_MIGRATE_TASK is sometimes 2, an=
d
> sometimes not defined, depending on other config options.  It makes the c=
ode
> much simpler if it is always defined as 2.  Maybe it makes more sense if =
I
> change it to this:
>=20
> #if !defined(PPC_MSG_MIGRATE_TASK)
> #define PPC_MSG_MIGRATE_TASK 2
> #endif

include/asm-powerpc/smp.h says:

/* This is unused now */
#if 0
#define PPC_MSG_MIGRATE_TASK    2
#endif


So it will never be defined. Why do you need it, you don't seem to use
it anywhere?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-gzB25fI1gXrKUCKKF2P4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFW8ktdSjSd0sB4dIRAuWaAJ9kxhYPvcrqwS25adYNKIu6pPKZxACggBmD
lqc/4dDmxTDPNiOFFs2HId8=
=l5wB
-----END PGP SIGNATURE-----

--=-gzB25fI1gXrKUCKKF2P4--
