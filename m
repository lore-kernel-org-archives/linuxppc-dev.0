Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F398ADDE01
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 10:54:46 +1100 (EST)
Subject: Re: [PATCH] Enable enhanced functions for 8536 TSEC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jason Jin <Jason.jin@freescale.com>
In-Reply-To: <1224149492-11204-1-git-send-email-Jason.jin@freescale.com>
References: <1224149492-11204-1-git-send-email-Jason.jin@freescale.com>
Content-Type: text/plain
Date: Tue, 21 Oct 2008 10:54:35 +1100
Message-Id: <1224546875.7654.198.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-10-16 at 17:31 +0800, Jason Jin wrote:
> Signed-off-by: Jason Jin <Jason.jin@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc8536ds.dts |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts b/arch/powerpc/boot/dts/mpc8536ds.dts
> index 93fdd99..dce2f65 100644
> --- a/arch/powerpc/boot/dts/mpc8536ds.dts
> +++ b/arch/powerpc/boot/dts/mpc8536ds.dts
> @@ -180,7 +180,7 @@
>  		enet0: ethernet@24000 {
>  			cell-index = <0>;
>  			device_type = "network";
> -			model = "TSEC";
> +			model = "eTSEC";
>  			compatible = "gianfar";
>  			reg = <0x24000 0x1000>;
>  			local-mac-address = [ 00 00 00 00 00 00 ];

While this works, this isn't quite "proper" use of the device-tree,
you should instead have something like

compatible="gianfar-eTSEC","gianfar" or something like that

Cheers,
Ben.
