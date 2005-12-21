Return-Path: <Simon.Richter@hogyros.de>
Received: from kleinhenz.com (kleinhenz.com [213.239.205.196])
	by ozlabs.org (Postfix) with ESMTP id A0FA268900
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Dec 2005 01:00:19 +1100 (EST)
Message-ID: <43A95FE5.8060504@hogyros.de>
Date: Wed, 21 Dec 2005 15:00:05 +0100
From: Simon Richter <Simon.Richter@hogyros.de>
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
References: <20051221121201.GA54164@muc.de>
In-Reply-To: <20051221121201.GA54164@muc.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig79CC0A6047D3C2E1F2C1F2D0"
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Don't allow CONFIG_PMAC_BACKLIGHT on pmac64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig79CC0A6047D3C2E1F2C1F2D0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Andi Kleen wrote:

> Don't allow to set CONFIG_MAC_BACKLIGHT on pmac64. It won't compile.

 > -	depends on ADB_PMU && (BROKEN || !PPC64)
 > +	depends on ADB_PMU && !PPC64

That's why it's marked BROKEN, perhaps?

    Simon


--------------enig79CC0A6047D3C2E1F2C1F2D0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ6lf7FYr4CN7gCINAQLFSgP/Z17hXsLRLTEZRdc2CPUzOg7g+kHofags
XiGhJy1E4JbqMLbCB7on/zVuwEV2t2ErWKchLpndkFjtySdDmuJStH9hr66CCI/g
ligx5p7JrQWjKqoLXCLILGh3+LdIqB7zHwpTHpGuEnPKawo/u5Aw9M7hE6oWwfdi
qPBEI6taawA=
=B3aM
-----END PGP SIGNATURE-----

--------------enig79CC0A6047D3C2E1F2C1F2D0--
