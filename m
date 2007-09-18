Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 110B2DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 23:21:50 +1000 (EST)
Date: Tue, 18 Sep 2007 23:21:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 18/28] 8xx: mpc885ads cleanup
Message-Id: <20070918232135.bc079b20.sfr@canb.auug.org.au>
In-Reply-To: <20070917165805.GR6563@loki.buserror.net>
References: <20070917165643.GA6545@loki.buserror.net>
	<20070917165805.GR6563@loki.buserror.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__18_Sep_2007_23_21_35_+1000_n=dZjcg_UY9Tb+PU"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__18_Sep_2007_23_21_35_+1000_n=dZjcg_UY9Tb+PU
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Sep 2007 11:58:05 -0500 Scott Wood <scottwood@freescale.com> wro=
te:
>
> +++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
>  #include <asm/fs_pd.h>
> -#include <asm/prom.h>
> +#include <asm/of_platform.h>

linux/of_platform.h

Sorry if I am getting boring.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__18_Sep_2007_23_21_35_+1000_n=dZjcg_UY9Tb+PU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG79DlTgG2atn1QN8RAtLrAJ9K3HCBOmCn9/NB9ST5fdonhFX1GQCdEEsI
f0K7Y/hZNKBiiCWFHciI6jQ=
=BMu9
-----END PGP SIGNATURE-----

--Signature=_Tue__18_Sep_2007_23_21_35_+1000_n=dZjcg_UY9Tb+PU--
