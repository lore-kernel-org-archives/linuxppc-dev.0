Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] [POWERPC] Always hookup PHB IO resource even when empty
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20080121003256.E1EBDDDDF0@ozlabs.org>
References: <20080121003256.E1EBDDDDF0@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/wnO5wxT3izwv+apEMSM"
Date: Mon, 21 Jan 2008 11:37:01 +1100
Message-Id: <1200875821.8537.4.camel@concordia.ozlabs.ibm.com>
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


--=-/wnO5wxT3izwv+apEMSM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-01-21 at 11:32 +1100, Benjamin Herrenschmidt wrote:
> We must always hookup the pci_bus resource 0 to the PHB io_resource even
> if the later is empty (the bus has no IO support). Otherwise, some other
> code will end up hooking it up to something bogus and the resource tree
> will end up being broken.
>=20
> This fixes boot on QS20 Cell blades where the IDE driver failed to alloca=
te
> the IO resources due to breakage of the resource tree.

Tested-by: Michael Ellerman <michael@ellerman.id.au>

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-/wnO5wxT3izwv+apEMSM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHk+ktdSjSd0sB4dIRAhY1AJ0RRBtpLnJMtDRNtYv7mqal9NSoaACZAQFn
PlFdUKLfl/H0Si2+oIZ6eM8=
=7xDq
-----END PGP SIGNATURE-----

--=-/wnO5wxT3izwv+apEMSM--
