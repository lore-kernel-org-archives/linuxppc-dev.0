Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2A759DECA9
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 03:16:29 +1000 (EST)
Date: Fri, 11 Apr 2008 12:16:28 -0500
From: Scott Wood <scottwood@freescale.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] 86xx: mark functions static, other minor cleanups
Message-ID: <20080411171628.GA3203@loki.buserror.net>
References: <1207933186-20555-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1207933186-20555-1-git-send-email-paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 11, 2008 at 12:59:46PM -0400, Paul Gortmaker wrote:
> diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> index 79385bc..d5c2da4 100644
> --- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> +++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> @@ -13,7 +13,7 @@
>  
>  / {
>  	model = "MPC8641HPCN";
> -	compatible = "mpc86xx";
> +	compatible = "fsl,mpc86xx";
>  	#address-cells = <1>;
>  	#size-cells = <1>;

If we're changing the compatible, change it to something proper (e.g.
fsl,mpc8641hpcn).

-Scott
