Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 75C13DDEEF
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 09:32:45 +1000 (EST)
Date: Wed, 14 May 2008 09:32:34 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/6] [WATCHDOG] mpc83xx_wdt: convert to the OF platform
	driver
Message-Id: <20080514093234.495513b4.sfr@canb.auug.org.au>
In-Reply-To: <20080513141454.GA15717@polina.dev.rtsoft.ru>
References: <20080513141411.GA8981@polina.dev.rtsoft.ru>
	<20080513141454.GA15717@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__14_May_2008_09_32_34_+1000_6T0CYARHgcbzKwGT"
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Wim Van Sebroeck <wim@iguana.be>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__14_May_2008_09_32_34_+1000_6T0CYARHgcbzKwGT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Anton,

On Tue, 13 May 2008 18:14:54 +0400 Anton Vorontsov <avorontsov@ru.mvista.co=
m> wrote:
>
> +static struct of_platform_driver mpc83xx_wdt_driver =3D {
> +	.name		=3D "mpc83xx_wdt",
> +	.match_table	=3D mpc83xx_wdt_match,
>  	.probe		=3D mpc83xx_wdt_probe,
>  	.remove		=3D __devexit_p(mpc83xx_wdt_remove),
> -	.driver		=3D {
> -		.name	=3D "mpc83xx_wdt",
> -		.owner	=3D THIS_MODULE,
> -	},

You should leave this as it was because the name and owner fields are
being removed from struct of_platform_driver in favour of those embedded in
the .driver.

Maybe I should add a comment to the structure definition.  Or maybe it is
time to actually remove them.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__14_May_2008_09_32_34_+1000_6T0CYARHgcbzKwGT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIKiUXTgG2atn1QN8RAkYJAJ9RMqmbmiOaU9/GwGHdiuMZA9+LHgCfXe5Y
PljSHpJCG3E4BEcY955rF6U=
=lEuP
-----END PGP SIGNATURE-----

--Signature=_Wed__14_May_2008_09_32_34_+1000_6T0CYARHgcbzKwGT--
