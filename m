Return-Path: <dgibson@ozlabs.org>
Date: Mon, 5 Nov 2007 11:50:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH v2 08/12] [POWERPC] CM5200 DTS
Message-ID: <20071105005007.GH19867@localhost.localdomain>
References: <20071103235210.31906.83423.stgit@hekate.izotz.org>
	<20071103235259.31906.54116.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071103235259.31906.54116.stgit@hekate.izotz.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Nov 04, 2007 at 12:52:59AM +0100, Marian Balakowicz wrote:
> Add device tree source file for CM5200 board.
> 
> Signed-off-by: Marian Balakowicz <m8@semihalf.com>

Same comments as the TQM device tree, plus those below.

[snip]
> +		rtc@800 {	// Real time clock
> +			compatible = "mpc5200b-rtc","mpc5200-rtc";
> +			device_type = "rtc";

No device_type here.

[snip]
> +		spi@f00 {
> +			device_type = "spi";

Definitely no device_type here.

> +			compatible = "mpc5200b-spi","mpc5200-spi";
> +			reg = <f00 20>;
> +			interrupts = <2 d 0 2 e 0>;
> +			interrupt-parent = <&mpc5200_pic>;
> +		};

[snip]
> +		i2c@3d40 {
> +			device_type = "i2c";

No device_type here.


> +			compatible = "mpc5200b-i2c","mpc5200-i2c","fsl-i2c";
> +			reg = <3d40 40>;
> +			interrupts = <2 10 0>;
> +			interrupt-parent = <&mpc5200_pic>;
> +			fsl5200-clocking;
> +		};
> +
> +		sram@8000 {
> +			compatible = "mpc5200b-sram","mpc5200-sram","sram";
> +			reg = <8000 4000>;
> +		};
> +	};
> +};

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
