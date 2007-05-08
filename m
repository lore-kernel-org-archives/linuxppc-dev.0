Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 3A344DDDFB
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 13:40:47 +1000 (EST)
Date: Mon, 7 May 2007 22:42:47 -0500
To: Dave Jiang <djiang@mvista.com>
Subject: Re: [PATCH] powerpc: add dts entries to 85xx for EDAC
Message-ID: <20070508034247.GA13409@lixom.net>
References: <20070425213700.GA8814@blade.az.mvista.com>
	<20070426000852.GA2193@localhost.localdomain>
	<20070426003748.GA30730@blade.az.mvista.com>
	<9903F55A-5E4E-42CE-8C27-6B7143B9FE25@kernel.crashing.org>
	<20070501183220.GA6426@blade.az.mvista.com>
	<20070507232634.GA11166@blade.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070507232634.GA11166@blade.az.mvista.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Mon, May 07, 2007 at 04:26:34PM -0700, Dave Jiang wrote:

> Adding memory-controller and l2-cache-controller entries to be used by EDAC as
> of_devices.
> 
> Signed-off-by: Dave Jiang <djiang@mvista.com>
> 
> ---
> 
>  arch/powerpc/boot/dts/mpc8540ads.dts |   16 ++++++++++++++++
>  arch/powerpc/boot/dts/mpc8548cds.dts |   16 ++++++++++++++++
>  arch/powerpc/boot/dts/mpc8560ads.dts |   18 +++++++++++++++++-
>  3 files changed, 49 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
> index f261d64..f411bc1 100644
> --- a/arch/powerpc/boot/dts/mpc8540ads.dts
> +++ b/arch/powerpc/boot/dts/mpc8540ads.dts
> @@ -48,6 +48,22 @@
>  		reg = <e0000000 00100000>;	// CCSRBAR 1M
>  		bus-frequency = <0>;
>  
> +		memory-controller@2000 {
> +			compatible = "fsl,85xx-memory-controller";
> +			reg = <2000 1000>;
> +			interrupt-parent = <&mpic>;
> +			interrupts = <2 2>;
> +		};
> +
> +		l2-cache-controller@20000 {
> +			compatible = "fsl,85xx-memory-controller";

Interesting. Is the programming model really the same for the memory and cache controller?


-Olof
