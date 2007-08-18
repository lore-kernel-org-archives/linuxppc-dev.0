Return-Path: <domen@coderock.org>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id E1A53DDE32
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Aug 2007 20:33:19 +1000 (EST)
Date: Sat, 18 Aug 2007 12:06:43 +0200
From: Domen Puncer <domen@coderock.org>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [RFC PATCH v0.1] net driver: mpc52xx fec
Message-ID: <20070818100643.GA31233@nd47.coderock.org>
References: <20070810095153.GC13994@moe.telargo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070810095153.GC13994@moe.telargo.com>
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

Hi!

On 10/08/07 11:51 +0200, Domen Puncer wrote:
> Index: work-powerpc.git/arch/powerpc/boot/dts/lite5200b.dts
> ===================================================================
> --- work-powerpc.git.orig/arch/powerpc/boot/dts/lite5200b.dts
> +++ work-powerpc.git/arch/powerpc/boot/dts/lite5200b.dts
> +		mdio@3000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "mdio";
> +			compatible = "mpc5200b-fec-phy";
> +			reg = <3000 400>;	// fec range, since we need to setup fec interrupts
> +			interrupts = <2 5 0>;	// these are for "mii command finished", not link changes & co.
> +			interrupt-parent = <&mpc5200_pic>;
> +
> +			phy0:ethernet-phy@0 {
> +				device_type = "ethernet-phy";
> +				reg = <0>;
> +			};
>  		};

I am struggling with this part on Efika.
I would like to add this to the device tree from
fixup_device_tree_efika() (arch/powerpc/kernel/prom_init.c).

AFAICS client-services doesn't offer anything like new-device,
so I guess "interpret" or "call-method" will have to be used.

I have read some docs, but I'm still wandering in the dark.
Can I please get an example?
Pretty please with a cherry on top?


	Domen
