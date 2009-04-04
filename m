Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8A760DDDF9
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Apr 2009 15:37:29 +1100 (EST)
Subject: Re: [PATCH] powerpc: Keep track of emulated instructions
From: Michael Ellerman <michael@ellerman.id.au>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <alpine.LRH.2.00.0904031404450.32353@vixen.sonytel.be>
References: <alpine.LRH.2.00.0904031404450.32353@vixen.sonytel.be>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-ObWiVvpIOZKKCwnsFX0v"
Date: Sat, 04 Apr 2009 15:37:28 +1100
Message-Id: <1238819848.9595.25.camel@localhost>
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


--=-ObWiVvpIOZKKCwnsFX0v
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-04-03 at 14:08 +0200, Geert Uytterhoeven wrote:
> 	Hi Ben, Kumar,
>=20
> Finally (after ca. 1.5 years), he're an updated version of my patch to ke=
ep
> track of emulated instructions.  In the light of Kumar's `Emulate enough =
of SPE
> instructions to make gcc happy' patch, he probably also wants to keep tra=
ck of
> the actual runtime overhead.
>=20
> Changes since last version:
>   - arch/powerpc/kernel/sysfs.c is now compiled on ppc32, so we can provi=
de
>     counters in sysfs on ppc32, too,
>   - WARN_EMULATED() is a no-op if CONFIG_SYSCTL is disabled,
>   - Add warnings for altivec,
>   - Add warnings for recently introduced emulation of vsx and isel
>     instructions.

You don't count instructions that fall through to the bottom of
fix_alignment()?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-ObWiVvpIOZKKCwnsFX0v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknW5AgACgkQdSjSd0sB4dJNMgCfSmv9SSFUEWa3Lelr7QZ7A/OP
AgAAni1ZuGddzu1TLpXfIRD4EBJdc93B
=J2d+
-----END PGP SIGNATURE-----

--=-ObWiVvpIOZKKCwnsFX0v--
