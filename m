Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 23813DDE09
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 09:57:52 +1100 (EST)
Date: Thu, 24 Jan 2008 09:57:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCHv2 7/8] [POWERPC] Rename commproc to cpm1 and
	cpm2_common.c to cpm2.c
Message-Id: <20080124095743.09a442ad.sfr@canb.auug.org.au>
In-Reply-To: <479764F5.1000105@scram.de>
References: <479764F5.1000105@scram.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__24_Jan_2008_09_57_43_+1100_Md2WAUlKrbxk8=fR"
Cc: Scott Wood <scottwood@freescale.com>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__24_Jan_2008_09_57_43_+1100_Md2WAUlKrbxk8=fR
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jochen,

On Wed, 23 Jan 2008 17:01:57 +0100 Jochen Friedrich <jochen@scram.de> wrote:
>
> +++ b/arch/powerpc/platforms/8xx/ep88xc.c
> @@ -15,7 +15,7 @@
>   #include <asm/machdep.h>
>   #include <asm/io.h>
>   #include <asm/udbg.h>
> -#include <asm/commproc.h>
> +#include <asm/cpm1.h>
>   #include <asm/mpc8xx.h>

Something has whitespace damaged this patch.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__24_Jan_2008_09_57_43_+1100_Md2WAUlKrbxk8=fR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHl8ZtTgG2atn1QN8RAohaAJ9IGF3klbf3wGbuMgTYOeh9RavcDQCdF2Ob
EziIj8DMpQmNEt2Ue+80m4k=
=qrsT
-----END PGP SIGNATURE-----

--Signature=_Thu__24_Jan_2008_09_57_43_+1100_Md2WAUlKrbxk8=fR--
