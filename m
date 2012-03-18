Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B2965B6FD8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2012 10:39:01 +1100 (EST)
Date: Mon, 19 Mar 2012 00:38:57 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v2 2/4] powerpc, mpc52xx: add a4m072 board support
Message-ID: <20120319003857.7a64163f@wker>
In-Reply-To: <1308739150-31527-1-git-send-email-hs@denx.de>
References: <1308729311-15375-3-git-send-email-hs@denx.de>
 <1308739150-31527-1-git-send-email-hs@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Heiko,

On Wed, 22 Jun 2011 12:39:10 +0200
Heiko Schocher <hs@denx.de> wrote:
...
> diff --git a/arch/powerpc/boot/dts/a4m072.dts b/arch/powerpc/boot/dts/a4m072.dts
> new file mode 100644
> index 0000000..adb6746
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/a4m072.dts
...
> +		cdm@200 {
> +			fsl,ext_48mhz_en = <0x0>;
> +			fsl,fd_enable = <0x01>;
> +			fsl,fd_counters = <0xbbbb>;

When applying this patch I've fixed these properties according to
previously added bindings (fsl,init-*-*), but one question remains:
is fd-counters value really 0xbbbb? Here, the 3rd bit in each nibble
should always be cleared as mentioned in the register description.

...
> +		timer@600 {
> +			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
> +			reg = <0x600 0x80>;
> +			interrupts = <1 9 0>;

I've removed above three lines as these are already in the dtsi file.

Thanks,
Anatolij
