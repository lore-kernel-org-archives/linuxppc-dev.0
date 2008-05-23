Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc ptrace block-step
From: Michael Ellerman <michael@ellerman.id.au>
To: Roland McGrath <roland@redhat.com>
In-Reply-To: <20080502065145.B4FCA26FA07@magilla.localdomain>
References: <20080502065145.B4FCA26FA07@magilla.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-iHwnAWsEKcqsWYj/xk/p"
Date: Fri, 23 May 2008 16:21:44 +1000
Message-Id: <1211523704.27274.8.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-iHwnAWsEKcqsWYj/xk/p
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-05-01 at 23:51 -0700, Roland McGrath wrote:
> I didn't test the booke variant of this (I don't have that hardware).
> I only tested it on a Mac G5 (ppc64, 970FX).
>=20
> There is a test program at:
>=20
> http://sources.redhat.com/cgi-bin/cvsweb.cgi/~checkout~/tests/ptrace-test=
s/tests/block-step.c?cvsroot=3Dsystemtap
>=20
> To build that program for powerpc, remove the && 0 from this line:
>=20
> # elif defined __powerpc__  && 0	/* XXX not upstream yet */
>=20
> and compile with -D_GNU_SOURCE.

I ran this on a power3 and it worked fine, by which I mean the testcase
didn't hit any assertions AFAICT and returned 0.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-iHwnAWsEKcqsWYj/xk/p
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBINmJ4dSjSd0sB4dIRAmW1AJ9BqXtvXjQZtnGStTA/2fyC14pWRQCgvUMq
pXjg/k5vdZofxuhQS3KS5dw=
=SOrn
-----END PGP SIGNATURE-----

--=-iHwnAWsEKcqsWYj/xk/p--
