Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A26FEDDE48
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 10:36:23 +1000 (EST)
Date: Thu, 16 Aug 2007 10:36:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] powerpc: fix i2c device string format
Message-Id: <20070816103616.4e2e35b7.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.60.0708152106090.10160@poirot.grange>
References: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
	<Pine.LNX.4.60.0707032356270.3876@poirot.grange>
	<E0E696F1-2F9E-4D6B-A194-EB42BA826BCD@kernel.crashing.org>
	<Pine.LNX.4.60.0707180010330.3535@poirot.grange>
	<87DC7695-382B-4641-B9D9-75ACB49D41A4@kernel.crashing.org>
	<Pine.LNX.4.60.0707191932300.3365@poirot.grange>
	<719AE7E4-FE6D-4973-8887-F787EC8ABC85@kernel.crashing.org>
	<Pine.LNX.4.60.0707202219340.3946@poirot.grange>
	<235e0ff22961e25016727c0e74fd0c0f@kernel.crashing.org>
	<Pine.LNX.4.60.0708010739560.4228@poirot.grange>
	<19a13f8700d078abc4cab0064a7d0183@kernel.crashing.org>
	<Pine.LNX.4.60.0708012053240.7394@poirot.grange>
	<46B0F030.9030007@freescale.com>
	<Pine.LNX.4.60.0708080023030.8493@poirot.grange>
	<3368b27f860fafb35d10f6352e9055bf@kernel.crashing.org>
	<Pine.LNX.4.60.0708092233130.5995@poirot.grange>
	<18114.39893.913684.592560@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.60.0708152106090.10160@poirot.grange>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__16_Aug_2007_10_36_16_+1000_V=6gZp6qmkElj6=p"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__16_Aug_2007_10_36_16_+1000_V=6gZp6qmkElj6=p
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Aug 2007 21:15:03 +0200 (CEST) Guennadi Liakhovetski <g.liakhove=
tski@gmx.de> wrote:
>
> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
> index 727453d..c0d66df 100644
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -320,21 +320,26 @@ static struct i2c_driver_device i2c_devices[] __ini=
tdata =3D {
>  	{"ricoh,rv5c387a", "rtc-rs5c372", "rv5c387a",},
>  };
> =20
> -static int __init of_find_i2c_driver(struct device_node *node, struct i2=
c_board_info *info)
> +static int __init of_find_i2c_driver(struct device_node *node,
> +				     struct i2c_board_info *info)

Please don't do unrelated formatting changes in a patch.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__16_Aug_2007_10_36_16_+1000_V=6gZp6qmkElj6=p
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGw5wFTgG2atn1QN8RAsVSAKCOlQS/UJSSOdFhNyNTPIdL3gwcJQCghHIj
0O6hGJZW4u/E1OOy20otkVY=
=/jED
-----END PGP SIGNATURE-----

--Signature=_Thu__16_Aug_2007_10_36_16_+1000_V=6gZp6qmkElj6=p--
