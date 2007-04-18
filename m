Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Initialise spinlock in the DEBUG_PAGEALLOC code
From: Michael Ellerman <michael@ellerman.id.au>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <076a5a3adc4b5b29a3fd2ade48d52184@bga.com>
References: <076a5a3adc4b5b29a3fd2ade48d52184@bga.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-1pk4eDVlpOYMY33CagQb"
Date: Wed, 18 Apr 2007 11:38:48 +1000
Message-Id: <1176860328.4987.15.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-1pk4eDVlpOYMY33CagQb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-04-17 at 02:57 -0500, Milton Miller wrote:
> On Tue Apr 17 11:43:12 EST 2007, Michael Ellerman wrote:
> > -static spinlock_t linear_map_hash_lock;
> > +static spinlock_t linear_map_hash_lock =3D SPIN_LOCK_UNLOCKED;
>=20
> I think the people in this thread
>=20
> [KJ][PATCH]SPIN_LOCK_UNLOCKED cleanup in arch/powerpc
> http://ozlabs.org/pipermail/linuxppc-dev/2007-April/034210.html
>=20
> SPIN_LOCK_UNLOCKED cleanup,use DEFINE_SPINLOCK or
> __SPIN_LOCK_UNLOCKED where ever appropriate.
>=20
> would like you to initialize it differently.  (I think it has
> to do with the lock dependancy stuff).

And it's documented where .. ?

I'll send a new patch.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-1pk4eDVlpOYMY33CagQb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBGJXaodSjSd0sB4dIRAlabAJ9Dk8gYyketUEv8yIEEbna95RKQoQCcDagJ
D21I9ZN1oP/Ot4oKpWciVEQ=
=6nrm
-----END PGP SIGNATURE-----

--=-1pk4eDVlpOYMY33CagQb--
