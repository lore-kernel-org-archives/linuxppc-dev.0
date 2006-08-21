Return-Path: <hollis@penguinppc.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by ozlabs.org (Postfix) with ESMTP id F0A9F67BCB
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 05:39:13 +1000 (EST)
Subject: Re: [PATCH] Fix FEC node in 8540 ADS dts
From: Hollis Blanchard <hollis@penguinppc.org>
To: Andy Fleming <afleming@freescale.com>
In-Reply-To: <Pine.LNX.4.61.0608211427330.12614@ld0175-tx32.am.freescale.net>
References: <Pine.LNX.4.61.0608211427330.12614@ld0175-tx32.am.freescale.net>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 14:39:30 -0500
Message-Id: <1156189170.11326.56.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-08-21 at 14:29 -0500, Andy Fleming wrote:
> 
> diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts
> b/arch/powerpc/boot/dts/mpc8540ads.dts
> index 93d2c2d..5f41c1f 100644
> --- a/arch/powerpc/boot/dts/mpc8540ads.dts
> +++ b/arch/powerpc/boot/dts/mpc8540ads.dts
> @@ -83,11 +83,11 @@
>                                 reg = <1>;
>                                 device_type = "ethernet-phy";
>                         };
> -                       ethernet-phy@2 {
> -                               linux,phandle = <2452002>;
> +                       ethernet-phy@3 {
> +                               linux,phandle = <2452003>; 

Again, doesn't DTC assign linux,phandle properties as needed (i.e. when
the node is referenced with & syntax)?

-Hollis
