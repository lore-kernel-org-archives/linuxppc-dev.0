Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0122.outbound.protection.outlook.com [65.55.169.122])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 891311A0935
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2015 01:10:24 +1100 (AEDT)
Message-ID: <1450793404.18314.90.camel@freescale.com>
Subject: Re: [PATCH] powerpc/mpc85xx: Add pcsphy nodes to FManV3 device tree
From: Scott Wood <scottwood@freescale.com>
To: Liberman Igal-B31950 <Igal.Liberman@freescale.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC: Bucur Madalin-Cristian-B32716 <madalin.bucur@freescale.com>, "Xie
 Shaohui-B21989" <Shaohui.Xie@freescale.com>
Date: Tue, 22 Dec 2015 08:10:04 -0600
In-Reply-To: <DM2PR03MB509CAE5558807F9E327DCBDE6E50@DM2PR03MB509.namprd03.prod.outlook.com>
References: <1450655851-6556-1-git-send-email-igal.liberman@freescale.com>
 <1450708833.18314.35.camel@freescale.com>
 <DM2PR03MB509CAE5558807F9E327DCBDE6E50@DM2PR03MB509.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-12-22 at 02:51 -0600, Liberman Igal-B31950 wrote:
> 
> Regards,
> Igal Liberman
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Monday, December 21, 2015 4:41 PM
> > To: Liberman Igal-B31950 <Igal.Liberman@freescale.com>;
> > devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> > Cc: Bucur Madalin-Cristian-B32716 <madalin.bucur@freescale.com>; Xie
> > Shaohui-B21989 <Shaohui.Xie@freescale.com>
> > Subject: Re: [PATCH] powerpc/mpc85xx: Add pcsphy nodes to FManV3
> > device tree
> > 
> > On Mon, 2015-12-21 at 01:57 +0200, igal.liberman@freescale.com wrote:
> > > From: Igal Liberman <igal.liberman@freescale.com>
> > > 
> > > Signed-off-by: Igal Liberman <igal.liberman@freescale.com>
> > > 
> > > This patch adds pcsphy node to FManV3 device tree.
> > > Based on: https://patchwork.ozlabs.org/patch/503921/
> > > ---
> > >  .../dts/fsl/qoriq-fman3-0-10g-0-best-effort.dtsi   |    5 +++++
> > >  arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0.dtsi |    5 +++++
> > >  .../dts/fsl/qoriq-fman3-0-10g-1-best-effort.dtsi   |    5 +++++
> > >  arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1.dtsi |    5 +++++
> > >  arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-0.dtsi  |    5 +++++
> > >  arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-1.dtsi  |    5 +++++
> > >  arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-2.dtsi  |    5 +++++
> > >  arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-3.dtsi  |    5 +++++
> > >  arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-4.dtsi  |    5 +++++
> > >  arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-5.dtsi  |    5 +++++
> > >  arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-0.dtsi |    5 +++++
> > >  arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-1.dtsi |    5 +++++
> > >  arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-0.dtsi  |    5 +++++
> > >  arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-1.dtsi  |    5 +++++
> > >  arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-2.dtsi  |    5 +++++
> > >  arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-3.dtsi  |    5 +++++
> > >  arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-4.dtsi  |    5 +++++
> > >  arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-5.dtsi  |    5 +++++
> > >  18 files changed, 90 insertions(+)
> > 
> > Binding?
> > 
> 
> Working on that, I'll submit ASAP. 
> 
> Igal

Always submit the binding before the dts patch.

-Scott
