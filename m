Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 0F1F7DE1A0
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 13:19:59 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1M6cLS-0007MT-6R
	for linuxppc-dev@ozlabs.org; Tue, 19 May 2009 20:19:54 -0700
Message-ID: <23628338.post@talk.nabble.com>
Date: Tue, 19 May 2009 20:19:54 -0700 (PDT)
From: "Sauce.Cheng" <chmhou@sina.com>
To: linuxppc-dev@ozlabs.org
Subject: question : DMA of PCI bridge
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


excuse me
I hate to bother everyone but I have a question about DMA of PCI bridge

Now I attempt to fetch data from peripheral device to SDRAM, and it has been
successed

but how the DMA controller know the data bandwidth of src and dest.

for example, if i get a 16bits data with a 32bits bus, and other 16bits will
be set high
and data will fetched into cache line of dma, then it will be wrote to
32bits SDRAM.

i guess the data will be wrong, isn't ?

please give me some advices. thank you

-- 
View this message in context: http://www.nabble.com/question-%3A-DMA-of-PCI-bridge-tp23628338p23628338.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
