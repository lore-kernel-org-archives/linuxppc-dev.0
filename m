Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id BEFDF1A044F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 12:11:11 +1100 (AEDT)
Date: Mon, 26 Oct 2015 18:27:46 -0700 (PDT)
Message-Id: <20151026.182746.1323901353520152838.davem@davemloft.net>
To: nacc@linux.vnet.ibm.com
Cc: willy@linux.intel.com, keith.busch@intel.com, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 david@gibson.dropbear.id.au, hch@infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
From: David Miller <davem@davemloft.net>
In-Reply-To: <20151023205420.GA10197@linux.vnet.ibm.com>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Fri, 23 Oct 2015 13:54:20 -0700

> 1) add a generic dma_get_page_shift implementation that just returns
> PAGE_SHIFT

I won't object to this patch series, but if I had implemented this I
would have required the architectures to implement this explicitly,
one-by-one.  I think it is less error prone and more likely to end
up with all the architectures setting this correctly.
