Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 93620DDF8F
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 11:05:58 +1000 (EST)
Date: Thu, 11 Oct 2007 11:05:46 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH 4/9] add platform support for MPC837x MDS board
Message-Id: <20071011110546.99239e24.sfr@canb.auug.org.au>
In-Reply-To: <1192010804-20071-4-git-send-email-leoli@freescale.com>
References: <1192010804-20071-1-git-send-email-leoli@freescale.com>
	<1192010804-20071-2-git-send-email-leoli@freescale.com>
	<1192010804-20071-3-git-send-email-leoli@freescale.com>
	<1192010804-20071-4-git-send-email-leoli@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__11_Oct_2007_11_05_46_+1000_ZEmdiuHtCk9bgEtN"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__11_Oct_2007_11_05_46_+1000_ZEmdiuHtCk9bgEtN
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Oct 2007 18:06:39 +0800 Li Yang <leoli@freescale.com> wrote:
>
> +++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
>
> +#include <asm/of_platform.h>

You actually neeed linux/of.h (for of_ routines) and asm/prom.h (for
of_flat_dt_is_compatible).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__11_Oct_2007_11_05_46_+1000_ZEmdiuHtCk9bgEtN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHDXbzTgG2atn1QN8RApKXAJ9L6nV/D3hRMQi8lAukRCpwuEboMACePJJa
/Hmm32rZ+PDfHWuO8fsgs/g=
=7/SS
-----END PGP SIGNATURE-----

--Signature=_Thu__11_Oct_2007_11_05_46_+1000_ZEmdiuHtCk9bgEtN--
