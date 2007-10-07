Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id EE5C4DDE9F
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Oct 2007 22:29:42 +1000 (EST)
Date: Sun, 7 Oct 2007 22:29:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH 06/15] [POWERPC] CM5200 board support
Message-Id: <20071007222930.a5b03174.sfr@canb.auug.org.au>
In-Reply-To: <4708C1E2.6020506@semihalf.com>
References: <47075FA7.3030108@semihalf.com>
	<4708C1E2.6020506@semihalf.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__7_Oct_2007_22_29_30_+1000_jKYlmOE.3_oynHXH"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__7_Oct_2007_22_29_30_+1000_jKYlmOE.3_oynHXH
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 07 Oct 2007 13:24:18 +0200 Marian Balakowicz <m8@semihalf.com> wrot=
e:
>
> +++ b/arch/powerpc/platforms/52xx/cm5200.c
>
> +#include <asm/prom.h>
> +#include <asm/of_platform.h>

Same comments as for tqm5200.c.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__7_Oct_2007_22_29_30_+1000_jKYlmOE.3_oynHXH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHCNE3TgG2atn1QN8RAltwAKCEhsB1EGXz1kTdh0gRaBTrsF00kQCcCU62
Pm8w7Iu/cDrc19zy5y4gvoY=
=AjF4
-----END PGP SIGNATURE-----

--Signature=_Sun__7_Oct_2007_22_29_30_+1000_jKYlmOE.3_oynHXH--
