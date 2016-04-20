Return-Path: <dmitry.torokhov@gmail.com>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqq3B3qMWzDqCB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 03:42:46 +1000 (AEST)
Received: by mail-pa0-x22a.google.com with SMTP id fs9so19998001pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 10:42:46 -0700 (PDT)
Date: Wed, 20 Apr 2016 10:42:41 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Zhou Wang <wangzhou1@hisilicon.com>, Tony Lindgren <tony@atomide.com>,
 Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Joe Perches <joe@perches.com>, devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org
Subject: Re: [PATCH 09/14] Input: touchscreen: Broadcom iProc: DT spelling
 s/clock-name/clock-names/
Message-ID: <20160420174241.GA28831@dtor-ws>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
 <1461166339-11109-10-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461166339-11109-10-git-send-email-geert+renesas@glider.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 20, 2016 at 05:32:14PM +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thank you.

> ---
>  .../devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
> index 25541f30e38701f2..ac5dff412e25266f 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
> @@ -7,7 +7,7 @@ Required properties:
>    If this property is selected please make sure MFD_SYSCON config
>    is enabled in the defconfig file.
>  - clocks:  The clock provided by the SOC to driver the tsc
> -- clock-name:  name for the clock
> +- clock-names:  name for the clock
>  - interrupts: The touchscreen controller's interrupt
>  - address-cells: Specify the number of u32 entries needed in child nodes.
>    Should set to 1.
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
