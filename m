Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 5053ADDE07
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 11:59:05 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1M3hGm-0005Kz-AH
	for linuxppc-dev@ozlabs.org; Mon, 11 May 2009 18:59:00 -0700
Message-ID: <23494879.post@talk.nabble.com>
Date: Mon, 11 May 2009 18:59:00 -0700 (PDT)
From: "Sauce.Cheng" <chmhou@sina.com>
To: linuxppc-dev@ozlabs.org
Subject: get data failed with DMA
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


i tried to fetch data from periphial memories with DMA

the flow as following

flags = claim_dma_lock();
disable_dma(DMA_CH);
clear_dma_ff();
set_dma_count(DMA_CH, 4);
set_dma_addr(DMA_CH, virt_to_bus(kv_buf));
release_dma_lock(flags);
enable_dma(DMA_CH);

the code hault at disable_dma(DMA_CH)

in addition, i defined DMA_CH as 0 for channel 0
'kv_buf' is an kernel space virtual address. i can red the correct value of
periphal from this address
i supposed the fault along with the configured of registers about DMA in
processer. but i am not sure.
give some suggestion about this, thanks!

-- 
View this message in context: http://www.nabble.com/get-data-failed-with-DMA-tp23494879p23494879.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
