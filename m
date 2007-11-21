Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3DA44DDE99
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 17:34:10 +1100 (EST)
Date: Wed, 21 Nov 2007 17:34:02 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 13/14] powerpc: EP405 boards support for arch/powerpc
Message-Id: <20071121173402.9b8e5231.sfr@canb.auug.org.au>
In-Reply-To: <20071121061556.7F527DDFE7@ozlabs.org>
References: <20071121061556.7F527DDFE7@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__21_Nov_2007_17_34_02_+1100_sgrGzyzqpMd0pMSE"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__21_Nov_2007_17_34_02_+1100_sgrGzyzqpMd0pMSE
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Nov 2007 17:15:06 +1100 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> +++ linux-work/arch/powerpc/platforms/40x/ep405.c	2007-11-21 16:45:38.000=
000000 +1100
> +#include <asm/of_platform.h>

Please use linux/of_platform.h instead.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__21_Nov_2007_17_34_02_+1100_sgrGzyzqpMd0pMSE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHQ9FfTgG2atn1QN8RAqb/AJ9bcv9DfrY7vJZuFMoJiSvk4RhInQCbByuw
Cc1JcRTYQI8G9z0T0pvIWMw=
=PWVf
-----END PGP SIGNATURE-----

--Signature=_Wed__21_Nov_2007_17_34_02_+1100_sgrGzyzqpMd0pMSE--
