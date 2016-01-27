Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0B35B1A0174
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 01:23:49 +1100 (AEDT)
Message-ID: <1453904619.27129.41.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Zhiqiang Hou <zhiqiang.hou@nxp.com>, Zhiqiang Hou
 <Zhiqiang.Hou@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "galak@kernel.crashing.org"
 <galak@kernel.crashing.org>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>,  "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,  "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk"
 <ijc+devicetree@hellion.org.uk>, Harninder Rai
 <harninder.rai@freescale.com>,  "robh@kernel.org" <robh@kernel.org>
Cc: "Lian M.H." <Minghuan.Lian@freescale.com>, Hu Vincent
 <Mingkai.Hu@freescale.com>, Hou Zhiqiang <B48286@freescale.com>
Date: Wed, 27 Jan 2016 08:23:39 -0600
In-Reply-To: <HE1PR04MB09060D4FCE88CD7B3F1CBF9084D90@HE1PR04MB0906.eurprd04.prod.outlook.com>
References: <1446693360-1578-1-git-send-email-Zhiqiang.Hou@freescale.com>
 <HE1PR04MB0906A35F4F48C8DACF5CD16D84E50@HE1PR04MB0906.eurprd04.prod.outlook.com>
 <HE1PR04MB09060D4FCE88CD7B3F1CBF9084D90@HE1PR04MB0906.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH V4 1/2] powerpc/fsl: Add PCI node in device tree of
 bsc9132qds
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-01-27 at 06:47 +0000, Zhiqiang Hou wrote:
> Hi Herring and Kumar and Ian,
> 
> Can you help to apply this patch?
> 
> Thanks,
> Zhiqiang 

Can you check whether a patch has already been applied before pinging people
about it?

-Scott

