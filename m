Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2D097DDF00
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 05:08:40 +1100 (EST)
Message-ID: <47A1FEB4.1040806@freescale.com>
Date: Thu, 31 Jan 2008 11:00:36 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Zhang Wei <wei.zhang@freescale.com>
Subject: Re: [PATCH 1/2] Add RapidIO node into MPC8641HPCN dts file
References: <12017656032841-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <12017656032841-git-send-email-wei.zhang@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Zhang Wei wrote:
> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc8641_hpcn.dts |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> index 556a9ca..1a0fce5 100644
> --- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> +++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts

> @@ -499,4 +500,16 @@
>  				  0 00100000>;
>  		};
>  	};
> +
> +	rapidio0: rapidio@f80c0000 {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "fsl,rapidio-delta";
> +		reg = <f80c0000 20000>;
> +		ranges = <0 0 c0000000 0 20000000>;
> +		interrupt-parent = <&mpic>;
> +		/* err_irq bell_outb_irq bell_inb_irq
> +			msg1_tx_irq msg1_rx_irq	msg2_tx_irq msg2_rx_irq */
> +		interrupts = <30 2 31 2 32 2 35 2 36 2 37 2 38 2>;
> +	};
>  };

Have updates to the booting-without-of.txt file for
been made or proposed for the RapidIO node definition?

jdl
