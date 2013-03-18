Return-Path: <B20052@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 40FBE2C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 17:59:48 +1100 (EST)
From: Leekha Shaveta-B20052 <B20052@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 1/6] powerpc/fsl-booke: Add initial silicon device tree
 files for B4860QDS
Date: Mon, 18 Mar 2013 06:59:40 +0000
Message-ID: <E12D2F89F87F4A49B0320A4C2DE7E749144AC1@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1363334109-21922-1-git-send-email-shaveta@freescale.com>
 <112ADD30-18A2-4147-B185-46841D0119BD@kernel.crashing.org>
In-Reply-To: <112ADD30-18A2-4147-B185-46841D0119BD@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Li Yang-R58472 <r58472@freescale.com>,
 Zhao Chenhui-B35336 <B35336@freescale.com>,
 Mehresh Ramneek-B31383 <B31383@freescale.com>,
 Lian Minghuan-B31939 <B31939@freescale.com>,
 Tang Yuantian-B29983 <B29983@freescale.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 Sethi Varun-B16395 <B16395@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
Sent: Saturday, March 16, 2013 2:00 AM
To: Leekha Shaveta-B20052
Cc: linuxppc-dev@lists.ozlabs.org; Zhao Chenhui-B35336; Li Yang-R58472; Tan=
g Yuantian-B29983; Sethi Varun-B16395; Lian Minghuan-B31939; Mehresh Ramnee=
k-B31383; Fleming Andy-AFLEMING
Subject: Re: [PATCH 1/6] powerpc/fsl-booke: Add initial silicon device tree=
 files for B4860QDS


On Mar 15, 2013, at 2:55 AM, Shaveta Leekha wrote:

> Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> ---
> arch/powerpc/boot/dts/fsl/b4860si-post.dtsi |  184 ++++++++++++++++++++++=
+++++
> arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi  |   80 ++++++++++++
> 2 files changed, 264 insertions(+), 0 deletions(-) create mode 100644=20
> arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
> create mode 100644 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi

* SEC node is missing
* DCSR nodes are missing.

- k

[SL] will add sec node, same reply for dcsr.


