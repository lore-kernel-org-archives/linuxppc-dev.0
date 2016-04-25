Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qtnXf3kv6zDqHk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 23:45:06 +1000 (AEST)
Date: Mon, 25 Apr 2016 08:45:00 -0500
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>,
 Zhou Wang <wangzhou1@hisilicon.com>, Tony Lindgren <tony@atomide.com>,
 Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Joe Perches <joe@perches.com>, devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org
Subject: Re: [PATCH 12/14] phy: phy-stih41x-usb: DT spelling
 s/#phy-cell/#phy-cells/
Message-ID: <20160425134500.GA5523@rob-hp-laptop>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
 <1461166339-11109-13-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461166339-11109-13-git-send-email-geert+renesas@glider.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 20, 2016 at 05:32:17PM +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thanks.

Rob

> ---
>  Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt b/Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt
> index 00944a05ee6b4998..744b4809542edd3b 100644
> --- a/Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt
> @@ -17,7 +17,7 @@ Example:
>  
>  usb2_phy: usb2phy@0 {
>  	compatible	= "st,stih416-usb-phy";
> -	#phy-cell	= <0>;
> +	#phy-cells	= <0>;
>  	st,syscfg	= <&syscfg_rear>;
>  	clocks		= <&clk_sysin>;
>  	clock-names	= "osc_phy";
> -- 
> 1.9.1
> 
