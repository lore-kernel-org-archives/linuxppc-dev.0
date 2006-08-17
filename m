Return-Path: <hollis@penguinppc.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by ozlabs.org (Postfix) with ESMTP id B28FF679E2
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 04:51:26 +1000 (EST)
Subject: Re: Patch] Fix the mpc8641_hpcn.dts file.
From: Hollis Blanchard <hollis@penguinppc.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1155835482.10054.140.camel@cashmere.sps.mot.com>
References: <1155835482.10054.140.camel@cashmere.sps.mot.com>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 13:51:40 -0500
Message-Id: <1155840700.27466.64.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Doesn't the device tree compiler add linux,phandle properties as needed?
In this case that would be when the node is referenced by a
"<&/foo/bar/i8259@4d0>" property.

On Thu, 2006-08-17 at 12:24 -0500, Jon Loeliger wrote:
> Add 'linux,phandle' entry to i8259@4d0 node.
> 
> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> ---
> 
> Paul,
> 
> If possible, this should be slated for the
> upcoming .18 release.
> 
> Thanks,
> jdl
> 
> 
>  arch/powerpc/boot/dts/mpc8641_hpcn.dts |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> index e832a88..f0c7731 100644
> --- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> +++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> @@ -293,6 +293,7 @@
>  				f800 0 0 4 4d0 0 0
>  				>;
>  			i8259@4d0 {
> +				linux,phandle = <4d0>;
>  				clock-frequency = <0>;
>  				interrupt-controller;
>  				device_type = "interrupt-controller";
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
