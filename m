Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 864551A0145
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Oct 2015 06:52:26 +1000 (AEST)
Message-ID: <1443819066.27295.19.camel@kernel.crashing.org>
Subject: Re: [PATCH 0/5 v2] Fix NVMe driver support on Power with 32-bit DMA
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, Matthew Wilcox
 <willy@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Alexey Kardashevskiy
 <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>, Christoph
 Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Sat, 03 Oct 2015 06:51:06 +1000
In-Reply-To: <20151002200953.GB40695@linux.vnet.ibm.com>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002200953.GB40695@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-10-02 at 13:09 -0700, Nishanth Aravamudan wrote:

> 1) add a generic dma_get_page_shift implementation that just returns
> PAGE_SHIFT

So you chose to return the granularity of the iommu to the driver
rather than providing a way for the driver to request a specific
alignment for DMA mappings. Any specific reason ?

Cheers,
Ben.
