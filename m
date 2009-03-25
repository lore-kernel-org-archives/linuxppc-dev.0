Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Add write barrier before enabling DTL flags
From: Michael Ellerman <michael@ellerman.id.au>
To: Jeremy Kerr <jk@ozlabs.org>
In-Reply-To: <200903241659.55302.jk@ozlabs.org>
References: <1237863308.620048.912148989400.1.gpush@pingu>
	<1237874006.6478.284.camel@localhost>
	<200903241659.55302.jk@ozlabs.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-J7nX/HkyCTHJqJSdy8+L"
Date: Wed, 25 Mar 2009 11:44:42 +1100
Message-Id: <1237941882.6462.64.camel@localhost>
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


--=-J7nX/HkyCTHJqJSdy8+L
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-03-24 at 16:59 +1100, Jeremy Kerr wrote:
> Michael,
>=20
> > Wouldn't this still be a problem on a UP kernel?
>=20
> I don't believe so - stores should be ordered with respect to the=20
> current CPU, and in the UP case we still get a barrier().

But what if the CPU decides to do the store to the enable_mask before
the stores to the other fields?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-J7nX/HkyCTHJqJSdy8+L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknJfnoACgkQdSjSd0sB4dLWYgCdEpBKR9/KbrK7qc6ebGADvj7E
2LAAoK5ztDCsglYnk7/QyPWlKmqQTr5s
=+04I
-----END PGP SIGNATURE-----

--=-J7nX/HkyCTHJqJSdy8+L--
