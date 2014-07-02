Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0243.outbound.protection.outlook.com [207.46.163.243])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 917C01A0003
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jul 2014 08:40:08 +1000 (EST)
Message-ID: <1404340794.21434.67.camel@snotra.buserror.net>
Subject: Re: [1/3,v4] powerpc/fsl-booke: Add support for T2080/T2081 SoC
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Date: Wed, 2 Jul 2014 17:39:54 -0500
In-Reply-To: <20140702014324.GA21768@home.buserror.net>
References: <1402481406-10830-1-git-send-email-Shengzhou.Liu@freescale.com>
 <20140702014324.GA21768@home.buserror.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-07-01 at 20:43 -0500, Scott Wood wrote:
> On Wed, Jun 11, 2014 at 06:10:04PM +0800, Shengzhou Liu wrote:
> > +/* controller at 0x240000 */
> > +&pci0 {
> > +	compatible = "fsl,t2080-pcie", "fsl,qoriq-pcie";
> 
> None of your patches add "fsl,qoriq-pcie" to of_device_ids[] in
> corenet_generic.c, so PCIe will not get probed.
> 
> Worse, if I add that string, the kernel hangs trying to access a PCIe
> controller that is disabled by the RCW.  This is because U-Boot is
> expecting "fsl,qoriq-pcie-v3.0", and thus can't find the disabled node in
> order to delete it.
> 
> Did you test PCIe at all on these boards?
> 
> Did you test other peripherals?

I'll add fsl,qoriq-pcie-v3.0 when applying.  Could you reply to the
question on patch 3/3?

-Scott
