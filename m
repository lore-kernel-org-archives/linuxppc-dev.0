Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C4D65DE0F0
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 08:19:00 +1000 (EST)
Message-ID: <48923A43.9040901@freescale.com>
Date: Thu, 31 Jul 2008 17:18:43 -0500
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix whitespace merge in mpc8641 hpcn device tree
References: <Pine.LNX.4.64.0807311709530.10954@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0807311709530.10954@blarg.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> When we coverted the .dts to v1 we lost a space between the irq
> and its polarity/sense information.  This causes a bit of chaos
> as the reset of the blob is off by one cell.
>
> 
> diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> index ae08761..d665e76 100644
> --- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> +++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> @@ -411,7 +411,7 @@
>  			0xe000 0 0 1 &i8259 12 2
>  			0xe100 0 0 2 &i8259 9 2
>  			0xe200 0 0 3 &i8259 10 2
> -			0xe300 0 0 4 &i8259 112
> +			0xe300 0 0 4 &i8259 11 2
> 

Ouch.  That was probably my typo and fault.

Apologies.

jdl
