Return-Path: <brking@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F9841A0D3C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2015 05:38:21 +1000 (AEST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Mon, 29 Jun 2015 13:38:19 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 24E6419D803E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2015 13:29:17 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5TJcHlm55115814
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2015 12:38:17 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5TJcG27012512
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2015 13:38:17 -0600
Message-ID: <55919EA7.9050806@linux.vnet.ibm.com>
Date: Mon, 29 Jun 2015 14:38:15 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/iommu: Support "hybrid" iommu/direct DMA ops for
 coherent_mask < dma_mask
References: <20150518064027.27A97140D18@ozlabs.org>
 <5584874D.2060402@linux.vnet.ibm.com>
 <1434754913.27935.1.camel@kernel.crashing.org>
In-Reply-To: <1434754913.27935.1.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/19/2015 06:01 PM, Benjamin Herrenschmidt wrote:
> On Fri, 2015-06-19 at 16:19 -0500, Brian King wrote:
>> On 05/18/2015 01:40 AM, Michael Ellerman wrote:
>>> On Mon, 2015-18-05 at 03:56:51 UTC, Benjamin Herrenschmidt wrote:
>>>> This patch adds the ability to the DMA direct ops to fallback to the IOMMU
>>>> ops for coherent alloc/free if the coherent mask of the device isn't
>>>> suitable for accessing the direct DMA space and the device also happens
>>>> to have an active IOMMU table.
>>>
>>> Can you do the removal of the union, the #ifdef PPC64 and the static inlines as
>>> a precursor patch, that would remove some of the noise in the diff.
>>>
>>> And can you explain the changes to dart, pseries and powernv.
>>>
>>> There's also some whitespace changes in iommu.h that I assume you didn't want?
>>
>> Hi Ben,
>>
>> Do you plan to resubmit with these changes? The patch seems to work fine in
>> my testing. Would be nice to get this merged.
> 
> Argh, completely forgot about it. I'll respin it next week.

Anything I can do to help on this one?

Thanks,

Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
