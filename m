Return-Path: <xemul@odin.com>
Received: from mx2.parallels.com (mx2.parallels.com [199.115.105.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3FCF11A01A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 00:32:44 +1000 (AEST)
Message-ID: <552BD37A.8070505@parallels.com>
Date: Mon, 13 Apr 2015 17:32:26 +0300
From: Pavel Emelyanov <xemul@parallels.com>
MIME-Version: 1.0
To: "Kirill A. Shutemov" <kirill@shutemov.name>, Laurent Dufour
 <ldufour@linux.vnet.ibm.com>
Subject: Re: [RESEND PATCH v3 1/2] mm: Introducing arch_remap hook
References: <cover.1428916945.git.ldufour@linux.vnet.ibm.com>
 <9d827fc618a718830b2c47aa87e8be546914c897.1428916945.git.ldufour@linux.vnet.ibm.com>
 <20150413115811.GA12354@node.dhcp.inet.fi>
 <552BB972.3010704@linux.vnet.ibm.com>
 <20150413131357.GC12354@node.dhcp.inet.fi>
 <552BC2CA.80309@linux.vnet.ibm.com> <552BC619.9080603@parallels.com>
 <20150413140219.GA14480@node.dhcp.inet.fi>
 <552BCE87.8040103@linux.vnet.ibm.com>
 <20150413142655.GA14646@node.dhcp.inet.fi>
In-Reply-To: <20150413142655.GA14646@node.dhcp.inet.fi>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Rik van Riel <riel@redhat.com>, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org, criu@openvz.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, Mel Gorman <mgorman@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, cov@codeaurora.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> I initially thought it would be enough to put it into
>>> <asm-generic/mmu_context.h>, expecting it works as
>>> <asm-generic/pgtable.h>. But that's not the case.
>>>
>>> It probably worth at some point rework all <asm/mmu_context.h> to include
>>> <asm-generic/mmu_context.h> at the end as we do for <asm/pgtable.h>.
>>> But that's outside the scope of the patchset, I guess.
>>>
>>> I don't see any better candidate for such dummy header. :-/
>>
>> Clearly, I'm not confortable with a rewrite of <asm/mmu_context.h> :(
>>
>> So what about this patch, is this v3 acceptable ?
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Other than the #ifdef thing, the same:

Acked-by: Pavel Emelyanov <xemul@parallels.com>
