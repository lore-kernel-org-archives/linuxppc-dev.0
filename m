Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D5468DDDE1
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jun 2009 12:06:49 +1000 (EST)
Subject: Re: [PATCH] powerpc: fix annotation of pcibios_claim_one_bus
From: Michael Ellerman <michael@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20090602105353.b4a7e93d.sfr@canb.auug.org.au>
References: <20090602105353.b4a7e93d.sfr@canb.auug.org.au>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-0PKk1oQG4De+72tVICNY"
Date: Tue, 02 Jun 2009 12:06:49 +1000
Message-Id: <1243908409.6119.2.camel@concordia>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-0PKk1oQG4De+72tVICNY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-06-02 at 10:53 +1000, Stephen Rothwell wrote:
> It was __devinit, but it is also within a CONFIG_HOTPLUG guarded section
> of code, so the __devinit does nothing but cause the following warning:
>=20
> WARNING: vmlinux.o(.text+0x107a8): Section mismatch in reference from the=
 function pcibios_finish_adding_to_bus() to the function .devinit.text:pcib=
ios_claim_one_bus()

Isn't the real problem that the PCI hotplug code is not marked as
__devinit?

cheers


--=-0PKk1oQG4De+72tVICNY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEUEABECAAYFAkokiTQACgkQdSjSd0sB4dL04ACfe5ugYYsZdcXqu1cxX6VgPQAH
BTEAmN5bxRDthPDUXVbhGk/dkMyJ2c4=
=42VV
-----END PGP SIGNATURE-----

--=-0PKk1oQG4De+72tVICNY--
