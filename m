Return-Path: <vabhav.sharma@nxp.com>
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60073.outbound.protection.outlook.com [40.107.6.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41x6z45qg6zF2Py
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 01:00:14 +1000 (AEST)
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "mturquette@baylibre.com"
 <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org"
 <viresh.kumar@linaro.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "linux-kernel-owner@vger.kernel.org"
 <linux-kernel-owner@vger.kernel.org>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de"
 <arnd@arndb.de>, "kstewart@linuxfoundation.org"
 <kstewart@linuxfoundation.org>, "yamada.masahiro@socionext.com"
 <yamada.masahiro@socionext.com>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, Varun Sethi <V.Sethi@nxp.com>, Udit Kumar
 <udit.kumar@nxp.com>, Ramneek Mehresh <ramneek.mehresh@nxp.com>, Ying Zhang
 <ying.zhang22455@nxp.com>, Nipun Gupta <nipun.gupta@nxp.com>, Priyanka Jain
 <priyanka.jain@nxp.com>, Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 Sriram Dash <sriram.dash@nxp.com>
Subject: RE: [PATCH 4/5] arm64: dts: add QorIQ LX2160A SoC support
Date: Thu, 23 Aug 2018 15:00:03 +0000
Message-ID: <AM6PR04MB47899CE5F871731749E59636F3370@AM6PR04MB4789.eurprd04.prod.outlook.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-5-git-send-email-vabhav.sharma@nxp.com>
 <20180821101652.GA18139@e107155-lin>
In-Reply-To: <20180821101652.GA18139@e107155-lin>
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
> From: Sudeep Holla <sudeep.holla@arm.com>
> Sent: Tuesday, August 21, 2018 3:47 PM
> To: Vabhav Sharma <vabhav.sharma@nxp.com>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> robh+dt@kernel.org; mark.rutland@arm.com; linuxppc-dev@lists.ozlabs.org;
> linux-arm-kernel@lists.infradead.org; mturquette@baylibre.com;
> sboyd@kernel.org; rjw@rjwysocki.net; viresh.kumar@linaro.org; linux-
> clk@vger.kernel.org; linux-pm@vger.kernel.org; linux-kernel-
> owner@vger.kernel.org; catalin.marinas@arm.com; will.deacon@arm.com;
> gregkh@linuxfoundation.org; arnd@arndb.de;
> kstewart@linuxfoundation.org; yamada.masahiro@socionext.com;
> linux@armlinux.org.uk; Varun Sethi <V.Sethi@nxp.com>; Udit Kumar
> <udit.kumar@nxp.com>; Ramneek Mehresh <ramneek.mehresh@nxp.com>;
> Ying Zhang <ying.zhang22455@nxp.com>; Nipun Gupta
> <nipun.gupta@nxp.com>; Priyanka Jain <priyanka.jain@nxp.com>; Yogesh
> Narayan Gaur <yogeshnarayan.gaur@nxp.com>; Sriram Dash
> <sriram.dash@nxp.com>; Sudeep Holla <sudeep.holla@arm.com>
> Subject: Re: [PATCH 4/5] arm64: dts: add QorIQ LX2160A SoC support
>=20
> On Mon, Aug 20, 2018 at 12:17:15PM +0530, Vabhav Sharma wrote:
> > LX2160A SoC is based on Layerscape Chassis Generation 3.2 Architecture.
> >
> > LX2160A features an advanced 16 64-bit ARM v8 CortexA72 processor
> > cores in 8 cluster, CCN508, GICv3,two 64-bit DDR4 memory controller, 8
> > I2C controllers, 3 dspi, 2 esdhc,2 USB 3.0, mmu 500, 3 SATA, 4 PL011
> > SBSA UARTs etc.
> >
> > Signed-off-by: Ramneek Mehresh <ramneek.mehresh@nxp.com>
> > Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
> > Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> > Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
> > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> > Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 572
> > +++++++++++++++++++++++++
> >  1 file changed, 572 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > new file mode 100644
> > index 0000000..e35e494
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > @@ -0,0 +1,572 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT) // // Device Tree
> > +Include file for Layerscape-LX2160A family SoC.
> > +//
> > +// Copyright 2018 NXP
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +/memreserve/ 0x80000000 0x00010000;
> > +
> > +/ {
> > +	compatible =3D "fsl,lx2160a";
> > +	interrupt-parent =3D <&gic>;
> > +	#address-cells =3D <2>;
> > +	#size-cells =3D <2>;
> > +
> > +	cpus {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +
> > +		// 8 clusters having 2 Cortex-A72 cores each
> > +		cpu@0 {
> > +			device_type =3D "cpu";
> > +			compatible =3D "arm,cortex-a72";
> > +			reg =3D <0x0>;
> > +			clocks =3D <&clockgen 1 0>;
> > +			next-level-cache =3D <&cluster0_l2>;
>=20
> If you expect to get cache properties in sysfs entries, you need to popul=
ate
> them here and for each L2 cache.
Rather sysfs, If Entry is not present then print  "cacheinfo: Unable to det=
ect cache hierarchy for CPU 0" appears in boot log which is bad saying some=
thing is not present.
Either this print is require change to debug instead of warning.
>=20
> [...]
>=20
> > +
> > +	rstcr: syscon@1e60000 {
> > +		compatible =3D "syscon";
> > +		reg =3D <0x0 0x1e60000 0x0 0x4>;
> > +	};
> > +
> > +	reboot {
> > +		compatible =3D"syscon-reboot";
> > +		regmap =3D <&rstcr>;
> > +		offset =3D <0x0>;
> > +		mask =3D <0x2>;
>=20
> Is this disabled in bootloader ? With PSCI, it's preferred to use
> SYSTEM_RESET/OFF. EL3 f/w may need to do some housekeeping on
> poweroff.
No, PSCIv0.2 is used and control passes to EL3 fw via smc call, psci node i=
s present in the file.
This node is not required and keeping it in case PSCI is not used.
>=20
> > +	};
> > +
> > +	timer {
> > +		compatible =3D "arm,armv8-timer";
> > +		interrupts =3D <1 13 4>, // Physical Secure PPI, active-low
>=20
> The comment says active low but the value 4 indicates it's HIGH from
> "include/dt-bindings/interrupt-controller/irq.h"
Thanks, I will change the entries to existing definition IRQ_TYPE_LEVEL_LOW=
,GIC_PPI which is self-explanatory and not require comments
>=20
> > +			     <1 14 4>, // Physical Non-Secure PPI, active-low
> > +			     <1 11 4>, // Virtual PPI, active-low
> > +			     <1 10 4>; // Hypervisor PPI, active-low
> > +	};
> > +
> > +	pmu {
> > +		compatible =3D "arm,armv8-pmuv3";
>=20
> More specific compatible preferably "arm,cortex-a72-pmu" ?
Sure.
>=20
> --
> Regards,
> Sudeep
