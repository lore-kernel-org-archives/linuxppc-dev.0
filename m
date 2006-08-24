Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4910867C26
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 12:02:50 +1000 (EST)
In-Reply-To: <20060823203944.34c85a6a.kim.phillips@freescale.com>
References: <20060823203944.34c85a6a.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FC1BA132-91BE-482F-BF79-FAB91667E188@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/3] Add MPC8349E MDS device tree source file to
	arch/powerpc/boot/dts
Date: Wed, 23 Aug 2006 21:02:44 -0500
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 23, 2006, at 8:39 PM, Kim Phillips wrote:

> Add MPC8349E MDS device tree source file to arch/powerpc/boot/dts
>
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
>
>  arch/powerpc/boot/dts/mpc8349emds.dts |  327 ++++++++++++++++++++++ 
> +++++++++++
>  1 files changed, 327 insertions(+), 0 deletions(-)

Can we rename the defconfig to match the dts, mpc834x_sys was a bad  
choice but what was I to do.  Things seem to have stabilized on MDS  
so we should go with that.

> +
> +		/* IPIC
> +		 * interrupts cell = <intr #, sense>
> +		 * sense == 8: Level, low assertion
> +		 * sense == 2: Edge, high-to-low change
> +		 */

Would be good to add a comment that we match IORESOURCE_IRQ_* defn.

> +		pic@700 {
> +			linux,phandle = <700>;
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			reg = <700 100>;
> +			built-in;
> +			device_type = "ipic";
> +		};
> +	};
> +};
> -- 
> 2006_06_07.01.gittree_pull-dirty
