Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id F11C5B70B1
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jul 2010 17:30:35 +1000 (EST)
Received: by eyh6 with SMTP id 6so2160683eyh.15
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jul 2010 00:30:34 -0700 (PDT)
Date: Fri, 30 Jul 2010 11:30:30 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH 2/3] dts: Add sdhci-auto-cmd12 field for p4080 device tree
Message-ID: <20100730073030.GD20351@oksana.dev.rtsoft.ru>
References: <1280295887-14251-1-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1280295887-14251-1-git-send-email-tie-fei.zang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-mmc-approval@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 28, 2010 at 01:44:47PM +0800, Roy Zang wrote:
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
>  arch/powerpc/boot/dts/p4080ds.dts |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
> index 6b29eab..11c8884 100644
> --- a/arch/powerpc/boot/dts/p4080ds.dts
> +++ b/arch/powerpc/boot/dts/p4080ds.dts
> @@ -280,6 +280,7 @@
>  			reg = <0x114000 0x1000>;
>  			interrupts = <48 2>;
>  			interrupt-parent = <&mpic>;
> +			fsl,sdhci-auto-cmd12;

This should be sdhci,auto-cmd12 or something like that,
not fsl-specific.

Also please document this property in
Documentation/powerpc/dts-bindings/fsl/esdhc.txt.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
