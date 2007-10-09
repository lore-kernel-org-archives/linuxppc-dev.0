Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 44E03DDFD6
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 14:49:20 +1000 (EST)
Date: Tue, 9 Oct 2007 14:49:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [UNTESTED PATCH] 8xx: Convert mpc866ads to the new device binding.
Message-Id: <20071009144913.7cafa9cf.sfr@canb.auug.org.au>
In-Reply-To: <20071008223806.GA2210@loki.buserror.net>
References: <20071008223806.GA2210@loki.buserror.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__9_Oct_2007_14_49_13_+1000_TwoHmPkpXExLfexM"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__9_Oct_2007_14_49_13_+1000_TwoHmPkpXExLfexM
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Oct 2007 17:38:06 -0500 Scott Wood <scottwood@freescale.com> wrot=
e:
>
> +++ b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
>
> -#include <asm/prom.h>

Still needed for of_flat_dt_is_compatible()

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__9_Oct_2007_14_49_13_+1000_TwoHmPkpXExLfexM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHCwhNTgG2atn1QN8RAiLwAJwKhDBnCfrjBKPjGT1pbR7XYbNM1wCdHTYf
6+qMZJIHIepgb7VCNPikvmU=
=2n0r
-----END PGP SIGNATURE-----

--Signature=_Tue__9_Oct_2007_14_49_13_+1000_TwoHmPkpXExLfexM--
