Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w0W9Z66vmzDqHq
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Apr 2017 19:19:30 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: pc@us.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH V4] powerpc/hugetlb: Add ABI defines for supported HugeTLB
 page sizes
In-Reply-To: <947e3e42-9c9e-a7b2-dc1b-0e5ffe747168@us.ibm.com>
References: <5fb76b92-2988-1207-2bed-814a96e6a51a@linux.vnet.ibm.com>
 <20170407035539.21688-1-khandual@linux.vnet.ibm.com>
 <87lgrcgynk.fsf@concordia.ellerman.id.au>
 <947e3e42-9c9e-a7b2-dc1b-0e5ffe747168@us.ibm.com>
Date: Sat, 08 Apr 2017 19:19:26 +1000
Message-ID: <87a87rgstd.fsf@concordia.ellerman.id.au>
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

Paul Clarke <pc@us.ibm.com> writes:

> nits... take 'em or leave 'em...
>
> On 04/07/2017 08:01 AM, Michael Ellerman wrote:
>> Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:
>> And I reworded the comment the make it clearer (I think) that most users
>> shouldn't need to use these, and should just use the default size:
>>
>> /*
>>  * When MAP_HUGETLB is set bits [26:31] encode the log2 of the huge page size.
>
> need a comma after "set".

Hmm, 'spose.

> also, "bits [26:31]" of what?

Flags!

But yeah fair cop, as it happened I was rebasing it anyway, so:

/*
 * When MAP_HUGETLB is set, bits [26:31] of the flags argument to mmap(2),
 * encode the log2 of the huge page size. A value of zero indicates that the
 * default huge page size should be used. To use a non-default huge page size,
 * one of these defines can be used, or the size can be encoded by hand. Note
 * that on most systems only a subset, or possibly none, of these sizes will be
 * available.
 */

Thanks for the review.

cheers