> 
> > -----Original Message-----
> > From: Zhiqiang Hou [mailto:zhiqiang.hou@nxp.com]
> > Sent: 2015年12月22日 17:28
> > To: Zhiqiang Hou <Zhiqiang.Hou@freescale.com>; 
> > linuxppc-dev@lists.ozlabs.org;
> > Scott Wood <scottwood@freescale.com>; galak@kernel.crashing.org;
> > benh@kernel.crashing.org; paulus@samba.org; mpe@ellerman.id.au;
> > devicetree@vger.kernel.org; robh+dt@kernel.org; pawel.moll@arm.com;
> > mark.rutland@arm.com; ijc+devicetree@hellion.org.uk; Harninder Rai
> > <harninder.rai@freescale.com>
> > Cc: Lian M.H. <Minghuan.Lian@freescale.com>; Hu Vincent
> > <Mingkai.Hu@freescale.com>; Hou Zhiqiang <B48286@freescale.com>
> > Subject: RE: [PATCH V4 1/2] powerpc/fsl: Add PCI node in device tree of
> > bsc9132qds
> > 
> > Hi Rob,
> > 
> > Could you please take this patch into account?
> > 
> > Thanks,
> > Zhiqiang
> > 
> > > -----Original Message-----
> > > From: Zhiqiang Hou [mailto:Zhiqiang.Hou@freescale.com]
> > > Sent: 2015年11月5日 11:16
> > > To: linuxppc-dev@lists.ozlabs.org; Scott Wood;
> > > galak@kernel.crashing.org; benh@kernel.crashing.org; paulus@samba.org;
> > > mpe@ellerman.id.au; devicetree@vger.kernel.org; robh+dt@kernel.org;
> > > pawel.moll@arm.com; mark.rutland@arm.com;
> > > ijc+devicetree@hellion.org.uk; Harninder Rai
> > > Cc: Minghuan Lian; Mingkai Hu; Zhiqiang Hou
> > > Subject: [PATCH V4 1/2] powerpc/fsl: Add PCI node in device tree of
> > > bsc9132qds
> > > 
> > > From: Harninder Rai <harninder.rai@freescale.com>
> > > 
> > > Signed-off-by: Harninder Rai <harninder.rai@freescale.com>
> > > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> > > Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
> > > ---
> > > V4: V3:
> > >  - Remove gerrit stuff.
> > > V2:
> > >  - Remove property clock-frequency.
> > > 
> > >  arch/powerpc/boot/dts/bsc9132qds.dts          | 15 ++++++++++++++
> > >  arch/powerpc/boot/dts/fsl/bsc9132si-post.dtsi | 28
> > > +++++++++++++++++++++++++++
> > > +++++++++++++++++++++++++++ arch/powerpc/boot/dts/fsl/bsc9132si-pre.dt
> > > +++++++++++++++++++++++++++ si
> > > >  1 +
> > >  3 files changed, 44 insertions(+)
> > > 
> > > diff --git a/arch/powerpc/boot/dts/bsc9132qds.dts
> > > b/arch/powerpc/boot/dts/bsc9132qds.dts
> > > index 6cab106..940d719 100644
> > > --- a/arch/powerpc/boot/dts/bsc9132qds.dts
> > > +++ b/arch/powerpc/boot/dts/bsc9132qds.dts
> > > @@ -29,6 +29,21 @@
> > >  soc: soc@ff700000 {
> > >  ranges = <0x0 0x0 0xff700000 0x100000>;  };
> > > +
> > > +pci0: pcie@ff70a000 {
> > > +reg = <0 0xff70a000 0 0x1000>;
> > > +ranges = <0x2000000 0x0 0x90000000 0 0x90000000 0x0
> > > 0x20000000
> > > +  0x1000000 0x0 0x00000000 0 0xc0010000 0x0 0x10000>;
> > > +pcie@0 {
> > > +ranges = <0x2000000 0x0 0x90000000
> > > +  0x2000000 0x0 0x90000000
> > > +  0x0 0x20000000
> > > +
> > > +  0x1000000 0x0 0x0
> > > +  0x1000000 0x0 0x0
> > > +  0x0 0x100000>;
> > > +};
> > > +};
> > >  };
> > > 
> > >  /include/ "bsc9132qds.dtsi"
> > > diff --git a/arch/powerpc/boot/dts/fsl/bsc9132si-post.dtsi
> > > b/arch/powerpc/boot/dts/fsl/bsc9132si-post.dtsi
> > > index c723071..b5f0715 100644
> > > --- a/arch/powerpc/boot/dts/fsl/bsc9132si-post.dtsi
> > > +++ b/arch/powerpc/boot/dts/fsl/bsc9132si-post.dtsi
> > > @@ -40,6 +40,34 @@
> > >  interrupts = <16 2 0 0 20 2 0 0>;
> > >  };
> > > 
> > > +/* controller at 0xa000 */
> > > +&pci0 {
> > > +compatible = "fsl,bsc9132-pcie", "fsl,qoriq-pcie-v2.2"; device_type =
> > > +"pci"; #size-cells = <2>; #address-cells = <3>; bus-range = <0 255>;
> > > +interrupts = <16 2 0 0>;
> > > +
> > > +pcie@0 {
> > > +reg = <0 0 0 0 0>;
> > > +#interrupt-cells = <1>;
> > > +#size-cells = <2>;
> > > +#address-cells = <3>;
> > > +device_type = "pci";
> > > +interrupts = <16 2 0 0>;
> > > +interrupt-map-mask = <0xf800 0 0 7>;
> > > +
> > > +interrupt-map = <
> > > +/* IDSEL 0x0 */
> > > +0000 0x0 0x0 0x1 &mpic 0x0 0x2 0x0 0x0
> > > +0000 0x0 0x0 0x2 &mpic 0x1 0x2 0x0 0x0
> > > +0000 0x0 0x0 0x3 &mpic 0x2 0x2 0x0 0x0
> > > +0000 0x0 0x0 0x4 &mpic 0x3 0x2 0x0 0x0
> > > +>;
> > > +};
> > > +};
> > > +
> > >  &soc {
> > >  #address-cells = <1>;
> > >  #size-cells = <1>;
> > > diff --git a/arch/powerpc/boot/dts/fsl/bsc9132si-pre.dtsi
> > > b/arch/powerpc/boot/dts/fsl/bsc9132si-pre.dtsi
> > > index 301a9db..90f7949 100644
> > > --- a/arch/powerpc/boot/dts/fsl/bsc9132si-pre.dtsi
> > > +++ b/arch/powerpc/boot/dts/fsl/bsc9132si-pre.dtsi
> > > @@ -45,6 +45,7 @@
> > >  serial0 = &serial0;
> > >  ethernet0 = &enet0;
> > >  ethernet1 = &enet1;
> > > +pci0 = &pci0;
> > >  };
> > > 
> > >  cpus {
> > > --
> > > 2.1.0.27.g96db324
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
