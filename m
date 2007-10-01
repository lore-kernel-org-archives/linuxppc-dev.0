Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0FF89DDE18
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 01:06:50 +1000 (EST)
Date: Tue, 2 Oct 2007 01:06:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCHv2 4/4] Virtex: Add generic Xilinx Virtex board support
Message-Id: <20071002010630.e78e4889.sfr@canb.auug.org.au>
In-Reply-To: <20070930222048.583.82010.stgit@trillian.cg.shawcable.net>
References: <20070930221613.583.252.stgit@trillian.cg.shawcable.net>
	<20070930222048.583.82010.stgit@trillian.cg.shawcable.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__2_Oct_2007_01_06_30_+1000_cJ._=K=gVkyS260J"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__2_Oct_2007_01_06_30_+1000_cJ._=K=gVkyS260J
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 30 Sep 2007 16:20:52 -0600 Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>
> +++ b/arch/powerpc/platforms/40x/virtex.c
> +#include <asm/of_platform.h>

/me puts on broken record voice  :-)

linux/of_platform.h, please

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__2_Oct_2007_01_06_30_+1000_cJ._=K=gVkyS260J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHAQz8TgG2atn1QN8RAvv9AJ9tJGVpIRDzxIRhHNkQeTwHGAmlYwCfRIwt
0R+wpGcZgYQJmYJI+m6IG/g=
=9UJ2
-----END PGP SIGNATURE-----

--Signature=_Tue__2_Oct_2007_01_06_30_+1000_cJ._=K=gVkyS260J--
