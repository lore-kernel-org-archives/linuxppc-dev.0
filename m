Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 459B21A087B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 03:05:01 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Mon, 12 Oct 2015 10:04:59 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 2BFDF1FF0045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 09:53:08 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t9CG1gQi57475222
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 09:01:42 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9CG4sfC014414
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 10:04:55 -0600
Date: Mon, 12 Oct 2015 09:04:52 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@linux.intel.com>,
 Keith Busch <keith.busch@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/5 v2] dma-mapping: add generic dma_get_page_shift API
Message-ID: <20151012160452.GB24212@linux.vnet.ibm.com>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002200953.GB40695@linux.vnet.ibm.com>
 <20151002201142.GC40695@linux.vnet.ibm.com>
 <20151006095136.GB14144@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151006095136.GB14144@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06.10.2015 [02:51:36 -0700], Christoph Hellwig wrote:
> Do we need a function here or can we just have a IOMMU_PAGE_SHIFT define
> with an #ifndef in common code?

I suppose we could do that -- I wasn't sure if the macro would be
palatable.

> Also not all architectures use dma-mapping-common.h yet, so you either
> need to update all of those as well, or just add the #ifndef directly
> to linux/dma-mapping.h.

Ok, I will take a look at that and spin up a v3.

Thanks for the feedback!

-Nish
