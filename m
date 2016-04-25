Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qtnXL1KGzzDqBS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 23:44:50 +1000 (AEST)
Date: Mon, 25 Apr 2016 08:44:42 -0500
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
Subject: Re: [PATCH 11/14] PCI: hisi: DT spelling s/interrupts-*/interrupt-*/
Message-ID: <20160425134442.GA5097@rob-hp-laptop>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
 <1461166339-11109-12-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461166339-11109-12-git-send-email-geert+renesas@glider.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 20, 2016 at 05:32:16PM +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thanks.

Rob

> ---
>  Documentation/devicetree/bindings/pci/hisilicon-pcie.txt | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> index b721beacfe4dae6c..59c2f47aa303ae24 100644
> --- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> @@ -34,11 +34,11 @@ Hip05 Example (note that Hip06 is the same except compatible):
>  		ranges = <0x82000000 0 0x00000000 0x220 0x00000000 0 0x10000000>;
>  		num-lanes = <8>;
>  		port-id = <1>;
> -		#interrupts-cells = <1>;
> -		interrupts-map-mask = <0xf800 0 0 7>;
> -		interrupts-map = <0x0 0 0 1 &mbigen_pcie 1 10
> -				  0x0 0 0 2 &mbigen_pcie 2 11
> -				  0x0 0 0 3 &mbigen_pcie 3 12
> -				  0x0 0 0 4 &mbigen_pcie 4 13>;
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0xf800 0 0 7>;
> +		interrupt-map = <0x0 0 0 1 &mbigen_pcie 1 10
> +				 0x0 0 0 2 &mbigen_pcie 2 11
> +				 0x0 0 0 3 &mbigen_pcie 3 12
> +				 0x0 0 0 4 &mbigen_pcie 4 13>;
>  		status = "ok";
>  	};
> -- 
> 1.9.1
> 
