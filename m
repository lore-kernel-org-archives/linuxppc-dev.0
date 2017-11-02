Return-Path: <minghuan.lian@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0057.outbound.protection.outlook.com [104.47.2.57])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySJmw2ttpzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 19:54:37 +1100 (AEDT)
From: "M.h. Lian" <minghuan.lian@nxp.com>
To: Xiaowei Bao <xiaowei.bao@nxp.com>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, Madalin-cristian Bucur
 <madalin.bucur@nxp.com>, Sumit Garg <sumit.garg@nxp.com>, "Y.b. Lu"
 <yangbo.lu@nxp.com>, "hongtao.jia@nxp.com" <hongtao.jia@nxp.com>, Andy Tang
 <andy.tang@nxp.com>, Leo Li <leoyang.li@nxp.com>, "kishon@ti.com"
 <kishon@ti.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 "pbrobinson@gmail.com" <pbrobinson@gmail.com>, "songxiaowei@hisilicon.com"
 <songxiaowei@hisilicon.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "Z.q. Hou" <zhiqiang.hou@nxp.com>, "Mingkai
 Hu" <mingkai.hu@nxp.com>
CC: Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCH 1/3] ARMv8: dts: ls1046a: add the property of IB and OB
Date: Thu, 2 Nov 2017 08:54:29 +0000
Message-ID: <VI1PR04MB16150087206A5385F52D163CE85C0@VI1PR04MB1615.eurprd04.prod.outlook.com>
References: <20171024083045.31135-1-xiaowei.bao@nxp.com>
 <20171024083045.31135-2-xiaowei.bao@nxp.com>
In-Reply-To: <20171024083045.31135-2-xiaowei.bao@nxp.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Minghuan Lian <minghuan.Lian@nxp.com>

> -----Original Message-----
> From: Bao Xiaowei [mailto:xiaowei.bao@nxp.com]
> Sent: Tuesday, October 24, 2017 4:31 PM
> To: robh+dt@kernel.org; mark.rutland@arm.com; catalin.marinas@arm.com;
> will.deacon@arm.com; bhelgaas@google.com; shawnguo@kernel.org;
> Madalin-cristian Bucur <madalin.bucur@nxp.com>; Sumit Garg
> <sumit.garg@nxp.com>; Y.b. Lu <yangbo.lu@nxp.com>; hongtao.jia@nxp.com;
> Andy Tang <andy.tang@nxp.com>; Leo Li <leoyang.li@nxp.com>;
> kishon@ti.com; jingoohan1@gmail.com; pbrobinson@gmail.com;
> songxiaowei@hisilicon.com; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> pci@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Z.q. Hou
> <zhiqiang.hou@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>
> Cc: Xiaowei Bao <xiaowei.bao@nxp.com>
> Subject: [PATCH 1/3] ARMv8: dts: ls1046a: add the property of IB and OB
>=20
> Add the property of inbind and outbind windows number for ep driver.
>=20
> add the inband or outband window entry for pcie controller ep driver used=
 in dts.
>=20
> Signed-off-by: Bao Xiaowei <xiaowei.bao@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index 06b5e12d04d8..f8332669663c 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -674,6 +674,8 @@
>  			device_type =3D "pci";
>  			dma-coherent;
>  			num-lanes =3D <4>;
> +			num-ib-windows =3D <6>;
> +			num-ob-windows =3D <6>;
>  			bus-range =3D <0x0 0xff>;
>  			ranges =3D <0x81000000 0x0 0x00000000 0x40
> 0x00010000 0x0 0x00010000   /* downstream I/O */
>  				  0x82000000 0x0 0x40000000 0x40
> 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */ @@ -699,6
> +701,8 @@
>  			device_type =3D "pci";
>  			dma-coherent;
>  			num-lanes =3D <2>;
> +			num-ib-windows =3D <6>;
> +			num-ob-windows =3D <6>;
>  			bus-range =3D <0x0 0xff>;
>  			ranges =3D <0x81000000 0x0 0x00000000 0x48
> 0x00010000 0x0 0x00010000   /* downstream I/O */
>  				  0x82000000 0x0 0x40000000 0x48
> 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */ @@ -724,6
> +728,8 @@
>  			device_type =3D "pci";
>  			dma-coherent;
>  			num-lanes =3D <2>;
> +			num-ib-windows =3D <6>;
> +			num-ob-windows =3D <6>;
>  			bus-range =3D <0x0 0xff>;
>  			ranges =3D <0x81000000 0x0 0x00000000 0x50
> 0x00010000 0x0 0x00010000   /* downstream I/O */
>  				  0x82000000 0x0 0x40000000 0x50
> 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> --
> 2.14.1
