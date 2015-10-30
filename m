Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ACA2E1A0D6F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2015 08:35:54 +1100 (AEDT)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 30 Oct 2015 15:35:52 -0600
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 71DF438C803B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 17:35:49 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9ULZnNW51052604
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 21:35:49 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9ULZlN4008445
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 17:35:49 -0400
Date: Fri, 30 Oct 2015 14:35:46 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: David Miller <davem@davemloft.net>
Cc: hch@infradead.org, keith.busch@intel.com, aik@ozlabs.ru,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 paulus@samba.org, sparclinux@vger.kernel.org, willy@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, david@gibson.dropbear.id.au
Subject: Re: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
Message-ID: <20151030213546.GL7716@linux.vnet.ibm.com>
References: <20151028135922.GA27909@localhost.localdomain>
 <20151029115536.GA28090@infradead.org>
 <20151029155701.GJ7716@linux.vnet.ibm.com>
 <20151029.184955.728736673434401711.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151029.184955.728736673434401711.davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 29.10.2015 [18:49:55 -0700], David Miller wrote:
> From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> Date: Thu, 29 Oct 2015 08:57:01 -0700
> 
> > So, would that imply changing just the NVMe driver code rather than
> > adding the dma_page_shift API at all? What about
> > architectures that can support the larger page sizes? There is an
> > implied performance impact, at least, of shifting the IO size down.
> > 
> > Sorry for the continuing questions -- I got lots of conflicting feedback
> > on the last series and want to make sure v4 is more acceptable.
> 
> In the long term I would be very happy to see us having a real interface
> for this stuff, just my opinion...

Yep, I think I'll try and balance the two -- fix NVMe for now with a 4K
page size as suggested by Christoph, and then work on the more complete
API for the next merge.

Thanks,
Nish
