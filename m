Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Fix /dev/oldmem for kdump
From: Michael Ellerman <michael@ellerman.id.au>
To: "Sachin P. Sant" <sachinp@in.ibm.com>
In-Reply-To: <486C726A.9080606@in.ibm.com>
References: <48637594.5040709@in.ibm.com>
	<1215065710.17950.12.camel@localhost>  <486C726A.9080606@in.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-bAVyYX0KacCVUyDXmsZ0"
Date: Thu, 03 Jul 2008 16:36:04 +1000
Message-Id: <1215066964.17950.28.camel@localhost>
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


--=-bAVyYX0KacCVUyDXmsZ0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-07-03 at 12:02 +0530, Sachin P. Sant wrote:
> Michael Ellerman wrote:
> > Even though I wrote this, it was so long ago I can't really vouch for
> > it. If you've tested it and it works Sachin then we should merge it. Is
> > this fix in distros or does it not apply?
> >  =20
> Yes, i have tested this on couple of power boxes and the patch
> works fine. [ i can copy dump using both /proc/vmcore and /dev/oldmem
> interface ]

OK great, thanks for that.

> No this fix is not part of distro ATM. But yes it applies to distros
> also. Once it is merged upstream, distros will eventually pick this up.

Crud, OK well I guess we should hurry up and merge it then :D

Paul, this has been broken for quite a while, but it would still be nice
if the fix was in 26 - sorry!

Acked-by: Michael Ellerman <michael@ellerman.id.au>

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-bAVyYX0KacCVUyDXmsZ0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIbHNUdSjSd0sB4dIRAvh4AJ46tPEz8+/Xz16SXdBLOFrY6LKQfgCgi+M1
kpqznj47asn4tjZolYJiOvo=
=KpkT
-----END PGP SIGNATURE-----

--=-bAVyYX0KacCVUyDXmsZ0--
