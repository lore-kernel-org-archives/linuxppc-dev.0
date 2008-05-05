Return-Path: <michael@ellerman.id.au>
Subject: Re: WARNING: mutexes are preferred for single holder semaphores
From: Michael Ellerman <michael@ellerman.id.au>
To: Sean MacLennan <seanm@seanm.ca>
In-Reply-To: <20080504204104.7eea7618@lappy.seanm.ca>
References: <20080504204104.7eea7618@lappy.seanm.ca>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-SHc9PO4GJBAyf1l0eEkS"
Date: Mon, 05 May 2008 11:06:55 +1000
Message-Id: <1209949615.8159.7.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-SHc9PO4GJBAyf1l0eEkS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2008-05-04 at 20:41 -0400, Sean MacLennan wrote:
> This is a bit OT, but I got the warning in the subject from
> checkpatch.pl for a piece of code. The code *is* using a mutex. Does it
> actually mean I shouldn't use a mutex?
>=20
> The code declares a global mutex:
>=20
> 	static DECLARE_MUTEX(list_lock);

.. which is a semaphore :(  [see include/linux/semaphore.h]

I think you want DEFINE_MUTEX().

Yes, this is completely ridiculous.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-SHc9PO4GJBAyf1l0eEkS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIHl2vdSjSd0sB4dIRAkW9AKCqZC6cuGFQBjSAvBUmArlYvdYEBACfTQXa
J0JAVI/Xh6VXeb5rPPeHSaQ=
=kYoG
-----END PGP SIGNATURE-----

--=-SHc9PO4GJBAyf1l0eEkS--
