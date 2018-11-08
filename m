Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FDDC32789
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 06:26:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E32A020857
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 06:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oDag5zXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32A020857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rCx26wBLzF3Dg
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 17:26:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oDag5zXw";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rCkT03bkzF3Hg
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2018 17:17:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="oDag5zXw"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42rCkS4kGDz9sC7; Thu,  8 Nov 2018 17:17:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1541657856;
 bh=+l6obkmmVOTpkWBG/SMJ+4WwtN67+xVgthyNcmGzyj8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oDag5zXw/lnNR9Pa1pmRLqpBCk2S05oayrA3w9AgQcnTs2M8zS1IlAEzTk2zsH5CW
 z8Djyfi1mqIk4otp6uhqlsCPYBPAJJduC46QpvGDCskVQPRl2deYeIXmY2o0O/5CFO
 ogF8khj+5wcuzqpJXbm5uijhGBG691PQi4/7GWHI=
Date: Thu, 8 Nov 2018 16:11:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel 1/2] powerpc/pseries: Remove IOMMU API support for
 non-LPAR systems
Message-ID: <20181108051153.GN5575@umbus.fritz.box>
References: <20181018075243.4798-1-aik@ozlabs.ru>
 <20181018075243.4798-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6yHiY5vv/BiPjcMt"
Content-Disposition: inline
In-Reply-To: <20181018075243.4798-2-aik@ozlabs.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--6yHiY5vv/BiPjcMt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 06:52:42PM +1100, Alexey Kardashevskiy wrote:
> The pci_dma_bus_setup_pSeries and pci_dma_dev_setup_pSeries hooks are
> registered for the pseries platform which does not have FW_FEATURE_LPAR;
> these would be pre-powernv platforms which we never supported PCI pass
> through for anyway so remove it.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
> Propably should remove all pseries-but-not-lpar code.
> ---
>  arch/powerpc/platforms/pseries/iommu.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platfo=
rms/pseries/iommu.c
> index cf90582..eae2578 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -648,7 +648,6 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus =
*bus)
>  	iommu_table_setparms(pci->phb, dn, tbl);
>  	tbl->it_ops =3D &iommu_table_pseries_ops;
>  	iommu_init_table(tbl, pci->phb->node);
> -	iommu_register_group(pci->table_group, pci_domain_nr(bus), 0);
> =20
>  	/* Divide the rest (1.75GB) among the children */
>  	pci->phb->dma_window_size =3D 0x80000000ul;
> @@ -759,10 +758,7 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev=
 *dev)
>  		iommu_table_setparms(phb, dn, tbl);
>  		tbl->it_ops =3D &iommu_table_pseries_ops;
>  		iommu_init_table(tbl, phb->node);
> -		iommu_register_group(PCI_DN(dn)->table_group,
> -				pci_domain_nr(phb->bus), 0);
>  		set_iommu_table_base(&dev->dev, tbl);
> -		iommu_add_device(&dev->dev);
>  		return;
>  	}
> =20
> @@ -773,11 +769,10 @@ static void pci_dma_dev_setup_pSeries(struct pci_de=
v *dev)
>  	while (dn && PCI_DN(dn) && PCI_DN(dn)->table_group =3D=3D NULL)
>  		dn =3D dn->parent;
> =20
> -	if (dn && PCI_DN(dn)) {
> +	if (dn && PCI_DN(dn))
>  		set_iommu_table_base(&dev->dev,
>  				PCI_DN(dn)->table_group->tables[0]);
> -		iommu_add_device(&dev->dev);
> -	} else
> +	else
>  		printk(KERN_WARNING "iommu: Device %s has no iommu table\n",
>  		       pci_name(dev));
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6yHiY5vv/BiPjcMt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvjxZgACgkQbDjKyiDZ
s5IfUBAAhZrowrNckTfyAuMK2DEwos2uEG4FoLupbJxBksBzRZu8hsGW9y/XzD8K
JRa9thLXHbNjOWMMTHQ3czFZnyRduWyUvqgNfa9yFQNNWigL1se4VM+FpnmKay/g
y/OX6cQsAo6fMoXBoqhHFp82BJXbNtVmaGpaMGFbrs0oWXh/5JeAloxZito4Zbo4
6qbA+YTSqJRLpLimxHb9CxkqY81wwHmS1v8VS7VXR3TOoFFEzMHExBMWXhoX6F8b
SYzNHESfpRDM5R81ZIm1zgo4cNPvvc947R+Bz5Citfqoyd/9hfdJSuKCa7cu5OrN
xURmzUu07XBUn3SiPeat+ZGFKL4vxhR0MzXHGDHHxexsCG9Ct7liGQFBQ5xGDO32
fkvWZLwk32sSzyFk+iPfHkG+ac1Vvv5hoY1+Hp4ijPDPetz25loC8xP21wq0voFF
fWyKLZRkJodWQmMHARfnWp59UmHlJI18ef1YHrsSKdNMB5ihsp20JAScO4JUnRXT
XLlzYV6y9NtHoq7pXoXgT3v9+BTfMBHbc3jV5xLPSkjP7JT7E0qlCHcHNfgl8LCa
MOxNBZX+Fb70dJchfSGhN0L6T5boOZSWIR9OgKUaTG0T2CZK83Kwp0H2AN+KbkK0
CVSd7hi4J7rYaVL9XQiREeloiYB6bssP8NvipM21JcR/4GxqdDQ=
=zFUs
-----END PGP SIGNATURE-----

--6yHiY5vv/BiPjcMt--
