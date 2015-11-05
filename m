Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A724C1A010C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 08:54:12 +1100 (AEDT)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 5 Nov 2015 14:54:09 -0700
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id C0D3838C8039
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 16:54:06 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA5Ls6EP54460446
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 21:54:06 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA5Ls43o010403
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 16:54:06 -0500
Date: Thu, 5 Nov 2015 13:54:03 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, aik@ozlabs.ru,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 paulus@samba.org, sparclinux@vger.kernel.org, willy@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 david@gibson.dropbear.id.au
Subject: Re: [PATCH 1/1 v4] drivers/nvme: default to 4k device page size
Message-ID: <20151105215403.GA18259@linux.vnet.ibm.com>
References: <20151027.175443.140992924519172506.davem@davemloft.net>
 <20151028135922.GA27909@localhost.localdomain>
 <20151029115536.GA28090@infradead.org>
 <20151029155701.GJ7716@linux.vnet.ibm.com>
 <20151029172043.GA8343@localhost.localdomain>
 <20151030213511.GK7716@linux.vnet.ibm.com>
 <20151103131824.GA12232@infradead.org>
 <20151103134624.GG13904@localhost.localdomain>
 <20151105170145.GB16308@linux.vnet.ibm.com>
 <20151105195839.GB3194@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151105195839.GB3194@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05.11.2015 [11:58:39 -0800], Christoph Hellwig wrote:
> Looks fine,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> ... but I doubt we'll ever bother updating it.  Most architectures
> with arger page sizes also have iommus and would need different settings
> for different iommus vs direct mapping for very little gain.  There's a
> reason why we never bothered for RDMA either.

Fair enough :) Thanks for all your reviews and comments.

-Nish
