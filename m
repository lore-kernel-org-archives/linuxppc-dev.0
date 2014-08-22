Return-Path: <robherring2@gmail.com>
Received: from mail-vc0-x22a.google.com (mail-vc0-x22a.google.com
 [IPv6:2607:f8b0:400c:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB74A1A0160
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Aug 2014 13:13:10 +1000 (EST)
Received: by mail-vc0-f170.google.com with SMTP id lf12so11834639vcb.29
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 20:13:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1408524184-31928-5-git-send-email-p.zabel@pengutronix.de>
References: <1408524184-31928-1-git-send-email-p.zabel@pengutronix.de>
 <1408524184-31928-5-git-send-email-p.zabel@pengutronix.de>
From: Rob Herring <robherring2@gmail.com>
Date: Thu, 21 Aug 2014 22:12:47 -0500
Message-ID: <CAL_JsqK3Wi9b=7w=Npu3HN8SSkyFgVT0Qoc48LUyoiEaBjSCTA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/6] powerpc/85xx: Change vendor prefix for Intersil
 Corporation to isil
To: Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Alessandro Zummo <a.zummo@towertech.it>, Russell King <linux@arm.linux.org.uk>,
 Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>,
 Kumar Gala <galak@codeaurora.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 20, 2014 at 3:43 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Currently there is a wild mixture of isl, isil, and intersil
> compatibles in the kernel. At this point, changing the vendor
> symbol to the most often used variant, which is equal to the
> NASDAQ symbol, isil, should not hurt, since the isl1208 driver
> doesn't care either way.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  arch/powerpc/boot/dts/ppa8548.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/boot/dts/ppa8548.dts b/arch/powerpc/boot/dts/ppa8548.dts
> index 27b0699..000262b 100644
> --- a/arch/powerpc/boot/dts/ppa8548.dts
> +++ b/arch/powerpc/boot/dts/ppa8548.dts
> @@ -89,7 +89,7 @@
>  &soc {
>         i2c@3000 {
>                 rtc@6f {
> -                       compatible = "intersil,isl1208";
> +                       compatible = "isil,isl1208";

This is a mature platform. You cannot change it. You can add the new
string, but the dts and kernel need both strings.

I would just leave it all alone and add the new prefix and mark the
others deprecated.

Rob

>                         reg = <0x6f>;
>                 };
>         };
> --
> 2.1.0.rc1
>
