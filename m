Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A4F9B1A060B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2015 09:13:32 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 30 Oct 2015 18:13:30 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id D0168C90048
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 18:01:37 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9UMDQtk50135144
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 22:13:26 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9UMDPTR020974
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 18:13:26 -0400
Date: Fri, 30 Oct 2015 15:13:24 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Keith Busch <keith.busch@intel.com>
Cc: aik@ozlabs.ru, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@infradead.org>,
 paulus@samba.org, sparclinux@vger.kernel.org, willy@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 david@gibson.dropbear.id.au
Subject: Re: [PATCH 1/1 v3] drivers/nvme: default to 4k device page size
Message-ID: <20151030221324.GM7716@linux.vnet.ibm.com>
References: <20151026.182746.1323901353520152838.davem@davemloft.net>
 <20151027222010.GD7716@linux.vnet.ibm.com>
 <20151027223643.GA25332@localhost.localdomain>
 <20151027.175443.140992924519172506.davem@davemloft.net>
 <20151028135922.GA27909@localhost.localdomain>
 <20151029115536.GA28090@infradead.org>
 <20151029155701.GJ7716@linux.vnet.ibm.com>
 <20151029172043.GA8343@localhost.localdomain>
 <20151030213511.GK7716@linux.vnet.ibm.com>
 <20151030214848.GC13904@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151030214848.GC13904@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 30.10.2015 [21:48:48 +0000], Keith Busch wrote:
> On Fri, Oct 30, 2015 at 02:35:11PM -0700, Nishanth Aravamudan wrote:
> > Given that it's 4K just about everywhere by default (and sort of
> > implicitly expected to be, I guess), I think I'd prefer we default to
> > 4K. That should mitigate the performance impact (I'll ask our IO team to
> > do some runs, but since this impacts functionality on some hardware, I
> > don't think it's too relevant for now). Unless there are NVMe devcies
> > with a MPSMAX < 4K? 
> 
> Right, I assumed MPSMIN was always 4k for the same reason you mentioned,
> but you can hard code it like you've done in your patch.
> 
> The spec defines MPSMAX such that it's impossible to find a device
> with MPSMAX < 4k.

Great, thanks!

-Nish
