Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 573E5B7B80
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Oct 2009 13:16:02 +1100 (EST)
Subject: Re: [PATCH][v2] powerpc/4xx: Add 16K FIFO size DTS entries on
	supported platforms
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Mitchell <dmitchell@appliedmicro.com>
In-Reply-To: <1255019609-2033-1-git-send-email-dmitchell@appliedmicro.com>
References: <1255019609-2033-1-git-send-email-dmitchell@appliedmicro.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Oct 2009 13:15:54 +1100
Message-Id: <1255054554.2355.28.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-10-08 at 11:33 -0500, Dave Mitchell wrote:
> Adding tx/rx-fifo-size-gige to EMAC fields for evaluation kit DTS
> files where appropriate.
> 
> Signed-off-by: Dave Mitchell <dmitchell@appliedmicro.com>
> Acked-by: Prodyut Hazarika <phazarika@appliedmicro.com>
> Acked-by: Victor Gallardo <vgallardo@appliedmicro.com>
> Acked-by: Loc Ho <lho@appliedmicro.com>
> ---
>  v1->v2: local date/time was out-of-sync and thus mail was as well

I'll have to wait for the EMAC patch to go in, so ping me if you don't
see me take that one after that happens.

Cheers,
Ben.

>  arch/powerpc/boot/dts/canyonlands.dts |    2 ++
>  arch/powerpc/boot/dts/eiger.dts       |    6 ++++++
>  arch/powerpc/boot/dts/glacier.dts     |    6 ++++++
>  arch/powerpc/boot/dts/haleakala.dts   |    2 ++
>  arch/powerpc/boot/dts/kilauea.dts     |    4 ++++
>  arch/powerpc/boot/dts/makalu.dts      |    4 ++++
>  arch/powerpc/boot/dts/redwood.dts     |    1 +
>  7 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
> index c920170..cd56bb5 100644
> --- a/arch/powerpc/boot/dts/canyonlands.dts
> +++ b/arch/powerpc/boot/dts/canyonlands.dts
> @@ -352,6 +352,7 @@
>  				max-frame-size = <9000>;
>  				rx-fifo-size = <4096>;
>  				tx-fifo-size = <2048>;
> +				rx-fifo-size-gige = <16384>;
>  				phy-mode = "rgmii";
>  				phy-map = <0x00000000>;
>  				rgmii-device = <&RGMII0>;
> @@ -381,6 +382,7 @@
>  				max-frame-size = <9000>;
>  				rx-fifo-size = <4096>;
>  				tx-fifo-size = <2048>;
> +				rx-fifo-size-gige = <16384>;
>  				phy-mode = "rgmii";
>  				phy-map = <0x00000000>;
>  				rgmii-device = <&RGMII0>;
> diff --git a/arch/powerpc/boot/dts/eiger.dts b/arch/powerpc/boot/dts/eiger.dts
> index c4a934f..48bcf71 100644
> --- a/arch/powerpc/boot/dts/eiger.dts
> +++ b/arch/powerpc/boot/dts/eiger.dts
> @@ -316,6 +316,7 @@
>  				max-frame-size = <9000>;
>  				rx-fifo-size = <4096>;
>  				tx-fifo-size = <2048>;
> +				rx-fifo-size-gige = <16384>;
>  				phy-mode = "rgmii";
>  				phy-map = <0x00000000>;
>  				rgmii-device = <&RGMII0>;
> @@ -345,6 +346,7 @@
>  				max-frame-size = <9000>;
>  				rx-fifo-size = <4096>;
>  				tx-fifo-size = <2048>;
> +				rx-fifo-size-gige = <16384>;
>  				phy-mode = "rgmii";
>  				phy-map = <0x00000000>;
>  				rgmii-device = <&RGMII0>;
> @@ -375,6 +377,8 @@
>  				max-frame-size = <9000>;
>  				rx-fifo-size = <4096>;
>  				tx-fifo-size = <2048>;
> +				rx-fifo-size-gige = <16384>;
> +				tx-fifo-size-gige = <16384>; /* emac2&3 only */
>  				phy-mode = "rgmii";
>  				phy-map = <0x00000000>;
>  				rgmii-device = <&RGMII1>;
> @@ -403,6 +407,8 @@
>  				max-frame-size = <9000>;
>  				rx-fifo-size = <4096>;
>  				tx-fifo-size = <2048>;
> +				rx-fifo-size-gige = <16384>;
> +				tx-fifo-size-gige = <16384>; /* emac2&3 only */
>  				phy-mode = "rgmii";
>  				phy-map = <0x00000000>;
>  				rgmii-device = <&RGMII1>;
> diff --git a/arch/powerpc/boot/dts/glacier.dts b/arch/powerpc/boot/dts/glacier.dts
> index f3787a2..f6f6189 100644
> --- a/arch/powerpc/boot/dts/glacier.dts
> +++ b/arch/powerpc/boot/dts/glacier.dts
> @@ -292,6 +292,7 @@
>  				max-frame-size = <9000>;
>  				rx-fifo-size = <4096>;
>  				tx-fifo-size = <2048>;
> +				rx-fifo-size-gige = <16384>;
>  				phy-mode = "rgmii";
>  				phy-map = <0x00000000>;
>  				rgmii-device = <&RGMII0>;
> @@ -321,6 +322,7 @@
>  				max-frame-size = <9000>;
>  				rx-fifo-size = <4096>;
>  				tx-fifo-size = <2048>;
> +				rx-fifo-size-gige = <16384>;
>  				phy-mode = "rgmii";
>  				phy-map = <0x00000000>;
>  				rgmii-device = <&RGMII0>;
> @@ -351,6 +353,8 @@
>  				max-frame-size = <9000>;
>  				rx-fifo-size = <4096>;
>  				tx-fifo-size = <2048>;
> +				rx-fifo-size-gige = <16384>;
> +				tx-fifo-size-gige = <16384>; /* emac2&3 only */
>  				phy-mode = "rgmii";
>  				phy-map = <0x00000000>;
>  				rgmii-device = <&RGMII1>;
> @@ -379,6 +383,8 @@
>  				max-frame-size = <9000>;
>  				rx-fifo-size = <4096>;
>  				tx-fifo-size = <2048>;
> +				rx-fifo-size-gige = <16384>;
> +				tx-fifo-size-gige = <16384>; /* emac2&3 only */
>  				phy-mode = "rgmii";
>  				phy-map = <0x00000000>;
>  				rgmii-device = <&RGMII1>;
> diff --git a/arch/powerpc/boot/dts/haleakala.dts b/arch/powerpc/boot/dts/haleakala.dts
> index 5b2a494..2b25669 100644
> --- a/arch/powerpc/boot/dts/haleakala.dts
> +++ b/arch/powerpc/boot/dts/haleakala.dts
> @@ -226,6 +226,8 @@
>  				max-frame-size = <9000>;
>  				rx-fifo-size = <4096>;
>  				tx-fifo-size = <2048>;
> +				rx-fifo-size-gige = <16384>;
> +				tx-fifo-size-gige = <16384>;
>  				phy-mode = "rgmii";
>  				phy-map = <0x00000000>;
>  				rgmii-device = <&RGMII0>;
> diff --git a/arch/powerpc/boot/dts/kilauea.dts b/arch/powerpc/boot/dts/kilauea.dts
> index c465614..083e68e 100644
> --- a/arch/powerpc/boot/dts/kilauea.dts
> +++ b/arch/powerpc/boot/dts/kilauea.dts
> @@ -272,6 +272,8 @@
>  				max-frame-size = <9000>;
>  				rx-fifo-size = <4096>;
>  				tx-fifo-size = <2048>;
> +				rx-fifo-size-gige = <16384>;
> +				tx-fifo-size-gige = <16384>;
>  				phy-mode = "rgmii";
>  				phy-map = <0x00000000>;
>  				rgmii-device = <&RGMII0>;
> @@ -300,6 +302,8 @@
>  				max-frame-size = <9000>;
>  				rx-fifo-size = <4096>;
>  				tx-fifo-size = <2048>;
> +				rx-fifo-size-gige = <16384>;
> +				tx-fifo-size-gige = <16384>;
>  				phy-mode = "rgmii";
>  				phy-map = <0x00000000>;
>  				rgmii-device = <&RGMII0>;
> diff --git a/arch/powerpc/boot/dts/makalu.dts b/arch/powerpc/boot/dts/makalu.dts
> index ffc246e..63d48b6 100644
> --- a/arch/powerpc/boot/dts/makalu.dts
> +++ b/arch/powerpc/boot/dts/makalu.dts
> @@ -227,6 +227,8 @@
>  				max-frame-size = <9000>;
>  				rx-fifo-size = <4096>;
>  				tx-fifo-size = <2048>;
> +				rx-fifo-size-gige = <16384>;
> +				tx-fifo-size-gige = <16384>;
>  				phy-mode = "rgmii";
>  				phy-map = <0x0000003f>;	/* Start at 6 */
>  				rgmii-device = <&RGMII0>;
> @@ -255,6 +257,8 @@
>  				max-frame-size = <9000>;
>  				rx-fifo-size = <4096>;
>  				tx-fifo-size = <2048>;
> +                                rx-fifo-size-gige = <16384>;
> +                                tx-fifo-size-gige = <16384>;
>  				phy-mode = "rgmii";
>  				phy-map = <0x00000000>;
>  				rgmii-device = <&RGMII0>;
> diff --git a/arch/powerpc/boot/dts/redwood.dts b/arch/powerpc/boot/dts/redwood.dts
> index ad402c4..d2af32e 100644
> --- a/arch/powerpc/boot/dts/redwood.dts
> +++ b/arch/powerpc/boot/dts/redwood.dts
> @@ -226,6 +226,7 @@
>  				max-frame-size = <9000>;
>  				rx-fifo-size = <4096>;
>  				tx-fifo-size = <2048>;
> +				rx-fifo-size-gige = <16384>;
>  				phy-mode = "rgmii";
>  				phy-map = <0x00000000>;
>  				rgmii-device = <&RGMII0>;
