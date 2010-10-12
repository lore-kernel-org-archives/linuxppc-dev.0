Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 66538B70A5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Oct 2010 01:10:06 +1100 (EST)
Subject: Re: [PATCH] powerpc/fsl: 85xx: add cache-sram support
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1286879117-5616-1-git-send-email-harninder.rai@freescale.com>
Date: Tue, 12 Oct 2010 09:09:57 -0500
Message-Id: <04CFEB4E-DFA2-44AB-AD90-859A7D0691A8@kernel.crashing.org>
References: <1286879117-5616-1-git-send-email-harninder.rai@freescale.com>
To: "<harninder.rai@freescale.com>" <harninder.rai@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 12, 2010, at 5:25 AM, <harninder.rai@freescale.com> =
<harninder.rai@freescale.com> wrote:

>=20
> +static int __devinit mpc85xx_l2ctlr_of_probe(struct platform_device =
*dev,
> +					  const struct of_device_id =
*match)
> +{
> +	long rval;
> +	unsigned int rem;
> +	unsigned char ways;
> +	const unsigned int *prop;
> +	unsigned int l2cache_size;
> +	struct device_node *np;
> +	int i =3D 0;
> +	bool amp =3D 0;
> +	struct sram_parameters sram_params;
> +	static char *compatible_list[] =3D {
> +					"fsl,MPC85XXRDB-CAMP",
> +					"fsl,P2020DS-CAMP",
> +					NULL
> +				};
> +

Remove this AMP stuff.  We specify the cache-sram-size & =
cache-sram-offset so for the AMP kernels these can be set as needed.

- k=
