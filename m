Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BD674DE91A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Mar 2008 05:54:01 +1100 (EST)
Message-Id: <60A35F8F-FA66-4ADD-B192-6AC6A301DBA0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Sebastian Siewior <bigeasy@tglx.de>
In-Reply-To: <20080311103906.GD9656@www.tglx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [RFC/PATCH] [POWER] mpc85xx_ds add DMA engine to the DT and parse
	it.
Date: Tue, 11 Mar 2008 13:53:40 -0500
References: <20080311103906.GD9656@www.tglx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mar 11, 2008, at 5:39 AM, Sebastian Siewior wrote:

> The DT entry is copy / paste from the documentation.
>
> Signed-off-by: Sebastian Siewior <bigeasy@linutronix.de>
> ---
> arch/powerpc/boot/dts/mpc8544ds.dts      |   41 +++++++++++++++++++++ 
> +++++++++
> arch/powerpc/platforms/85xx/mpc85xx_ds.c |   13 +++++++++
> 2 files changed, 54 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/ 
> dts/mpc8544ds.dts
> index 688af9d..fdaf793 100644
> --- a/arch/powerpc/boot/dts/mpc8544ds.dts
> +++ b/arch/powerpc/boot/dts/mpc8544ds.dts
> @@ -116,6 +116,47 @@
> 			};
> 		};
>
> +		dma@21300 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "fsl,mpc8540-dma", "fsl,eloplus-dma";
> +			reg = <21300 4>;
> +			ranges = <0 21100 200>;
> +			cell-index = <0>;
> +			dma-channel@0 {
> +				compatible = "fsl,mpc8540-dma-channel",
> +						"fsl,eloplus-dma-channel";

this should be mpc8544-dma everywhere.

- k
