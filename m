Return-Path: <sfr@canb.auug.org.au>
Date: Thu, 4 Oct 2007 17:00:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/4] edac: Add Cell memory controller
Message-Id: <20071004170047.30883e02.sfr@canb.auug.org.au>
In-Reply-To: <20071004054106.E5329DDE3C@ozlabs.org>
References: <1191476442.154524.519055590678.qpush@grosgo>
	<20071004054106.E5329DDE3C@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__4_Oct_2007_17_00_47_+1000_ufpDCE5PNg0ExTRp"
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, cbe-oss-dev@ozlabs.org,
	linuxppc-dev@ozlabs.org, Mackerras <paulus@samba.org>, Paul,
	bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__4_Oct_2007_17_00_47_+1000_ufpDCE5PNg0ExTRp
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 04 Oct 2007 15:40:44 +1000 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> +++ linux-work/drivers/edac/cell-edac.c	2007-10-04 15:34:46.000000000 +10=
00
> @@ -0,0 +1,258 @@
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/stop_machine.h>
> +#include <asm/io.h>
> +#include <asm/machdep.h>
> +#include <asm/cell-regs.h>

Since you use the of_ accessors, you should include linux/of.h

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__4_Oct_2007_17_00_47_+1000_ufpDCE5PNg0ExTRp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHBI+kTgG2atn1QN8RAkLyAJ9Xa0OKV63xN42qB4mOq5hkT2/WdwCfYOH/
EK+3T/Iylc0QOTnLErfzYek=
=R1GL
-----END PGP SIGNATURE-----

--Signature=_Thu__4_Oct_2007_17_00_47_+1000_ufpDCE5PNg0ExTRp--
