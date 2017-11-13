Return-Path: <minghuan.lian@nxp.com>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30056.outbound.protection.outlook.com [40.107.3.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yZvrt6LGmzDqG6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 13:35:56 +1100 (AEDT)
From: "M.h. Lian" <minghuan.lian@nxp.com>
To: Leo Li <leoyang.li@nxp.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 Xiaowei Bao <xiaowei.bao@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org"
 <shawnguo@kernel.org>, Madalin-cristian Bucur <madalin.bucur@nxp.com>, "Sumit
 Garg" <sumit.garg@nxp.com>, "Y.b. Lu" <yangbo.lu@nxp.com>, Andy Tang
 <andy.tang@nxp.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 "pbrobinson@gmail.com" <pbrobinson@gmail.com>, "songxiaowei@hisilicon.com"
 <songxiaowei@hisilicon.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "Z.q. Hou" <zhiqiang.hou@nxp.com>, "Mingkai
 Hu" <mingkai.hu@nxp.com>
Subject: RE: [PATCHv4 1/3] ARMv8: dts: ls1046a: add the property of IB and OB
Date: Mon, 13 Nov 2017 02:35:48 +0000
Message-ID: <VI1PR04MB161516288A0FF2F507DAA9BEE82B0@VI1PR04MB1615.eurprd04.prod.outlook.com>
References: <20171110034847.17891-1-xiaowei.bao@nxp.com>
 <20171110034847.17891-2-xiaowei.bao@nxp.com>
 <20b8f1d2-f817-469f-afbf-66f25d6f8c46@ti.com>
 <AM4PR0401MB16999BD34AFBB1362BD32EBD8F540@AM4PR0401MB1699.eurprd04.prod.outlook.com>
In-Reply-To: <AM4PR0401MB16999BD34AFBB1362BD32EBD8F540@AM4PR0401MB1699.eurprd04.prod.outlook.com>
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
> From: Leo Li
> Sent: Saturday, November 11, 2017 5:21 AM
> To: Kishon Vijay Abraham I <kishon@ti.com>; Xiaowei Bao
> <xiaowei.bao@nxp.com>; robh+dt@kernel.org; mark.rutland@arm.com;
> catalin.marinas@arm.com; will.deacon@arm.com; bhelgaas@google.com;
> shawnguo@kernel.org; Madalin-cristian Bucur <madalin.bucur@nxp.com>;
> Sumit Garg <sumit.garg@nxp.com>; Y.b. Lu <yangbo.lu@nxp.com>; Andy Tang
> <andy.tang@nxp.com>; jingoohan1@gmail.com; pbrobinson@gmail.com;
> songxiaowei@hisilicon.com; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> pci@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Z.q. Hou
> <zhiqiang.hou@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>
> Subject: RE: [PATCHv4 1/3] ARMv8: dts: ls1046a: add the property of IB an=
d OB
>=20
>=20
>=20
> > -----Original Message-----
> > From: Kishon Vijay Abraham I [mailto:kishon@ti.com]
> > Sent: Friday, November 10, 2017 12:22 AM
> > To: Xiaowei Bao <xiaowei.bao@nxp.com>; robh+dt@kernel.org;
> > mark.rutland@arm.com; catalin.marinas@arm.com; will.deacon@arm.com;
> > bhelgaas@google.com; shawnguo@kernel.org; Madalin-cristian Bucur
> > <madalin.bucur@nxp.com>; Sumit Garg <sumit.garg@nxp.com>; Y.b. Lu
> > <yangbo.lu@nxp.com>; hongtao.jia@nxp.com; Andy Tang
> > <andy.tang@nxp.com>; Leo Li <leoyang.li@nxp.com>;
> > jingoohan1@gmail.com; pbrobinson@gmail.com; songxiaowei@hisilicon.com;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux- kernel@vger.kernel.org; linux-pci@vger.kernel.org; linuxppc-
> > dev@lists.ozlabs.org; Z.q. Hou <zhiqiang.hou@nxp.com>; Mingkai Hu
> > <mingkai.hu@nxp.com>; M.h. Lian <minghuan.lian@nxp.com>
> > Subject: Re: [PATCHv4 1/3] ARMv8: dts: ls1046a: add the property of IB
> > and OB
> >
> > Hi Bao,
> >
> > On Friday 10 November 2017 09:18 AM, Bao Xiaowei wrote:
> > > Add the property of inbound and outbound windows number for ep driver=
.
> > >
> > > Signed-off-by: Bao Xiaowei <xiaowei.bao@nxp.com>
> > > Acked-by: Minghuan Lian <minghuan.Lian@nxp.com>
> > > ---
> > >  v2:
> > >  - no change
> > >  v3:
> > >  - modify the commit message
> > >  v4:
> > >  - no change
> > >
> > >  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> >
> > $subject should start with something like
> > arm64: dts: ls1046a: **
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > > b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > > index 06b5e12d04d8..f8332669663c 100644
> > > --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > > @@ -674,6 +674,8 @@
> > >  			device_type =3D "pci";
> > >  			dma-coherent;
> > >  			num-lanes =3D <4>;
> > > +			num-ib-windows =3D <6>;
> > > +			num-ob-windows =3D <6>;
> >
> > EP specific properties shouldn't be added in RC dt node. Ideally you
> > should have a separate dt node for RC and EP.
>=20
> It is a single PCIe controller which can be configured to either RC mode =
or EP
> mode.  Wouldn't it conflict with the device tree principles to have two d=
evice
> tree nodes for the same PCIe controller?  And obviously the two modes can=
not
> be used at the same time so we cannot have two drivers both probe on the
> same hardware.
>=20
[Minghuan Lian]  There is only one PCIe dts node in the dts file. PCIe dts =
node describes the PCIe controller's hardware properties and does not have =
work mode.  The new properties  "num-ib-windows " and "num-ob-windows" are =
used to describe the inbound/outbound window number included in the PCIe ha=
rdware. These windows are used in both RC and EP mode.  We can change work =
mode when resetting via RCW(reset configuration word).


> Regards,
> Leo
