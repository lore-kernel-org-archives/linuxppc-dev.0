Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 17D42DDF30
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 10:35:55 +1000 (EST)
Date: Wed, 18 Jun 2008 10:35:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: John Rigby <jrigby@freescale.com>
Subject: Re: [PATCH] MPC5121 FEC support
Message-Id: <20080618103549.06110799.sfr@canb.auug.org.au>
In-Reply-To: <1213724880-14965-1-git-send-email-jrigby@freescale.com>
References: <1213724880-14965-1-git-send-email-jrigby@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__18_Jun_2008_10_35_49_+1000_c0G.dy8u=H_cf0=b"
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__18_Jun_2008_10_35_49_+1000_c0G.dy8u=H_cf0=b
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi John,

You should factor out the fec_t -> struct fec change into an earlier
patch of its own.

On Tue, 17 Jun 2008 11:48:00 -0600 John Rigby <jrigby@freescale.com> wrote:
>
> +++ b/drivers/net/fs_enet/fec_mpc5121.h

> +#include <asm/cpm.h>

Nothing in this file uses anything in asm/cpm.h, so it shouldn't be
included here.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__18_Jun_2008_10_35_49_+1000_c0G.dy8u=H_cf0=b
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhYWGUACgkQTgG2atn1QN+R7QCfbJBhFoLvgDCmB/z3shv+h7X3
CC8AoIvv0qr75ZfY9uLxTsJImhpocL9p
=JRAq
-----END PGP SIGNATURE-----

--Signature=_Wed__18_Jun_2008_10_35_49_+1000_c0G.dy8u=H_cf0=b--
