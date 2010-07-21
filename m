Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 82589B70A6
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 00:25:02 +1000 (EST)
Subject: Re: [PATCH] DTS: Adding device tree source for the STx GP3 SSA
	MPC8555-based board.
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <AANLkTinQkpBTtmVZYGM71wzREHGDzG6R3k7LbR66yX5c@mail.gmail.com>
Date: Wed, 21 Jul 2010 09:24:56 -0500
Message-Id: <7AD5FB58-D6EA-4AA6-870B-32E901F72589@kernel.crashing.org>
References: <AANLkTinQkpBTtmVZYGM71wzREHGDzG6R3k7LbR66yX5c@mail.gmail.com>
To: Bradley Hughes <bhughes@silicontkx.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> 
> +	soc8555@e0000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";
> +		compatible = "simple-bus";
> +		ranges = <0x0 0xe0000000 0x100000>;
> +		bus-frequency = <0>;
> +
> +		ecm-law@0 {
> +			compatible = "fsl,ecm-law";
> +			reg = <0x0 0x1000>;
> +			fsl,num-laws = <8>;
> +		};
> +
> +		ecm@1000 {
> +			compatible = "fsl,mpc8555-ecm", "fsl,ecm";
> +			reg = <0x1000 0x1000>;
> +			interrupts = <17 2>;
> +			interrupt-parent = <&mpic>;
> +		};
> +
> +		memory-controller@2000 {
> +			compatible = "fsl,8555-memory-controller";

fsl,mpc8555?

> +			reg = <0x2000 0x1000>;
> +			interrupt-parent = <&mpic>;
> +			interrupts = <18 2>;
> +		};
> +
> +		L2: l2-cache-controller@20000 {

fsl,mpc8555?

> +			compatible = "fsl,8555-l2-cache-controller";
> +			reg = <0x20000 0x1000>;
> +			cache-line-size = <32>;	// 32 bytes
> +			cache-size = <0x40000>;	// L2, 256K
> +			interrupt-parent = <&mpic>;
> +			interrupts = <16 2>;
> +		};
> +

- k
