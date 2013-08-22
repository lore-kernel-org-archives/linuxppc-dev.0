Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AB4712C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 07:53:33 +1000 (EST)
Received: from mail85-am1 (localhost [127.0.0.1])	by mail85-am1-R.bigfish.com
 (Postfix) with ESMTP id 6A157C0515	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,
 22 Aug 2013 21:53:28 +0000 (UTC)
Received: from AM1EHSMHS012.bigfish.com (unknown [10.3.201.247])	by
 mail85-am1.bigfish.com (Postfix) with ESMTP id D2CA84A004B	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 21:53:21 +0000 (UTC)
Message-ID: <1377208398.20722.16.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/p1010rdb: update phy node in dts
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Date: Thu, 22 Aug 2013 16:53:18 -0500
In-Reply-To: <1377144372-9003-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1377144372-9003-1-git-send-email-Shengzhou.Liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-08-22 at 12:06 +0800, Shengzhou Liu wrote:
> Update phy node according to new P1010RDB-PB board.
> 
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
>  arch/powerpc/boot/dts/p1010rdb.dtsi |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/p1010rdb.dtsi b/arch/powerpc/boot/dts/p1010rdb.dtsi
> index ec7c27a..da24b2d 100644
> --- a/arch/powerpc/boot/dts/p1010rdb.dtsi
> +++ b/arch/powerpc/boot/dts/p1010rdb.dtsi
> @@ -193,17 +193,17 @@
>  
>  	mdio@24000 {
>  		phy0: ethernet-phy@0 {
> -			interrupts = <3 1 0 0>;
> +			interrupts = <0 1>;
>  			reg = <0x1>;
>  		};
>  
>  		phy1: ethernet-phy@1 {
> -			interrupts = <2 1 0 0>;
> +			interrupts = <2 1>;
>  			reg = <0x0>;
>  		};
>  
>  		phy2: ethernet-phy@2 {
> -			interrupts = <2 1 0 0>;
> +			interrupts = <1 1>;
>  			reg = <0x2>;
>  		};

#interrupt-cells is 4

-Scott
