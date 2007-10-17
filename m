Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 03A6DDDE9C
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 16:23:18 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id l9H6MdnO004117
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 16:22:39 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9H6P0ug175252
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 16:25:01 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9H6LAR0000378
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 16:21:10 +1000
Message-ID: <4715A9C1.9090106@linux.vnet.ibm.com>
Date: Wed, 17 Oct 2007 11:50:49 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Andy Whitcroft <apw@shadowen.org>
Subject: 2.6.23-git-10 Build Failure on powerpc - asm-powerpc/dma_mapping.h
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Build fails on the powerpc fails with 2.6.23-git10

  CC      init/main.o
In file included from include/linux/dma-mapping.h:42,
                 from include/linux/dmaengine.h:29,
                 from include/linux/skbuff.h:29,
                 from include/linux/netlink.h:155,
                 from include/linux/genetlink.h:4,
                 from include/net/genetlink.h:4,
                 from include/linux/taskstats_kern.h:12,
                 from init/main.c:45:
include/asm/dma-mapping.h: In function `dma_unmap_page':
include/asm/dma-mapping.h:14: error: implicit declaration of function `get_dma_ops'
include/asm/dma-mapping.h:14: warning: initialization makes pointer from integer without a cast
include/asm/dma-mapping.h:17: error: dereferencing pointer to incomplete type
include/asm/dma-mapping.h: At top level:
include/asm/dma-mapping.h:21: warning: `struct scatterlist' declared inside parameter list
include/asm/dma-mapping.h:21: warning: its scope is only this definition or declaration, which is probably not what you want
include/asm/dma-mapping.h: In function `dma_map_sg':
include/asm/dma-mapping.h:23: warning: initialization makes pointer from integer without a cast
include/asm/dma-mapping.h:26: error: dereferencing pointer to incomplete type
include/asm/dma-mapping.h: At top level:
include/asm/dma-mapping.h:31: warning: `struct scatterlist' declared inside parameter list
include/asm/dma-mapping.h: In function `dma_unmap_sg':
include/asm/dma-mapping.h:33: warning: initialization makes pointer from integer without a cast
include/asm/dma-mapping.h:36: error: dereferencing pointer to incomplete type
include/asm/dma-mapping.h: In function `dma_sync_single_for_cpu':
include/asm/dma-mapping.h:167: error: implicit declaration of function `__dma_sync'
include/asm/dma-mapping.h:167: error: implicit declaration of function `bus_to_virt'
include/asm/dma-mapping.h: At top level:
include/asm/dma-mapping.h:180: warning: `struct scatterlist' declared inside parameter list
include/asm/dma-mapping.h: In function `dma_sync_sg_for_cpu':
include/asm/dma-mapping.h:187: error: implicit declaration of function `for_each_sg'
include/asm/dma-mapping.h:188: error: parse error before "__dma_sync_page"
include/asm/dma-mapping.h: At top level:
include/asm/dma-mapping.h:193: warning: `struct scatterlist' declared inside parameter list
include/asm/dma-mapping.h: In function `dma_sync_sg_for_device':
include/asm/dma-mapping.h:201: error: parse error before "__dma_sync_page"
include/asm/dma-mapping.h: In function `dma_mapping_error':
include/asm/dma-mapping.h:207: error: `DMA_ERROR_CODE' undeclared (first use in this function)
include/asm/dma-mapping.h:207: error: (Each undeclared identifier is reported only once
include/asm/dma-mapping.h:207: error: for each function it appears in.)
In file included from include/linux/dma-mapping.h:42,
                 from include/linux/dmaengine.h:29,
                 from include/linux/skbuff.h:29,
                 from include/linux/netlink.h:155,
                 from include/linux/genetlink.h:4,
                 from include/net/genetlink.h:4,
                 from include/linux/taskstats_kern.h:12,
                 from init/main.c:45:
include/asm/dma-mapping.h:259:2: #endif without #if
include/asm/dma-mapping.h:260:2: #endif without #if
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2
-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
