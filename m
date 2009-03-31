Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 391EEDDDB6
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 10:52:52 +1100 (EST)
Subject: Re: kexec: proc/device-tree/chosen/linux,kernel-end: No such file
	or directory
From: Michael Ellerman <michael@ellerman.id.au>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <alpine.LRH.2.00.0903311808310.32461@vixen.sonytel.be>
References: <alpine.LRH.2.00.0903311808310.32461@vixen.sonytel.be>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-ADP8YsNQt+rpts71mGc0"
Date: Wed, 01 Apr 2009 10:52:51 +1100
Message-Id: <1238543571.6522.12.camel@localhost>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ADP8YsNQt+rpts71mGc0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-03-31 at 18:25 +0200, Geert Uytterhoeven wrote:
> With today's kernel, I can no longer kexec any kernel on PS3:
>=20
> | /proc/device-tree/chosen/linux,kernel-end: No such file or directory
> | Could not get memory layout
>=20
> Today's bad version: 15f7176eb1cccec0a332541285ee752b935c1c85
> Yesterday's good version: 0d34fb8e93ceba7b6dad0062dbb4a0813bacd75b
>=20
> Before I start bisecting (tomorrow or the day thereafter), anyone with an=
 idea?

Hmm, not really.

Looking at the code the only obvious way you could end up without that
property is if you didn't have a /chosen?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-ADP8YsNQt+rpts71mGc0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEUEABECAAYFAknSrNMACgkQdSjSd0sB4dJSrQCY5Yw3R5z6Q0D4ywkL4rFW1FQj
zgCggptIqIJnYq22h4mgt6f+QkV6r50=
=IcxA
-----END PGP SIGNATURE-----

--=-ADP8YsNQt+rpts71mGc0--
