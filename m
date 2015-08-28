Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 766CB1A01ED
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 13:23:46 +1000 (AEST)
Message-ID: <1440732225.8076.4.camel@ellerman.id.au>
Subject: Re: [kernel] powerpc/iommu: Set default DMA offset in dma_dev_setup
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Fri, 28 Aug 2015 13:23:45 +1000
In-Reply-To: <55DF0BA8.9080805@ozlabs.ru>
References: <20150827093754.4BE371401F6@ozlabs.org>
 <55DF0BA8.9080805@ozlabs.ru>
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

On Thu, 2015-08-27 at 23:07 +1000, Alexey Kardashevskiy wrote:
> On 08/27/2015 07:37 PM, Michael Ellerman wrote:
> > On Thu, 2015-27-08 at 06:01:16 UTC, Alexey Kardashevskiy wrote:
> >> "powerpc/iommu: Cleanup setting of DMA base/offset" expects that
> >
> > This should be:
> >
> > Commit e91c25111aa3 "powerpc/iommu: Cleanup setting of DMA base/offset" ...
> 
> Is not this format for reverts (which this patch is not)?

No, it's for any time you reference a commit in a change log.

> >> Makes sense to squash it to "powerpc/iommu: Cleanup setting of DMA base/offset".
> >
> > We don't squash things that are already in next.
> 
> imho this screams for rebase. There is no point in having broken patches in 
> non merged tree, rebase is a very cheap operation.

You can scream all you like.

Scott has already forked my next as the basis for his next, so if I rebased my
tree we'd get duplicate copies of all of that, and conflicts everywhere.

cheers
