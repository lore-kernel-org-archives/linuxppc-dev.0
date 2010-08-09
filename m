Return-Path: <cbouatmailru@gmail.com>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42]) by ozlabs.org (Postfix) with ESMTP id 58E34B70A7
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 03:36:51 +1000 (EST)
Received: by bwz17 with SMTP id 17so2415932bwz.15
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Aug 2010 10:36:50 -0700 (PDT)
Date: Mon, 9 Aug 2010 21:36:47 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH 2/3 v2] dts: Add sdhci,auto-cmd12 field for p4080
	device tree
Message-ID: <20100809173647.GB7665@oksana.dev.rtsoft.ru>
References: <1280805072-26112-1-git-send-email-tie-fei.zang@freescale.com>
	<1280805072-26112-2-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1280805072-26112-2-git-send-email-tie-fei.zang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-mmc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 03, 2010 at 11:11:11AM +0800, Roy Zang wrote:
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
>  Documentation/powerpc/dts-bindings/fsl/esdhc.txt |    2 ++
>  arch/powerpc/boot/dts/p4080ds.dts                |    1 +
>  2 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/powerpc/dts-bindings/fsl/esdhc.txt b/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
> index 8a00407..64bcb8b 100644
> --- a/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
> +++ b/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
> @@ -14,6 +14,8 @@ Required properties:
>      reports inverted write-protect state;
>    - sdhci,1-bit-only : (optional) specifies that a controller can
>      only handle 1-bit data transfers.
> +  - sdhci,auto-cmd12: (optional) specifies that a controller can
> +    only handle auto CMD12.

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

>  Example:
>  
> diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
> index 6b29eab..efa0091 100644
> --- a/arch/powerpc/boot/dts/p4080ds.dts
> +++ b/arch/powerpc/boot/dts/p4080ds.dts
> @@ -280,6 +280,7 @@
>  			reg = <0x114000 0x1000>;
>  			interrupts = <48 2>;
>  			interrupt-parent = <&mpic>;
> +			sdhci,auto-cmd12;
>  		};
>  
>  		i2c@118000 {

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
