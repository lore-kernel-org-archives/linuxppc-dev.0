Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8A7E1DDF9F
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 18:22:34 +1000 (EST)
Date: Fri, 25 Apr 2008 18:22:25 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] add gpiolib support for mpc5200
Message-Id: <20080425182225.0a6749d5.sfr@canb.auug.org.au>
In-Reply-To: <20080424153659.GJ6692@pengutronix.de>
References: <20080424153659.GJ6692@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__25_Apr_2008_18_22_25_+1000_cvHsVKxGcmGQFBkn"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__25_Apr_2008_18_22_25_+1000_cvHsVKxGcmGQFBkn
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sascha,

One small comment.

On Thu, 24 Apr 2008 17:36:59 +0200 Sascha Hauer <s.hauer@pengutronix.de> wr=
ote:
>
> +#include <asm/of_platform.h>

Never include <asm/of_platform.h>, use <linux/of_platform.h>

> +static struct of_device_id mpc52xx_wkup_gpiochip_match[] =3D {

const, please.

OK, I lied about only one comment :-)

> +static struct of_device_id mpc52xx_simple_gpiochip_match[] =3D {

const, again.

> +static struct of_device_id mpc52xx_gpt_gpiochip_match[] =3D {

Another one.

Also, I don't think you need to include <asm/prom.h>
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__25_Apr_2008_18_22_25_+1000_cvHsVKxGcmGQFBkn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIEZTITgG2atn1QN8RAr8LAJ4uRf6TY8tsuat0uc5kBJ5h0oApDQCeKi/G
SWfvi5MLeLfqM6JuJcNGqsU=
=YRLg
-----END PGP SIGNATURE-----

--Signature=_Fri__25_Apr_2008_18_22_25_+1000_cvHsVKxGcmGQFBkn--
