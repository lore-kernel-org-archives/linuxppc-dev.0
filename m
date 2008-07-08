Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 33DD1DDE04
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 13:54:34 +1000 (EST)
Date: Tue, 8 Jul 2008 13:54:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: powerpc: Add proper reference to dma_mask
Message-Id: <20080708135426.43edb5dc.sfr@canb.auug.org.au>
In-Reply-To: <20080708031256.57176084@vitb-lp>
References: <20080708031256.57176084@vitb-lp>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__8_Jul_2008_13_54_26_+1000_fI1vu_B2=Nf.zvbF"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__8_Jul_2008_13_54_26_+1000_fI1vu_B2=Nf.zvbF
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vitaly,

On Tue, 8 Jul 2008 03:12:56 +0400 Vitaly Bordug <vitb@kernel.crashing.org> =
wrote:
>
> +++ b/arch/powerpc/kernel/of_platform.c
> @@ -76,6 +76,9 @@ struct of_device* of_platform_device_create(struct devi=
ce_node *np,
>  		return NULL;
> =20
>  	dev->dma_mask =3D 0xffffffffUL;
> +	dev->dev.dma_mask =3D &dev->dma_mask;

That is done in of_device_alloc which is called just above.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__8_Jul_2008_13_54_26_+1000_fI1vu_B2=Nf.zvbF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhy5PIACgkQjjKRsyhoI8xBpQCfbPrPL6YKGiaA7kUs3tZX4bKM
Xu4AnjR8/Iax1UhlWnjcmmlu3IfAZPIS
=ZhnE
-----END PGP SIGNATURE-----

--Signature=_Tue__8_Jul_2008_13_54_26_+1000_fI1vu_B2=Nf.zvbF--
