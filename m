Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDlz91BPqzDvkg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 12:37:25 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v4 0/4] powerpc/spapr/vfio: Put pages on VFIO
 container shutdown
In-Reply-To: <20161108160620.54591201@t450s.home>
References: <1477291990-2872-1-git-send-email-aik@ozlabs.ru>
 <871syml83v.fsf@concordia.ellerman.id.au>
 <20161108160620.54591201@t450s.home>
Date: Thu, 10 Nov 2016 12:37:24 +1100
Message-ID: <87inrwjesr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alex Williamson <alex.williamson@redhat.com> writes:
> On Tue, 08 Nov 2016 18:54:28 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
>> >  arch/powerpc/include/asm/mmu_context.h |  20 ++--
>> >  arch/powerpc/kernel/setup-common.c     |   2 +-
>> >  arch/powerpc/mm/mmu_context_book3s64.c |   6 +-
>> >  arch/powerpc/mm/mmu_context_iommu.c    |  60 ++++-------
>> >  drivers/vfio/vfio_iommu_spapr_tce.c    | 181 ++++++++++++++++++++++-----------
>> >  5 files changed, 154 insertions(+), 115 deletions(-)  
>> 
>> Alex, given the diffstat how do you want to merge this? (for 4.10)
>> 
>> Should I merge it, you merge it, or I can put it in a topic branch?
>
> I have an outstanding question on one patch, but otherwise I'd prefer
> you merge it, I'm not expecting to have anything that would conflict
> with vfio_iommu_spapr_tce.c and this code is tied pretty tightly with
> arch code.  I'll provide acks depending on how we resolve my question.

Great, thanks.

cheers
