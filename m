Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/2] Make setjmp/longjmp code generic
From: Michael Ellerman <michael@ellerman.id.au>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080117064527.397cdfd6@zod.rchland.ibm.com>
References: <1200545142.37022.89292279731.qpush@coopers>
	<20080117044542.2F6CD70006@localhost.localdomain>
	<20080117053857.GA29035@lixom.net> <15983.1200548209@neuling.org>
	<20080117064527.397cdfd6@zod.rchland.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-NbHZHQq32Rsd04AWwN0e"
Date: Fri, 18 Jan 2008 08:49:22 +1100
Message-Id: <1200606562.7295.4.camel@concordia>
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, THEMANN@de.ibm.com,
	linuxppc-dev@ozlabs.org, RAISCH@de.ibm.com,
	Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-NbHZHQq32Rsd04AWwN0e
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-01-17 at 06:45 -0600, Josh Boyer wrote:
> On Thu, 17 Jan 2008 16:36:49 +1100
> Michael Neuling <mikey@neuling.org> wrote:
> > In message <20080117053857.GA29035@lixom.net> you wrote:
> > > Hi,
> > >=20
> > > On Thu, Jan 17, 2008 at 03:45:42PM +1100, Michael Neuling wrote:
> > >=20
> > > > Index: linux-2.6-ozlabs/include/asm-powerpc/setjmp.h
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > --- /dev/null
> > > > +++ linux-2.6-ozlabs/include/asm-powerpc/setjmp.h
> > > > @@ -0,0 +1,18 @@
> > > > +/*
> > > > + * Copyright (C) 2007 Michael Neuling
> >                      ^^^^^^
> >=20
> > > > + *
> > > > + *      This program is free software; you can redistribute it and=
/or
> > > > + *      modify it under the terms of the GNU General Public Licens=
e
> > > > + *      as published by the Free Software Foundation; either versi=
on
> > > > + *      2 of the License, or (at your option) any later version.
> > > > + *
> > > > + */
> > > > +#ifndef _ASM_POWERPC_SETJMP_H
> > > > +#define _ASM_POWERPC_SETJMP_H
> > > > +
> > > > +#define JMP_BUF_LEN    23
> > > > +
> > > > +extern long setjmp(long *);
> > > > +extern void longjmp(long *, long);
> > > > +
> > > > +#endif /* _ASM_POWERPC_SETJMP_H */
> > >=20
> > > Should the above be inside #ifdef __KERNEL__?
> >=20
> > Yep... _and_ it's 2008 now!
> >=20
> > I'll update.
>=20
> While you're off updating it, remove the (C).  It's bogus and shouldn't
> be there.

And it should say IBM corp too.

Oh and my car needs a wash when you're free ..

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-NbHZHQq32Rsd04AWwN0e
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHj81idSjSd0sB4dIRAvZyAKCGpms9NolhHg6BB1AX1Jl81HHX0ACfZAfn
0YxumSJkYj1qXsQmrtztJyc=
=fKvf
-----END PGP SIGNATURE-----

--=-NbHZHQq32Rsd04AWwN0e--
