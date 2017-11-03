Return-Path: <leoyang.li@nxp.com>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0067.outbound.protection.outlook.com [104.47.0.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yT7fh4P1CzDrD1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Nov 2017 04:07:07 +1100 (AEDT)
From: Leo Li <leoyang.li@nxp.com>
To: Xiaowei Bao <xiaowei.bao@nxp.com>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, Madalin-cristian Bucur
 <madalin.bucur@nxp.com>, Sumit Garg <sumit.garg@nxp.com>, "Y.b. Lu"
 <yangbo.lu@nxp.com>, "hongtao.jia@nxp.com" <hongtao.jia@nxp.com>, Andy Tang
 <andy.tang@nxp.com>, "kishon@ti.com" <kishon@ti.com>, "jingoohan1@gmail.com"
 <jingoohan1@gmail.com>, "pbrobinson@gmail.com" <pbrobinson@gmail.com>,
 "songxiaowei@hisilicon.com" <songxiaowei@hisilicon.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "Z.q. Hou" <zhiqiang.hou@nxp.com>, "Mingkai
 Hu" <mingkai.hu@nxp.com>, "M.h. Lian" <minghuan.lian@nxp.com>
CC: Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCH 0/3] dts: Add the property of IB and OB
Date: Fri, 3 Nov 2017 17:06:58 +0000
Message-ID: <AM4PR0401MB1699C33E678BB7DD027307568F5D0@AM4PR0401MB1699.eurprd04.prod.outlook.com>
References: <20171103093115.14915-1-xiaowei.bao@nxp.com>
In-Reply-To: <20171103093115.14915-1-xiaowei.bao@nxp.com>
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



> -----Original Message-----
> From: Bao Xiaowei [mailto:xiaowei.bao@nxp.com]
> Sent: Friday, November 03, 2017 4:31 AM
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
> Subject: [PATCH 0/3] dts: Add the property of IB and OB

When you send a v2 series, please include v2 in the title of all patches li=
ke "[PATCH v2 0/3]"...

Also the title of this summary email should really be the summary of all 3 =
patches like "Adding PCIe EP support to ls1046a".

-Leo


>=20
> Depend on
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fpatch=
w
> ork.ozlabs.org%2Fpatch%2F815382%2F&data=3D02%7C01%7Cleoyang.li%40nxp.c
> om%7C7db015020c8a414f57e708d522a03165%7C686ea1d3bc2b4c6fa92cd99c
> 5c301635%7C0%7C0%7C636452993777387982&sdata=3D19Fmzg%2FOJGl%2Bgizv
> xfY1yELlFgWKRuZ%2FVNbx49yz2Wk%3D&reserved=3D0
>=20
> Bao Xiaowei (3):
>   ARMv8: dts: ls1046a: add the property of IB and OB
>   ARMv8: layerscape: add the pcie ep function support
>   ARMv8: pcie: make the DWC EP driver support for layerscape
>=20
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   6 ++
>  drivers/pci/dwc/Kconfig                        |   1 +
>  drivers/pci/dwc/pci-layerscape.c               | 122 +++++++++++++++++++=
++++--
>  3 files changed, 123 insertions(+), 6 deletions(-)
>=20
> --
> 2.14.1
