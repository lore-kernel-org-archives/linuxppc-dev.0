Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: minor fix of numa message
From: Michael Ellerman <michael@ellerman.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <45097273.8070103@am.sony.com>
References: <45097273.8070103@am.sony.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-LL46h287Qf7iwgZXk548"
Date: Fri, 15 Sep 2006 11:04:26 +1000
Message-Id: <1158282267.10020.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-LL46h287Qf7iwgZXk548
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-09-14 at 08:17 -0700, Geoff Levand wrote:
> This is a very minor fix that effects no current system.  The NUMA startu=
p
> message values for 'Top of RAM' and 'Memory hole size' were reported
> incorrectly if more than one lmb region was added.
>=20
> A comment in the lmb code states that lmb_analyze() must be called before
> lmb_phys_mem_size().

But we've already called it in early_init_devtree()?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-LL46h287Qf7iwgZXk548
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFCfwadSjSd0sB4dIRAp6yAKCFnFsifvkrG3sNI4/rC8AUPe1aZgCfRMHN
zBNHBLIOZ0e+nI3AnrX6nSg=
=OWbd
-----END PGP SIGNATURE-----

--=-LL46h287Qf7iwgZXk548--
