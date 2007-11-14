Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 65668DDE00
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 01:32:51 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IsJIO-0007MM-Cs
	for linuxppc-dev@ozlabs.org; Wed, 14 Nov 2007 06:32:48 -0800
Message-ID: <13747460.post@talk.nabble.com>
Date: Wed, 14 Nov 2007 06:32:48 -0800 (PST)
From: sivaji <rameshmrm@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: DMA interrupt is not generating in MPC8641D
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hai,

We have designed a MPC8641D based AMC card. As part of our customer
requirement for a PCIe messaging driver for communicating between the
MPC8641D AMC card as the PCIe target and the MPC8548E AMC card as the Host.

We are using the DMA for transferring data between the boards thru' PCIe.
The DMA Interrupt on the target end is not getting registered and hence we
face the issue (ie) No interrupt is generated after DMA transfer completion.

As per datasheet(Rev. 1, 05/2007) page no:445 interrupt number for
DMAchannel 1 is 4. We are using linux kernel version :2.6.23-rc3. According
to file (include/asm-powerpc/irq.h) line no:636 the interrupt number for DMA
in linux is 20(decimal). When using this interrupt number 20 we are not able
to registerd the DMA interrupts.

Note:
1. Linux is configured in SMP mode.
2. Value of Device status register(0xf80E000C)  : 0x0aa28747 


Thanks and Regards
Sivaji

-- 
View this message in context: http://www.nabble.com/DMA-interrupt-is-not-generating-in-MPC8641D-tf4805310.html#a13747460
Sent from the linuxppc-dev mailing list archive at Nabble.com.
