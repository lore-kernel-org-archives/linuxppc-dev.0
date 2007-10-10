Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5036ADDF8D
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 17:32:01 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IfW2u-0006zF-Ld
	for linuxppc-dev@ozlabs.org; Wed, 10 Oct 2007 00:31:56 -0700
Message-ID: <13130850.post@talk.nabble.com>
Date: Wed, 10 Oct 2007 00:31:56 -0700 (PDT)
From: FabioJo <joel@fabiotec.com>
To: linuxppc-dev@ozlabs.org
Subject: MPC8548 PCI Burst issue
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


I have an issue with a 8548 while I memcpy a block from DDR over a Tundra-60X
bridge.
I have been told by FS that the best way in my case is to use the DMA for
DDR to PCI transfer.

I can't find any reference or API for this implementation. May someone
points me on the right documentation or API.
My board looks like a CDS.

Thanks for any info.
-- 
View this message in context: http://www.nabble.com/MPC8548-PCI-Burst-issue-tf4599073.html#a13130850
Sent from the linuxppc-dev mailing list archive at Nabble.com.
