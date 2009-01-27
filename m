Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 12F89DE0FE
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 23:02:03 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LRmdg-0007vS-TW
	for linuxppc-dev@ozlabs.org; Tue, 27 Jan 2009 04:01:56 -0800
Message-ID: <21683674.post@talk.nabble.com>
Date: Tue, 27 Jan 2009 04:01:56 -0800 (PST)
From: wael showair <showair2003@yahoo.com>
To: linuxppc-dev@ozlabs.org
Subject: using dma engine on MPC8555 processor
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi All,
i have an evaluation board with MPC8555 processor.
linux kernel 2.6.27
i have read the Documentation of my board, i found that it contains DMA
engine.
i know that there fsldma.c & fsldma.h
all my target is that i want to test the DMA on my board.
i want to transfer data from source to destination & i imagine that the DMA
will raise an interrupt after it finishes the transfer.

so i believe there must be some APIs related to the DMA engine which do the
following:
1. initialize the DMA by determining the src & dest addresses. Also
determines which channel to use.
2. register an interrupt handler for the DMA interrupt line.
3. fire the DMA.

where can i find these APIs, or i m missing something?
thanks in advance for ur help
-- 
View this message in context: http://www.nabble.com/using-dma-engine-on-MPC8555-processor-tp21683674p21683674.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
