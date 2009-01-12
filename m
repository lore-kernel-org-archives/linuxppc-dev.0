Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 9A388DE0B0
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 23:03:18 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LMLVj-0006Si-Q5
	for linuxppc-dev@ozlabs.org; Mon, 12 Jan 2009 04:03:15 -0800
Message-ID: <21413193.post@talk.nabble.com>
Date: Mon, 12 Jan 2009 04:03:15 -0800 (PST)
From: wael showair <showair2003@yahoo.com>
To: linuxppc-dev@ozlabs.org
Subject: When do i need to allocate DMA buffer
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
i have MPC8555 processor, also i have linux-kernel 2.6.19-rc5 on my board.i
want to use the DMA on my board, just a simple example is enough for me but
during my reading on how to use the DMA i have some questions:
1. The DMA buffer is always needed for all kind of buses or not? (I think
this is valid in the ISA bus but not in the PCI bus, plz correct me if i m
wrong?)
Note that my target is to transfer data from memory location to another
memory location & it will be an overhead if i copy the data from the src to
the DMA buffer then from the DMA buffer to the Destination.
isn't there any other way to avoid using that DMA buffer & to copy data from
src to dest directly?
i read the documentation of my board & it tells me that it contain DMA
engine which "is capable of transferring blocks of data from any legal
address range to any
other legal address range."

2. i have read DMA-API.txt in the linux Documentation folder but i m little
confused about the APIs that exist in this file. Actually, it is stated in
this file the following:
"This document describes the DMA API.This API is split into two pieces. 
Part I describes the API and the corresponding pci_ API".

so if the DMA controller is connected to the PCI bus, am i obligated to use
the pci_API & for any other case (like ISA bus or any other bus types) shall
i use this generic API?
also what r the benefits of these APIs over the normal kmalloc? specially
that i have read the following section in the DMA-mapping.txt:
"If you acquired your memory via the page allocator
(i.e. __get_free_page*()) or the generic memory allocators
(i.e. kmalloc() or kmem_cache_alloc()) then you may DMA to/from
that memory using the addresses returned from those routines."

thanks in advance for ur help
-- 
View this message in context: http://www.nabble.com/When-do-i-need-to-allocate-DMA-buffer-tp21413193p21413193.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
