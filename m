Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1CB42DDF84
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 11:00:01 +1000 (EST)
Date: Thu, 11 Oct 2007 10:59:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH 3/9] add Freescale SerDes PHY support
Message-Id: <20071011105951.95967235.sfr@canb.auug.org.au>
In-Reply-To: <1192010804-20071-3-git-send-email-leoli@freescale.com>
References: <1192010804-20071-1-git-send-email-leoli@freescale.com>
	<1192010804-20071-2-git-send-email-leoli@freescale.com>
	<1192010804-20071-3-git-send-email-leoli@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__11_Oct_2007_10_59_51_+1000_4tEDrkMugx6xaDTS"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__11_Oct_2007_10_59_51_+1000_4tEDrkMugx6xaDTS
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Oct 2007 18:06:38 +0800 Li Yang <leoli@freescale.com> wrote:
>
> +++ b/arch/powerpc/sysdev/fsl_serdes.c
>
> +#include <asm/prom.h>

You actually want linux/of.h not asm/prom.h

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__11_Oct_2007_10_59_51_+1000_4tEDrkMugx6xaDTS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHDXWNTgG2atn1QN8RAvkjAJ9MVWDm7l1d/mlmAdInABtvIqi5hACfaFJq
+6wthgOaITuL9lUJu3Fjlmw=
=eTqL
-----END PGP SIGNATURE-----

--Signature=_Thu__11_Oct_2007_10_59_51_+1000_4tEDrkMugx6xaDTS--
