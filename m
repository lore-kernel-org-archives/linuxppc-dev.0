Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0D3C2DDED9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 14:20:30 +1000 (EST)
Date: Fri, 16 May 2008 14:20:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 2/8] [WATCHDOG] mpc83xx_wdt: convert to the OF platform
	driver
Message-Id: <20080516142016.8eed4133.sfr@canb.auug.org.au>
In-Reply-To: <20080515165349.GB3887@polina.dev.rtsoft.ru>
References: <20080515165250.GA30738@polina.dev.rtsoft.ru>
	<20080515165349.GB3887@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__16_May_2008_14_20_16_+1000_cbSSO5Mudez11Q=U"
Cc: linuxppc-dev@ozlabs.org, Wim Van Sebroeck <wim@iguana.be>,
	Chen Gong <G.Chen@freescale.com>,
	Scott Wood <scottwood@freescale.com>, Tabi <timur@freescale.com>, Timur
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__16_May_2008_14_20_16_+1000_cbSSO5Mudez11Q=U
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Anton,

On Thu, 15 May 2008 20:53:49 +0400 Anton Vorontsov <avorontsov@ru.mvista.co=
m> wrote:
>
> This patch simply converts mpc83xx_wdt to the OF platform driver so we
> can directly work with the device tree without passing various stuff
> through platform data.
>=20
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Looks good.

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__16_May_2008_14_20_16_+1000_cbSSO5Mudez11Q=U
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFILQuJTgG2atn1QN8RArv9AKCWDehM2UCL1rFIGuGURAKfqD9x+wCfbtCj
/8fKaPhp1FhvXBgG1cR6nFQ=
=0o3A
-----END PGP SIGNATURE-----

--Signature=_Fri__16_May_2008_14_20_16_+1000_cbSSO5Mudez11Q=U--
