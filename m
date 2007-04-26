Return-Path: <Rick.Moleres@xilinx.com>
Received: from outbound1-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A8BCEDDE36
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 07:37:00 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: ML403 and PPC4xx_DMA ?
Date: Thu, 26 Apr 2007 15:36:56 -0600
In-Reply-To: <1177603586.5532.20.camel@localhost>
From: "Rick Moleres" <Rick.Moleres@xilinx.com>
To: =?iso-8859-1?Q?Joachim_F=F6rster?= <mls.JOFT@gmx.de>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20070426213657.CAFF7630046@mail101-cpk.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Joachim,

The Xilinx PPC405 core does not have an integrated DMA controller.

-----Original Message-----
From: linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org =
[mailto:linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org] On =
Behalf Of Joachim F=F6rster
Sent: Thursday, April 26, 2007 10:06 AM
To: linuxppc-embedded@ozlabs.org
Subject: ML403 and PPC4xx_DMA ?

Hi all,

I have a question regarding the PowerPC 405 Core on the Xilinx ML403
board and DMA . The Linux kernel has an option called CONFIG_PPC4xx_DMA.
Do all/some PowerPC 4xx Cores have an integrated DMA Controller? I tried
to find some documentation about this DMA Controller in several Xilinx
and IBM manuals which cover the PowerPC 405 Core - but I didn't find
anything.
So, my question is: Does the Virtex-4 FX12 PowerPC 405 Core on the ML403
have such DMA Controller? If yes, is it usable within Linux to transfer
data from RAM to a device's hardware buffers (typical task of a DMA
controller)?

Thanks,
 Joachim

PS: I tried to compile a kernel image with CONFIG_PPC4xx_DMA enabled,
but gcc complains about missing definitions in ppc4xx_dma.c ... e.g.
DCRN_DMASR (defined in ibm405.h). Well I guess I have to have
DCRN_MASR_BASE defined in xparameters_ml403.h .... but defined to what?


_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
