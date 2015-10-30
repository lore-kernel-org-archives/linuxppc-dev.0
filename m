Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 410A61A0B6F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 12:33:15 +1100 (AEDT)
Date: Thu, 29 Oct 2015 18:49:55 -0700 (PDT)
Message-Id: <20151029.184955.728736673434401711.davem@davemloft.net>
To: nacc@linux.vnet.ibm.com
Cc: hch@infradead.org, keith.busch@intel.com, aik@ozlabs.ru,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 paulus@samba.org, sparclinux@vger.kernel.org, willy@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, david@gibson.dropbear.id.au
Subject: Re: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
From: David Miller <davem@davemloft.net>
In-Reply-To: <20151029155701.GJ7716@linux.vnet.ibm.com>
References: <20151028135922.GA27909@localhost.localdomain>
 <20151029115536.GA28090@infradead.org>
 <20151029155701.GJ7716@linux.vnet.ibm.com>
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
Date: Thu, 29 Oct 2015 08:57:01 -0700

> So, would that imply changing just the NVMe driver code rather than
> adding the dma_page_shift API at all? What about
> architectures that can support the larger page sizes? There is an
> implied performance impact, at least, of shifting the IO size down.
> 
> Sorry for the continuing questions -- I got lots of conflicting feedback
> on the last series and want to make sure v4 is more acceptable.

In the long term I would be very happy to see us having a real interface
for this stuff, just my opinion...
