Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqz7g3S6DzDqb3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 09:47:11 +1000 (AEST)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id 08EFA202EC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 23:47:09 +0000 (UTC)
Received: from mail-yw0-f170.google.com (mail-yw0-f170.google.com
 [209.85.161.170])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 403A92034E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 23:47:06 +0000 (UTC)
Received: by mail-yw0-f170.google.com with SMTP id t10so72017589ywa.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 16:47:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1461166339-11109-5-git-send-email-geert+renesas@glider.be>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
 <1461166339-11109-5-git-send-email-geert+renesas@glider.be>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 20 Apr 2016 18:46:45 -0500
Message-ID: <CAL_JsqKSbGPKNZdZnowGpdF8zxXbh6g-wkq96+KmBNLwp7n=HQ@mail.gmail.com>
Subject: Re: [PATCH 04/14] ARM: dts: OMAP36xx: : DT spelling
 s/#address-cell/#address-cells/
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>,
 Zhou Wang <wangzhou1@hisilicon.com>, Tony Lindgren <tony@atomide.com>,
 Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Joe Perches <joe@perches.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, dmaengine@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 20, 2016 at 10:32 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/boot/dts/omap36xx.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
> index ce1e242d4dc07ea8..8b797915300894d8 100644
> --- a/arch/arm/boot/dts/omap36xx.dtsi
> +++ b/arch/arm/boot/dts/omap36xx.dtsi
> @@ -44,7 +44,7 @@
>                 abb_mpu_iva: regulator-abb-mpu {
>                         compatible = "ti,abb-v1";
>                         regulator-name = "abb_mpu_iva";
> -                       #address-cell = <0>;
> +                       #address-cells = <0>;

dtc should flag this if it was really needed. However, it looks like
it isn't as there are no child nodes (unless the board files add
them).

A nice dtc check would be to flag unnecessary #address-cells or
#size-cells. That would only help here after your fix though.

Rob

>                         #size-cells = <0>;
>                         reg = <0x483072f0 0x8>, <0x48306818 0x4>;
>                         reg-names = "base-address", "int-address";
> --
> 1.9.1
>
