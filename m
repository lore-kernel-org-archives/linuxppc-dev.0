Return-Path: <B42677@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 66D6D2C00E9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Sep 2013 18:07:31 +1000 (EST)
Received: from mail78-db8 (localhost [127.0.0.1])	by mail78-db8-R.bigfish.com
 (Postfix) with ESMTP id 45B24520081	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,
 16 Sep 2013 08:07:25 +0000 (UTC)
Received: from DB8EHSMHS009.bigfish.com (unknown [10.174.8.240])	by
 mail78-db8.bigfish.com (Postfix) with ESMTP id B0386300041	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Sep 2013 08:07:22 +0000 (UTC)
Message-ID: <5236BD62.8050604@freescale.com>
Date: Mon, 16 Sep 2013 16:12:18 +0800
From: Zhang Haijun <B42677@freescale.com>
MIME-Version: 1.0
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: Re: [PATCH] Powerpc/dts: Correct sdhci quirk for bsc9131
References: <1378118222-17338-1-git-send-email-Haijun.Zhang@freescale.com>
In-Reply-To: <1378118222-17338-1-git-send-email-Haijun.Zhang@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org, X.Xie@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/02/2013 06:37 PM, Haijun Zhang wrote:
> We use property "sdhci,auto-cmd12" instead of "fsl,sdhci-auto-cmd12"
> to distinguish if the sdhc host has quirk SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12.
>
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> ---
>   arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi b/arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi
> index 5180d9d..0c0efa9 100644
> --- a/arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi
> @@ -130,7 +130,7 @@ usb@22000 {
>
>   /include/ "pq3-esdhc-0.dtsi"
>   	sdhc@2e000 {
> -		fsl,sdhci-auto-cmd12;
> +		sdhci,auto-cmd12;
>   		interrupts = <41 0x2 0 0>;
>   	};
>
>


Hi, scott

Could you help review this patch?

-- 
Thanks & Regards

Haijun
