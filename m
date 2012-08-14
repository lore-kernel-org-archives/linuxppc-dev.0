Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 851232C0085
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2012 07:45:48 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc/85xx: add Fman MDIO muxing support to the
 P4080DS
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1344637896-14267-2-git-send-email-timur@freescale.com>
Date: Tue, 14 Aug 2012 16:45:36 -0500
Message-Id: <5F0028FE-C555-47DE-B69A-888E7322A6E1@kernel.crashing.org>
References: <1344637896-14267-1-git-send-email-timur@freescale.com>
 <1344637896-14267-2-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
 Andy Fleming <afleming@freescale.com>, ddaney.cavm@gmail.com,
 netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 10, 2012, at 5:31 PM, Timur Tabi wrote:

> diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c =
b/arch/powerpc/platforms/85xx/corenet_ds.c
> index 925b028..a79fc79 100644
> --- a/arch/powerpc/platforms/85xx/corenet_ds.c
> +++ b/arch/powerpc/platforms/85xx/corenet_ds.c
> @@ -106,6 +106,13 @@ static const struct of_device_id of_device_ids[] =
__devinitconst =3D {
> 	{
> 		.name		=3D "handles",
> 	},
> +	{
> +		/*
> +		 * Warning: this entry might need to be located before =
those
> +		 * for the Fman Ethernet nodes.
> +		 */
> +		.compatible	=3D "mdio-mux",
> +	},
> 	{}
> };

Under what condition would that be the case?

- k=
