Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 6/16] cell: abstract spu management routines
From: Michael Ellerman <michael@ellerman.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <4554DA9C.9040102@am.sony.com>
References: <4554DA9C.9040102@am.sony.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-UZn5SO+a5lGEcosiGr6A"
Date: Mon, 13 Nov 2006 15:11:21 +1100
Message-Id: <1163391081.7410.65.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd@arndb.de>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-UZn5SO+a5lGEcosiGr6A
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-11-10 at 12:01 -0800, Geoff Levand wrote:
> This adds a platform specific spu management abstraction and the corespon=
ding
> routines to support the IBM Cell Blade.  It also removes the hypervisor o=
nly
> resources that were included in struct spu.
>=20
> Three new platform specific routines are introduced, spu_enumerate_spus()=
,
> spu_create_spu() and spu_destroy_spu().  The underlining design uses a ne=
w
> type, struct spu_management_ops, to hold function pointers that the platf=
orm
> setup code is expected to initialize to instances appropriate to that pla=
tform.
>=20
> For the IBM Cell Blade support, I put the hypervisor only resources that =
were
> in struct spu into a platform specific data structure struct spu_pdata.

As far as I can see you haven't posted your HV-backed management ops, is
that right?

Why can't your PS3 platform code fake-up device nodes for SPUs? It seems
that would simplify this quite a lot.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-UZn5SO+a5lGEcosiGr6A
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFV/BpdSjSd0sB4dIRAgZ1AJ93+BSzteEmVTDZxYGp28ckyvMQwQCfcEA/
1ViGkr2w3Fmic5ucWm13Us0=
=wfdW
-----END PGP SIGNATURE-----

--=-UZn5SO+a5lGEcosiGr6A--
