Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D9DABDDE45
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 01:08:38 +1000 (EST)
Date: Tue, 2 Oct 2007 01:08:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCHv2 3/4] Virtex: add xilinx interrupt controller driver
Message-Id: <20071002010819.6f2736be.sfr@canb.auug.org.au>
In-Reply-To: <20070930222038.583.20385.stgit@trillian.cg.shawcable.net>
References: <20070930221613.583.252.stgit@trillian.cg.shawcable.net>
	<20070930222038.583.20385.stgit@trillian.cg.shawcable.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__2_Oct_2007_01_08_19_+1000_PaFhNlvuRKHrf+dr"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__2_Oct_2007_01_08_19_+1000_PaFhNlvuRKHrf+dr
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 30 Sep 2007 16:20:43 -0600 Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>
> diff --git a/arch/powerpc/sysdev/xilinx_intc.c b/arch/powerpc/sysdev/xili=
nx_intc.c
> new file mode 100644
> index 0000000..69f05cd
> --- /dev/null
> +++ b/arch/powerpc/sysdev/xilinx_intc.c
> @@ -0,0 +1,151 @@
> +#include <linux/kernel.h>
> +#include <linux/irq.h>
> +#include <asm/io.h>
> +#include <asm/processor.h>
> +#include <asm/prom.h>

You probably want linux/of_device.h or linux/of.h instead of asm/prom.h

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__2_Oct_2007_01_08_19_+1000_PaFhNlvuRKHrf+dr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHAQ1pTgG2atn1QN8RAsnnAJ9KzuIzn5gXTALSq9pdZX4XRfx+kACfZrhF
DfxEYRd6vbEyv0WZfltTAs8=
=1KdN
-----END PGP SIGNATURE-----

--Signature=_Tue__2_Oct_2007_01_08_19_+1000_PaFhNlvuRKHrf+dr--
