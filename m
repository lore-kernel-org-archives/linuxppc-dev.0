Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B2C0ADDED9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 14:46:54 +1000 (EST)
Date: Fri, 16 May 2008 14:46:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Remi Machet <rmachet@slac.stanford.edu>
Subject: Re: [PATCH 3/5] powerpc: C2K board driver
Message-Id: <20080516144645.490114f6.sfr@canb.auug.org.au>
In-Reply-To: <1210897468.13992.16.camel@pcds-ts102.slac.stanford.edu>
References: <1210897468.13992.16.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__16_May_2008_14_46_45_+1000_qaba6t8RU1P8iqoY"
Cc: Linux PPC <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__16_May_2008_14_46_45_+1000_qaba6t8RU1P8iqoY
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Remi,

On Thu, 15 May 2008 17:24:28 -0700 Remi Machet <rmachet@slac.stanford.edu> =
wrote:
>
> +#include <linux/stddef.h>
> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/seq_file.h>
> +
> +#include <asm/machdep.h>
> +#include <asm/prom.h>
> +#include <asm/system.h>
> +#include <linux/time.h>
> +#include <asm/time.h>
> +#include <linux/kexec.h>

Normally we don'y mix linux/ and asm/ includes (put all the linux ones at
the top).

You need to include <linux/of.h> because you use the device tree accessor
functions.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__16_May_2008_14_46_45_+1000_qaba6t8RU1P8iqoY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFILRG9TgG2atn1QN8RAhnRAJ9r+F8Dj4/75b/NgKgal46Oh+Sc/wCeNXSO
enCrFhEHQq8NewwOrNSX6oU=
=w4Rr
-----END PGP SIGNATURE-----

--Signature=_Fri__16_May_2008_14_46_45_+1000_qaba6t8RU1P8iqoY--