>=20
> diff --git a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi=20
> b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
> new file mode 100644
> index 0000000..2db68b2
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
> @@ -0,0 +1,184 @@
> +/*
> + * B4860 Silicon/SoC Device Tree Source (post include)
> + *
> + * Copyright 2012 Freescale Semiconductor Inc.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions ar=
e met:
> + *     * Redistributions of source code must retain the above copyright
> + *       notice, this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above copyrig=
ht
> + *       notice, this list of conditions and the following disclaimer in=
 the
> + *       documentation and/or other materials provided with the distribu=
tion.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *       names of its contributors may be used to endorse or promote pro=
ducts
> + *       derived from this software without specific prior written permi=
ssion.
> + *
> + *
> + * ALTERNATIVELY, this software may be distributed under the terms of=20
> +the
> + * GNU General Public License ("GPL") as published by the Free=20
> +Software
> + * Foundation, either version 2 of that License or (at your option)=20
> +any
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND=20
> +ANY
> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE=20
> +IMPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE=20
> +ARE
> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE=20
> +FOR ANY
> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL=20
> +DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR=20
> +SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER=20
> +CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,=20
> +OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE=20
> +USE OF THIS
> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +&ifc {
> +	#address-cells =3D <2>;
> +	#size-cells =3D <1>;
> +	compatible =3D "fsl,ifc", "simple-bus";
> +	interrupts =3D <25 2 0 0>;
> +};
> +
> +/* controller at 0x200000 */
> +&pci0 {
> +	compatible =3D "fsl,b4860-pcie", "fsl,qoriq-pcie-v2.4";
> +	device_type =3D "pci";
> +	#size-cells =3D <2>;
> +	#address-cells =3D <3>;
> +	bus-range =3D <0x0 0xff>;
> +	interrupts =3D <20 2 0 0>;
> +	pcie@0 {
> +		#interrupt-cells =3D <1>;
> +		#size-cells =3D <2>;
> +		#address-cells =3D <3>;
> +		device_type =3D "pci";
> +		interrupts =3D <20 2 0 0>;
> +		interrupt-map-mask =3D <0xf800 0 0 7>;
> +		interrupt-map =3D <
> +			/* IDSEL 0x0 */
> +			0000 0 0 1 &mpic 40 1 0 0
> +			0000 0 0 2 &mpic 1 1 0 0
> +			0000 0 0 3 &mpic 2 1 0 0
> +			0000 0 0 4 &mpic 3 1 0 0
> +			>;
> +	};
> +};
> +
> +&rio {
> +	compatible =3D "fsl,srio";
> +	interrupts =3D <16 2 1 11>;
> +	#address-cells =3D <2>;
> +	#size-cells =3D <2>;
> +	ranges;
> +
> +	port1 {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		cell-index =3D <1>;
> +	};
> +
> +	port2 {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		cell-index =3D <2>;
> +	};
> +};
> +
> +&soc {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +	device_type =3D "soc";
> +	compatible =3D "simple-bus";
> +
> +	soc-sram-error {
> +		compatible =3D "fsl,soc-sram-error";
> +		interrupts =3D <16 2 1 2>;
> +	};
> +
> +	corenet-law@0 {
> +		compatible =3D "fsl,corenet-law";
> +		reg =3D <0x0 0x1000>;
> +		fsl,num-laws =3D <32>;
> +	};
> +
> +	ddr1: memory-controller@8000 {
> +		compatible =3D "fsl,qoriq-memory-controller-v4.5", "fsl,qoriq-memory-c=
ontroller";
> +		reg =3D <0x8000 0x1000>;
> +		interrupts =3D <16 2 1 8>;
> +	};
> +
> +	ddr2: memory-controller@9000 {
> +		compatible =3D "fsl,qoriq-memory-controller-v4.5","fsl,qoriq-memory-co=
ntroller";
> +		reg =3D <0x9000 0x1000>;
> +		interrupts =3D <16 2 1 9>;
> +	};
> +
> +	cpc: l3-cache-controller@10000 {
> +		compatible =3D "fsl,p5020-l3-cache-controller", "fsl,p4080-l3-cache-co=
ntroller", "cache";
> +		reg =3D <0x10000 0x1000
> +		       0x11000 0x1000>;
> +		interrupts =3D <16 2 1 4
> +			      16 2 1 5>;
> +	};
> +
> +	corenet-cf@18000 {
> +		compatible =3D "fsl,corenet-cf";
> +		reg =3D <0x18000 0x1000>;
> +		interrupts =3D <16 2 1 0>;
> +		fsl,ccf-num-csdids =3D <32>;
> +		fsl,ccf-num-snoopids =3D <32>;
> +	};
> +
> +	iommu@20000 {
> +		compatible =3D "fsl,pamu-v1.0", "fsl,pamu";
> +		reg =3D <0x20000 0x4000>;
> +		interrupts =3D <
> +			24 2 0 0
> +			16 2 1 1>;
> +	};
> +
> +/include/ "qoriq-mpic.dtsi"
> +
> +	guts: global-utilities@e0000 {
> +		compatible =3D "fsl,b4860-device-config";
> +		reg =3D <0xe0000 0xe00>;
> +		fsl,has-rstcr;
> +		fsl,liodn-bits =3D <12>;
> +	};
> +
> +	clockgen: global-utilities@e1000 {
> +		compatible =3D "fsl,b4860-clockgen", "fsl,qoriq-clockgen-2";
> +		reg =3D <0xe1000 0x1000>;
> +	};
> +
> +	rcpm: global-utilities@e2000 {
> +		compatible =3D "fsl,b4860-rcpm", "fsl,qoriq-rcpm-2";
> +		reg =3D <0xe2000 0x1000>;
> +	};
> +
> +/include/ "qoriq-dma-0.dtsi"
> +/include/ "qoriq-dma-1.dtsi"
> +
> +/include/ "qonverge-usb2-dr-0.dtsi"
> +	usb0: usb@210000 {
> +		compatible =3D "fsl-usb2-dr-v2.4", "fsl-usb2-dr";
> +	};
> +
> +/include/ "qoriq-espi-0.dtsi"
> +	spi@110000 {
> +		fsl,espi-num-chipselects =3D <4>;
> +	};
> +
> +/include/ "qoriq-esdhc-0.dtsi"
> +	sdhc@114000 {
> +		sdhci,auto-cmd12;
> +	};
> +/include/ "qoriq-i2c-0.dtsi"
> +/include/ "qoriq-i2c-1.dtsi"
> +/include/ "qoriq-duart-0.dtsi"
> +/include/ "qoriq-duart-1.dtsi"
> +
> +	L2: l2-cache-controller@c20000 {
> +		next-level-cache =3D <&cpc>;

should have compatible & reg nodes
[SL] agree. Will add=20

> +	};
> +};

[ snip ]

- k

Regards,
Shaveta
