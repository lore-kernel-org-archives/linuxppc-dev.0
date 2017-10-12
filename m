Return-Path: <minghuan.lian@nxp.com>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0050.outbound.protection.outlook.com [104.47.0.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCGBM1bRHzDr4T
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 14:12:56 +1100 (AEDT)
From: "M.h. Lian" <minghuan.lian@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "Z.q. Hou" <zhiqiang.hou@nxp.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "marc.zyngier@arm.com"
 <marc.zyngier@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "Mingkai
 Hu" <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, Thomas Gleixner
 <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>
Subject: RE: [PATCH 0/5] arm64: add ls1012a and ls1046a pcie support
Date: Thu, 12 Oct 2017 03:12:47 +0000
Message-ID: <VI1PR04MB16157ABDE174A8DD1567173CE84B0@VI1PR04MB1615.eurprd04.prod.outlook.com>
References: <20170919092658.22482-1-Zhiqiang.Hou@nxp.com>
 <20171011185719.GL25517@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171011185719.GL25517@bhelgaas-glaptop.roam.corp.google.com>
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

Hi Bjorn,

I greatly appreciate for your review and picking up them.

Acked-by: Minghuan Lian <minghuan.Lian@nxp.com>


> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Thursday, October 12, 2017 2:57 AM
> To: Z.q. Hou <zhiqiang.hou@nxp.com>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-
> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linuxppc-
> dev@lists.ozlabs.org; marc.zyngier@arm.com; robh+dt@kernel.org;
> mark.rutland@arm.com; bhelgaas@google.com; shawnguo@kernel.org;
> Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian <minghuan.lian@nxp.com>; Roy
> Zang <roy.zang@nxp.com>; Thomas Gleixner <tglx@linutronix.de>; Jason
> Cooper <jason@lakedaemon.net>
> Subject: Re: [PATCH 0/5] arm64: add ls1012a and ls1046a pcie support
>=20
> On Tue, Sep 19, 2017 at 05:26:53PM +0800, Zhiqiang Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > This patch set adds ls1012a MSI and PCIe support, including driver and
> > device tree nodes. The ls1046a's MSI support patch and PCIe driver
> > patch has been applied, so only adds the PCIe device tree nodes.
> >
> > Hou Zhiqiang (5):
> >   irqchip/ls-scfg-msi: add LS1012a MSI support
> >   arm64: dts: ls1012a: Add MSI controller DT node
> >   PCI: layerscape: Add support for ls1012a
> >   arm64: dts: ls1012a: Add PCIe controller DT node
> >   arm64: dts: ls1046a: add PCIe controller DT nodes
> >
> >  .../interrupt-controller/fsl,ls-scfg-msi.txt       |  1 +
> >  .../devicetree/bindings/pci/layerscape-pci.txt     |  1 +
> >  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     | 31 +++++++++
> >  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     | 75
> ++++++++++++++++++++++
> >  drivers/irqchip/irq-ls-scfg-msi.c                  |  1 +
> >  drivers/pci/dwc/pci-layerscape.c                   |  1 +
> >  6 files changed, 110 insertions(+)
>=20
> I'm not 100% sure who should take these.  They trivially touch PCI and I =
haven't
> seen anybody else respond, so I put them on pci/host-layerscape with Rob'=
s acks.
>=20
> If somebody else wants to take them, just let me know and I'll drop them.
>=20
> They really should be acked by Minghuan or Mingkai, who are listed as the
> maintainers of drivers/pci/dwc/pci-layerscape.c and are presumably respon=
sible
> for the related dtsi files, too.
>=20
> Thomas, Jason, and Marc are listed as maintainers of drivers/irqchip/irq-=
ls-scfg-
> msi.c.  It's a trivial change, but I added them to the cc list.
