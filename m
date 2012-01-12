Return-Path: <B32736@freescale.com>
Received: from VA3EHSOBE002.bigfish.com (va3ehsobe002.messaging.microsoft.com
 [216.32.180.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2367DB6EF2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2012 21:00:31 +1100 (EST)
Subject: Re: [SDK v1.2][PATCH] powerpc/dts: update dts for p1020rdb
From: fanzc <b32736@freescale.com>
To: <galak@kernel.crashing.org>
In-Reply-To: <1326362459-9654-1-git-send-email-B32736@freescale.com>
References: <y>  <1326362459-9654-1-git-send-email-B32736@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 12 Jan 2012 18:02:52 +0800
Message-ID: <1326362572.18469.7.camel@B32736>
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hi all
	please ignore this email

On Thu, 2012-01-12 at 18:00 +0800, Zhicheng Fan wrote:
> nand: Sync base address with U-boot
> sdhc: Add suppot auto cmd12
> 
> Signed-off-by: Zhicheng Fan <B32736@freescale.com>
> ---
>  arch/powerpc/boot/dts/fsl/p1020si-post.dtsi |    3 +++
>  arch/powerpc/boot/dts/p1020rdb.dts          |    2 +-
>  arch/powerpc/boot/dts/p1020rdb_36b.dts      |    2 +-
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
> index fc924c5..8e56ad2 100644
> --- a/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
> @@ -145,6 +145,9 @@
>  /include/ "pq3-usb2-dr-1.dtsi"
>  
>  /include/ "pq3-esdhc-0.dtsi"
> +	sdhc@2e000 {
> +		sdhci,auto-cmd12;
> +	};
>  /include/ "pq3-sec3.3-0.dtsi"
>  
>  /include/ "pq3-mpic.dtsi"
> diff --git a/arch/powerpc/boot/dts/p1020rdb.dts b/arch/powerpc/boot/dts/p1020rdb.dts
> index 518bf99..19b8c77 100644
> --- a/arch/powerpc/boot/dts/p1020rdb.dts
> +++ b/arch/powerpc/boot/dts/p1020rdb.dts
> @@ -23,7 +23,7 @@
>  
>  		/* NOR, NAND Flashes and Vitesse 5 port L2 switch */
>  		ranges = <0x0 0x0 0x0 0xef000000 0x01000000
> -			  0x1 0x0 0x0 0xffa00000 0x00040000
> +			  0x1 0x0 0x0 0xff800000 0x00040000
>  			  0x2 0x0 0x0 0xffb00000 0x00020000>;
>  	};
>  
> diff --git a/arch/powerpc/boot/dts/p1020rdb_36b.dts b/arch/powerpc/boot/dts/p1020rdb_36b.dts
> index bdbdb60..7c53ad7 100644
> --- a/arch/powerpc/boot/dts/p1020rdb_36b.dts
> +++ b/arch/powerpc/boot/dts/p1020rdb_36b.dts
> @@ -23,7 +23,7 @@
>  
>  		/* NOR, NAND Flashes and Vitesse 5 port L2 switch */
>  		ranges = <0x0 0x0 0xf 0xef000000 0x01000000
> -			  0x1 0x0 0xf 0xffa00000 0x00040000
> +			  0x1 0x0 0xf 0xff800000 0x00040000
>  			  0x2 0x0 0xf 0xffb00000 0x00020000>;
>  	};
>  
