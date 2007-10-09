Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id EBAF8DE031
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 14:43:55 +1000 (EST)
Date: Tue, 9 Oct 2007 14:43:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 5/6] MPC52xx: Trim includes on mpc5200 platform support
	code
Message-Id: <20071009144347.6e903574.sfr@canb.auug.org.au>
In-Reply-To: <20071008222517.25840.46075.stgit@trillian.cg.shawcable.net>
References: <20071008222445.25840.6561.stgit@trillian.cg.shawcable.net>
	<20071008222517.25840.46075.stgit@trillian.cg.shawcable.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__9_Oct_2007_14_43_47_+1000_em=ScAU.wVoQ+jCQ"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__9_Oct_2007_14_43_47_+1000_em=ScAU.wVoQ+jCQ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 08 Oct 2007 16:25:18 -0600 Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>
> -#include <asm/prom.h>
> +#include <linux/of.h>

You should keep asm/prom.h if you are using any of the flat device tree
accessors (which thses files do).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__9_Oct_2007_14_43_47_+1000_em=ScAU.wVoQ+jCQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHCwcITgG2atn1QN8RApG/AJoDVl5mFeR3MELblZXLPLO2uw8NNgCgiAtB
ZjyKOWcW3YSubpwHwgs9UEY=
=q240
-----END PGP SIGNATURE-----

--Signature=_Tue__9_Oct_2007_14_43_47_+1000_em=ScAU.wVoQ+jCQ--
