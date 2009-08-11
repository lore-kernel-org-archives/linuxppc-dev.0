Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9D9F1B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Aug 2009 23:43:34 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C60E8DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 23:43:33 +1000 (EST)
Message-Id: <BAFDE07A-DC01-46A5-A36E-7F8FB508CBFD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Poonam Aggrwal <poonam.aggrwal@freescale.com>
In-Reply-To: <1249659316-22927-1-git-send-email-poonam.aggrwal@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [v3][PATCH][powerpc/85xx] P2020RDB Platform Support Added
Date: Tue, 11 Aug 2009 08:41:21 -0500
References: <1249659316-22927-1-git-send-email-poonam.aggrwal@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 7, 2009, at 10:35 AM, Poonam Aggrwal wrote:

>
> +		enet2: ethernet@26000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			cell-index = <2>;
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <0x26000 0x1000>;
> +			ranges = <0x0 0x26000 0x1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <31 2 32 2 33 2>;
> +			interrupt-parent = <&mpic>;
> +			phy-handle = <&phy1>;
> +			phy-connection-type = "rgmii-id";
> +		};

was there an answer to why we don't have an mdio node for enet2?

- k
