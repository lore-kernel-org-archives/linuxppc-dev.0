Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 3/5] powerpc: Move
	create_(instruction|branch|function_call) into util.h
From: Michael Ellerman <michael@ellerman.id.au>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20060330181049.GN2172@austin.ibm.com>
References: <1143699173.339118.857634197021.qpush@concordia>
	<20060330061300.0B12567B6C@ozlabs.org>
	<20060330181049.GN2172@austin.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-HzyYI1DRKz81ZNQKjv/X"
Date: Fri, 31 Mar 2006 09:43:05 +1100
Message-Id: <1143758585.10478.3.camel@localhost.localdomain>
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


--=-HzyYI1DRKz81ZNQKjv/X
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-03-30 at 12:10 -0600, Linas Vepstas wrote:
> Hi,
> A minor quibble from the dept. of naming things:
>=20
> On Thu, Mar 30, 2006 at 05:12:59PM +1100, Michael Ellerman wrote:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- /dev/null
> > +++ to-merge/include/asm-powerpc/util.h
> > @@ -0,0 +1,56 @@
> > +
> > +#ifndef _ASM_POWERPC_UTIL_H
> > +#define _ASM_POWERPC_UTIL_H
> > +
> > +static inline void create_instruction(unsigned long addr, unsigned int=
 instr)
>=20
>=20
> Surely there is a more descriptive name for this new file than "util.h"?
>=20
> How about "dynamic_insn.h" or "insn_patch.h" or "dyn_fixup.h" or
> something like that?=20

That would be more descriptive of what's in there now, but I actually
intended it to be a place where we can put util-ish code. Obviously
we'll have to make sure it doesn't get abused, but I think it's valid to
have one header file for random stuff that doesn't belong elsewhere.
Others may disagree?

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-HzyYI1DRKz81ZNQKjv/X
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBELF75dSjSd0sB4dIRAl/KAJsGG6YSWU78mNAuk6wEDTSXGmHSCwCdGFLX
8ugjHKFQub3he9IvNbtDhQE=
=xgEa
-----END PGP SIGNATURE-----

--=-HzyYI1DRKz81ZNQKjv/X--
