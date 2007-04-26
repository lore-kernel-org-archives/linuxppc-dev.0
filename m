Return-Path: <mls.JOFT@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 4D6A7DDF35
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 02:06:29 +1000 (EST)
Subject: ML403 and PPC4xx_DMA ?
From: Joachim =?ISO-8859-1?Q?F=F6rster?= <mls.JOFT@gmx.de>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Thu, 26 Apr 2007 18:06:26 +0200
Message-Id: <1177603586.5532.20.camel@localhost>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

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
