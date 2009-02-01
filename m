Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 5D8C9DDF22
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Feb 2009 03:05:28 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LTep1-0002QV-Ty
	for linuxppc-dev@ozlabs.org; Sun, 01 Feb 2009 08:05:23 -0800
Message-ID: <21776812.post@talk.nabble.com>
Date: Sun, 1 Feb 2009 08:05:23 -0800 (PST)
From: wael showair <showair2003@yahoo.com>
To: linuxppc-dev@ozlabs.org
Subject: Testing DMA on MPC8555 board
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
i have an evaluation board with MPC8555 processor with kernel 2.6.27
the board contains DMA engine.

I want to test the DMA on my board by transferring data from a source to
destination.

I dont know can i do this using the module of dmatest? i have inserted it
but i did not get any sign that it works correct or not, so i m convinced
that fsldma will achieve my aim.
the problem is that the function of 
fsl_dma_self_test   which is called in the function of 
of_fsl_dma_chan_probe.
& i dont know how to trigger the probe function to work?


-- 
View this message in context: http://www.nabble.com/Testing-DMA-on-MPC8555-board-tp21776812p21776812.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
