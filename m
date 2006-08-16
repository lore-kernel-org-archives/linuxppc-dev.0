Return-Path: <michael@ellerman.id.au>
Subject: Re: [POWERPC] iseries: remove some gcc 4.1 warnings
From: Michael Ellerman <michael@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20060816152032.2407a832.sfr@canb.auug.org.au>
References: <20060816152032.2407a832.sfr@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-HAJ2CCeM/49aoS5jII8s"
Date: Wed, 16 Aug 2006 15:26:04 +1000
Message-Id: <1155705964.12715.8.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-HAJ2CCeM/49aoS5jII8s
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-08-16 at 15:20 +1000, Stephen Rothwell wrote:
> gcc 4.1 produces some warnings that it is ignoring the packed attribute
> on some structure elements, so just remove them.

Why is it ignoring them? Because there's no packing to be done?

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-HAJ2CCeM/49aoS5jII8s
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE4qxsdSjSd0sB4dIRAmUXAKCrtdTR1wNN8WM4qRm14HJ8yy0u2gCgmytw
NISBgPPSgnyBw2ip0EMrq1U=
=rQLe
-----END PGP SIGNATURE-----

--=-HAJ2CCeM/49aoS5jII8s--
