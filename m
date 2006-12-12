Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 12/15] powerpc: Do not use op_model_cell under LPAR
From: Michael Ellerman <michael@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200612122055.59698.arnd@arndb.de>
References: <200612120402.kBC42USg007674@toshiba.co.jp>
	<1165896791.14839.7.camel@concordia.ozlabs.ibm.com>
	<200612122055.59698.arnd@arndb.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ncK8I9CMH4rc+07iuMVC"
Date: Wed, 13 Dec 2006 09:51:11 +1100
Message-Id: <1165963871.21287.3.camel@concordia.ozlabs.ibm.com>
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


--=-ncK8I9CMH4rc+07iuMVC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-12-12 at 20:55 +0100, Arnd Bergmann wrote:
> On Tuesday 12 December 2006 05:13, Michael Ellerman wrote:
> >   On Tue, 2006-12-12 at 13:02 +0900, Ishizaki Kou wrote:
> > > op_model_cell supports native Cell processor. Under LPAR environment,
> > > it cannot work.
> > >=20
> > > Signed-off-by: Kou Ishizaki <kou.ishizaki.co.jp>
>=20
> Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
>=20
> >=20
> > Is FW_FEATURE_LPAR is the right switch to use here, I'm not sure.
>=20
> Yes, I think it is. The code accesses I/O memory areas that can not
> work under any hypervisor, so FW_FEATURE_LPAR makes perfect sense
> to me.

Yeah it's good enough.

But to be pedantic, P (LPAR) implies Q (HV), but !P does not imply !Q :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-ncK8I9CMH4rc+07iuMVC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFfzJedSjSd0sB4dIRAgkjAKCASZpnB3DoK30wgnd6QPs3Y7EGVgCeLh5V
cCrzz6qYdE93zMRReu2DNLE=
=REO7
-----END PGP SIGNATURE-----

--=-ncK8I9CMH4rc+07iuMVC--
