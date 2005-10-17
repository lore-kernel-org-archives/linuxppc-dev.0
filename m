Return-Path: <Simon.Richter@hogyros.de>
Received: from psionic8.psi5.com (psionic.psi5.com [212.112.229.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.psi5.com", Issuer "psi5.com CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9AE0F685BB
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Oct 2005 08:19:23 +1000 (EST)
Message-ID: <4354235B.8090608@hogyros.de>
Date: Tue, 18 Oct 2005 00:19:07 +0200
From: Simon Richter <Simon.Richter@hogyros.de>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
References: <17227.44943.714106.911471@cargo.ozlabs.ibm.com>	<434BB09B.9070605@hogyros.de>
	<17235.33942.754076.419504@cargo.ozlabs.ibm.com>
In-Reply-To: <17235.33942.754076.419504@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0BD8ECB714E533B28931CA39"
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: merge progress
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0BD8ECB714E533B28931CA39
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

Paul Mackerras schrieb:

> Hmmm, probably should work off the merge tree.

Good, then I'll fast-forward them there.

> However, we decided at
> OLS that platforms would require a device tree before being merged.
> Have you looked at creating a suitable flattened device tree blob with
> dtc?  (If not, you can continue to compile with ARCH=ppc for now.)

In fact my current plan is to move away from m68k bootinfo (which APUS
borrows so you can use the same bootloader) towards a flattened dev tree
passed in from the bootloader. For that, however, we need a new
bootloader first, which is dependant on AmigaOS binutils/gcc.

So I guess it will be ARCH=ppc until the new bootloader is ready.

Should APUS still get a special treatment then, or should I try to
emulate enough of OF in the bootloader so it is possible to build CHRP
images that work on APUS?

   Simon

--------------enig0BD8ECB714E533B28931CA39
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQCVAwUBQ1QjXFYr4CN7gCINAQJTxQP/VUCxqxfaGUiwpR4F7uDYv2K201vOEU62
LPUOL2r7Oez4rBFIJT5E/NvHIxyOsMCgVTZ4l8bcTsNIVwwLEQZoHALW9adYAZBA
mkXVLPZCUD+MnF8BWCCfVf1tbv40I9rr3IXz1GrN+vZDldH1XMpdMpmv1aeM+Wry
t74DHteuWOI=
=A2qH
-----END PGP SIGNATURE-----

--------------enig0BD8ECB714E533B28931CA39--
